//
//  AppDelegate.h
//  okto_ios
//
//  Created by Felix Lapalme on 2016-08-14.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

