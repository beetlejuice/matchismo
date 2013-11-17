//
//  CardMathingGame.m
//  Matchismo
//
//  Created by admin on 06.10.13.
//  Copyright (c) 2013 Dirty Citizens. All rights reserved.
//

#import "CardMathingGame.h"
#import "ProjectEnums.h"

@interface CardMathingGame()
@property (readwrite, nonatomic) int score;
@property (strong, nonatomic) NSMutableArray *cards; // of Card
@end

@implementation CardMathingGame

- (id)initWithCardCount:(NSUInteger)count usingDeck:(PlayingCardDeck *)deck withExtendedModeOn:(BOOL)extendedModeOn
{
    self = [super init];
    
    if (self) {
        for (int i = 0; i < count; i++) {
            PlayingCard *card = [deck drawRandomCard];
            if (card) {
                self.cards[i] = card;
            } else {
                self = nil;
                break;
            }
        }
    }
    self.extendedMode = extendedModeOn;
    
    return self;
}

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSDictionary *)flipResult
{
    if (!_flipResult) _flipResult = [[NSMutableDictionary alloc] init];
    return _flipResult;
}

- (PlayingCard *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (NSArray *)findActiveCards
{
    NSMutableArray *activeCards = [[NSMutableArray alloc] init];
    
    for (PlayingCard *otherCard in self.cards) {
        if (otherCard && otherCard.isFaceUp && !otherCard.isUnplayable) {
            [activeCards addObject:otherCard];
        }
    }
    
    return [NSArray arrayWithArray:activeCards];
}

- (NSArray *)getNeededCardsFromAll:(NSArray *)cards byIndices:(NSArray *)indices
{
    NSMutableArray *neededCards = [[NSMutableArray alloc] init];
    
    if (indices) {
        for (NSNumber *index in indices) {
            int i = [index intValue];
            [neededCards addObject:[cards objectAtIndex:i]];
        }
    } else {
        neededCards = [cards mutableCopy];
    }
    
    return [NSArray arrayWithArray:neededCards];
}

- (NSString *)prepareStringFromCards:(NSArray *)cards byIndices:(NSArray *)indices
{
    NSString *resultString = @"";
        NSMutableArray *contentsArray = [[NSMutableArray alloc] init];
    NSArray *neededCards = [self getNeededCardsFromAll:cards byIndices:indices];
    if (neededCards.count > 0) {
        for (PlayingCard *card in neededCards) {
            [contentsArray addObject:card.contents];
        }
    }
    resultString = [contentsArray componentsJoinedByString:@", "];
    
    return resultString;
}

#define MISMATCH_PENALTY 2
#define MISMATCH_PENALTY3 8
#define FLIP_COST 1

- (void)flipCardAtIndex:(NSUInteger)index
{
    PlayingCard *card = [self cardAtIndex:index];
    if (card && !card.isUnplayable) {
        if (!card.isFaceUp) {
            NSArray *otherActiveCards = [self findActiveCards];
            switch (otherActiveCards.count) {
                case 0: {
                    self.flipResult = @{
                                        @"Result" : @(FLIP),
                                        @"Cards" : card.contents,
                                        @"ScoreEffect" : @(FLIP_COST)
                                        };
                    break;
                }
                    
                case 1: {
                    if (!self.isExtendedGameMode) {
                        NSDictionary *matchResult = [card match:otherActiveCards];
                        int matchScore = [[matchResult valueForKey:@"Score"] intValue];
                        PlayingCard *otherCard = [otherActiveCards lastObject];
                        NSString *bothCardsString = [@[card.contents, otherCard.contents] componentsJoinedByString:@", "];
                        
                        if (matchScore) {
                            card.unplayable = YES;
                            otherCard.unplayable = YES;
                            self.score += matchScore;
                            self.flipResult = @{@"Result" : @(MATCH),
                                                @"Cards" : bothCardsString,
                                                @"ScoreEffect" : @(matchScore)};
                        } else {
                            otherCard.faceUp = NO;
                            self.score -= MISMATCH_PENALTY;
                            self.flipResult = @{
                                                @"Result" : @(MISMATCH),
                                                @"Cards" : bothCardsString,
                                                @"ScoreEffect" : @MISMATCH_PENALTY
                                                };
                        }
                    } else {
                        self.flipResult = @{
                                            @"Result" : @(FLIP),
                                            @"Cards" : card.contents,
                                            @"ScoreEffect" : @(FLIP_COST)
                                            };
                    }
                    break;
                }
                    
                case 2: {
                    NSDictionary *matchResult = [card match:otherActiveCards];
                    int matchScore = [[matchResult valueForKey:@"Score"] intValue];
                    NSArray *matchedCardsIndices = [matchResult valueForKey:@"Matched"];
                    NSArray *allActiveCards = [@[card] arrayByAddingObjectsFromArray:otherActiveCards];
                    
                    if (matchScore) {
//                        make 2 or 3 cards unplayable
                        NSArray *matchedCards = [self getNeededCardsFromAll:allActiveCards byIndices:matchedCardsIndices];
                        for (PlayingCard *card in matchedCards) {
                            card.unplayable = YES;
                        }
                        self.score += matchScore;
                        self.flipResult = @{@"Result" : @(MATCH),
                                            @"Cards" : [self prepareStringFromCards:allActiveCards byIndices:matchedCardsIndices],
                                            @"ScoreEffect" : @(matchScore)};
                    } else {                       
//                        make 2 other cards not faced up
                        for (PlayingCard *card in otherActiveCards) {
                            card.faceUp = NO;
                        }
                        self.score -= MISMATCH_PENALTY3;
                        self.flipResult = @{
                                            @"Result" : @(MISMATCH),
                                            @"Cards" : [self prepareStringFromCards:allActiveCards byIndices:0],
                                            @"ScoreEffect" : @(MISMATCH_PENALTY3)
                                            };
                    }
                    break;
                }
                    
                default:
                    break;
            }
        }
        self.score -= FLIP_COST;
        card.faceUp = !card.isFaceUp;
    }
}

@end
