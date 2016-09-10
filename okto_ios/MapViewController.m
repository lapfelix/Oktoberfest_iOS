//
//  MapViewController.m
//  okto_ios
//
//  Created by Felix Lapalme on 2016-09-03.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "MapViewController.h"
//#import ".h"

@import GoogleMaps;

@interface MapViewController ()

@property (copy, nonatomic) IBOutlet GMSMapView *mapView;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _mapView = [GMSMapView mapWithFrame:self.view.bounds camera:[GMSCameraPosition cameraWithTarget:CLLocationCoordinate2DMake(45.421667, -71.963151)  zoom:17.299424 bearing:37 viewingAngle:0]];
    
    [self.view addSubview:self.mapView];
    
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    GMSMutablePath *path = [GMSMutablePath pathFromEncodedPath:@"imftGrnfvLsByBpCuGxA`B[t@VX"];
    GMSPolygon *whitePolygon = [GMSPolygon polygonWithPath:path];
    whitePolygon.strokeColor = [UIColor blackColor];
    whitePolygon.strokeWidth = 2;
    whitePolygon.fillColor = [UIColor colorWithWhite:1.000 alpha:1];
    whitePolygon.zIndex = 0;
    whitePolygon.map = _mapView;
}

- (void)viewWillAppear:(BOOL)animated {
    self.mapView.camera = [GMSCameraPosition cameraWithTarget:CLLocationCoordinate2DMake(45.421667, -71.963151)  zoom:17.699424 bearing:37 viewingAngle:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateText {
    NSArray *fetchedObjects = [[self fetchedResultsController] fetchedObjects];
    
    if (fetchedObjects.count > 0) {
        FAQ *faq = fetchedObjects[0];
        
        NSAttributedString *attributedString = [[TSMarkdownParser standardParser] attributedStringFromMarkdown:faq.markdown];
        
        self.textView.attributedText = attributedString;
    }
}

#pragma mark - Fetched Results Controller Delegate methods


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self updateText];
}


#pragma mark - Core Data stack

- (void)initializeFetchedResultsController {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:[FAQ entityName]];
    
    NSSortDescriptor *idSort = [NSSortDescriptor sortDescriptorWithKey:@"markdown" ascending:YES];
    
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
