//
//  PlayingCardView.h
//  Matchismo
//
//  Created by Nophar Sarel on 17/10/2018.
//  Copyright © 2018 Lightricks. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CardView.h"

NS_ASSUME_NONNULL_BEGIN

/// A View of a Playing card.
@interface PlayingCardView : CardView

/// The rank of the card.
@property (nonatomic) NSUInteger rank;

/// The suit of the card.
@property (strong, nonatomic) NSString *suit;

/// Boolean represents the current state of the card.
@property (nonatomic) BOOL faceUp;

@end

NS_ASSUME_NONNULL_END
