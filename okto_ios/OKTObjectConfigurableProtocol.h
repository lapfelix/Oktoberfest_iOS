//
//  OKTObjectConfigurableProtocol.h
//  okto_ios
//
//  Created by Felix Lapalme on 2016-08-27.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OKTObjectConfigurableProtocol <NSObject>

@required
- (void)configureWithObject:(NSObject *)object;

@end
