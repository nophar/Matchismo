//
//  Deck.m
//  Matchismo
//
//  Created by Nophar Sarel on 08/10/2018.
//  Copyright © 2018 Lightricks. All rights reserved.
//

#import "Deck.h"

NS_ASSUME_NONNULL_BEGIN

@interface Deck()

// An array of the deck's cards.
@property (strong, nonatomic) NSMutableArray *cards;

@end

@implementation Deck

- (instancetype)init {
  if (self = [super init]) {
    [self createDeck];
  }
  return self;
}

- (NSMutableArray *)cards {
  if (!_cards) _cards = [[NSMutableArray alloc] init];
  return _cards;
}

- (void)addCard:(Card *)card atTop:(BOOL)atTop {
  if (atTop)
    [self.cards insertObject:card  atIndex:0];
  else
    [self.cards addObject:card];
}

- (void)addCard:(Card *)card {
  [self addCard:card atTop:NO];
}

- (void)createDeck {
}

- (Card *)drawRandomCard {
  Card *randomCard = nil;
  if (![self.cards count])
    [self createDeck];
  unsigned index = arc4random() % [self.cards count];
  randomCard = self.cards[index];
  [self.cards removeObjectAtIndex:index];
  return randomCard;
}

@end

NS_ASSUME_NONNULL_END
