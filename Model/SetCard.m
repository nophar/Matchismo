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

+ (NSArray *)validSymbols {
  return @[@"▲",@"●",@"■"];
}

- (void)setSymbol:(NSString *)symbol {
  if ([[SetCard validSymbols] containsObject:symbol])
    _symbol = symbol;
}

- (void)setNumber:(NSInteger)number {
  if (number <= [SetCard maxNumber])
    _number = number;
}

- (void)setColor:(NSString *)color {
  if ([[SetCard validColors] containsObject:color])
    _color = color;
}

- (void)setShading:(NSString *)shading {
  if ([[SetCard validShadings] containsObject:shading])
    _shading = shading;
}

- (NSString *)symbol {
  return _symbol ? _symbol : @"?";
}

- (NSString *)color {
  return _color ? _color : @"?";
}

- (NSString *)shading {
  return _shading ? _shading : @"?";
}

#pragma mark -
#pragma mark Class methods
#pragma mark -

+ (NSUInteger)maxNumber {
  return [[self validNumbers] count];
}

+ (NSArray *)validNumbers {
  return @[@1, @2, @3];
}

+ (NSArray *)validColors {
  return @[@"Red", @"Green", @"Purple"];
}

+ (NSArray *)validShadings {
  return @[@"Solid", @"Striped", @"Open"];
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
    if ([self.symbol isEqualToString:otherCard.symbol])
      sameSymbolCounter++;
    else
      differentSymbolCounter++;
  }
  if (sameSymbolCounter == kNumOfOtherCards)
    return true;
  else if (differentSymbolCounter == kNumOfOtherCards && ![otherCards[0].symbol
      isEqualToString:otherCards[1].symbol])
    return true;
  return false;
}

- (BOOL)isMatchColor:(NSArray<SetCard *> *)otherCards {
  int sameColorCounter = 0;
  int differentColorCounter = 0;
  for (SetCard *otherCard in otherCards) {
    if ([self.color isEqualToString:otherCard.color])
      sameColorCounter++;
    else
      differentColorCounter++;
  }
  if (sameColorCounter == kNumOfOtherCards)
    return true;
  else if (differentColorCounter == kNumOfOtherCards && ![otherCards[0].color
      isEqualToString:otherCards[1].color])
    return true;
  return false;
}

- (BOOL)isMatchShading:(NSArray<SetCard *> *)otherCards {
  int sameShadingCounter = 0;
  int differentShadingCounter = 0;
  for (SetCard *otherCard in otherCards) {
    if ([self.shading isEqualToString:otherCard.shading])
      sameShadingCounter++;
    else
      differentShadingCounter++;
  }
  if (sameShadingCounter == kNumOfOtherCards)
    return true;
  else if (differentShadingCounter == kNumOfOtherCards && ![otherCards[0].shading
      isEqualToString:otherCards[1].shading])
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
