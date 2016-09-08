//
//  BusPath+CoreDataProperties.m
//  okto_ios
//
//  Created by Felix Lapalme on 2016-09-07.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "BusPath+CoreDataProperties.h"

@implementation BusPath (CoreDataProperties)

+ (NSFetchRequest<BusPath *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"BusPath"];
}

@dynamic additionalString;
@dynamic id;
@dynamic interval;
@dynamic csvString;
@dynamic startTime;
@dynamic thumbnailImage;
@dynamic title;

@end
