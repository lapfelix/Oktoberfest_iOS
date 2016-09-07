//
//  Beer+CoreDataProperties.h
//  okto_ios
//
//  Created by Felix Lapalme on 2016-09-06.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "Beer+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Beer (CoreDataProperties)

+ (NSFetchRequest<Beer *> *)fetchRequest;

@property (nonatomic) float alcohol;
@property (nullable, nonatomic, copy) NSString *beerDescription;
@property (nonatomic) int16_t id;
@property (nullable, nonatomic, copy) NSString *imageURL;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *location;
@property (nullable, nonatomic, retain) BeerCategory *category;

@end

NS_ASSUME_NONNULL_END
