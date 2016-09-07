//
//  Beer+CoreDataProperties.m
//  okto_ios
//
//  Created by Felix Lapalme on 2016-09-06.
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
@dynamic imageURL;
@dynamic name;
@dynamic location;
@dynamic category;

@end
