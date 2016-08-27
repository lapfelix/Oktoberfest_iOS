//
//  ScheduleItemTableViewCell.m
//  okto_ios
//
//  Created by Felix Lapalme on 2016-08-27.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "ScheduleItemTableViewCell.h"
#import "ScheduleItem+Methods.h"

@interface ScheduleItemTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *startLabel;
@property (weak, nonatomic) IBOutlet UILabel *endLabel;


@end

@implementation ScheduleItemTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureWithObject:(NSObject *)object {
    if ([object isKindOfClass:[ScheduleItem class]]) {
        ScheduleItem *scheduleItem = (ScheduleItem *)object;
        self.nameLabel.text = scheduleItem.name;
        self.descriptionLabel.text = scheduleItem.scheduleItemDescription;
        
        //TODO: fix this if it causes a skipped frame on slow devices
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        [dateFormatter setDateFormat:@"HH:mm"];
        self.startLabel.text = [dateFormatter stringFromDate:scheduleItem.startTime];
        self.endLabel.text = [dateFormatter stringFromDate:scheduleItem.endTime];
    }
}

@end
