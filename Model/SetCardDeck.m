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

- (instancetype)init {
  if (self = [super init]) {
    for (NSString *symbol in [SetCard validSymbols]) {
      for (NSUInteger number = 1; number <= [SetCard maxNumber]; number++) {
        for (NSString *color in [SetCard validColors]) {
          for (NSString *shading in [SetCard validShadings]) {
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
  return self;
}

@end
