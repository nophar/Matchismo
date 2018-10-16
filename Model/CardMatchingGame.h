//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Nophar Sarel on 08/10/2018.
//  Copyright © 2018 Lightricks. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Card.h"
#import "Deck.h"

NS_ASSUME_NONNULL_BEGIN

/// Object that represents a game of matching cards.
@interface CardMatchingGame : NSObject

- (instancetype)init NS_UNAVAILABLE;

/// Initializes with the given \c count and \c deck.
/// Creates an array of \c count cards, using \c drawRandomCard of \c deck.
- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
    NS_DESIGNATED_INITIALIZER;

/// Marks the card in the given \c index as chosen. perform \c match if needed, updates score and
/// description accordingly.
- (void)chooseCardAtIndex:(NSUInteger)index;

/// Returns the card at the given \c index.
- (Card *)cardAtIndex:(NSUInteger)index;

/// Updates the number of cards involved in each game match.
- (void)updateCurrentNumCardMatch:(int)numCardMode;

/// Returns a string that describes the current state.
- (NSString *)getCurrentDescription;

/// Returns an array of the current chosen cards.
- (NSMutableArray<Card *> *)getCurrentChosenCards;

/// The current score of the game.
@property (readonly, nonatomic) NSInteger score;

@end

NS_ASSUME_NONNULL_END

