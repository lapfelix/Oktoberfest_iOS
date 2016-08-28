//
//  WelcomeInfo+Methods.m
//  okto_ios
//
//  Created by Felix Lapalme on 2016-08-28.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "WelcomeInfo+Methods.h"
#import "Sponsor+Methods.h"

static NSString *entityName = @"WelcomeInfo";

@implementation WelcomeInfo (Methods)

+ (NSString *)entityName {
    return entityName;
}

+ (instancetype) modelObjectWithDictionary:(NSDictionary *)dict managedObjectContext:(NSManagedObjectContext *)context {
    return [[self alloc] initWithDictionary:dict managedObjectContext:context];
}

+ (NSDateFormatter *)dateFormatter {
    static NSDateFormatter *formatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"MM-dd-yyyy HH:mm";
    });
    return formatter;
}

- (instancetype) initWithDictionary:(NSDictionary *)dict managedObjectContext:(NSManagedObjectContext *)context {
    self = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext: context];
    if([dict isKindOfClass:[NSDictionary class]]) {
        self.startDate = [[[self class] dateFormatter] dateFromString:[dict objectOrNilForKey:@"start_time"]];
        
        NSArray *sponsorsDics = [dict objectOrNilForKey:@"sponsors"];
        NSMutableSet<Sponsor *> *modelledSponsors = [NSMutableSet set];
        for (NSDictionary *sponsorDic in sponsorsDics) {
            Sponsor *sponsor = [Sponsor modelObjectWithDictionary:sponsorDic managedObjectContext:context];
            [modelledSponsors addObject:sponsor];
        }
        self.sponsors = modelledSponsors.copy;
    }
    return self;
}

@end
