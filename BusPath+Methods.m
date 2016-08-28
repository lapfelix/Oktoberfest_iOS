//
//  BusPath.m
//  okto_ios
//
//  Created by Felix Lapalme on 2016-08-26.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "BusPath+Methods.h"
#import "PathPosition+Methods.h"

static NSString *entityName = @"BusPath";

@implementation BusPath (Methods)

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
        
        self.title = [dict objectOrNilForKey:@"title"];
        self.additionalString = [dict objectOrNilForKey:@"additionnal_string"];
        self.startTime = [self.class.dateFormatter dateFromString:[dict objectOrNilForKey:@"start_time"]];
        self.interval = [dict[@"interval"] floatValue];
        NSArray *coordinates = [dict objectOrNilForKey:@"path"];
        NSMutableSet<PathPosition *> *pathPositions = [NSMutableSet set];
        for (NSDictionary *coordinateDictionary in coordinates) {
            PathPosition *position = [PathPosition modelObjectWithDictionary:coordinateDictionary managedObjectContext:context];
            [pathPositions addObject:position];
        }
        self.pathPositions = pathPositions.copy;
    }
    return self;
}

@end
