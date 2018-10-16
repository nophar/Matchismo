//
//  ViewController.h
//  Matchismo
//
//  Created by Nophar Sarel on 08/10/2018.
//  Copyright © 2018 Lightricks. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Card, Deck;

/// An abstract Controller of a cards' game.
@interface CardGameViewController : UIViewController

#pragma mark -
#pragma mark Abstract methods
#pragma mark -

/// An abstract method that creates the card table of the game.
- (Deck *)createDeck;

/// An abstract method that returns a string representation of the title of the card to display it
/// on the view.
- (NSMutableAttributedString *)titleForCard:(Card *)card;

/// An abstract method that returns a string representation of the title of the card to display it
/// in the \c descriptionLabel.
- (NSMutableAttributedString *)titleForCardDescription:(Card *)card;

/// An abstract method that returns the image of the card's background.
- (UIImage *)backgroundImageForCard:(Card *)card;

/// An abstract method that returns the number of cards involved in each game match.
- (int)getCurrentNumCardMatch;

@end

