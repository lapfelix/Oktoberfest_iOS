//
//  ContestStep+Methods.m
//  okto_ios
//
//  Created by Guillaume Paquet on 2016-09-13.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "ContestStep+Methods.h"

static NSString *entityName = @"ContestStep";

@implementation ContestStep (Methods)

+ (NSString *)entityName {
    return entityName;
}

+ (instancetype) modelObjectWithDictionary:(NSDictionary *)dict managedObjectContext:(NSManagedObjectContext *)context {
    return [[self alloc] initWithDictionary:dict managedObjectContext:context];
}

- (instancetype) initWithDictionary:(NSDictionary *)dict managedObjectContext:(NSManagedObjectContext *)context {
    self = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext: context];
    if([dict isKindOfClass:[NSDictionary class]]) {
        self.id = @([dict[@"id"] intValue]);
        self.answer = [dict objectOrNilForKey:@"answer"];
        self.answerImageUrl = [dict objectOrNilForKey:@"answer_image_url"];
        self.questionImageUrl = [dict objectOrNilForKey:@"question_image_url"];
    }
    return self;
}

- (NSArray<NSString *> *)getImageURLs {
    return @[self.answerImageUrl, self.questionImageUrl];
}

@end
