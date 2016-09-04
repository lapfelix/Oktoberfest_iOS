//
//  OKTLetterKeyLayer.h
//  okto_ios
//
//  Created by Felix Lapalme on 2016-09-03.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@class UIColor;

@interface OKTLetterKeyLayer : CALayer

@property (nonatomic, assign) float pressFactor;
@property (copy, nonatomic) UIColor *keyColor;

@end
