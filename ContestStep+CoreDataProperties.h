//
//  ContestStep+CoreDataProperties.h
//  okto_ios
//
//  Created by Guillaume Paquet on 2016-09-13.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "ContestStep+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ContestStep (CoreDataProperties)

+ (NSFetchRequest<ContestStep *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *answer;
@property (nullable, nonatomic, copy) NSString *answerImageUrl;
@property (nullable, nonatomic, copy) NSNumber *id;
@property (nullable, nonatomic, copy) NSString *questionImageUrl;
@property (nullable, nonatomic, retain) Contest *contest;

@end

NS_ASSUME_NONNULL_END
