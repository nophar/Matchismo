//
//  CardView.h
//  Matchismo
//
//  Created by Nophar Sarel on 21/10/2018.
//  Copyright © 2018 Lightricks. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// An abstract View of a cards' game.
@interface CardView : UIView

- (CGFloat)cornerScaleFactor;

- (CGFloat)cornerRadius;

- (CGFloat)cornerOffset;

@end

NS_ASSUME_NONNULL_END
