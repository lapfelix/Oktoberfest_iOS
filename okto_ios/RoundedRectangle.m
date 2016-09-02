//
//  RoundedRectangle.m
//  okto_ios
//
//  Created by Felix Lapalme on 2016-09-02.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "RoundedRectangle.h"

IB_DESIGNABLE

@implementation RoundedRectangle

- (instancetype)initWithFrame: (CGRect)frame fillColor: (UIColor*)fillColor strokeColor: (UIColor*)strokeColor cornerRadius: (CGFloat)cornerRadius strokeWidth: (CGFloat)strokeWidth {
    self = [super initWithFrame:frame];
    if (self != nil) {
        _fillColor = fillColor;
        _strokeColor = strokeColor;
        _strokeWidth = strokeWidth;
        _cornerRadius = cornerRadius;
    }
    return self;
}

- (void)setStrokeColor:(UIColor *)strokeColor {
    _strokeColor = strokeColor;
    [self setNeedsDisplay];
}

- (void)setStrokeWidth:(float)strokeWidth {
    _strokeWidth = strokeWidth;
    [self setNeedsDisplay];
}

- (void)setFillColor:(UIColor *)fillColor {
    _fillColor = fillColor;
    [self setNeedsDisplay];
}

- (void)setCornerRadius:(float)cornerRadius {
    _cornerRadius = cornerRadius;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(CGRectGetMinX(rect) + (self.strokeWidth/2),
                                                                                      CGRectGetMinY(rect) + (self.strokeWidth/2),
                                                                                      CGRectGetWidth(rect) - self.strokeWidth,
                                                                                      CGRectGetHeight(rect) - self.strokeWidth)
                                                             cornerRadius: self.cornerRadius];
    [self.fillColor setFill];
    [rectanglePath fill];
    [self.strokeColor setStroke];
    rectanglePath.lineWidth = self.strokeWidth;
    [rectanglePath stroke];
}

@end
