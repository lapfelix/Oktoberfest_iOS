//
//  OKTLetterKeyLayer.m
//  okto_ios
//
//  Created by Felix Lapalme on 2016-09-03.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "OKTLetterKeyLayer.h"
@import UIKit;

@implementation OKTLetterKeyLayer

- (id<CAAction>)actionForKey:(NSString *)key
{
    if ([key isEqualToString:@"pressFactor"])
    {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:key];
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        animation.fromValue = @([[self presentationLayer] pressFactor ]);
        return animation;
    }
    return [super actionForKey:key];
}

+ (BOOL)needsDisplayForKey:(NSString *)key
{
    if ([@"pressFactor" isEqualToString:key])
    {
        return YES;
    }
    return [super needsDisplayForKey:key];
}

- (void)setPressFactor:(float)pressFactor {
    _pressFactor = pressFactor;
    [self setNeedsDisplay];
}

- (void)drawInContext:(CGContextRef)ctx {
    UIGraphicsPushContext(ctx);
    
    CGRect rect = self.bounds;
    
    UIColor *keyColor = self.keyColor;
    float pressFactor = self.pressFactor;
    
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Color Declarations
    CGFloat keyColorHSBA[4];
    [keyColor getHue: &keyColorHSBA[0] saturation: &keyColorHSBA[1] brightness: &keyColorHSBA[2] alpha: &keyColorHSBA[3]];
    
    UIColor* color2 = [UIColor colorWithHue: keyColorHSBA[0] saturation: keyColorHSBA[1] brightness: 0.505 alpha: keyColorHSBA[3]];
    UIColor* shadowColor = [UIColor colorWithRed: 0 green: 0 blue: 0 alpha: 0.331];
    
    //// Shadow Declarations
    NSShadow* shadow = [[NSShadow alloc] init];
    [shadow setShadowColor: shadowColor];
    [shadow setShadowOffset: CGSizeMake(0.1, 3.1)];
    [shadow setShadowBlurRadius: 5];
    
    //// Variable Declarations
    CGFloat maxPress = 11;
    CGFloat yDisplacement = 6 + pressFactor * maxPress;
    
    //// Rectangle Drawing
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(CGRectGetMinX(rect) + 15, CGRectGetMinY(rect) + 18, 100, 96) cornerRadius: 15];
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius, [shadow.shadowColor CGColor]);
    [color2 setFill];
    [rectanglePath fill];
    CGContextRestoreGState(context);
    
    //// Rectangle 2 Drawing
    UIBezierPath* rectangle2Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(15, yDisplacement, 100, 96) cornerRadius: 15];
    [keyColor setFill];
    [rectangle2Path fill];
    
    
    //// Text Drawing
    CGRect textRect = CGRectMake(15, yDisplacement, 100, 96);
    {
        NSString* textContent = @"A";
        NSMutableParagraphStyle* textStyle = [NSMutableParagraphStyle new];
        textStyle.alignment = NSTextAlignmentCenter;
        
        NSDictionary* textFontAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize: 70], NSForegroundColorAttributeName: UIColor.blackColor, NSParagraphStyleAttributeName: textStyle};
        
        CGFloat textTextHeight = [textContent boundingRectWithSize: CGSizeMake(textRect.size.width, INFINITY)  options: NSStringDrawingUsesLineFragmentOrigin attributes: textFontAttributes context: nil].size.height;
        CGContextSaveGState(context);
        CGContextClipToRect(context, textRect);
        [textContent drawInRect: CGRectMake(CGRectGetMinX(textRect), CGRectGetMinY(textRect) + (CGRectGetHeight(textRect) - textTextHeight) / 2, CGRectGetWidth(textRect), textTextHeight) withAttributes: textFontAttributes];
        CGContextRestoreGState(context);
    }
    
    UIGraphicsPopContext();
}

@end
