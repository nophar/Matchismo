//
//  HistoryViewController.m
//  Matchismo
//
//  Created by Nophar Sarel on 15/10/2018.
//  Copyright © 2018 Lightricks. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController ()

// Text that shows the moves in the game.
@property (weak, nonatomic) IBOutlet UITextView *historyTextView;

@end

@implementation HistoryViewController

#pragma mark -
#pragma mark UIViewController
#pragma mark -

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self updateUI];
}

#pragma mark -
#pragma mark Show History
#pragma mark -

- (void)setCurrentDescription:(NSAttributedString *)descriptionLabel {
  _descriptionLabel = descriptionLabel;
  if (self.view.window)
    [self updateUI];
}

- (void)updateUI {
  self.historyTextView.attributedText = self.descriptionLabel;
}

@end
