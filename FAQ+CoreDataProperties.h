//
//  FAQ+CoreDataProperties.h
//  okto_ios
//
//  Created by Felix Lapalme on 2016-08-28.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "FAQ+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface FAQ (CoreDataProperties)

+ (NSFetchRequest<FAQ *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *markdown;

@end

NS_ASSUME_NONNULL_END
