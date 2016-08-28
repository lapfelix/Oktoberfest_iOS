//
//  WelcomeInfo+CoreDataProperties.h
//  okto_ios
//
//  Created by Felix Lapalme on 2016-08-28.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "WelcomeInfo+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface WelcomeInfo (CoreDataProperties)

+ (NSFetchRequest<WelcomeInfo *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *startDate;
@property (nullable, nonatomic, retain) NSSet<Sponsor *> *sponsors;

@end

@interface WelcomeInfo (CoreDataGeneratedAccessors)

- (void)addSponsorsObject:(Sponsor *)value;
- (void)removeSponsorsObject:(Sponsor *)value;
- (void)addSponsors:(NSSet<Sponsor *> *)values;
- (void)removeSponsors:(NSSet<Sponsor *> *)values;

@end

NS_ASSUME_NONNULL_END
