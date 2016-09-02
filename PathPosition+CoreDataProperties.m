//
//  PathPosition+CoreDataProperties.m
//  okto_ios
//
//  Created by Felix Lapalme on 2016-09-01.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "PathPosition+CoreDataProperties.h"

@implementation PathPosition (CoreDataProperties)

+ (NSFetchRequest<PathPosition *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"PathPosition"];
}

@dynamic id;
@dynamic latitude;
@dynamic longitude;
@dynamic path;

@end
