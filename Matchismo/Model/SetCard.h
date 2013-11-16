//
//  SetCard.h
//  Matchismo
//
//  Created by admin on 13.11.13.
//  Copyright (c) 2013 Dirty Citizens. All rights reserved.
//

#import "Card.h"
#import "ProjectEnums.h"

@interface SetCard : Card

@property (nonatomic) NSUInteger number;
@property (strong, nonatomic) NSString *symbol;
@property (nonatomic) CardShading shading;
@property (nonatomic) CardColor color;

@end
