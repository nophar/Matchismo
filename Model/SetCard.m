//
//  SetCard.m
//  Matchismo
//
//  Created by Nophar Sarel on 14/10/2018.
//  Copyright © 2018 Lightricks. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

#pragma mark -
#pragma mark Setters and Getters
#pragma mark -

@synthesize symbol = _symbol;
@synthesize color = _color;
@synthesize shading = _shading;

- (NSString *)contents {
  return nil;
}

#pragma mark -
#pragma mark Class methods
#pragma mark -

+ (NSUInteger)maxNumber {
  return [[self validNumbers] count];
}

#define SQUIGGLE 1
#define DAIMOND 2
#define OVAL 3

+ (NSArray *)validSymbols {
  return @[@SQUIGGLE, @DAIMOND, @OVAL];
}

+ (NSArray *)validNumbers {
  return @[@1, @2, @3];
}

#define RED 1
#define GREEN 2
#define PURPLE 3

+ (NSArray *)validColors {
  return @[@RED, @GREEN, @PURPLE];
}

#define SOLID 1
#define STRIPED 2
#define OPEN 3

+ (NSArray *)validShadings {
  return @[@SOLID, @STRIPED, @OPEN];
}

#pragma mark -
#pragma mark Card
#pragma mark -

static const int kMatchScore = 2;

- (int)match:(NSArray *)otherCards {
  int score = 0;
  if ([self isMatchSymbol:otherCards] && [self isMatchColor:otherCards] &&
      [self isMatchShading:otherCards] && [self isMatchNumber:otherCards])
    score = kMatchScore;
  return score;
}

static const int kNumOfOtherCards = 2;

- (BOOL)isMatchSymbol:(NSArray<SetCard *> *)otherCards {
  int sameSymbolCounter = 0;
  int differentSymbolCounter = 0;
  for (SetCard *otherCard in otherCards) {
    if (self.symbol == otherCard.symbol)
      sameSymbolCounter++;
    else
      differentSymbolCounter++;
  }
  if (sameSymbolCounter == kNumOfOtherCards)
    return true;
  else if (differentSymbolCounter == kNumOfOtherCards && otherCards[0].symbol !=
           otherCards[1].symbol)
    return true;
  return false;
}

- (BOOL)isMatchColor:(NSArray<SetCard *> *)otherCards {
  int sameColorCounter = 0;
  int differentColorCounter = 0;
  for (SetCard *otherCard in otherCards) {
    if (self.color==otherCard.color)
      sameColorCounter++;
    else
      differentColorCounter++;
  }
  if (sameColorCounter == kNumOfOtherCards)
    return true;
  else if (differentColorCounter == kNumOfOtherCards && otherCards[0].color != otherCards[1].color)
    return true;
  return false;
}

- (BOOL)isMatchShading:(NSArray<SetCard *> *)otherCards {
  int sameShadingCounter = 0;
  int differentShadingCounter = 0;
  for (SetCard *otherCard in otherCards) {
    if (self.shading==otherCard.shading)
      sameShadingCounter++;
    else
      differentShadingCounter++;
  }
  if (sameShadingCounter == kNumOfOtherCards)
    return true;
  else if (differentShadingCounter == kNumOfOtherCards && otherCards[0].shading !=
           otherCards[1].shading)
    return true;
  return false;
}

- (BOOL)isMatchNumber:(NSArray<SetCard *> *)otherCards {
  int sameNumberCounter = 0;
  int differentNumberCounter = 0;
  for (SetCard *otherCard in otherCards) {
    if (self.number == otherCard.number)
      sameNumberCounter++;
    else
      differentNumberCounter++;
  }
  if (sameNumberCounter == kNumOfOtherCards)
    return true;
  else if (differentNumberCounter == kNumOfOtherCards && otherCards[0].number !=
      otherCards[1].number)
    return true;
  return false;
}

@end
