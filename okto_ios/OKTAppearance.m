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
    [[UILabel appearanceWhenContainedInInstancesOfClasses:@[[UITableViewHeaderFooterView class]]] setTextColor:[[self class] greenColor]];
    [[UILabel appearanceWhenContainedInInstancesOfClasses:@[[UITableViewHeaderFooterView class]]] setFont:[UIFont fontWithName:@"Tommaso" size:45]];
    [[UITableViewHeaderFooterView appearance] setTintColor:[[self class] yellowColor]];

}

#pragma mark - Colors

+ (UIColor *)greenColor {
    return [UIColor colorWithHexString:@"006821"];
}

+ (UIColor *)yellowColor {
    return [UIColor colorWithHexString:@"FEDA2E"];
}

+ (UIColor *)orangeColor {
    return [UIColor colorWithHexString:@"F3B43E"];
}

@end
