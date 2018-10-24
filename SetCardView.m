//
//  SetCardView.m
//  Matchismo
//
//  Created by Nophar Sarel on 18/10/2018.
//  Copyright © 2018 Lightricks. All rights reserved.
//

#import "SetCardView.h"

@implementation SetCardView

- (void)drawNumber {
  for (int i = 1; i <= self.number; i++) {
    [self drawSymbolAtPoint:CGPointMake(self.bounds.origin.x + self.bounds.size.width/2,
                                        self.bounds.origin.y + i*self.bounds.size.height/(self.number+1))];
  }
}

#pragma mark -
#pragma mark Drawing Symbols
#pragma mark -

#define SQUIGGLE 1
#define DAIMOND 2
#define OVAL 3

- (void)drawSymbolAtPoint:(CGPoint)point {
  switch (self.symbol) {
    case SQUIGGLE: {
      [self drawSquiggleAtPoint:point];
      break;
    }
    case OVAL: {
      [self drawOvalAtPoint:point];
      break;
    }
    default: {
      [self drawDaimondAtPoint:point];
      break;
    }
  }
}

#define SYMBOL_LINE_WIDTH 1

#define SQUIGGLE_WIDTH 0.12
#define SQUIGGLE_HEIGHT 0.3
#define SQUIGGLE_FACTOR 0.8

- (void)drawSquiggleAtPoint:(CGPoint)point {
  CGFloat dx = self.bounds.size.width * SQUIGGLE_WIDTH / 2.0;
  CGFloat dy = self.bounds.size.height * SQUIGGLE_HEIGHT / 2.0;
  CGFloat dsqx = dx * SQUIGGLE_FACTOR;
  CGFloat dsqy = dy * SQUIGGLE_FACTOR;
  
  UIBezierPath *path = [[UIBezierPath alloc] init];
  [path moveToPoint:CGPointMake(point.x - dx, point.y - dy)];
  [path addQuadCurveToPoint:CGPointMake(point.x + dx, point.y - dy)
               controlPoint:CGPointMake(point.x - dsqx, point.y - dy - dsqy)];
  [path addCurveToPoint:CGPointMake(point.x + dx, point.y + dy)
          controlPoint1:CGPointMake(point.x + dx + dsqx, point.y - dy + dsqy)
          controlPoint2:CGPointMake(point.x + dx - dsqx, point.y + dy - dsqy)];
  [path addQuadCurveToPoint:CGPointMake(point.x - dx, point.y + dy)
               controlPoint:CGPointMake(point.x + dsqx, point.y + dy + dsqy)];
  [path addCurveToPoint:CGPointMake(point.x - dx, point.y - dy)
          controlPoint1:CGPointMake(point.x - dx - dsqx, point.y + dy - dsqy)
          controlPoint2:CGPointMake(point.x - dx + dsqx, point.y - dy + dsqy)];
  path.lineWidth = self.bounds.size.width * 0.02;
  [self rotatePath:path degree:90];
  [self shadePath:path];
  [path stroke];
}

- (void)rotatePath:(UIBezierPath *)path degree:(CGFloat)degree {
  CGRect bounds = CGPathGetBoundingBox(path.CGPath);
  CGPoint center = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));
  
  CGFloat radians = (degree / 180.0f * M_PI);
  CGAffineTransform transform = CGAffineTransformIdentity;
  transform = CGAffineTransformTranslate(transform, center.x, center.y);
  transform = CGAffineTransformRotate(transform, radians);
  transform = CGAffineTransformTranslate(transform, -center.x, -center.y);
  [path applyTransform:transform];
}

#define DAIMOND_WIDTH 0.3
#define DAIMOND_HEIGHT 0.3

- (void)drawDaimondAtPoint:(CGPoint)point {
  
  CGFloat dx = self.bounds.size.height * DAIMOND_WIDTH / 2.0;
  CGFloat dy = self.bounds.size.width * DAIMOND_HEIGHT / 2.0;

  UIBezierPath *path = [[UIBezierPath alloc] init];
  [path moveToPoint:CGPointMake(point.x, point.y - dy)];
  [path addLineToPoint:CGPointMake(point.x + dx, point.y)];
  [path addLineToPoint:CGPointMake(point.x, point.y + dy)];
  [path addLineToPoint:CGPointMake(point.x - dx, point.y)];
  [path addLineToPoint:CGPointMake(point.x, point.y - dy)];
  [path closePath];
  [path setLineWidth:SYMBOL_LINE_WIDTH];
  [self shadePath:path];
  [path stroke];
}

#define OVAL_WIDTH 0.7
#define OVAL_HEIGHT 0.6

- (void)drawOvalAtPoint:(CGPoint)point {
  
  CGFloat dx = self.bounds.size.height * OVAL_WIDTH / 2.0;
  CGFloat dy = self.bounds.size.width * OVAL_HEIGHT / 2.0;
  
  CGRect ovalRect = CGRectMake(point.x - 0.5 * dx, point.y - 0.5 * dy, dx, dy);
  UIBezierPath *oval = [UIBezierPath bezierPathWithOvalInRect:ovalRect];
  [oval setLineWidth:SYMBOL_LINE_WIDTH];
  [self shadePath:oval];
  [oval stroke];   // draw the outline of the shape
}

#pragma mark -
#pragma mark Shadings
#pragma mark -

#define SOLID 1
#define STRIPED 2
#define OPEN 3

- (void)shadePath:(UIBezierPath *)path {
  switch (self.shading) {
    case OPEN:
      return;
    case SOLID: {
      [path fill];
      return;
    }
    default:
      [self shadePathWithStripes:path];
  }
}

#define NUM_OF_STRIPES_PER_CARD 7

- (void)shadePathWithStripes:(UIBezierPath *)path {
  UIBezierPath *stripes = [UIBezierPath bezierPath];
  int distanceBetweenStripes = self.bounds.size.width / (NUM_OF_STRIPES_PER_CARD + 1);
  for ( int x = 0; x < path.bounds.size.width; x += distanceBetweenStripes )
  {
    [stripes moveToPoint:CGPointMake(path.bounds.origin.x + x, path.bounds.origin.y)];
    [stripes addLineToPoint:CGPointMake(path.bounds.origin.x + x, path.bounds.origin.y +
                                        path.bounds.size.height )];
  }
  [stripes setLineWidth:SYMBOL_LINE_WIDTH];
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSaveGState(context);
  [path addClip];
  [self.color set];
  [stripes stroke];
  CGContextRestoreGState(context);
}

#pragma mark -
#pragma mark Drawing
#pragma mark -

- (void)drawRect:(CGRect)rect {
  UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                         cornerRadius:[self cornerRadius]];
  [roundedRect addClip];
  [[UIColor whiteColor] setFill];
  UIRectFill(self.bounds);
  [[UIColor blackColor] setStroke];
  [roundedRect stroke];
  [self.color setStroke];
  [self.color setFill];
  [self drawNumber];
}

@end
