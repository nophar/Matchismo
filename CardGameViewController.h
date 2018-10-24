//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Nophar Sarel on 08/10/2018.
//  Copyright © 2018 Lightricks. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Card, Deck, CardView;

/// An abstract Controller of a cards' game.
@interface CardGameViewController : UIViewController

/// Adds three card (and their views) to the game when pressing "add Cards" button.
- (void)addThreeCards;

/// Reduces the game's current number of cards by one.
- (void)reduceCurrnetCardsNumber;

#pragma mark -
#pragma mark Abstract methods
#pragma mark -
  
/// An abstract method that creates the card table of the game.
- (Deck *)createDeck;

/// An abstract method that creates a \c cardView according to the card's type.
- (CardView *)addCardView:(CGRect)cardRect card:(Card *)curCard;

/// An abstract method that returns the number of cards involved in each game match.
- (int)getCurrentNumCardMatch;

/// An abstract method that updates the \c cardView state according to the last step of the game.
- (void)updateCardView:(Card *)card cardView:(CardView *)cardView;

/// An abstract method that indicates whether the game support removing match cards from the view.
- (BOOL)isSupportRemovingCards;

@end
