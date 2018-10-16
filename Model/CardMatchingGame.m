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

// A string that describes the current state.
@property (nonatomic,strong) NSString *currentDescription;

//An array of the current chosen cards.
@property (nonatomic,strong) NSMutableArray<Card *> *currentChosenCards;

@end

@implementation CardMatchingGame

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck {
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
  self.score = 0;
  self.currentChosenCards = [[NSMutableArray alloc] init];
  self.currentDescription = @"";
  return self;
}

- (NSMutableArray<Card *> *)cards {
  if (!_cards)
    _cards=[[NSMutableArray alloc] init];
  return _cards;
}

- (NSString *)getCurrentDescription {
  return self.currentDescription;
}

- (NSMutableArray<Card *> *)getCurrentChosenCards {
  return self.currentChosenCards;
}

- (Card *)cardAtIndex:(NSUInteger)index {
  return (index<self.cards.count) ? self.cards[index] : nil;
}

static const int kMismatchPenalty = 2;
static const int kMatchBonus = 4;
static const int kCostToChoose = 1;

- (void)updateCurrentNumCardMatch:(int)numCardMode {
  self.numCardsMatch = numCardMode;
}

# pragma mark -
# pragma mark Choose card
# pragma mark -

- (void)chooseCardAtIndex:(NSUInteger)index {
  self.currentChosenCards = [[NSMutableArray alloc] init];
  self.currentDescription = @"";
  Card *card = [self cardAtIndex:index];
  if (card.matched)
    return;
  if (card.chosen)
    [self dechooseCard:card];
  else { // match against other chosen cards
    NSMutableArray<Card *> *chosenCards = [self getOtherChosenCards];
    self.currentChosenCards = chosenCards;
    if (chosenCards.count < (self.numCardsMatch - 1))
      [chosenCards firstObject].chosen = YES;
    else
      [self calculateScoreAndUpdatingDescription:chosenCards currentCard:card];
    self.score -= kCostToChoose;
    card.chosen = YES;
    [self.currentChosenCards addObject:card];
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

- (void)dechooseCard:(Card *)card {
  card.chosen = NO;
  for (Card *otherCard in self.cards) {
    if (otherCard.chosen && !otherCard.matched)
      self.currentDescription = [self.currentDescription
          stringByAppendingString:otherCard.contents];
  }
}

- (void)calculateScoreAndUpdatingDescription:(NSMutableArray<Card *> *)chosenCards
                                 currentCard:(Card *)card{
  int matchScore = [card match:chosenCards];
  if (matchScore) {
    self.score += matchScore * kMatchBonus;
    for (Card *otherCard in chosenCards) {
      otherCard.matched = YES;
    }
    card.matched = YES;
    self.currentDescription = [NSString stringWithFormat:@" do match! %d points!",
        matchScore * kMatchBonus];
  }
  else {
    self.score -= kMismatchPenalty;
    for (Card *otherCard in chosenCards) {
      otherCard.chosen = NO;
    }
    self.currentDescription = @" don't match! 2 points penalty!";
  }
}

@end

NS_ASSUME_NONNULL_END
