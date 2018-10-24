//
//  SetCardView.h
//  Matchismo
//
//  Created by Nophar Sarel on 18/10/2018.
//  Copyright © 2018 Lightricks. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CardView.h"

NS_ASSUME_NONNULL_BEGIN

/// A View of a Set card.
@interface SetCardView : CardView

/// The symbol of the card.
@property (nonatomic) NSInteger symbol;

/// A string presentation of the color of the card.
@property (nonatomic) UIColor *color;

/// A string presentation of the shading of the card.
@property (nonatomic) NSInteger shading;

/// The number of symbols of the card.
@property (nonatomic) NSInteger number;

@end

NS_ASSUME_NONNULL_END
