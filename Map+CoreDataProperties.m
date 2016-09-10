//
//  Map+CoreDataProperties.m
//  okto_ios
//
//  Created by Felix Lapalme on 2016-09-10.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "Map+CoreDataProperties.h"

@implementation Map (CoreDataProperties)

+ (NSFetchRequest<Map *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Map"];
}

@dynamic east;
@dynamic imageURL;
@dynamic north;
@dynamic rotation;
@dynamic south;
@dynamic west;

@end
