//
//  PlayingCard.m
//  Matchismo
//
//  Created by Nophar Sarel on 08/10/2018.
//  Copyright © 2018 Lightricks. All rights reserved.
//

#import "PlayingCard.h"

NS_ASSUME_NONNULL_BEGIN


@implementation PlayingCard

- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;

+ (NSArray *)validSuits
{
    return @[@"♥️",@"♦️",@"♠️",@"♣️"];
}

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) _suit = suit;
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRank
{
    return [[self rankStrings] count] -1;
}

- (void)setRank:(NSInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

- (int)match2Cards:(PlayingCard *)otherCard
{
    int score = 0;
    if (otherCard.rank == self.rank){
        score = 4;
    }
    else if ([otherCard.suit isEqualToString:self.suit]) {
        score = 1;
    }
    return score;
}

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    for (PlayingCard *otherCard in otherCards) {
        score += [self match2Cards:otherCard];
    }
    if (otherCards.count > 1) {
        score += [[otherCards lastObject] match2Cards:[otherCards firstObject]];
    }
    return score;
}

@end

NS_ASSUME_NONNULL_END
