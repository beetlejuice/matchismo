//
//  PlayingCardDeck.m
//  Matchismo
//
//  Created by admin on 30.09.13.
//  Copyright (c) 2013 Dirty Citizens. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@interface PlayingCardDeck()
@property (strong, nonatomic) NSMutableArray *cards;
@end

@implementation PlayingCardDeck

@dynamic cards;

- (id)init
{
    self = [super init];
    
    if (self) {
        for (NSString *suit in [PlayingCard validSuits]) {
            for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++) {
                PlayingCard *card = [[PlayingCard alloc] init];
                card.rank = rank;
                card.suit = suit;
                [self addCard:card atTop:YES];
            }
        }
    }
    
    return self;
}

- (PlayingCard *)drawRandomCard
{
    PlayingCard *randomCard = nil;
    
    if (self.cards.count) {
        unsigned index = arc4random() % self.cards.count;
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    
    return randomCard;
}

@end
