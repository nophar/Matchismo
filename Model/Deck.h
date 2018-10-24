//
//  Deck.h
//  Matchismo
//
//  Created by Nophar Sarel on 08/10/2018.
//  Copyright © 2018 Lightricks. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

/// Object that represents a deck of cards.
@interface Deck : NSObject

/// Adds a card to the deck, at the top if \c atTop is \c True.
- (void)addCard:(Card*)card atTop:(BOOL)atTop;

/// Adds a card to the deck.
- (void)addCard:(Card*)card;

/// Returns a random card from the deck's cards.
- (Card *)drawRandomCard;

/// When the cards are over, creates the Deck's cards again.
- (void)createDeck;

@end

NS_ASSUME_NONNULL_END
