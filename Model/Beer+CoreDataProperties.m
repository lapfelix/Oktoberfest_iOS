//
//  Beer+CoreDataProperties.m
//  okto_ios
//
//  Created by Felix Lapalme on 2016-08-24.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "Beer+CoreDataProperties.h"

@implementation Beer (CoreDataProperties)

+ (NSFetchRequest<Beer *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Beer"];
}

@dynamic alcohol;
@dynamic beerDescription;
@dynamic id;
@dynamic name;

@end
