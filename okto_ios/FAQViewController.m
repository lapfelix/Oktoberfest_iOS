//
//  FAQViewController.m
//  okto_ios
//
//  Created by Felix Lapalme on 2016-08-28.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "FAQViewController.h"
#import "FAQ+Methods.h"
#import "AppDelegate.h"
#import "OKTAppearance.h"
#import <TSMarkdownParser/TSMarkdownParser.h>

@interface FAQViewController ()

@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end

@implementation FAQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initializeFetchedResultsController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [self updateText];
}

- (void)updateText {
    NSArray *fetchedObjects = [[self fetchedResultsController] fetchedObjects];
    
    if (fetchedObjects.count > 0) {
        FAQ *faq = fetchedObjects[0];
        
        TSMarkdownParser *parser = [TSMarkdownParser standardParser];
        parser.headerAttributes = @[
                                    @{ NSFontAttributeName: [UIFont boldSystemFontOfSize:33],
                                       NSForegroundColorAttributeName: [OKTAppearance greenColor]},
                                    @{ NSFontAttributeName: [UIFont boldSystemFontOfSize:28],
                                       NSForegroundColorAttributeName: [OKTAppearance greenColor]},
                                    @{ NSFontAttributeName: [UIFont boldSystemFontOfSize:26],
                                       NSForegroundColorAttributeName: [OKTAppearance greenColor]},
                                    @{ NSFontAttributeName: [UIFont boldSystemFontOfSize:23],
                                       NSForegroundColorAttributeName: [OKTAppearance greenColor]},
                                    @{ NSFontAttributeName: [UIFont boldSystemFontOfSize:21],
                                       NSForegroundColorAttributeName: [OKTAppearance greenColor]},
                                    ];
        parser.defaultAttributes = @{
                                     NSFontAttributeName: [UIFont systemFontOfSize:18 weight:UIFontWeightLight],
                                     NSForegroundColorAttributeName: [UIColor darkGrayColor]};
        NSAttributedString *attributedString = [parser attributedStringFromMarkdown:faq.markdown];
        
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
