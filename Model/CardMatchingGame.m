//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Nophar Sarel on 08/10/2018.
//  Copyright © 2018 Lightricks. All rights reserved.
//

#import "CardMatchingGame.h"

NS_ASSUME_NONNULL_BEGIN

@interface CardMatchingGame()

// The current score of the game.
@property (readwrite, nonatomic) NSInteger score;

// An array of the cards of the game.
@property (nonatomic, strong) NSMutableArray<Card *> *cards;

// Number of cards involved in each game match.
@property (nonatomic) int numCardsMatch;

// Current number of cards in the game.
@property (nonatomic) int numCardsOnDeck;

// The \c Deck of the game.
@property (nonatomic) Deck *gameDeck;

@end

@implementation CardMatchingGame

- (instancetype)initWithCardCount:(int)count usingDeck:(Deck *)deck {
  if (self = [super init]) {
    for (int i = 0; i < count; i++) {
      Card *card = [deck drawRandomCard];
      if (card)
        [self.cards addObject:card];
      else {
        self = nil;
        break;
      }
    }
  }
  self.gameDeck = deck;
  self.score = 0;
  self.numCardsOnDeck = count;
  return self;
}

- (NSMutableArray<Card *> *)cards {
  if (!_cards)
    _cards=[[NSMutableArray alloc] init];
  return _cards;
}

- (int)getCurrentCardsNumber {
  return self.numCardsOnDeck;
}

- (void)setCurrentCardsNumber:(int)numCardsOnDeck {
  self.numCardsOnDeck = numCardsOnDeck;
}

- (Card *)cardAtIndex:(NSUInteger)index {
  return (index<self.cards.count) ? self.cards[index] : nil;
}

- (void)updateCurrentNumCardMatch:(int)numCardMode {
  self.numCardsMatch = numCardMode;
}

- (NSArray<Card *> *)addCards:(int)numOfCardsToAdd {
  NSMutableArray<Card *> *newCards = [[NSMutableArray alloc] init];
  for (int i = 0; i < numOfCardsToAdd; i++) {
    Card *card = [self.gameDeck drawRandomCard];
    if (card) {
      [self.cards addObject:card];
      [newCards addObject:card];
    }
  }
  return newCards;
}

# pragma mark -
# pragma mark Choose card
# pragma mark -

static const int kMismatchPenalty = 2;
static const int kMatchBonus = 4;
static const int kCostToChoose = 1;

- (void)chooseCardAtIndex:(NSUInteger)index {
  Card *card = [self cardAtIndex:index];
  if (card.matched)
    return;
  if (card.chosen)
    card.chosen = NO;
  else { // match against other chosen cards
    NSMutableArray<Card *> *chosenCards = [self getOtherChosenCards];
    if (chosenCards.count < (self.numCardsMatch - 1))
      [chosenCards firstObject].chosen = YES;
    else
      [self calculateScore:chosenCards currentCard:card];
    self.score -= kCostToChoose;
    card.chosen = YES;
  }
}

- (NSMutableArray<Card *> *)getOtherChosenCards {
  NSMutableArray<Card *> *chosenCards = [[NSMutableArray alloc] init];
  for (Card *otherCard in self.cards) {
    if (otherCard.chosen && !otherCard.matched)
      [chosenCards addObject:otherCard];
  }
  return chosenCards;
}

- (void)calculateScore:(NSMutableArray<Card *> *)chosenCards currentCard:(Card *)card{
  int matchScore = [card match:chosenCards];
  if (matchScore) {
    self.score += matchScore * kMatchBonus;
    for (Card *otherCard in chosenCards) {
      otherCard.matched = YES;
    }
    card.matched = YES;
  }
  else {
    self.score -= kMismatchPenalty;
    for (Card *otherCard in chosenCards) {
      otherCard.chosen = NO;
    }
  }
}

@end

NS_ASSUME_NONNULL_END
