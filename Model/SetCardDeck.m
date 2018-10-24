//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Nophar Sarel on 14/10/2018.
//  Copyright © 2018 Lightricks. All rights reserved.
//

#import "SetCardDeck.h"

#import "SetCard.h"

@implementation SetCardDeck

- (void)createDeck {
  NSUInteger numOfValidSymbols = [[SetCard validSymbols] count];
  NSUInteger numOfValidColors = [[SetCard validColors] count];
  NSUInteger numOfValidShadings = [[SetCard validShadings] count];
  NSUInteger numOfValidNumbers = [SetCard maxNumber];
  
  for (int symbol = 1; symbol <= numOfValidSymbols; symbol++) {
    for (int number = 1; number <= numOfValidNumbers; number++) {
      for (int color = 1; color <= numOfValidColors; color++) {
        for (int shading = 1; shading <= numOfValidShadings; shading++) {
          SetCard *card = [[SetCard alloc] init];
          card.symbol = symbol;
          card.number = number;
          card.color = color;
          card.shading = shading;
          [self addCard:card];
        }
      }
    }
  }
}


@end
