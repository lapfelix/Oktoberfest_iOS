//
//  SponsorCollectionViewCell.m
//  okto_ios
//
//  Created by Felix Lapalme on 2016-08-28.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "SponsorCollectionViewCell.h"
#import "Sponsor+CoreDataClass.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface SponsorCollectionViewCell()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation SponsorCollectionViewCell

- (void)configureWithObject:(NSObject *)object {
    if ([object isKindOfClass:[Sponsor class]]) {
        Sponsor *sponsor = (Sponsor *)object;
        self.nameLabel.text = sponsor.name;
        
        if (sponsor.image != nil) {
            NSURL *imageURL = [NSURL URLWithString:sponsor.image];
            [self.imageView sd_setImageWithURL:imageURL completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                //cached! or taken from cache
            }];
        }
    }
}

@end
