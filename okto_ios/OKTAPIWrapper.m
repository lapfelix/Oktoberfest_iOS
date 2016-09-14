//
//  OKTAPIWrapper.m
//  okto_ios
//
//  Created by Felix Lapalme on 2016-08-14.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "OKTAPIWrapper.h"
#import "OKTNetworkMethods.h"
#import "OKTModelProtocol.h"
#import "AppDelegate.h"

#import <SDWebImage/SDWebImagePrefetcher.h>

// Import Core Data entities

#import "BeerCategory+Methods.h"
#import "ScheduleItem+Methods.h"
#import "BusPath+Methods.h"
#import "PathPosition+Methods.h"
#import "ContactInfo+Methods.h"
#import "WelcomeInfo+Methods.h"
#import "Sponsor+Methods.h"
#import "FAQ+Methods.h"
#import "ContactInfo+Methods.h"
#import "Map+Methods.h"
#import "Contest+Methods.h"

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
                      NSStringFromClass([BeerCategory class]) : @"bieres",
                      NSStringFromClass([ScheduleItem class]) : @"schedule_items",
                      NSStringFromClass([WelcomeInfo class])  : @"info",
                      NSStringFromClass([FAQ class])          : @"faq",
                      NSStringFromClass([BusPath class])      : @"bus_schedule",
                      NSStringFromClass([ContactInfo class])  : @"contact",
                      NSStringFromClass([Map class])          : @"map",
                      NSStringFromClass([Contest class])      : @"contest",
                    };
    });
    return sharedInstance;
}

- (NSURL *)urlFromClass:(Class)class {
    NSLog(@"dat:%@",NSStringFromClass(class));
    return [NSURL URLWithString:[baseURL stringByAppendingPathComponent:endpoints[NSStringFromClass(class)]]];
}

- (void)syncWithServer {
    [endpoints enumerateKeysAndObjectsUsingBlock:^(NSString * classString, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [self downloadForClass:NSClassFromString(classString) withCompletionHandler:^(NSObject *object, NSError * _Nullable error) {
            //nothing to do with the returned object
            
            [[NSNotificationCenter defaultCenter]
             postNotificationName:[NSString stringWithFormat:@"done_%@",classString]
             object:self];
            
            if ([classString isEqualToString:endpoints.allKeys[endpoints.count-1]]) {
                [[NSUserDefaults standardUserDefaults] setValue:@(YES) forKey:@"didDownload"];
            }
        }];
    }];
    
}

- (void)downloadForClass:(Class)class withCompletionHandler:(void (^)(NSObject *object, NSError * _Nullable error))completionHandler {
    
    [OKTNetworkMethods getObjectAtURL:[self urlFromClass:class] completionHandler:^(NSObject *objectArray, NSError *error) {
        Class<OKTModelProtocol> modelClass = class;
        
        NSMutableArray<NSString *> *imageURLs = [NSMutableArray<NSString *> array];
        
        if (objectArray == nil) {
            NSLog(@"Returned object was empty.");
            completionHandler(nil, nil);
            return;
        }
        
        //hack: force putting stuff in an array
        if (![objectArray isKindOfClass:[NSArray class]]) {
            objectArray = @[objectArray];
        }
        
        [self deleteEntityWithName:NSStringFromClass(class)];
        
        //special cases. There's probably a better way to do this but _gotta go fast_
        if ([NSStringFromClass(class) isEqual: @"WelcomeInfo"]) {
            [self deleteEntityWithName:@"Sponsor"];
        }
        
        if ([NSStringFromClass(class) isEqual: @"BeerCategory"]) {
            [self deleteEntityWithName:@"Beer"];
        }
        
        if ([NSStringFromClass(class) isEqual: @"Contest"]) {
            [self deleteEntityWithName:@"ContestStep"];
        }
        
        for (NSDictionary *obj in (NSArray *)objectArray) {
            if (![obj isKindOfClass:[NSDictionary class]]) {
                NSLog(@"Object contained was not a dictionary. In class %@: %@",NSStringFromClass(class),objectArray.description);
            } else {
                id modelledObject = [modelClass modelObjectWithDictionary:obj managedObjectContext:self.managedObjectContext];
                if (modelledObject == nil) {
                    NSLog(@"Failed to save object of class %@: %@",NSStringFromClass(class),objectArray.description);
                }
                
                if ([modelledObject respondsToSelector:@selector(getImageURLs)]) {
                    NSArray *urls = [modelledObject getImageURLs];
                    if (urls.count != 0) {
                        [imageURLs addObjectsFromArray:urls];
                    }
                }
            }
        }

        [self saveContext:self.managedObjectContext];

        SDWebImagePrefetcher *prefetcher = [SDWebImagePrefetcher new];
        //TODO: show prefetch status somewhere ?
        [prefetcher prefetchURLs:imageURLs];
        
        completionHandler(nil, nil);
    }];
}

- (void)deleteEntityWithName:(NSString *)entityName {
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:entityName];
    NSBatchDeleteRequest *delete = [[NSBatchDeleteRequest alloc] initWithFetchRequest:request];
    
    NSError *deleteError = nil;
    [((AppDelegate *)UIApplication.sharedApplication.delegate).persistentStoreCoordinator executeRequest:delete withContext:self.managedObjectContext error:&deleteError];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;

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
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
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
