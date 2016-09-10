//
//  ContestStepViewController.m
//  okto_ios
//
//  Created by Guillaume Paquet on 2016-09-07.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "ContestStepViewController.h"

@interface ContestStepViewController ()

@property (weak, nonatomic) IBOutlet UIProgressView *stepProgressView;
@property (weak, nonatomic) IBOutlet UIImageView *beerImage;
@property (weak, nonatomic) IBOutlet UITextField *answerTextField;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
- (IBAction)validateTap:(UIButton *)sender;

@end

@implementation ContestStepViewController

NSString *correctAnswer = @"Pabst";
int currentStep = 0;
int totalStep = 6;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)validateTap:(UIButton *)sender {
    
    if ([[_answerTextField.text lowercaseString] isEqualToString:[correctAnswer lowercaseString]]) {
        
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

- (void)showSuccessStep {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Bienvenue" bundle:nil];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"ContestDoneViewControllerIdentifier"];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
