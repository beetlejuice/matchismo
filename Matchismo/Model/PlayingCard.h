//
//  PlayingCard.h
//  Matchismo
//
//  Created by admin on 29.09.13.
//  Copyright (c) 2013 Dirty Citizens. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;
- (NSDictionary *)match:(NSArray *)otherCards;

@end
