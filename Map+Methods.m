//
//  Map+Methods.m
//  okto_ios
//
//  Created by Felix Lapalme on 2016-09-10.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "Map+Methods.h"

static NSString *entityName = @"Map";

@implementation Map (Methods)

+ (NSString *)entityName {
    return entityName;
}

+ (instancetype) modelObjectWithDictionary:(NSDictionary *)dict managedObjectContext:(NSManagedObjectContext *)context {
    return [[self alloc] initWithDictionary:dict managedObjectContext:context];
}

- (instancetype) initWithDictionary:(NSDictionary *)dict managedObjectContext:(NSManagedObjectContext *)context {
    self = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext: context];
    if([dict isKindOfClass:[NSDictionary class]]) {
        self.imageURL = [dict objectOrNilForKey:@"map_url"];
        self.north = [dict[@"map_north"] doubleValue];
        self.east = [dict[@"map_east"] doubleValue];
        self.west = [dict[@"map_west"] doubleValue];
        self.south = [dict[@"map_south"] doubleValue];
        self.rotation = [dict[@"map_rotation"] doubleValue];
    }
    return self;
}

- (NSArray<NSString *> *)getImageURLs {
    return @[self.imageURL];
}

@end
