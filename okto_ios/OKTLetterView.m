//
//  OKTLetterView.m
//  okto_ios
//
//  Created by Felix Lapalme on 2016-09-03.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "OKTLetterView.h"
#import "OKTLetterKeyLayer.h"

@interface OKTLetterView () <CALayerDelegate>

@property (copy, nonatomic) OKTLetterKeyLayer *keyLayer;

@end

@implementation OKTLetterView

@dynamic pressFactor;

- (instancetype)init {
    self = [super init];
    if (self != nil) {
        _keyLayer = [[OKTLetterKeyLayer alloc] initWithLayer:self.layer];
        
        self.keyLayer.frame = self.frame;
        [self.layer setNeedsDisplay];
        [self.layer addSublayer:self.keyLayer];
        self.keyLayer.delegate = self;
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [UIView animateWithDuration:0.5 animations:^{
        self.keyLayer.pressFactor = 1;
    }];
}

- (void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [UIView animateWithDuration:0.5 animations:^{
        self.keyLayer.pressFactor = 0;
    }];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
}

- (void)animate:(BOOL)pressed {
    //[];
}

# pragma mark - Drawing and animation


- (void)drawRect:(CGRect)rect {
    //[self drawLayer:self. inContext:<#(nonnull CGContextRef)#>];
    
}




@end
