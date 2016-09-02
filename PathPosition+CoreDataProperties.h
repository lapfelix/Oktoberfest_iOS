//
//  PathPosition+CoreDataProperties.h
//  okto_ios
//
//  Created by Felix Lapalme on 2016-09-01.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "PathPosition+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface PathPosition (CoreDataProperties)

+ (NSFetchRequest<PathPosition *> *)fetchRequest;

@property (nonatomic) int64_t id;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@property (nullable, nonatomic, retain) BusPath *path;

@end

NS_ASSUME_NONNULL_END
