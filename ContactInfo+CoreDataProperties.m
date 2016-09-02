//
//  ContactInfo+CoreDataProperties.m
//  okto_ios
//
//  Created by Felix Lapalme on 2016-09-02.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "ContactInfo+CoreDataProperties.h"

@implementation ContactInfo (CoreDataProperties)

+ (NSFetchRequest<ContactInfo *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ContactInfo"];
}

@dynamic facebookDisplayName;
@dynamic facebookUserName;
@dynamic snapchatUserName;
@dynamic twitterUserName;
@dynamic websiteURL;
@dynamic email;

@end
