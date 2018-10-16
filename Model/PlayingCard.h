//
//  PlayingCard.h
//  Matchismo
//
//  Created by Nophar Sarel on 08/10/2018.
//  Copyright © 2018 Lightricks. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

/// \c Card of a Playing Cards game.
@interface PlayingCard : Card

/// Returns an array of the valid suits of a card.
+ (NSArray *)validSuits;

/// Returns the maximum rank of a card.
+ (NSUInteger)maxRank;

/// The suit of the card.
@property (strong, nonatomic) NSString *suit;

/// The rank of the card.
@property (nonatomic) NSInteger rank;

@end

NS_ASSUME_NONNULL_END

