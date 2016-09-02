//
//  BeerCategory+CoreDataProperties.m
//  okto_ios
//
//  Created by Felix Lapalme on 2016-09-01.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "BeerCategory+CoreDataProperties.h"

@implementation BeerCategory (CoreDataProperties)

+ (NSFetchRequest<BeerCategory *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"BeerCategory"];
}

@dynamic name;
@dynamic id;
@dynamic beers;

@end
