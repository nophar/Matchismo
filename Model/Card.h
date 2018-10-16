//
//  Card.h
//  Matchismo
//
//  Created by Nophar Sarel on 08/10/2018.
//  Copyright © 2018 Lightricks. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// Object that represents a game card.
@interface Card : NSObject

/// Returns a score according to the matching of the array of cards it receives.
/// \c 0 if they do not match.
- (int)match:(NSArray<Card*> *)otherCards;

/// String representing the title of the card.
@property (strong, nonatomic) NSString *contents;

/// Boolean representing if the card is chosen in the game or not.
@property (nonatomic) BOOL chosen;

/// Boolean representing if the card was already matched with other cards.
@property (nonatomic) BOOL matched;

@end

NS_ASSUME_NONNULL_END
