//
//  CardGameViewController.h
//  Matchismo
//
//  Created by admin on 24.09.13.
//  Copyright (c) 2013 Dirty Citizens. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardGameViewController : UIViewController

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

- (void)setCardButtons:(NSArray *)cardButtons;
- (UIImage *)cardBackImage;

@end
