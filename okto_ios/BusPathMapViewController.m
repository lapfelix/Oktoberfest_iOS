//
//  BusPathMapViewController.m
//  okto_ios
//
//  Created by Felix Lapalme on 2016-09-07.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "BusPathMapViewController.h"

@interface BusPathMapViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation BusPathMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self displayPathFromCsv:self.csvString];
}

- (void)displayPathFromCsv:(NSString *)csvString {
    MKPolyline *overlay = [self overlayFromCsvString:csvString];

    [self.mapView removeOverlays:[self.mapView overlaysInLevel:MKOverlayLevelAboveRoads]];
    [self.mapView addOverlay:overlay level:MKOverlayLevelAboveRoads];
    self.mapView.visibleMapRect = [self.mapView mapRectThatFits:overlay.boundingMapRect];
    [self.mapView.camera setAltitude:50000];
}

- (MKPolyline *)overlayFromCsvString:(NSString *)csvString {
    
    NSArray *allLines = [csvString componentsSeparatedByString:@"\\n"];
    NSMutableArray<CLLocation *> *allLocations = [NSMutableArray array];
    
    for (NSString *line in allLines) {
        NSArray<NSString *> *individualCoordinates = [line componentsSeparatedByString:@","];
        if (individualCoordinates.count == 3) {
            CLLocation *location = [[CLLocation alloc] initWithLatitude:individualCoordinates[1].doubleValue longitude:individualCoordinates[0].doubleValue];
            [allLocations addObject:location];
        }
    }
    
    //conversion to CLLocationCoordinate2D array
    CLLocationCoordinate2D *locationArray = (CLLocationCoordinate2D *) malloc(allLocations.count * sizeof (CLLocationCoordinate2D));
    int position = 0;
    for (CLLocation *location in allLocations) {
        locationArray[position] = location.coordinate;
        position++;
    }
    
    return [MKPolyline polylineWithCoordinates:locationArray count:allLocations.count];
}

#pragma mark - MKMapViewDelegate

-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithPolyline:overlay];
    renderer.strokeColor = [UIColor colorWithRed:0 green:0.5 blue:0 alpha:1];
    renderer.lineWidth = 3;
    
    return renderer;
}

@end
