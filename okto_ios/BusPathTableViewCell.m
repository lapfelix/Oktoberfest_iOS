//
//  BusPathTableViewCell.m
//  okto_ios
//
//  Created by Felix Lapalme on 2016-08-28.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "BusPathTableViewCell.h"
#import "BusPath+Methods.h"

@interface BusPathTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *additionalLabel;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *intervalLabel;

@end

@implementation BusPathTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureWithObject:(NSObject *)object {
    if ([object isKindOfClass:[BusPath class]]) {
        BusPath *busPath = (BusPath *)object;
        
        self.titleLabel.text = busPath.title;
        self.additionalLabel.text = busPath.additionalString;
        self.intervalLabel.text = [NSString stringWithFormat:@"Passage aux %.0f minutes",busPath.interval];
        
        //TODO: fix this if it causes a skipped frame on slow devices
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        [dateFormatter setDateFormat:@"HH:mm"];
        self.startTimeLabel.text = [NSString stringWithFormat:@"À partir de %@",[dateFormatter stringFromDate:busPath.startTime]];
    }
}

@end