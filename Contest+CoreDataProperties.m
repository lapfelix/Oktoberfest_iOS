//
//  Contest+CoreDataProperties.m
//  okto_ios
//
//  Created by Guillaume Paquet on 2016-09-13.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "Contest+CoreDataProperties.h"

@implementation Contest (CoreDataProperties)

+ (NSFetchRequest<Contest *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Contest"];
}

@dynamic endTime;
@dynamic contestSteps;

@end
