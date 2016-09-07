//
//  BeersTableViewController.m
//  okto_ios
//
//  Created by Felix Lapalme on 2016-08-26.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "BeersTableViewController.h"
#import "BeerCategory+Methods.h"
#import "Beer+Methods.h"
#import "BeerTableViewCell.h"
#import "AppDelegate.h"

static NSString *CellReuseIdentifier = @"beer";

@interface BeersTableViewController ()

@end

@implementation BeersTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.allowsSelection = NO;

    self.title = @"Bières";
    
    [self initializeFetchedResultsController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (void)configureCell:(id)cell atIndexPath:(NSIndexPath*)indexPath {
    id object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    
    [(NSObject<OKTObjectConfigurableProtocol> *)cell configureWithObject:object];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id cell = [tableView dequeueReusableCellWithIdentifier:CellReuseIdentifier];
    // Set up the cell
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[[self fetchedResultsController] sections][section] name];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[[self fetchedResultsController] sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id< NSFetchedResultsSectionInfo> sectionInfo = [[self fetchedResultsController] sections][section];
    return [sectionInfo numberOfObjects];
}

#pragma mark - Core Data stack

- (void)initializeFetchedResultsController {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:[Beer entityName]];
    
    NSSortDescriptor *idSort = [NSSortDescriptor sortDescriptorWithKey:@"id" ascending:YES];
    
    [request setSortDescriptors:@[idSort]];
    
    NSManagedObjectContext *moc = ((AppDelegate *)UIApplication.sharedApplication.delegate).managedObjectContext;
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:moc sectionNameKeyPath:@"category.name" cacheName:nil];
    [[self fetchedResultsController] setDelegate:self];
    
    NSError *error = nil;
    if (![[self fetchedResultsController] performFetch:&error]) {
        NSLog(@"Failed to initialize FetchedResultsController: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
}

@end
