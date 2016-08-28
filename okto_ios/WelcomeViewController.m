//
//  WelcomeViewController.m
//  okto_ios
//
//  Created by Felix Lapalme on 2016-08-28.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "WelcomeViewController.h"
#import "UICollectionView+NSFetchedResultsController.h"
#import "Sponsor+Methods.h"
#import "OKTObjectConfigurableProtocol.h"
#import "AppDelegate.h"

@interface WelcomeViewController ()

@property (weak, nonatomic) IBOutlet UILabel *countdownLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *sponsorsCollectionView;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initializeFetchedResultsController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureCell:(id)cell atIndexPath:(NSIndexPath*)indexPath {
    id object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    
    [(NSObject<OKTObjectConfigurableProtocol> *)cell configureWithObject:object];
}

#pragma mark - Fetched Results Controller Delegate methods

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    [self.sponsorsCollectionView addChangeForSection:sectionInfo atIndex:sectionIndex forChangeType:type];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    [self.sponsorsCollectionView addChangeForObjectAtIndexPath:indexPath forChangeType:type newIndexPath:newIndexPath];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
   [self.sponsorsCollectionView commitChanges];
}

#pragma mark - UICollectionViewDatasource and delegate methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    id< NSFetchedResultsSectionInfo> sectionInfo = [[self fetchedResultsController] sections][section];
    return [sectionInfo numberOfObjects];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell<OKTObjectConfigurableProtocol> *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"sponsor" forIndexPath:indexPath];
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

#pragma mark - Core Data stack

- (void)initializeFetchedResultsController {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:[Sponsor entityName]];
    
    NSSortDescriptor *idSort = [NSSortDescriptor sortDescriptorWithKey:@"id" ascending:YES];
    
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
