//
//  BusPathMapViewController.h
//  okto_ios
//
//  Created by Felix Lapalme on 2016-09-07.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MapKit;

@interface BusPathMapViewController : UIViewController<MKMapViewDelegate>

@property (copy, nonatomic) IBOutlet NSString *csvString;

//- (void)displayPathFromCsv:(NSString *)csvString;

@end
