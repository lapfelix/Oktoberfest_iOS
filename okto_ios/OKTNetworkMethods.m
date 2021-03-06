//
//  OKTNetworkManager.m
//  okto_ios
//
//  Created by Felix Lapalme on 2016-08-14.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "OKTNetworkMethods.h"

@implementation OKTNetworkMethods

+ (void)getJsonObjectAtURL:(NSURL *)url completionHandler:(void (^)(NSObject * _Nullable object, NSError * _Nullable error))completionHandler{
    [[self class] getDataAtURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error != nil || data == nil) {
            completionHandler(nil, error);
            return;
        }
        
        NSObject *returnedObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        
        if (error != nil) {
            completionHandler(nil, error);
        } else {
            completionHandler(returnedObject, nil);
        }
    }];
}

+ (void)getDataAtURL:(NSURL *)url completionHandler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler {
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:completionHandler];
    [dataTask resume];
}

+ (void)postAtURL:(NSURL *)url completionHandler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler {
    NSURLSession *session = [NSURLSession sharedSession];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:completionHandler];
    [dataTask resume];
}

@end
