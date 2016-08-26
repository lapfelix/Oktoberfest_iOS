//
//  OKTAPIWrapper.m
//  okto_ios
//
//  Created by Felix Lapalme on 2016-08-14.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "OKTAPIWrapper.h"
#import "OKTNetworkMethods.h"
#import "OKTModelClass.h"
#import "AppDelegate.h"

// Import Core Data entities

#import "Beer+CoreDataProperties.h"
#import "ScheduleItem+CoreDataProperties.h"
#import "BusPath+CoreDataProperties.h"
#import "PathPosition+CoreDataProperties.h"
#import "ContactInfo+CoreDataProperties.h"

static NSString *baseURL = @"https://private-5fca2-oktoberfest.apiary-mock.com/";
static NSDictionary *endpoints;

@interface OKTAPIWrapper()

@property(readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property(readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;

@end


@implementation OKTAPIWrapper

+ (instancetype)sharedWrapper {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
        endpoints = @{
                      NSStringFromClass([Beer class]):@"beers",
                      NSStringFromClass([ScheduleItem class]):@"schedule_items",
                    };
    });
    return sharedInstance;
}

- (NSURL *)urlFromClass:(Class)class {
    return endpoints[NSStringFromClass(class)];
}


- (void)downloadForClass:(Class)class withCompletionHandler:(void (^)(NSObject *object, NSError * _Nullable error))completionHandler {
    
    [OKTNetworkMethods getObjectAtURL:[self urlFromClass:[Beer class]] completionHandler:^(NSObject *objectArray, NSError *error) {
        Class<OKTModelClass> modelClass = class;
        
        if (objectArray == nil) {
            NSLog(@"Returned object was empty.");
            completionHandler(nil, nil);
        }
        
        //hack: force putting stuff in an array
        if (![objectArray isKindOfClass:[NSArray class]]) {
            objectArray = @[objectArray];
        }
        
        for (NSDictionary *obj in (NSArray *)objectArray) {
            if (![obj isKindOfClass:[NSDictionary class]]) {
                NSLog(@"Object contained was not a dictionary. In class %@: %@",NSStringFromClass(class),objectArray.description);
            } else {
                id modelledObject = [modelClass modelObjectWithDictionary:obj managedObjectContext:self.managedObjectContext];
                if (modelledObject == nil) {
                    NSLog(@"Failed to save object of class %@: %@",NSStringFromClass(class),objectArray.description);
                }
            }
        }
    }];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
//@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

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
    [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    _managedObjectModel =
    [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already
    // bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = ((AppDelegate*)[UIApplication sharedApplication].delegate).persistentStoreCoordinator;
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    _managedObjectContext.persistentStoreCoordinator = coordinator;
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext :(NSManagedObjectContext*) managedObjectContext {
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
