//
//  ContestStep+CoreDataProperties.m
//  okto_ios
//
//  Created by Guillaume Paquet on 2016-09-13.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "ContestStep+CoreDataProperties.h"

@implementation ContestStep (CoreDataProperties)

+ (NSFetchRequest<ContestStep *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ContestStep"];
}

@dynamic answer;
@dynamic answerImageUrl;
@dynamic id;
@dynamic questionImageUrl;
@dynamic contest;

@end
