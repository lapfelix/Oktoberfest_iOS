//
//  ImportantPlaceAnnotation.h
//  okto_ios
//
//  Created by Felix Lapalme on 2016-09-10.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import <Foundation/Foundation.h>
@import MapKit;

@interface ImportantPlaceAnnotation : NSObject <MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *subtitle;
@property (assign, nonatomic) NSString *imageURL;
@property (assign, nonatomic) UIImage *image;

@end
