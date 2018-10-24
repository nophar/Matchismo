//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Nophar Sarel on 08/10/2018.
//  Copyright © 2018 Lightricks. All rights reserved.
//

#import "CardGameViewController.h"

#import "CardMatchingGame.h"
#import "CardView.h"
#import "Grid.h"

@interface CardGameViewController ()

// The game Model of this controller.
@property (strong, nonatomic) CardMatchingGame *game;

// A Label that represents the current score in the game.
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

// A Grid object that is used to calculate the size and position of every cardView in the game.
@property (strong, nonatomic) Grid *grid;

// A generic UIView that serves as the boundary area for the cards.
@property (weak, nonatomic) IBOutlet UIView *cardsBoundaryView;

// A dynamic Animator that is used to add attachment behavior to the pile.
@property (strong, nonatomic) UIDynamicAnimator *animator;

// An attachment behavior, used to attach the gesture point to the pile.
@property (strong, nonatomic) UIAttachmentBehavior *attachment;

@end

@implementation CardGameViewController

- (UIDynamicAnimator *)animator
{
  if (!_animator)
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.cardsBoundaryView];
  return _animator;
}

- (CardMatchingGame *)game {
  if (!_game) {
    _game = [[CardMatchingGame alloc] initWithCardCount:[self getInitNumberOfCards]
                                                        usingDeck:[self createDeck]];
    [_game updateCurrentNumCardMatch:[self getCurrentNumCardMatch]];
  }
  return _game;
}

static const double kCellAspectRatio = 0.6;

- (Grid *)grid {
  if (!_grid) {
    _grid = [[Grid alloc] init];
    [_grid setMinimumNumberOfCells:[self getInitNumberOfCards]];
    [_grid setSize:self.cardsBoundaryView.bounds.size];
    [_grid setCellAspectRatio:kCellAspectRatio];
  }
  return _grid;
}

- (void)createCardsViews {
  [self addNewCardsViews:[self getInitNumberOfCards]];
}

- (void)updateGrid {
  if (self.grid.minimumNumberOfCells == self.game.getCurrentCardsNumber)
    return;
  else if (self.game.getCurrentCardsNumber < [self getInitNumberOfCards])
    [self addThreeCards];
  [self updateCardsViewsPositions];
}

static const int kNumCardsToAdd = 3;

- (void)addThreeCards {
  [self.game addCards:kNumCardsToAdd];
  [self.game setCurrentCardsNumber:[self.game getCurrentCardsNumber] + kNumCardsToAdd];
  [self addNewCardsViews:kNumCardsToAdd];
}

- (void)addNewCardsViews:(int)numOfNewCardsViews {
  self.grid.minimumNumberOfCells = self.game.getCurrentCardsNumber;
  CGRect cardRect = CGRectZero;
  cardRect.size = self.grid.cellSize;
  int currentNumOfSubViews = (int)[[self.cardsBoundaryView subviews] count];
  NSMutableArray<CardView *> *newCardViews = [NSMutableArray array];
  for (int cardIndex = currentNumOfSubViews; cardIndex < numOfNewCardsViews + currentNumOfSubViews;
       cardIndex++) {
    Card *newCard = [self.game cardAtIndex:cardIndex];
    CardView* newCardView = [self addCardView:cardRect card:newCard];
    [newCardView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
        action:@selector(handleSingleTap:)]];
    [self.cardsBoundaryView addSubview:newCardView];
    [newCardViews addObject:newCardView];
  }
  [self animateInsertCards:newCardViews];
}

- (void)updateCardsViewsPositions {
  if (![self.grid inputsAreValid])
    return;
  int row = 0;
  int col = 0;
  int curIndex = 0;
  for (CardView *cardView in self.cardsBoundaryView.subviews) {
    if (!cardView.hidden) {
      CGRect cardRect = cardView.frame;
      CGRect newCardRect = [self.grid frameOfCellAtRow:row inColumn:col];
      cardRect.size = newCardRect.size;
      cardRect.origin = newCardRect.origin;
      cardView.frame = cardRect;
      if (col < [self.grid columnCount] - 1)
        col++;
      else {
        col = 0;
        if (row < [self.grid rowCount] - 1)
          row++;
      }
    }
    curIndex++;
  }
}


- (void)updateUI {
  NSArray<CardView *> *cardsView = [self.cardsBoundaryView subviews];
  NSMutableArray<CardView *> *matchedCardsView = [NSMutableArray array];
  for (CardView *cardView in cardsView) {
    NSUInteger cardViewIndex = [cardsView indexOfObject:cardView];
    Card *card = [self.game cardAtIndex:cardViewIndex];
    if ([self isSupportRemovingCards] && card.matched && !cardView.hidden)
      [matchedCardsView addObject:cardView];
    [self updateCardView:card cardView:cardView];
  }
  if ([self isSupportRemovingCards] && [matchedCardsView count])
    [self animateRemovingCards:matchedCardsView];
  else {
    [self updateGrid];
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
  }
}

- (void)reduceCurrnetCardsNumber {
  [self.game setCurrentCardsNumber:(self.game.getCurrentCardsNumber - 1)];
}

#pragma mark -
#pragma mark UIViewController
#pragma mark -

- (void)viewDidLoad {
  [super viewDidLoad];
  [self createCardsViews];
  [self enablePanGesture:false];
  [self enableTapGesture:false];
}

- (void)viewDidLayoutSubviews {
  [self.grid setSize:self.cardsBoundaryView.bounds.size];
  [self updateCardsViewsPositions];
}

#pragma mark -
#pragma mark Gestures
#pragma mark -

- (void)enablePanGesture:(BOOL)enable {
  for (UIGestureRecognizer *gestureRecognizer in self.cardsBoundaryView.gestureRecognizers) {
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
      gestureRecognizer.enabled = enable;
      break;
    }
  }
}

- (void)enableTapGesture:(BOOL)enable {
  for (UIGestureRecognizer *gestureRecognizer in self.cardsBoundaryView.gestureRecognizers) {
    if ([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]) {
      gestureRecognizer.enabled = enable;
      break;
    }
  }
}

- (IBAction)pinchGesture:(UIPinchGestureRecognizer *)sender {
  [self animatePileOfCards];
}

- (IBAction)panGesture:(UIPanGestureRecognizer *)sender {
  CGPoint gesturePoint = [sender locationInView:self.cardsBoundaryView];
  CardView *pileTopView = [self.cardsBoundaryView.subviews firstObject];
  if (sender.state == UIGestureRecognizerStateBegan)
    [self attachPileToPoint:gesturePoint pileView:pileTopView];
  else if (sender.state == UIGestureRecognizerStateChanged) {
    self.attachment.anchorPoint = gesturePoint;
    for (CardView *cardView in self.cardsBoundaryView.subviews) {
      cardView.center = pileTopView.center;
    }
  }
  else if (sender.state == UIGestureRecognizerStateEnded)
    [self.animator removeBehavior:self.attachment];
}

-(void)attachPileToPoint:(CGPoint)anchorPoint pileView:(CardView *)pileView {
  if (!pileView)
    return;
  self.attachment = [[UIAttachmentBehavior alloc] initWithItem:pileView
                                              attachedToAnchor:anchorPoint];
  pileView = nil;
  [self.animator addBehavior:self.attachment];
}

- (IBAction)tapPileGesture:(UITapGestureRecognizer *)sender {
  [self animateInsertCards:self.cardsBoundaryView.subviews];
  [self enableTapGesture:false];
  [self enablePanGesture:false];
}

- (void)addTapGesture:(NSArray<CardView *> *)cardsView {
  for (CardView *cardView in cardsView) {
    [cardView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
       action:@selector(handleSingleTap:)]];
  }
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
  CardView *cardTappedView = (CardView *)(recognizer.view);
  NSArray<CardView *> *cardsView = [self.cardsBoundaryView subviews];
  NSUInteger tappedViewIndex = [cardsView indexOfObject:cardTappedView];
  [self.game chooseCardAtIndex:tappedViewIndex];
  [self updateUI];
}

#pragma mark -
#pragma mark Animations
#pragma mark -

- (void)animateInsertCards:(NSArray<CardView *> *)cardsToInsert {
  [UIView animateWithDuration:0.5 animations:^{
    [self updateCardsViewsPositions];
    }
   completion:nil];
}

- (void)animateRemovingCards:(NSArray<CardView *> *)cardsToRemove {
  [UIView animateWithDuration:0.5 animations:^{
    [self moveCardsViewsToRandomPoisitions:cardsToRemove];
  }
 completion:^(BOOL finished) {
   for (UIView *cardView in cardsToRemove) {
     cardView.hidden = true;
   }
   [self updateGrid];
   self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
 }];
}

- (void)animateRedealRemovingCards:(NSArray<CardView *> *)cardsToRemove {
  [UIView animateWithDuration:0.5 animations:^{
    [self moveCardsViewsToRandomPoisitions:cardsToRemove];
  }
 completion:^(BOOL finished) {
   [cardsToRemove makeObjectsPerformSelector:@selector(removeFromSuperview)];
   self.game = nil;
   self.grid = nil;
   self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
   [self addNewCardsViews:[self getInitNumberOfCards]];
 }];
}

- (void)moveCardsViewsToRandomPoisitions:(NSArray<CardView *> *)cardsToRemove {
  for (UIView *cardView in cardsToRemove) {
    int x = (arc4random()%(int)(self.cardsBoundaryView.bounds.size.width*5)) -
    (int)self.cardsBoundaryView.bounds.size.width*2;
    int y = self.cardsBoundaryView.bounds.size.height;
    cardView.center = CGPointMake(x, -y);
  }
}

- (void)animatePileOfCards {
  [UIView animateWithDuration:0.5 animations:^{
    for (UIView *cardView in self.cardsBoundaryView.subviews) {
      cardView.center = self.cardsBoundaryView.center;
    }
  }
   completion:^(BOOL finished) {
     [self enablePanGesture:true];
     [self enableTapGesture:true];
   }];
}

#pragma mark -
#pragma mark Buttons
#pragma mark -

- (IBAction)dealButton:(UIButton *)sender {
  NSArray<CardView *> *cardsViewToRemove = self.cardsBoundaryView.subviews;
  [self animateRedealRemovingCards:cardsViewToRemove];
}

#pragma mark -
#pragma mark Abstract methods
#pragma mark -

- (int)getInitNumberOfCards { //abstract
  return 0;
}

- (Deck *)createDeck { //abstract
  return nil;
}

- (int)getCurrentNumCardMatch { //abstract
  return  0;
}

- (CardView *)addCardView:(CGRect)cardRect card:(Card *)curCard { //absract
  return nil;
}

- (void)updateCardView:(Card *)card cardView:(CardView *)cardView { //abstract
}

- (BOOL)isSupportRemovingCards { //abstract
  return false;
}

@end
