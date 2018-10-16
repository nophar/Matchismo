//
//  SetCardViewController.m
//  Matchismo
//
//  Created by Nophar Sarel on 14/10/2018.
//  Copyright © 2018 Lightricks. All rights reserved.
//

#import "SetCardViewController.h"

#import "SetCard.h"
#import "SetCardDeck.h"

@interface SetCardViewController ()
@end

@implementation SetCardViewController

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

- (NSMutableAttributedString *)titleForCardDescription:(Card *)card {
  return [self titleForCard:card];
}

static const double kStripedAlpha = 0.3;

- (NSMutableAttributedString *)titleForCard:(Card *)card {
  SetCard *setCard = (SetCard *)card;
  NSMutableAttributedString *string = [self getStringOfShapeAndNumber:setCard];
  UIColor* cardColor = [self getCardColorIncludeStripe:setCard];
  [string addAttribute:NSForegroundColorAttributeName
      value:cardColor range:NSMakeRange(0,setCard.number)];
  if ([setCard.shading isEqualToString:@"Open"])
    [string addAttributes:@{NSStrokeWidthAttributeName : @3, NSStrokeColorAttributeName: cardColor}
        range:NSMakeRange(0,setCard.number)];
  return string;
}

- (NSMutableAttributedString *)getStringOfShapeAndNumber:(SetCard *)setCard {
  NSMutableAttributedString *string = [[NSMutableAttributedString alloc]
      initWithString:setCard.symbol];
  for (int i = 1; i < setCard.number; i++) {
    [string appendAttributedString: [[NSMutableAttributedString alloc]
        initWithString:setCard.symbol]];
  }
  return string;
}

- (UIColor *)getCardColorIncludeStripe:(SetCard *)setCard {
  double alpha = 1;
  if ([setCard.shading isEqualToString:@"Striped"])
    alpha = kStripedAlpha;
  if ([setCard.color isEqualToString:@"Red"] )
    return [UIColor colorWithRed:1 green:0 blue:0 alpha:alpha];
  else if ([setCard.color isEqualToString:@"Green"] )
    return [UIColor colorWithRed:0 green:1 blue:0 alpha:alpha];
  else
    return [UIColor colorWithRed:0.5 green:0 blue:0.5 alpha:alpha];
}

- (UIImage *)backgroundImageForCard:(Card *)card {
  return [UIImage imageNamed:card.chosen ? @"cardfrontchosen" : @"cardfront"];
}

@end
