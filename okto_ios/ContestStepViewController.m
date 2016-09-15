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
#import "OKTAppearance.h"
#import <SDWebImage/UIImageView+WebCache.h>

#import <RKDropdownAlert/RKDropdownAlert.h>

@interface ContestStepViewController ()

@property (weak, nonatomic) IBOutlet UIProgressView *stepProgressView;
@property (weak, nonatomic) IBOutlet UIImageView *beerImage;
@property (weak, nonatomic) IBOutlet UITextField *answerTextField;

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLayoutConstraint;

- (IBAction)validateTap:(UIButton *)sender;

@end

@implementation ContestStepViewController

NSArray *contestSteps;
int currentStep = 0;
long totalSteps = 8;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeFetchedResultsController];
    contestSteps = [[self fetchedResultsController] fetchedObjects];
    totalSteps = contestSteps.count;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [self initialSetup];
}

- (void)initialSetup {
    [self loadCurrentQuestionImage];
    [self updateProgressBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateProgressBar {
    [self.stepProgressView setProgress:(float)currentStep/totalSteps animated:YES];
}

- (void)loadCurrentQuestionImage {
    ContestStep *currentContestStep = contestSteps[currentStep];
    [self.beerImage sd_setImageWithURL:[NSURL URLWithString:currentContestStep.questionImageUrl]];
}

- (void)loadCurrentAnswerImage {
    ContestStep *currentContestStep = contestSteps[currentStep];
    [self.beerImage sd_setImageWithURL:[NSURL URLWithString:currentContestStep.answerImageUrl]];
}

- (IBAction)validateTap:(UIButton *)sender {
    ContestStep *currentContestStep = contestSteps[currentStep];
    
    if ([[self.answerTextField.text lowercaseString] isEqualToString:[currentContestStep.answer lowercaseString]]) {
        
        [self loadCurrentAnswerImage];
        currentStep++;
        
        if (currentStep >= totalSteps) {
            [RKDropdownAlert title:@"Félicitations!" message:@"Vous avez réussi!" backgroundColor:[OKTAppearance greenColor] textColor:UIColor.whiteColor time:2.5 completionHandler:^{
                [self showSuccessStep];
            }];
        } else {
            [RKDropdownAlert title:@"Bravo!" message:@"Bonne réponse!" backgroundColor:[OKTAppearance greenColor] textColor:UIColor.whiteColor time:2.5 completionHandler:^{
                [self loadCurrentQuestionImage];
            }];
        }

        [self updateProgressBar];
        [self resetLabels];
        
    } else {
        [RKDropdownAlert title:@"Mauvaise réponse..." message:@"Essayez à nouveau!" backgroundColor:[OKTAppearance yellowColor] textColor:UIColor.blackColor time:2];
        [self resetLabels];
    }
}

- (void)resetLabels {
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

- (void)keyboardDidShow:(NSNotification *)notification {
    NSDictionary* info = [notification userInfo];
    CGRect kbRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    self.bottomLayoutConstraint.constant = CGRectGetHeight(kbRect);
}

- (void)keyboardWillBeHidden:(NSNotification *)notification {
    NSDictionary* info = [notification userInfo];
    CGRect kbRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    
    self.bottomLayoutConstraint.constant = CGRectGetHeight(kbRect);
}

@end
