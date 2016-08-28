//
//  FAQ+CoreDataProperties.m
//  okto_ios
//
//  Created by Felix Lapalme on 2016-08-28.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "FAQ+CoreDataProperties.h"

@implementation FAQ (CoreDataProperties)

+ (NSFetchRequest<FAQ *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"FAQ"];
}

@dynamic markdown;

@end
