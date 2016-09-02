//
//  BeerCategory+CoreDataProperties.h
//  okto_ios
//
//  Created by Felix Lapalme on 2016-09-01.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "BeerCategory+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface BeerCategory (CoreDataProperties)

+ (NSFetchRequest<BeerCategory *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) int16_t id;
@property (nullable, nonatomic, retain) NSSet<Beer *> *beers;

@end

@interface BeerCategory (CoreDataGeneratedAccessors)

- (void)addBeersObject:(Beer *)value;
- (void)removeBeersObject:(Beer *)value;
- (void)addBeers:(NSSet<Beer *> *)values;
- (void)removeBeers:(NSSet<Beer *> *)values;

@end

NS_ASSUME_NONNULL_END
