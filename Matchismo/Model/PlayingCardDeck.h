//
//  PlayingCardDeck.h
//  Matchismo
//
//  Created by admin on 30.09.13.
//  Copyright (c) 2013 Dirty Citizens. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "PlayingCard.h"

@interface PlayingCardDeck : Deck

- (PlayingCard *)drawRandomCard;

@end
