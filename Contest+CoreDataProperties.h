//
//  Contest+CoreDataProperties.h
//  okto_ios
//
//  Created by Guillaume Paquet on 2016-09-13.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "Contest+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Contest (CoreDataProperties)

+ (NSFetchRequest<Contest *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *endTime;
@property (nullable, nonatomic, retain) NSSet<ContestStep *> *contestSteps;

@end

@interface Contest (CoreDataGeneratedAccessors)

- (void)addContestStepsObject:(ContestStep *)value;
- (void)removeContestStepsObject:(ContestStep *)value;
- (void)addContestSteps:(NSSet<ContestStep *> *)values;
- (void)removeContestSteps:(NSSet<ContestStep *> *)values;

@end

NS_ASSUME_NONNULL_END
