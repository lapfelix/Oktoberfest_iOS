//
//  ScheduleItem.m
//  okto_ios
//
//  Created by Felix Lapalme on 2016-08-26.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "ScheduleItem+Methods.h"

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
        self.endTime = [self.class.dateFormatter dateFromString:[dict objectOrNilForKey:@"end_time"]];
        self.name = [dict objectOrNilForKey:@"name"];
        self.scheduleItemDescription = [dict objectForKey:@"description"];
        
        /*
        self.alcohol = [dict[@"alcohol"] floatValue];
        self.beerDescription = [dict objectOrNilForKey:@"description"];
        self.name = [dict objectOrNilForKey:@"name"];
        */
    }
    return self;
}

@end
