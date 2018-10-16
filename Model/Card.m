//
//  Card.m
//  Matchismo
//
//  Created by Nophar Sarel on 08/10/2018.
//  Copyright © 2018 Lightricks. All rights reserved.
//

#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

@implementation Card

- (int)match:(NSArray<Card*> *)otherCards {
  int score = 0;
  for (Card *card in otherCards) {
    if ([card.contents isEqualToString:self.contents])
      score = 1;
  }
  return score;
}

@end

NS_ASSUME_NONNULL_END

