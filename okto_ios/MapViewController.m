//
//  MapViewController.m
//  okto_ios
//
//  Created by Felix Lapalme on 2016-09-03.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "MapViewController.h"
#import "Map+Methods.h"
#import "AppDelegate.h"

#import <SDWebImage/SDWebImageManager.h>

@import GoogleMaps;

@interface MapViewController ()

@property (copy, nonatomic) IBOutlet GMSMapView *mapView;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _mapView = [GMSMapView mapWithFrame:self.view.bounds camera:[GMSCameraPosition cameraWithTarget:CLLocationCoordinate2DMake(45.421667, -71.963151)  zoom:17.299424 bearing:37 viewingAngle:0]];
    
    [self.view addSubview:self.mapView];
    
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.mapView.buildingsEnabled = false;
        
    GMSMutablePath *path = [GMSMutablePath pathFromEncodedPath:@"imftGrnfvLsByBpCuGxA`B[t@VX"];
    GMSPolygon *whitePolygon = [GMSPolygon polygonWithPath:path];
    whitePolygon.strokeColor = [UIColor blackColor];
    whitePolygon.strokeWidth = 2;
    whitePolygon.fillColor = [UIColor colorWithWhite:1.000 alpha:1];
    whitePolygon.zIndex = 0;
    whitePolygon.map = _mapView;
    
    [self initializeFetchedResultsController];
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"%f - %f",self.mapView.camera.target.latitude, self.mapView.camera.target.longitude);
    self.mapView.camera = [GMSCameraPosition cameraWithTarget:CLLocationCoordinate2DMake(45.421687, -71.962817)  zoom:17.603 bearing:36.8063 viewingAngle:0];
    [self updateMap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateMap {
    NSArray *fetchedObjects = [[self fetchedResultsController] fetchedObjects];
    
    if (fetchedObjects.count > 0) {
        Map *map = [fetchedObjects lastObject];
        
        CLLocationCoordinate2D northEast = CLLocationCoordinate2DMake(map.north, map.east);
        CLLocationCoordinate2D southWest = CLLocationCoordinate2DMake(map.south, map.west);
        
        GMSCoordinateBounds *overlayBounds = [[GMSCoordinateBounds alloc] initWithCoordinate:southWest
                                                                                  coordinate:northEast];
        
        NSURL *imageURL = [NSURL URLWithString:map.imageURL];
        
        [SDWebImageManager.sharedManager downloadImageWithURL:imageURL options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            GMSGroundOverlay *overlay = [GMSGroundOverlay groundOverlayWithBounds:overlayBounds icon:image];
            overlay.bearing = fmod(-map.rotation + 3600, 360);
            
            [self.mapView clear];
            overlay.map = self.mapView;
        }];
        
    }
}

#pragma mark - Fetched Results Controller Delegate methods


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self updateMap];
}


#pragma mark - Core Data stack

- (void)initializeFetchedResultsController {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:[Map entityName]];
    
    NSSortDescriptor *idSort = [NSSortDescriptor sortDescriptorWithKey:@"imageURL" ascending:YES];
    
    [request setSortDescriptors:@[idSort]];
    
    NSManagedObjectContext *moc = ((AppDelegate *)UIApplication.sharedApplication.delegate).managedObjectContext;
    
    [self setFetchedResultsController:[[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:moc sectionNameKeyPath:nil cacheName:nil]];
    [[self fetchedResultsController] setDelegate:self];
    
    NSError *error = nil;
    if (![[self fetchedResultsController] performFetch:&error]) {
        NSLog(@"Failed to initialize FetchedResultsController: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
}

@end
