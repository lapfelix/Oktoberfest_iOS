//
//  BeerTableViewCell.m
//  okto_ios
//
//  Created by Felix Lapalme on 2016-08-26.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "Beer+Methods.h"
#import "BeerTableViewCell.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface BeerTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *alcoholLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UIImageView *beerImage;

@end

@implementation BeerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureWithObject:(NSObject *)object {
    if ([object isKindOfClass:[Beer class]]) {
        Beer *beer = (Beer *)object;
        self.nameLabel.text = beer.name;
        self.alcoholLabel.text = [NSString stringWithFormat:@"%.2f%%",beer.alcohol];
        self.descriptionLabel.text = beer.beerDescription;
        self.locationLabel.text = beer.location;
        if (beer.imageURL != nil) {
            NSURL *imageURL = [NSURL URLWithString:beer.imageURL];
            [self.beerImage sd_setImageWithURL:imageURL completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                //cached! or taken from cache
            }];
        }
    }
}

@end
