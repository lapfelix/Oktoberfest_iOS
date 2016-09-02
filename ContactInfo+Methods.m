//
//  ContactInfo.m
//  okto_ios
//
//  Created by Felix Lapalme on 2016-08-26.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "ContactInfo+Methods.h"

static NSString *entityName = @"ContactInfo";

@implementation ContactInfo (Methods)

+ (NSString *)entityName {
    return entityName;
}

+ (instancetype) modelObjectWithDictionary:(NSDictionary *)dict managedObjectContext:(NSManagedObjectContext *)context {
    return [[self alloc] initWithDictionary:dict managedObjectContext:context];
}

- (instancetype) initWithDictionary:(NSDictionary *)dict managedObjectContext:(NSManagedObjectContext *)context {
    self = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext: context];
    if([dict isKindOfClass:[NSDictionary class]]) {
        self.email = [dict objectOrNilForKey:@"email"];
        self.physicalAddress = [dict objectOrNilForKey:@"physical_address"];
        self.facebookUserName = [dict objectOrNilForKey:@"facebook_user"];
        self.facebookDisplayName = [dict objectOrNilForKey:@"facebook"];
        self.websiteURL = [dict objectOrNilForKey:@"website_url"];
        self.snapchatUserName = [dict objectOrNilForKey:@"snapchat"];
        self.twitterUserName = [dict objectOrNilForKey:@"twitter"];
        self.phone = [dict objectOrNilForKey:@"phone"];
    }
    return self;
}

@end
