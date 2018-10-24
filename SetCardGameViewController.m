//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Nophar Sarel on 14/10/2018.
//  Copyright © 2018 Lightricks. All rights reserved.
//

#import "SetCardGameViewController.h"

#import "SetCard.h"
#import "SetCardDeck.h"
#import "SetCardView.h"

@interface SetCardGameViewController ()
@end

@implementation SetCardGameViewController

#pragma mark -
#pragma mark CardGameViewController
#pragma mark -

- (Deck *)createDeck {
  return [[SetCardDeck alloc] init];
}

static const int kNumOfCardsMatch = 3;

- (int)getCurrentNumCardMatch {
  return kNumOfCardsMatch;
}

static const int kInitNumberOfCardsOfSet = 12;

- (int)getInitNumberOfCards {
  return kInitNumberOfCardsOfSet;
}

#define RED 1
#define GREEN 2
#define PURPLE 3

- (UIColor *)createColor:(NSInteger)colorName {
  switch (colorName) {
    case RED:
      return [UIColor redColor];
    case GREEN:
      return [UIColor greenColor];
    default:
      return [UIColor purpleColor];
  }
}

- (IBAction)addThreeCardsButton:(UIButton *)sender {
  [super addThreeCards];
}

- (CardView *)addCardView:(CGRect)cardRect card:(Card *)curCard {
  SetCardView *cardView = [[SetCardView alloc] initWithFrame:cardRect];
  cardView.symbol = ((SetCard *)curCard).symbol;
  cardView.color = [self createColor:(((SetCard *)curCard).color)];
  cardView.number = ((SetCard *)curCard).number;
  cardView.shading = ((SetCard *)curCard).shading;
  return cardView;
}

static const double kChosenAlpha = 0.5;

- (void)updateCardView:(Card *)card cardView:(CardView *)cardView {
  SetCardView *setCardView = (SetCardView *)cardView;
  if (card.chosen)
    setCardView.alpha = kChosenAlpha;
  else
    setCardView.alpha = 1;
  if (card.matched && !setCardView.hidden)
    [self reduceCurrnetCardsNumber];
}

- (BOOL)isSupportRemovingCards {
  return true;
}

@end
