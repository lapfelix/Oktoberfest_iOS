//
//  BeerCategory+Methods.m
//  okto_ios
//
//  Created by Felix Lapalme on 2016-09-01.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "BeerCategory+Methods.h"
#import "Beer+Methods.h"

static NSString *entityName = @"BeerCategory";

@implementation BeerCategory (Methods)

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
        
        NSArray *beersDictionary = [dict objectOrNilForKey:@"beers"];
        NSMutableSet<Beer *> *beers = [NSMutableSet set];
        for (NSDictionary *beerDictionary in beersDictionary) {
            Beer *beer = [Beer modelObjectWithDictionary:beerDictionary managedObjectContext:context];
            [beers addObject:beer];
        }
        
        self.beers = beers.copy;
        
    }
    return self;
}

- (NSArray<NSString *> *)getImageURLs {
    NSMutableArray *images = [NSMutableArray array];
    
    for (Beer *beer in self.beers) {
        [images addObjectsFromArray:[beer getImageURLs]];
    }
    
    return images.copy;
}


@end
