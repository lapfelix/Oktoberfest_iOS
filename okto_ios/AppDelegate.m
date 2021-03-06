//
//  AppDelegate.m
//  okto_ios
//
//  Created by Felix Lapalme on 2016-08-14.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "AppDelegate.h"
#import "OKTAppearance.h"
#import "OKTAPIWrapper.h"
#import "RootViewController.h"
#import "LoadingViewController.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>

@import GoogleMaps;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [Fabric with:@[[Crashlytics class]]];

    [GMSServices provideAPIKey:@"***REMOVED***"];
    [OKTAppearance setupAppearances];
    
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:screenBounds];
    
    [window makeKeyAndVisible];
    [self setWindow:window];
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    LoadingViewController *loadingVC = [mainStoryboard instantiateInitialViewController];
    
    RootViewController *rootViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"root"];
    [rootViewController view];
    
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"didDownload"] boolValue] == YES) {
        
        window.rootViewController = rootViewController;
    } else {
        
        window.rootViewController = loadingVC;
        
        [[NSNotificationCenter defaultCenter]
         addObserverForName:@"done_WelcomeInfo"
         object:nil
         queue:[NSOperationQueue mainQueue]
         usingBlock:^(NSNotification *notification)
         {
             if (rootViewController.view.window == nil && ![window.rootViewController.presentedViewController isKindOfClass:[RootViewController class]]) {
                 [rootViewController setModalPresentationStyle:UIModalPresentationCustom];
                 [rootViewController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
                 [loadingVC presentViewController:rootViewController animated:YES completion:nil];
             }
             return;
         }];
    }
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [[OKTAPIWrapper sharedWrapper] syncWithServer];
    [NSTimer scheduledTimerWithTimeInterval:120 target:self selector:@selector(syncWithServer) userInfo:nil repeats:YES];
}

- (void)syncWithServer {
    [[OKTAPIWrapper sharedWrapper] syncWithServer];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}



#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This
    // code uses a directory named "com.lapfelix.CentreDeFoires" in the
    // application's documents directory.
    return [[NSFileManager defaultManager]
            URLsForDirectory:NSDocumentDirectory
            inDomains:NSUserDomainMask].lastObject;
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the
    // application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL =
    [[NSBundle mainBundle] URLForResource:@"okto_ios" withExtension:@"momd"];
    _managedObjectModel =
    [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation
    // creates and return a coordinator, having added the store for the
    // application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]
                                   initWithManagedObjectModel:self.managedObjectModel];
    NSURL *storeURL = [[self applicationDocumentsDirectory]
                       URLByAppendingPathComponent:@"okto1.sqlite"];
    NSError *error = nil;
    NSString *failureReason =
    @"There was an error creating or loading the application's saved data.";
    NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption: @YES,
                              NSInferMappingModelAutomaticallyOption: @YES};
    
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                   configuration:nil
                                                             URL:storeURL
                                                         options:options
                                                           error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] =
        @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error =
        [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You
        // should not use this function in a shipping application, although it may
        // be useful during development.
        //[syncManager clearDatabase];
        //[syncManager syncWithServer];
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        //abort();
    }
    
    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already
    // bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = self.persistentStoreCoordinator;
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    _managedObjectContext.persistentStoreCoordinator = coordinator;
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSLog(@"saving appdelegate managedobject");
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if (managedObjectContext.hasChanges &&
            ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error
            // appropriately.
            // abort() causes the application to generate a crash log and terminate.
            // You should not use this function in a shipping application, although it
            // may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, error.userInfo);
            abort();
        }
    }
}

@end
