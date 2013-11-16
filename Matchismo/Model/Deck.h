//
//  Deck.h
//  Matchismo
//
//  Created by admin on 29.09.13.
//  Copyright (c) 2013 Dirty Citizens. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;

- (Card *)drawRandomCard;

@end
