//
//  CardGameViewController.m
//  Matchismo
//
//  Created by admin on 24.09.13.
//  Copyright (c) 2013 Dirty Citizens. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "CardMatchingGame.h"
#import "ProjectEnums.h"
#import "GameResult.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
//@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *flipResultLabel;
@property (weak, nonatomic) IBOutlet UISwitch *extendedModeSwitch;
@property (strong, nonatomic) GameResult *gameResult;
@end

@implementation CardGameViewController

- (GameResult *)gameResult
{
    if (!_gameResult) _gameResult = [[GameResult alloc] init];
    return _gameResult;
}

- (CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[[PlayingCardDeck alloc] init] withExtendedModeOn:self.extendedModeSwitch.isOn];
    
    return _game;
}

- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

- (UIImage *)cardBackImage
{
    UIImage *cardBackImage = [UIImage imageNamed:@"cardback.png"];
    return cardBackImage;
}

- (NSString *)composeFlipResultStringFromDictionary:(NSDictionary *)resultDictionary
{
    NSString *flipResultString = nil;
    int scoreEffect = [[resultDictionary objectForKey:@"ScoreEffect"] intValue];
    int result = [[resultDictionary objectForKey:@"Result"] intValue];
    
    switch (result) {
        case FLIP:
            flipResultString = [NSString stringWithFormat:@"Flipped up %@. -%d for score", [resultDictionary objectForKey:@"Cards"], scoreEffect];
            break;
        case MATCH:
            flipResultString = [NSString stringWithFormat:@"Matched %@ for %d points", [resultDictionary objectForKey:@"Cards"], scoreEffect];
            break;
        case MISMATCH:
            flipResultString = [NSString stringWithFormat:@"%@ don't match! %d point penalty!", [resultDictionary objectForKey:@"Cards"], scoreEffect];
            break;
    }
    
    return flipResultString;
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setImage:self.cardBackImage forState:UIControlStateNormal];
        [cardButton setImage:[[UIImage alloc] init] forState:UIControlStateSelected];
        [cardButton setImage:[[UIImage alloc] init] forState:UIControlStateSelected|UIControlStateDisabled];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = (card.isUnplayable ? 0.3 : 1.0);
    }
    NSLog(@"Buttons: %d", self.cardButtons.count);
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.flipResultLabel.text = [self composeFlipResultStringFromDictionary:self.game.flipResult];
}

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    self.extendedModeSwitch.userInteractionEnabled = NO;
    [self updateUI];
    self.gameResult.score = self.game.score;
}

- (IBAction)redealCards:(UIButton *)sender
{
    self.game = nil;
    self.flipCount = 0;
    self.gameResult = nil;
    self.extendedModeSwitch.userInteractionEnabled = YES;
    [self updateUI];
}

- (IBAction)activateExtendedGameMode:(UISwitch *)sender {
    self.game.extendedMode = sender.isOn;
}

@end
