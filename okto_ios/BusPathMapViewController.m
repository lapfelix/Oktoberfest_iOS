//
//  BusPathMapViewController.m
//  okto_ios
//
//  Created by Felix Lapalme on 2016-09-07.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "BusPathMapViewController.h"
#import "BusPath+CoreDataClass.h"
#import "ImportantPlace+CoreDataClass.h"
#import "ImportantPlaceAnnotation.h"

#import <SDWebImage/SDWebImageManager.h>

@interface BusPathMapViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation BusPathMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self displayPathFromCsv:self.busPath.csvString];
    [self displayImportantPlaces:self.busPath.importantPlaces];
}

- (void)displayImportantPlaces:(NSSet<ImportantPlace *> *)importantPlaces {
    [self.mapView removeAnnotations:self.mapView.annotations];

    for (ImportantPlace *place in importantPlaces) {
        ImportantPlaceAnnotation *annotation = [ImportantPlaceAnnotation new];
        annotation.imageURL = place.imageUrl;
        
        NSArray<NSString *> *coordinatesStringArray = [place.coordinatesString componentsSeparatedByString:@","];
        
        if (coordinatesStringArray.count >= 2) {
            
            annotation.coordinate = CLLocationCoordinate2DMake(coordinatesStringArray[1].doubleValue, coordinatesStringArray[0].doubleValue);
            
            [self.mapView addAnnotation:annotation];
        }
    }
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

- (MKAnnotationView *)mapView:(MKMapView *)map viewForAnnotation:(ImportantPlaceAnnotation *)annotation {
    static NSString *annotationViewReuseIdentifier = @"annotationViewReuseIdentifier";
    
    MKAnnotationView *annotationView = (MKAnnotationView *)[map dequeueReusableAnnotationViewWithIdentifier:annotationViewReuseIdentifier];
    
    if (annotationView == nil)
    {
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationViewReuseIdentifier];
        
    }
    
    NSURL *url = [NSURL URLWithString:annotation.imageURL];
    
    if (url != nil) {
        [[SDWebImageManager sharedManager] downloadImageWithURL:url options:SDWebImageHighPriority progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            if (image != nil) {
                MKAnnotationView *annotation = [[MKAnnotationView alloc] init];
                annotation.image = image;
                if (annotationView != nil) {
                    annotationView.image = image;
                }
            }
        }];
    }
    
    annotationView.annotation = annotation;
    
    return annotationView;
}
@end
