//
//  BusPath.m
//  okto_ios
//
//  Created by Felix Lapalme on 2016-08-26.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "BusPath+Methods.h"

static NSString *entityName = @"BusPath";

@implementation BusPath (Methods)

+ (NSString *)entityName {
    return entityName;
}

+ (instancetype) modelObjectWithDictionary:(NSDictionary *)dict managedObjectContext:(NSManagedObjectContext *)context {
    return [[self alloc] initWithDictionary:dict managedObjectContext:context];
}

- (instancetype) initWithDictionary:(NSDictionary *)dict managedObjectContext:(NSManagedObjectContext *)context {
    self = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext: context];
    if([dict isKindOfClass:[NSDictionary class]]) {
        /*
         self.id = [dict[@"id"] intValue];
         self.alcohol = [dict[@"alcohol"] floatValue];
         self.beerDescription = [dict objectOrNilForKey:@"description"];
         self.name = [dict objectOrNilForKey:@"name"];
         */
    }
    return self;
}

@end
