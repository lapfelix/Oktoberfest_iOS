//
//  InfoViewController.m
//  okto_ios
//
//  Created by Felix Lapalme on 2016-08-31.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "InfoViewController.h"
#import "AppDelegate.h"
#import "ContactInfo+Methods.h"
#import <IntentKit/INKMailHandler.h>
#import <IntentKit/INKTwitterHandler.h>
#import <IntentKit/INKFacebookHandler.h>
#import <IntentKit/INKMapsHandler.h>

@import CoreData;

@interface InfoViewController ()<NSFetchedResultsControllerDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (copy, nonatomic) ContactInfo *contactInfo;

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Infos";
    
    [self initializeFetchedResultsController];
    [self fetchUpdatedContactInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)mailButtonTap:(id)sender {
    if (self.contactInfo.email.length != 0) {
        INKMailHandler *mailHandler = [INKMailHandler new];
        [[mailHandler sendMailTo:self.contactInfo.email] presentModally];
    } else {
        //TODO: handle this
    }
}

- (IBAction)phoneButtonTap:(id)sender {
    if (self.contactInfo.phone.length != 0) {
        NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",self.contactInfo.phone]];
        if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
            [[UIApplication sharedApplication] openURL:phoneUrl];
        } else
        {
            //TODO: handle this (iPad or iPod)
        }
    } else {
        //TODO: handle this
    }
}

- (IBAction)snapchatButtonTap:(id)sender {
    if (self.contactInfo.snapchatUserName.length != 0) {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"snapchat://add/%@",self.contactInfo.snapchatUserName]];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        } else {
            //TODO: handle this
            
        }
    } else {
        //TODO: handle this
    }
}

- (IBAction)twitterButtonTap:(id)sender {
    if (self.contactInfo.twitterUserName.length != 0) {
        INKTwitterHandler *twitterHandler = [INKTwitterHandler new];
        [[twitterHandler showUserWithScreenName:self.contactInfo.twitterUserName] presentModally];
    } else {
        //TODO: handle this
    }
}

- (IBAction)facebookButtonTap:(id)sender {
    if (self.contactInfo.facebookUserName.length != 0) {
        INKFacebookHandler *facebookHandler = [INKFacebookHandler new];
        [[facebookHandler showProfileWithId:self.contactInfo.facebookUserName] presentModally];
    } else {
        //TODO: handle this
    }
}

- (IBAction)mapsButtonTap:(id)sender {
    if (self.contactInfo.physicalAddress.length != 0) {
        INKMapsHandler *mapsHandler = [INKMapsHandler new];
        [[mapsHandler searchForLocation:self.contactInfo.physicalAddress] presentModally];
    } else {
        //TODO: handle this
    }
}

- (IBAction)websiteButtonTap:(id)sender {
    
}

- (void)fetchUpdatedContactInfo {
    NSArray *fetchedObjects = [[self fetchedResultsController] fetchedObjects];
    
    if (fetchedObjects.count > 0) {
        _contactInfo = fetchedObjects[0];
        self.addressLabel.text = _contactInfo.physicalAddress;
    } else {
        self.contactInfo = nil;
    }
}

#pragma mark - Fetched Results Controller Delegate methods

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self fetchUpdatedContactInfo];
}

#pragma mark - Core Data stack

- (void)initializeFetchedResultsController {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:[ContactInfo entityName]];
    
    NSSortDescriptor *idSort = [NSSortDescriptor sortDescriptorWithKey:@"email" ascending:YES];
    
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
