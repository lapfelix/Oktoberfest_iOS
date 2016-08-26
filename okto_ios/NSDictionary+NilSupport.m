//
//  NSDictionary+NilSupport.m
//  okto_ios
//
//  Created by Felix Lapalme on 2016-08-26.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "NSDictionary+NilSupport.h"

@implementation NSDictionary (NilSupport)

- (id)objectOrNilForKey:(id)aKey
{
    id object = self[aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}

@end
