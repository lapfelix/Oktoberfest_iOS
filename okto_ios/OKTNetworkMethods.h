//
//  OKTNetworkManager.h
//  okto_ios
//
//  Created by Felix Lapalme on 2016-08-14.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OKTNetworkMethods : NSObject

+ (void)getObjectAtURL:(NSURL *)url completionHandler:(void (^)(NSObject * object, NSError * error))completionHandler;
+ (void)getDataAtURL:(NSURL *)url completionHandler:(void (^)(NSData * data, NSURLResponse * response, NSError * error))completionHandler;

@end
