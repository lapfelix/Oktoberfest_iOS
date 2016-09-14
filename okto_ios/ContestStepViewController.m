//
//  ContestStepViewController.m
//  okto_ios
//
//  Created by Guillaume Paquet on 2016-09-07.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "ContestStepViewController.h"
#import "AppDelegate.h"
#import "ContestStep+Methods.h"

@interface ContestStepViewController ()

@property (weak, nonatomic) IBOutlet UIProgressView *stepProgressView;
@property (weak, nonatomic) IBOutlet UIImageView *beerImage;
@property (weak, nonatomic) IBOutlet UITextField *answerTextField;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

- (IBAction)validateTap:(UIButton *)sender;

@end

@implementation ContestStepViewController

NSArray *contestSteps;
int currentStep = 0;
long totalStep = 8;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeFetchedResultsController];
    contestSteps = [[self fetchedResultsController] fetchedObjects];
    totalStep = contestSteps.count;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)validateTap:(UIButton *)sender {
    ContestStep *currentContestStep = contestSteps[currentStep];
    
    if ([[_answerTextField.text lowercaseString] isEqualToString:[currentContestStep.answer lowercaseString]]) {
        
        currentStep++;
        
        if (currentStep >= totalStep) {
            [self showSuccessStep];
        }

        [_stepProgressView setProgress:(float)currentStep/totalStep];
        [self resetLabels];
        
    } else {
        [_resultLabel setText:@"Mauvaise réponse..."];
    }
}

- (void)resetLabels {
    [_resultLabel setText:@"Deviner"];
    [_answerTextField setText:@""];
}

#pragma mark - Navigation

- (void)showSuccessStep {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Bienvenue" bundle:nil];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"ContestDoneViewControllerIdentifier"];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Core Data stack

- (void)initializeFetchedResultsController {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:[ContestStep entityName]];
    
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
