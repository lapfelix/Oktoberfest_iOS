//
//  NSDictionary+NilSupport.h
//  okto_ios
//
//  Created by Felix Lapalme on 2016-08-26.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (NilSupport)

NS_ASSUME_NONNULL_BEGIN

- (id)objectOrNilForKey:(id)aKey;

NS_ASSUME_NONNULL_END

@end
