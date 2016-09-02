//
//  RoundedRectangle.h
//  okto_ios
//
//  Created by Felix Lapalme on 2016-09-02.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoundedRectangle : UIView

@property (copy, nonatomic) IBInspectable UIColor *fillColor;
@property (copy, nonatomic) IBInspectable UIColor *strokeColor;
@property (nonatomic) IBInspectable float strokeWidth;
@property (nonatomic) IBInspectable float cornerRadius;

@end
