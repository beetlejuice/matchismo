//
//  ProjectEnums.h
//  Matchismo
//
//  Created by admin on 13.10.13.
//  Copyright (c) 2013 Dirty Citizens. All rights reserved.
//

typedef enum FlipResultType : NSUInteger {
    FLIP = 1,
    MATCH = 2,
    MISMATCH = 3
} FlipResultType;

typedef enum CardShading : NSUInteger {
    OPEN = 1,
    STRIPED = 2,
    SOLID = 3
} CardShading;

typedef enum CardColor : NSUInteger {
    BLUE = 1,
    RED = 2,
    YELLOW = 3
} CardColor;
