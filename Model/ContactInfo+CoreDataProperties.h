//
//  ContactInfo+CoreDataProperties.h
//  okto_ios
//
//  Created by Felix Lapalme on 2016-08-24.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "ContactInfo+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ContactInfo (CoreDataProperties)

+ (NSFetchRequest<ContactInfo *> *)fetchRequest;

@property (nullable, nonatomic, retain) NSObject *snapchatUserName;
@property (nullable, nonatomic, retain) NSObject *twitterUserName;
@property (nullable, nonatomic, retain) NSObject *facebookDisplayName;
@property (nullable, nonatomic, retain) NSObject *facebookUserName;
@property (nullable, nonatomic, retain) NSObject *websiteURL;

@end

NS_ASSUME_NONNULL_END
