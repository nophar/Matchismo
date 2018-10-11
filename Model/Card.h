//
//  Card.h
//  Matchismo
//
//  Created by Nophar Sarel on 8 October 2018.
//  Copyright © 5779 Lightricks. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;
@property (nonatomic) BOOL chosen;
@property (nonatomic) BOOL matched;

- (int)match:(NSArray *)otherCards;

@end

NS_ASSUME_NONNULL_END
