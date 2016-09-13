//
//  ScheduleItemTableViewCell.m
//  okto_ios
//
//  Created by Felix Lapalme on 2016-08-27.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "ScheduleItemTableViewCell.h"
#import "ScheduleItem+Methods.h"
#import "UIColor+HexColors.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface ScheduleItemTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *startLabel;
@property (weak, nonatomic) IBOutlet UILabel *endLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIImageView *smallImage;
@property (weak, nonatomic) IBOutlet UIImageView *smallImage2;

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
        self.startLabel.text = [@"À partir de " stringByAppendingString:[dateFormatter stringFromDate:scheduleItem.startTime]];
        self.endLabel.text = [dateFormatter stringFromDate:scheduleItem.endTime];
        
        UIColor *textColor = [UIColor colorWithHexString:scheduleItem.textColorHex];
        
        self.startLabel.textColor = textColor;
        self.endLabel.textColor = textColor;
        self.nameLabel.textColor = textColor;
        self.descriptionLabel.textColor = textColor;
        
        if (scheduleItem.largeImage != nil) {
            NSURL *imageURL = [NSURL URLWithString:scheduleItem.largeImage];
            [self.backgroundImage sd_setImageWithURL:imageURL completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                //cached! or taken from cache
            }];
        }
        if (scheduleItem.smallImage != nil) {
            NSURL *imageURL = [NSURL URLWithString:scheduleItem.smallImage];
            [self.smallImage sd_setImageWithURL:imageURL completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                self.smallImage2.image = [UIImage imageWithCGImage:image.CGImage
                                                       scale:image.scale
                                                 orientation:UIImageOrientationUpMirrored];
            }];
            
        }
    }
}

@end
