//
//  ImportantPlace+CoreDataProperties.m
//  okto_ios
//
//  Created by Felix Lapalme on 2016-09-07.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "ImportantPlace+CoreDataProperties.h"

@implementation ImportantPlace (CoreDataProperties)

+ (NSFetchRequest<ImportantPlace *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ImportantPlace"];
}

@dynamic id;
@dynamic imageUrl;
@dynamic coordinatesString;
@dynamic busPath;

@end
