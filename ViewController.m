//
//  ViewController.m
//  Matchismo
//
//  Created by Nophar Sarel on 8 October 2018.
//  Copyright © 5779 Lightricks. All rights reserved.
//

#import "ViewController.h"
#import "Deck.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface ViewController ()
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutlet UISegmentedControl *modeButton;
@property (nonatomic) int cardMode;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end


@implementation ViewController

- (CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:[self createDeck]];
    return _game;
}

- (IBAction)touchCardButton:(UIButton *)sender {
    self.modeButton.enabled = NO;
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}


- (void) updateUI {
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.matched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
        self.descriptionLabel.text = [self.game getCurrentDescription];
    }
}

- (NSString *)titleForCard:(Card *)card {
    return card.chosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.chosen ? @"cardfront" : @"cardback"];
}

- (Deck *)createDeck{
    return [[PlayingCardDeck alloc] init];
}


- (IBAction)changeModeBottun:(UISegmentedControl *)sender {
    self.cardMode = (int)sender.selectedSegmentIndex;
    [self.game updateCurrentMatchMode:self.cardMode];
}

- (IBAction)dealButton:(UIButton *)sender {
    int curMode = self.cardMode;
    self.game = nil;
    [self updateUI];
    self.modeButton.enabled = YES;
    self.cardMode = curMode;
    [self.game updateCurrentMatchMode:self.cardMode];
}



@end
