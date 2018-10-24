//
//  PlayingCardViewController.m
//  Matchismo
//
//  Created by Nophar Sarel on 14/10/2018.
//  Copyright © 2018 Lightricks. All rights reserved.
//

#import "PlayingCardGameViewController.h"

#import "PlayingCard.h"
#import "PlayingCardDeck.h"
#import "PlayingCardView.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

#pragma mark -
#pragma mark CardGameViewController
#pragma mark -

- (Deck *)createDeck {
  return [[PlayingCardDeck alloc] init];
}

static const int kNumOfCardMatchPlayingCard = 2;

- (int)getCurrentNumCardMatch {
  return kNumOfCardMatchPlayingCard;
}

static const int kInitNumberOfCardsOfPlayingCard = 30;

- (int)getInitNumberOfCards {
  return kInitNumberOfCardsOfPlayingCard;
}

- (CardView *)addCardView:(CGRect)cardRect card:(Card *)curCard {
  PlayingCardView *cardView = [[PlayingCardView alloc] initWithFrame:cardRect];
  cardView.rank = ((PlayingCard *)curCard).rank;
  cardView.suit = ((PlayingCard *)curCard).suit;
  return cardView;
}

- (BOOL)isSupportRemovingCards {
  return false;
}

static const double kMatchedAlpha = 0.5;

- (void)updateCardView:(Card *)card cardView:(CardView *)cardView {
  PlayingCardView *playingCardView = (PlayingCardView *)cardView;
  if (card.matched)
    playingCardView.alpha = kMatchedAlpha;
  if (playingCardView.faceUp != card.chosen)
    [self animateFlip:playingCardView];
  playingCardView.faceUp = card.chosen;
  }

- (void)animateFlip:(PlayingCardView *)cardView {
  [UIView animateWithDuration:0.0 delay:0.0 options:UIViewAnimationOptionTransitionFlipFromLeft
                   animations:^(void) {
   cardView.transform = CGAffineTransformMakeScale(-1, 1);
   }
   completion:^(BOOL finished) {
    [UIView animateWithDuration:0.1 animations:^{
       cardView.transform = CGAffineTransformMakeScale(1, 1);
     }];
   }];
}

@end
