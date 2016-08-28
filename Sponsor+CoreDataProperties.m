//
//  Sponsor+CoreDataProperties.m
//  okto_ios
//
//  Created by Felix Lapalme on 2016-08-28.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "Sponsor+CoreDataProperties.h"

@implementation Sponsor (CoreDataProperties)

+ (NSFetchRequest<Sponsor *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Sponsor"];
}

@dynamic url;
@dynamic image;
@dynamic id;
@dynamic name;
@dynamic welcomeInfo;

@end
