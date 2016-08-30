//
//  ScheduleItem+CoreDataProperties.h
//  okto_ios
//
//  Created by Felix Lapalme on 2016-08-30.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "ScheduleItem+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ScheduleItem (CoreDataProperties)

+ (NSFetchRequest<ScheduleItem *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *endTime;
@property (nonatomic) int16_t id;
@property (nullable, nonatomic, copy) NSString *largeImage;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *scheduleItemDescription;
@property (nullable, nonatomic, copy) NSString *smallImage;
@property (nullable, nonatomic, copy) NSDate *startTime;

@end

NS_ASSUME_NONNULL_END
