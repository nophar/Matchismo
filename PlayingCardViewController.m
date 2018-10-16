//
//  PlayingCardViewController.m
//  Matchismo
//
//  Created by Nophar Sarel on 14/10/2018.
//  Copyright © 2018 Lightricks. All rights reserved.
//

#import "PlayingCardViewController.h"

#import "PlayingCardDeck.h"

@interface PlayingCardViewController ()
@end

@implementation PlayingCardViewController

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

- (NSMutableAttributedString *)titleForCard:(Card *)card {
  NSMutableAttributedString *string = [NSMutableAttributedString alloc];
  return card.chosen ? [string initWithString:card.contents] : [string initWithString:@""];
}

- (NSMutableAttributedString *)titleForCardDescription:(Card *)card {
  NSMutableAttributedString *string = [NSMutableAttributedString alloc];
  return [string initWithString:card.contents];
}

- (UIImage *)backgroundImageForCard:(Card *)card {
  return [UIImage imageNamed:card.chosen ? @"cardfront" : @"cardback"];
}

@end
