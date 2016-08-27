//
//  Beer.h
//  okto_ios
//
//  Created by Felix Lapalme on 2016-08-26.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OKTModelProtocol.h"
#import "Beer+CoreDataClass.h"
#import "Beer+CoreDataProperties.h"

@interface Beer (Methods) <OKTModelProtocol>

+ (NSString *)entityName;

@end
