//
//  OKTAppearance.h
//  okto_ios
//
//  Created by Felix Lapalme on 2016-09-11.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UIColor;

@interface OKTAppearance : NSObject

+ (void)setupAppearances;

+ (UIColor *)greenColor;
+ (UIColor *)yellowColor;
+ (UIColor *)orangeColor;

@end
