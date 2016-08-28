//
//  SponsorCollectionViewCell.m
//  okto_ios
//
//  Created by Felix Lapalme on 2016-08-28.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "SponsorCollectionViewCell.h"
#import "Sponsor+CoreDataClass.h"

@interface SponsorCollectionViewCell()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation SponsorCollectionViewCell

- (void)configureWithObject:(NSObject *)object {
    if ([object isKindOfClass:[Sponsor class]]) {
        Sponsor *sponsor = (Sponsor *)object;
        self.nameLabel.text = sponsor.name;
    }
}

@end
