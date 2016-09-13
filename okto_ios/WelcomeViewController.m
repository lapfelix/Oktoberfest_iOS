//
//  WelcomeViewController.m
//  okto_ios
//
//  Created by Felix Lapalme on 2016-08-28.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "WelcomeViewController.h"
#import "UICollectionView+NSFetchedResultsController.h"
#import "WelcomeInfo+Methods.h"
#import "Sponsor+Methods.h"
#import "OKTObjectConfigurableProtocol.h"
#import "AppDelegate.h"

@interface WelcomeViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *sponsorsCollectionView;
@property (nonatomic, strong) NSFetchedResultsController *sponsorsFetchedResultsController;
@property (nonatomic, strong) NSFetchedResultsController *welcomeInfoFetchedResultsController;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *daysLabel;
@property (weak, nonatomic) IBOutlet UILabel *hoursLabel;
@property (weak, nonatomic) IBOutlet UILabel *minutesLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondsLabel;

@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSTimer *countdownTimer;

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initializeFetchedResultsControllers];
    [self updateWelcomeInfo];
    [[NSNotificationCenter defaultCenter]
     addObserverForName:@"done_WelcomeInfo"
     object:nil
     queue:[NSOperationQueue mainQueue]
     usingBlock:^(NSNotification *notification)
     {
         [self initializeFetchedResultsControllers];
         [self updateWelcomeInfo];
     }];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateWelcomeInfo {
    NSArray *fetchedObjects = [self.welcomeInfoFetchedResultsController fetchedObjects];
    if (fetchedObjects.count > 0) {
        WelcomeInfo *info = fetchedObjects.firstObject;
        self.startDate = info.startDate;
    }
}

- (void)setStartDate:(NSDate *)startDate {
    _startDate = startDate;
    
    [self updateCountdown];
    
    [self.countdownTimer invalidate];
    
    _countdownTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updateCountdown) userInfo:nil repeats:YES];
}

- (void)updateCountdown {
    NSInteger ti = MAX([self.startDate timeIntervalSinceNow],0);
    NSInteger seconds = ti % 60;
    NSInteger minutes = (ti / 60) % 60;
    NSInteger hours = (ti / 3600) % 24;
    NSInteger days = ti / (3600 * 24);
    
    self.daysLabel.text = [NSString stringWithFormat:@"%02li",days];
    self.hoursLabel.text = [NSString stringWithFormat:@"%02li",hours];
    self.minutesLabel.text = [NSString stringWithFormat:@"%02li",minutes];
    self.secondsLabel.text = [NSString stringWithFormat:@"%02li",seconds];
    
    //TODO: do something when ti hits 0
    
}

- (void)configureCell:(id)cell atIndexPath:(NSIndexPath*)indexPath {
    id object = [[self sponsorsFetchedResultsController] objectAtIndexPath:indexPath];
    
    [(NSObject<OKTObjectConfigurableProtocol> *)cell configureWithObject:object];
}

#pragma mark - Fetched Results Controller Delegate methods

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    if (controller == self.sponsorsFetchedResultsController) {
        [self.sponsorsCollectionView addChangeForSection:sectionInfo atIndex:sectionIndex forChangeType:type];
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    if (controller == self.sponsorsFetchedResultsController) {
        [self.sponsorsCollectionView addChangeForObjectAtIndexPath:indexPath forChangeType:type newIndexPath:newIndexPath];
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    if (controller == self.sponsorsFetchedResultsController) {
        [self.sponsorsCollectionView commitChanges];
    } else {
        [self updateWelcomeInfo];
    }
}

#pragma mark - UICollectionViewDatasource and delegate methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    id< NSFetchedResultsSectionInfo> sectionInfo = [[self sponsorsFetchedResultsController] sections][section];
    return [sectionInfo numberOfObjects];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell<OKTObjectConfigurableProtocol> *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"sponsor" forIndexPath:indexPath];
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

#pragma mark - Core Data stack

- (void)initializeFetchedResultsControllers {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:[Sponsor entityName]];
    
    NSSortDescriptor *idSort = [NSSortDescriptor sortDescriptorWithKey:@"id" ascending:YES];
    
    [request setSortDescriptors:@[idSort]];
    
    NSManagedObjectContext *moc = ((AppDelegate *)UIApplication.sharedApplication.delegate).managedObjectContext;
    
    [self setSponsorsFetchedResultsController:[[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:moc sectionNameKeyPath:nil cacheName:nil]];
    [[self sponsorsFetchedResultsController] setDelegate:self];
    
    NSError *error = nil;
    if (![[self sponsorsFetchedResultsController] performFetch:&error]) {
        NSLog(@"Failed to initialize FetchedResultsController: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
    
    request = [NSFetchRequest fetchRequestWithEntityName:[WelcomeInfo entityName]];
    
    idSort = [NSSortDescriptor sortDescriptorWithKey:@"startDate" ascending:YES];
    
    [request setSortDescriptors:@[idSort]];
    
    [self setWelcomeInfoFetchedResultsController:[[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:moc sectionNameKeyPath:nil cacheName:nil]];
    [[self welcomeInfoFetchedResultsController] setDelegate:self];
    
    error = nil;
    if (![[self welcomeInfoFetchedResultsController] performFetch:&error]) {
        NSLog(@"Failed to initialize FetchedResultsController: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
}


@end
