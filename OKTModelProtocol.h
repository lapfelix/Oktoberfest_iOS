//
//  OKTModelProtocol.h
//  okto_ios
//
//  Created by Felix Lapalme on 2016-08-26.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#ifndef OKTModelProtocol_h
#define OKTModelProtocol_h

#import <CoreData/CoreData.h>
#import "NSDictionary+NilSupport.h"

@protocol OKTModelProtocol <NSObject>

@required
+ (NSString *)entityName;

@required
+ (instancetype) modelObjectWithDictionary:(NSDictionary *)dict managedObjectContext:(NSManagedObjectContext *)context;

@optional
+ (instancetype) modelObjectFromId:(NSNumber *)eventId managedObjectContext:(NSManagedObjectContext *)context;

@required
- (instancetype) initWithDictionary:(NSDictionary *)dict managedObjectContext:(NSManagedObjectContext *)context;

@optional
- (NSArray<NSString *> *)getImageURLs;

@end

#endif /* OKTModelProtocol_h */
