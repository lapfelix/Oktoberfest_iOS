//
//  Map+CoreDataProperties.h
//  okto_ios
//
//  Created by Felix Lapalme on 2016-09-10.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "Map+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Map (CoreDataProperties)

+ (NSFetchRequest<Map *> *)fetchRequest;

@property (nonatomic) double east;
@property (nullable, nonatomic, copy) NSString *imageURL;
@property (nonatomic) double north;
@property (nonatomic) double rotation;
@property (nonatomic) double south;
@property (nonatomic) double west;

@end

NS_ASSUME_NONNULL_END
