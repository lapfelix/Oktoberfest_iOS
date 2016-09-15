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
#import "KRConfettiView.h"
#import <RKDropdownAlert/RKDropdownAlert.h>

@interface ContestStepViewController ()

@property (weak, nonatomic) IBOutlet KRConfettiView *confettiView;
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
    
    [self.navigationItem setHidesBackButton:YES animated:YES];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Quitter" style:UIBarButtonItemStylePlain target:self action:@selector(quitTap)];
    
    [self.confettiView setup];
    
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
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self initialSetup];
}

- (void)initialSetup {
    [self loadCurrentQuestionImage];
    [self updateProgressBar];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.answerTextField becomeFirstResponder];
}

- (void)quitTap {
    [self.navigationController dismissViewControllerAnimated:true completion:nil];
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
        
        self.answerTextField.alpha = 0.5;
        sender.alpha = 0.5;
        sender.userInteractionEnabled = NO;
        
        if (currentStep >= totalSteps) {
            self.confettiView.alpha = 1;
            self.answerTextField.userInteractionEnabled = NO;
            [self.confettiView startConfetti];
            [self.answerTextField resignFirstResponder];
            
            [RKDropdownAlert title:@"Félicitations!" message:@"Vous avez réussi!" backgroundColor:[OKTAppearance greenColor] textColor:UIColor.whiteColor time:2.5 completionHandler:^{
                [self.confettiView stopConfetti];
                [self showSuccessStep];
            }];
        } else {
            
            [RKDropdownAlert title:@"Bravo!" message:@"Bonne réponse!" backgroundColor:[OKTAppearance greenColor] textColor:UIColor.whiteColor time:2 completionHandler:^{
                if (currentStep < totalSteps) {
                    
                    self.answerTextField.alpha = 1;
                    self.answerTextField.userInteractionEnabled = YES;
                    sender.alpha = 1;
                    sender.userInteractionEnabled = YES;
                    [self loadCurrentQuestionImage];
                }
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
    
    [UIView animateWithDuration:0.2 animations:^{
        self.bottomLayoutConstraint.constant = CGRectGetHeight(kbRect);
        [self.view layoutIfNeeded];
    }];
}

- (void)keyboardWillBeHidden:(NSNotification *)notification {
    NSDictionary* info = [notification userInfo];
    CGRect kbRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.bottomLayoutConstraint.constant = CGRectGetHeight(kbRect);
        [self.view layoutIfNeeded];
    }];
}

@end
