//
//  ScheduleItem.m
//  okto_ios
//
//  Created by Felix Lapalme on 2016-08-26.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "ScheduleItem+Methods.h"
#import <SDWebImage/SDWebImageManager.h>

static NSString *entityName = @"ScheduleItem";

@implementation ScheduleItem (Methods)

+ (NSString *)entityName {
    return entityName;
}

+ (instancetype) modelObjectWithDictionary:(NSDictionary *)dict managedObjectContext:(NSManagedObjectContext *)context {
    return [[self alloc] initWithDictionary:dict managedObjectContext:context];
}

+ (NSDateFormatter *)dateFormatter {
    static NSDateFormatter *formatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"MM-dd-yyyy HH:mm";
    });
    return formatter;
}

- (instancetype) initWithDictionary:(NSDictionary *)dict managedObjectContext:(NSManagedObjectContext *)context {
    self = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext: context];
    if([dict isKindOfClass:[NSDictionary class]]) {
        
        self.id = [dict[@"id"] intValue];
        self.startTime = [self.class.dateFormatter dateFromString:[dict objectOrNilForKey:@"start_time"]];
        //self.endTime = [self.class.dateFormatter dateFromString:[dict objectOrNilForKey:@"end_time"]];
        self.name = [dict objectOrNilForKey:@"name"];
        //self.scheduleItemDescription = [dict objectOrNilForKey:@"description"];
        self.textColorHex = [dict objectForKey:@"text_color_hex"];
        self.largeImage = [dict objectOrNilForKey:@"large_image_url"];
        self.smallImage =  [dict objectOrNilForKey:@"small_image_url"];
        
    }
    return self;
}

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

- (NSArray<NSString *> *)getImageURLs {
    return @[self.smallImage, self.largeImage];
}

@end
