//
//  OKTAPIWrapper.h
//  okto_ios
//
//  Created by Felix Lapalme on 2016-08-14.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OKTAPIWrapper : NSObject

+ (instancetype)sharedWrapper;
- (void)syncWithServer;

@end
