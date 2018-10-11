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
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards;
@property (nonatomic) int numCardsMode;
@property (nonatomic,strong) NSString *currentDescription;
@end

@implementation CardMatchingGame

- (NSString *)getCurrentDescription {
    return self.currentDescription;
}

- (NSMutableArray<Card *> *)cards
{
    if (!_cards) _cards=[[NSMutableArray alloc] init];
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    if (self = [super init])
    {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) [self.cards addObject:card];
            else {
                self = nil;
                break;
            }
        }
    }
    self.numCardsMode = NUM_CARDS_TWO_CARDS_MODE;
    self.currentDescription = @"";
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index<self.cards.count) ? self.cards[index] : nil;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;
static const int NUM_CARDS_TWO_CARDS_MODE = 2;


-(void)updateCurrentMatchMode:(int)matchMode
{
    self.numCardsMode = matchMode + NUM_CARDS_TWO_CARDS_MODE;
}

- (void)dechooseCard:(Card *)card
{
    card.chosen = NO;
    for (Card *otherCard in self.cards) {
        if (otherCard.chosen && !otherCard.matched)
            self.currentDescription = [self.currentDescription stringByAppendingString:otherCard.contents];
    }
}
- (NSMutableArray<Card *> *)getChosenCards
{
    NSMutableArray<Card *> *chosenCards = [[NSMutableArray alloc] init];
    for (Card *otherCard in self.cards) {
        if (otherCard.chosen && !otherCard.matched) {
            [chosenCards addObject:otherCard];
            self.currentDescription = [self.currentDescription stringByAppendingString:otherCard.contents];
        }
    }
    return chosenCards;
}

- (void)chooseCardAtIndex:(NSUInteger)index
{
    self.currentDescription = @"";
    Card *card = [self cardAtIndex:index];
    if (!card.matched) {
        if (card.chosen) {
            [self dechooseCard:card];
            }
        else { // match against other chosen cards
            self.currentDescription = [self.currentDescription stringByAppendingString:card.contents];
            NSMutableArray<Card *> *chosenCards = [self getChosenCards];
            if (chosenCards.count < (self.numCardsMode - 1)) {
                [chosenCards firstObject].chosen = YES;
            }
            else {
                int matchScore = [card match:chosenCards];
                if (matchScore) {
                    self.score += matchScore * MATCH_BONUS;
                    for (Card *otherCard in chosenCards) {
                        otherCard.matched = YES;
                    }
                    card.matched = YES;
                    self.currentDescription = [self.currentDescription stringByAppendingString:[NSString stringWithFormat:@" do match! %d points!", matchScore]];
                }
                else {
                    self.score -= MISMATCH_PENALTY;
                    for (Card *otherCard in chosenCards) {
                        otherCard.chosen = NO;
                    }
                    self.currentDescription = [self.currentDescription stringByAppendingString:@" don't match! 2 points penalty!"];
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}
@end

NS_ASSUME_NONNULL_END
