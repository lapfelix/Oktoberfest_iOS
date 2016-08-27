//
//  BeerTableViewCell.m
//  okto_ios
//
//  Created by Felix Lapalme on 2016-08-26.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "Beer+Methods.h"
#import "BeerTableViewCell.h"

@interface BeerTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *alcoholLabel;

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

- (void)configureWithObject:(Beer *)beer {
    self.nameLabel.text = beer.name;
    self.alcoholLabel.text = [NSString stringWithFormat:@"%.2f%%",beer.alcohol];
    self.descriptionLabel.text = beer.beerDescription;
}

@end
