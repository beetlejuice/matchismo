//
//  CardMathingGame.h
//  Matchismo
//
//  Created by admin on 06.10.13.
//  Copyright (c) 2013 Dirty Citizens. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlayingCard.h"
#import "PlayingCardDeck.h"

@interface CardMatchingGame : NSObject

// designated initializer
- (id)initWithCardCount:(NSUInteger)count usingDeck:(PlayingCardDeck *)deck withExtendedModeOn:(BOOL)extendedModeOn;

- (void)flipCardAtIndex:(NSUInteger)index;

- (PlayingCard *)cardAtIndex:(NSUInteger)index;

@property (readonly, nonatomic) int score;
@property (strong, nonatomic) NSDictionary *flipResult;
@property (nonatomic, getter = isExtendedGameMode) BOOL extendedMode;

@end