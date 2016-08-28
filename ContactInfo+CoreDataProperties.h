//
//  ContactInfo+CoreDataProperties.h
//  okto_ios
//
//  Created by Felix Lapalme on 2016-08-28.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "ContactInfo+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ContactInfo (CoreDataProperties)

+ (NSFetchRequest<ContactInfo *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *facebookDisplayName;
@property (nullable, nonatomic, copy) NSString *facebookUserName;
@property (nullable, nonatomic, copy) NSString *snapchatUserName;
@property (nullable, nonatomic, copy) NSString *twitterUserName;
@property (nullable, nonatomic, copy) NSString *websiteURL;

@end

NS_ASSUME_NONNULL_END
