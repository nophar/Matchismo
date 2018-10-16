//
//  SetCard.h
//  Matchismo
//
//  Created by Nophar Sarel on 14/10/2018.
//  Copyright © 2018 Lightricks. All rights reserved.
//

#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

/// \c Card of a Set game.
@interface SetCard : Card

/// Returns an array of the valid symbols of a card.
+ (NSArray *)validSymbols;

/// Returns an array of the valid colors of a card.
+ (NSArray *)validColors;

/// Returns an array of the valid shadings of a card.
+ (NSArray *)validShadings;

/// Returns the maximum number of symbols in a card.
+ (NSUInteger)maxNumber;

/// The symbol of the card.
@property (strong, nonatomic) NSString *symbol;

/// A string presentation of the color of the card.
@property (strong, nonatomic) NSString *color;

/// A string presentation of the shading of the card.
@property (strong, nonatomic) NSString *shading;

/// The number of symbols of the card.
@property (nonatomic) NSInteger number;

@end

NS_ASSUME_NONNULL_END
