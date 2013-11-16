//
//  PlayingCard.m
//  Matchismo
//
//  Created by admin on 29.09.13.
//  Copyright (c) 2013 Dirty Citizens. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

- (NSDictionary *)match:(NSArray *)otherCards
{
    NSMutableDictionary *matchResult = [NSMutableDictionary dictionaryWithObjectsAndKeys:0, @"Matched", 0, @"Score", nil];
    if ([otherCards count] == 1) {
        PlayingCard *otherCard = [otherCards lastObject];
        if ([otherCard.suit isEqualToString:self.suit]) {  // 2 of 2 suit match
            [matchResult addEntriesFromDictionary:@{@"Matched" : @[@(0), @(1)], @"Score" : @(4)}];
        } else if (otherCard.rank == self.rank) {  // 2 of 2 rank match
            [matchResult addEntriesFromDictionary:@{@"Matched" : @[@(0), @(1)], @"Score" : @(16)}];
        }
    } else if ([otherCards count] == 2) {
        PlayingCard *firstOtherCard = [otherCards  objectAtIndex:0];
        PlayingCard *secondOtherCard = [otherCards objectAtIndex:1];
        if (firstOtherCard.rank == self.rank && secondOtherCard.rank == self.rank) {
            [matchResult addEntriesFromDictionary:@{@"Matched" : @[@(0), @(1), @(2)], @"Score" : @(32)}]; // 3 of 3 rank match
        } else if ([firstOtherCard.suit isEqualToString:self.suit] && [secondOtherCard.suit isEqualToString:self.suit]) {
            [matchResult addEntriesFromDictionary:@{@"Matched" : @[@(0), @(1), @(2)], @"Score" : @(16)}];  // 3 of 3 suit match
        } else if (firstOtherCard.rank == self.rank && secondOtherCard.rank != self.rank && firstOtherCard.rank != secondOtherCard.rank) {
            [matchResult addEntriesFromDictionary:@{@"Matched" : @[@(0), @(1)], @"Score" : @(9)}]; // 2 of 3 rank match (self and first)
        } else if (firstOtherCard.rank != self.rank && secondOtherCard.rank == self.rank && firstOtherCard.rank != secondOtherCard.rank) {
            [matchResult addEntriesFromDictionary:@{@"Matched" : @[@(0), @(2)], @"Score" : @(9)}]; // 2 of 3 rank match (self and second)
        } else if (firstOtherCard.rank != self.rank && secondOtherCard.rank != self.rank && firstOtherCard.rank == secondOtherCard.rank) {
            [matchResult addEntriesFromDictionary:@{@"Matched" : @[@(1), @(2)], @"Score" : @(9)}]; // 2 of 3 rank match (first and second)
        } else if ([firstOtherCard.suit isEqualToString:self.suit] && ![secondOtherCard.suit isEqualToString:self.suit] && ![firstOtherCard.suit isEqualToString:secondOtherCard.suit]) {
            [matchResult addEntriesFromDictionary:@{@"Matched" : @[@(0), @(1)], @"Score" : @(3)}];  // 2 of 3 suit match (self and first)
        } else if (![firstOtherCard.suit isEqualToString:self.suit] && [secondOtherCard.suit isEqualToString:self.suit] && ![firstOtherCard.suit isEqualToString:secondOtherCard.suit]) {
            [matchResult addEntriesFromDictionary:@{@"Matched" : @[@(0), @(2)], @"Score" : @(3)}];  // 2 of 3 suit match (self and second)
        } else if (![firstOtherCard.suit isEqualToString:self.suit] && ![secondOtherCard.suit isEqualToString:self.suit] && [firstOtherCard.suit isEqualToString:secondOtherCard.suit]) {
            [matchResult addEntriesFromDictionary:@{@"Matched" : @[@(1), @(2)], @"Score" : @(3)}];  // 2 of 3 suit match (first and second)
        }        
    }

    return [NSDictionary dictionaryWithDictionary:matchResult];
}

@synthesize suit = _suit;

+ (NSArray *)validSuits
{
    static NSArray *validSuits = nil;
    if (!validSuits) validSuits = @[@"♥", @"♦", @"♠", @"♣"];
    return validSuits;
}

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings
{
    static NSArray *rankStrings = nil;
    if (!rankStrings) rankStrings = @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
    return rankStrings;
}

+ (NSUInteger)maxRank
{
    return [self rankStrings].count-1;
}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

@end
