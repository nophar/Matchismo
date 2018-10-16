//
//  HistoryViewController.h
//  Matchismo
//
//  Created by Nophar Sarel on 15/10/2018.
//  Copyright © 2018 Lightricks. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// A Controller of the history of card game.
@interface HistoryViewController : UIViewController

/// A string that represents the moves in the game.
@property (strong, nonatomic) NSAttributedString *descriptionLabel;

@end

NS_ASSUME_NONNULL_END
