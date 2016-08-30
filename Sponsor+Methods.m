//
//  Sponsor+Methods.m
//  okto_ios
//
//  Created by Felix Lapalme on 2016-08-28.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "Sponsor+Methods.h"

static NSString *entityName = @"Sponsor";

@implementation Sponsor (Methods)

+ (NSString *)entityName {
    return entityName;
}

+ (instancetype) modelObjectWithDictionary:(NSDictionary *)dict managedObjectContext:(NSManagedObjectContext *)context {
    return [[self alloc] initWithDictionary:dict managedObjectContext:context];
}

- (instancetype) initWithDictionary:(NSDictionary *)dict managedObjectContext:(NSManagedObjectContext *)context {
    self = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext: context];
    if([dict isKindOfClass:[NSDictionary class]]) {
        self.id = [dict[@"id"] intValue];
        self.name = [dict objectOrNilForKey:@"name"];
        self.url = [dict objectOrNilForKey:@"website_url"];
        self.image = [dict objectOrNilForKey:@"image_url"];
    }
    return self;
}

- (NSArray<NSString *> *)getImageURLs {
    return @[self.image];
}

@end
