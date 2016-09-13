//
//  Contest+Methods.m
//  okto_ios
//
//  Created by Guillaume Paquet on 2016-09-13.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "Contest+Methods.h"
#import "ContestStep+Methods.h"

static NSString *entityName = @"Contest";

@implementation Contest (Methods)

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
        self.endTime = [[[self class] dateFormatter] dateFromString:[dict objectOrNilForKey:@"end_time"]];
        
        NSArray *contestStepsDics = [dict objectOrNilForKey:@"contest_steps"];
        NSMutableSet<ContestStep *> *modelledContestSteps = [NSMutableSet set];
        for (NSDictionary *contestStepDic in contestStepsDics) {
            ContestStep *contestStep = [ContestStep modelObjectWithDictionary:contestStepDic managedObjectContext:context];
            [modelledContestSteps addObject:contestStep];
        }
        self.contestSteps = modelledContestSteps.copy;
    }
    return self;
}

-(NSDate*)str2date:(NSString*)dateStr{
    if ([dateStr isKindOfClass:[NSDate class]]) {
        return (NSDate*)dateStr;
    }
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormat dateFromString:dateStr];
    return date;
}

@end
