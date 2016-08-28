//
//  WelcomeInfo+CoreDataProperties.m
//  okto_ios
//
//  Created by Felix Lapalme on 2016-08-28.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "WelcomeInfo+CoreDataProperties.h"

@implementation WelcomeInfo (CoreDataProperties)

+ (NSFetchRequest<WelcomeInfo *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"WelcomeInfo"];
}

@dynamic startDate;
@dynamic sponsors;

@end
