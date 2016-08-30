//
//  BusPath+CoreDataProperties.h
//  okto_ios
//
//  Created by Felix Lapalme on 2016-08-30.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "BusPath+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface BusPath (CoreDataProperties)

+ (NSFetchRequest<BusPath *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *additionalString;
@property (nonatomic) int16_t id;
@property (nonatomic) float interval;
@property (nullable, nonatomic, copy) NSDate *startTime;
@property (nullable, nonatomic, copy) NSString *thumbnailImage;
@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, retain) NSSet<PathPosition *> *pathPositions;

@end

@interface BusPath (CoreDataGeneratedAccessors)

- (void)addPathPositionsObject:(PathPosition *)value;
- (void)removePathPositionsObject:(PathPosition *)value;
- (void)addPathPositions:(NSSet<PathPosition *> *)values;
- (void)removePathPositions:(NSSet<PathPosition *> *)values;

@end

NS_ASSUME_NONNULL_END
