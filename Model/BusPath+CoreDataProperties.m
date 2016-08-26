//
//  BusPath+CoreDataProperties.m
//  okto_ios
//
//  Created by Felix Lapalme on 2016-08-24.
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
@dynamic startTime;
@dynamic thumbnailURL;
@dynamic title;
@dynamic pathPositions;

@end
