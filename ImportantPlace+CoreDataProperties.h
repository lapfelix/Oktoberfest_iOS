//
//  ImportantPlace+CoreDataProperties.h
//  okto_ios
//
//  Created by Felix Lapalme on 2016-09-07.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "ImportantPlace+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ImportantPlace (CoreDataProperties)

+ (NSFetchRequest<ImportantPlace *> *)fetchRequest;

@property (nonatomic) int16_t id;
@property (nullable, nonatomic, copy) NSString *imageUrl;
@property (nullable, nonatomic, copy) NSString *coordinatesString;
@property (nullable, nonatomic, retain) BusPath *busPath;

@end

NS_ASSUME_NONNULL_END
