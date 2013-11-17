//
//  SetCard.m
//  Matchismo
//
//  Created by admin on 13.11.13.
//  Copyright (c) 2013 Dirty Citizens. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

@synthesize symbol = _symbol;

- (NSString *)contents
{
    NSString *contents = [[NSString alloc] init];
    if (self.number > 0) {
        for (int i = 0; i < self.number; i++) {
            [contents stringByAppendingString:self.symbol];
        }
    } else {
        contents = @"?";
    }
    
    return contents;
}

- (NSString *)symbol
{
    return _symbol ? _symbol : @"?";
}

+ (NSArray *)validSymbols
{
    static NSArray *validSymbols = nil;
    if (!validSymbols) validSymbols = @[@"●", @"■", @"▲"];
    return validSymbols;
}

- (void)setSymbol:(NSString *)symbol
{
    if ([[SetCard validSymbols] containsObject:symbol]) {
        _symbol = symbol;
    }
}

- (void)setNumber:(NSUInteger)number
{
    if (number <= 3) _number = number; // 3 is maximum number in a Set game
}

//- (NSDictionary *)match:(NSArray *)otherCards
//{
//    
//}


@end
