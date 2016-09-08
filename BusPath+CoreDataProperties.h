//
//  BusPath+CoreDataProperties.h
//  okto_ios
//
//  Created by Felix Lapalme on 2016-09-07.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "BusPath+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface BusPath (CoreDataProperties)

+ (NSFetchRequest<BusPath *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *additionalString;
@property (nonatomic) int16_t id;
@property (nonatomic) float interval;
@property (nullable, nonatomic, copy) NSString *csvString;
@property (nullable, nonatomic, copy) NSDate *startTime;
@property (nullable, nonatomic, copy) NSString *thumbnailImage;
@property (nullable, nonatomic, copy) NSString *title;

@end

NS_ASSUME_NONNULL_END
