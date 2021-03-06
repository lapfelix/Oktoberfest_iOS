//
//  ScheduleItem+CoreDataProperties.m
//  okto_ios
//
//  Created by Felix Lapalme on 2016-09-12.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "ScheduleItem+CoreDataProperties.h"

@implementation ScheduleItem (CoreDataProperties)

+ (NSFetchRequest<ScheduleItem *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ScheduleItem"];
}

@dynamic endTime;
@dynamic id;
@dynamic largeImage;
@dynamic name;
@dynamic scheduleItemDescription;
@dynamic smallImage;
@dynamic startTime;
@dynamic textColorHex;

@end
