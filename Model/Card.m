//
//  Card.m
//  Matchismo
//
//  Created by Nophar Sarel on 8 October 2018.
//  Copyright © 5779 Lightricks. All rights reserved.
//

#import "Card.h"

NS_ASSUME_NONNULL_BEGIN


@implementation Card

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    return score;
}


@end

NS_ASSUME_NONNULL_END

