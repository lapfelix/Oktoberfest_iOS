//
//  Beer+CoreDataProperties.h
//  okto_ios
//
//  Created by Felix Lapalme on 2016-08-24.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "Beer+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Beer (CoreDataProperties)

+ (NSFetchRequest<Beer *> *)fetchRequest;

@property (nonatomic) float alcohol;
@property (nullable, nonatomic, copy) NSString *beerDescription;
@property (nonatomic) int16_t id;
@property (nullable, nonatomic, copy) NSString *name;

@end

NS_ASSUME_NONNULL_END
