//
//  OKTAppearance.m
//  okto_ios
//
//  Created by Felix Lapalme on 2016-09-11.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "OKTAppearance.h"
#import "UIColor+HexColors.h"
@import UIKit;

@implementation OKTAppearance



+ (void)setupAppearances {
    [[UINavigationBar appearance] setBarTintColor:[[self class] greenColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           NSForegroundColorAttributeName: [UIColor whiteColor],
                                                           }];
    [[UINavigationBar appearance] setTintColor:[[self class] yellowColor]];
    [[UITabBar appearance] setTintColor:[[self class] yellowColor]];
    [[UITabBar appearance] setBarTintColor:[[self class] greenColor]];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }
                                             forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [[self class] yellowColor] }
                                             forState:UIControlStateSelected];
}

#pragma mark - Colors

+ (UIColor *)greenColor {
    return [UIColor colorWithHexString:@"008044"];
}

+ (UIColor *)yellowColor {
    return [UIColor colorWithHexString:@"FEDA2E"];
}

+ (UIColor *)orangeColor {
    return [UIColor colorWithHexString:@"F3B43E"];
}

@end
