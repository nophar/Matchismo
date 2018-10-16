//
//  ViewController.m
//  Matchismo
//
//  Created by Nophar Sarel on 08/10/2018.
//  Copyright © 2018 Lightricks. All rights reserved.
//

#import "CardGameViewController.h"

#import "CardMatchingGame.h"
#import "HistoryViewController.h"

@interface CardGameViewController ()

 // The game Model of this controller.
@property (strong, nonatomic) CardMatchingGame *game;

// The card's buttons of the game.
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

// A Label that represents the current score in the game.
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

// A Label that represents the last move in the game.
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

// A string that represents the moves in the game.
@property (strong, nonatomic) NSMutableAttributedString *historyLines;
@end

@implementation CardGameViewController

- (CardMatchingGame *)game {
  if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                        usingDeck:[self createDeck]];
  [_game updateCurrentNumCardMatch:[self getCurrentNumCardMatch]];
  return _game;
}

- (NSMutableAttributedString *)historyLines {
  if (!_historyLines)
    _historyLines = [[NSMutableAttributedString alloc] init];
  return _historyLines;
}

#pragma mark -
#pragma mark UIViewController
#pragma mark -


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"Show History"]) {
    if ([segue.destinationViewController isKindOfClass:[HistoryViewController class]]) {
      HistoryViewController *hvc = (HistoryViewController *)segue.destinationViewController;
      hvc.descriptionLabel = self.historyLines;
    }
  }
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self updateUI];
}

#pragma mark -
#pragma mark Buttons
#pragma mark -

- (IBAction)touchCardButton:(UIButton *)sender {
  NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
  [self.game chooseCardAtIndex:chosenButtonIndex];
  [self updateUI];
}

- (IBAction)dealButton:(UIButton *)sender {
  self.game = nil;
  self.historyLines = nil;
  [self updateUI];
}

- (void)updateUI {
  for (UIButton *cardButton in self.cardButtons) {
    NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
    Card *card = [self.game cardAtIndex:cardButtonIndex];
    [cardButton setAttributedTitle:[self titleForCard:card] forState:UIControlStateNormal];
    [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                          forState:UIControlStateNormal];
    cardButton.enabled = !card.matched;
  }
  self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
  self.descriptionLabel.attributedText = [self updateDescriptionLabel];
  [self.historyLines appendAttributedString:self.descriptionLabel.attributedText];
  [self.historyLines appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
}

- (NSMutableAttributedString *)updateDescriptionLabel {
  NSMutableAttributedString *description = [[NSMutableAttributedString alloc] init];
  NSArray<Card *> *currentChosenCards = [self.game getCurrentChosenCards];
  for (Card *card in currentChosenCards) {
    [description appendAttributedString: [self titleForCardDescription:card]];
  }
  [description appendAttributedString:[[NSMutableAttributedString alloc]
      initWithString:[self.game getCurrentDescription]]];
  return description;
}

#pragma mark -
#pragma mark Abstract methods
#pragma mark -

- (NSMutableAttributedString *)titleForCard:(Card *)card { //abstract
  return nil;
}

- (NSMutableAttributedString *)titleForCardDescription:(Card *)card { //abstract
  return nil;
}

- (UIImage *)backgroundImageForCard:(Card *)card { //abstract
  return nil;
}

- (Deck *)createDeck { //abstract
  return nil;
}

- (int)getCurrentNumCardMatch { //abstract
  return  0;
}

@end
