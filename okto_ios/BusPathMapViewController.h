//
//  BusPathMapViewController.h
//  okto_ios
//
//  Created by Felix Lapalme on 2016-09-07.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MapKit;

@class BusPath;

@interface BusPathMapViewController : UIViewController<MKMapViewDelegate>

@property (assign, nonatomic) IBOutlet BusPath *busPath;

//- (void)displayPathFromCsv:(NSString *)csvString;

@end
