//
//  Sponsor+CoreDataProperties.h
//  okto_ios
//
//  Created by Felix Lapalme on 2016-09-01.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "Sponsor+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Sponsor (CoreDataProperties)

+ (NSFetchRequest<Sponsor *> *)fetchRequest;

@property (nonatomic) int16_t id;
@property (nullable, nonatomic, copy) NSString *image;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *url;
@property (nullable, nonatomic, retain) WelcomeInfo *welcomeInfo;

@end

NS_ASSUME_NONNULL_END
