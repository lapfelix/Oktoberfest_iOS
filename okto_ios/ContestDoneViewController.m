//
//  ContestDoneViewController.m
//  okto_ios
//
//  Created by Guillaume Paquet on 2016-09-07.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "ContestDoneViewController.h"
#import "OKTAPIWrapper.h"
#import "OKTAppearance.h"
#import "KRConfettiView.h"

#import <RKDropdownAlert/RKDropdownAlert.h>

@interface ContestDoneViewController ()

@property (weak, nonatomic) IBOutlet KRConfettiView *confettiView;
@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberField;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;

- (IBAction)sendTap:(UIButton *)sender;

@property (copy, nonatomic) NSArray *textFields;

@end

@implementation ContestDoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.confettiView setup];
    
    _textFields = @[self.firstNameField, self.lastNameField, self.emailField, self.phoneNumberField];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [self.firstNameField becomeFirstResponder];
}

- (IBAction)sendTap:(UIButton *)sender {
    
    BOOL somethingIsNotValid = NO;
    
    if (![self firstNameFieldIsValid]) {
        somethingIsNotValid = YES;
    }
    if (![self lastNameFieldIsValid]) {
        somethingIsNotValid = YES;
    }
    if (![self phoneFieldIsValid]) {
        somethingIsNotValid = YES;
    }
    if (![self emailFieldIsValid]) {
        somethingIsNotValid = YES;
    }
    
    if (somethingIsNotValid) {
        return;
    }
    
    for (UITextField *textfield in self.textFields) {
        textfield.alpha = 0.5;
        textfield.userInteractionEnabled = NO;
    }
    
    self.sendButton.alpha = 0.5;
    self.sendButton.userInteractionEnabled = NO;
    
    [self attemptToSendInfo];
}

- (void)attemptToSendInfo {
    self.confettiView.alpha = 1;
    [self.confettiView startConfetti];
    [[OKTAPIWrapper sharedWrapper] sendUserContestData:@{
                                                         @"email":self.emailField.text,
                                                         @"firstName":self.firstNameField.text,
                                                         @"lastName":self.lastNameField.text,
                                                         @"phone":self.phoneNumberField.text,
                                                         }
                                 withCompletionHandler:^(BOOL success) {
                                     
                                     dispatch_async(dispatch_get_main_queue(), ^{
                                     if (!success) {
                                         [RKDropdownAlert title:@"Erreur!" message:@"Avez-vous une bonne connexion à l'Internet ? Nous allons réessayer d'envoyer les données." backgroundColor:[UIColor redColor] textColor:UIColor.whiteColor time:2.5 completionHandler:^{
                                                 [self attemptToSendInfo];
                                         }];
                                     } else {
                                         [RKDropdownAlert title:@"Succès!" message:@"Nous allons vous contacter si vous avez gagné!" backgroundColor:[OKTAppearance greenColor] textColor:UIColor.whiteColor time:2 completionHandler:^{
                                             [self dismissContest];
                                         }];
                                     }
                                         
                                     });
                                 }];
}

- (BOOL)firstNameFieldIsValid {
    BOOL notValid = self.firstNameField.text.length <= 0;
    
    if (notValid) {
        [self flashTextfieldRed:self.firstNameField];
    }
    
    return !notValid;
}
- (BOOL)lastNameFieldIsValid {
    BOOL notValid = self.lastNameField.text.length <= 0;
    
    if (notValid) {
        [self flashTextfieldRed:self.lastNameField];
    }
    
    return !notValid;
}
- (BOOL)emailFieldIsValid {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,5}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    BOOL notValid = !(self.emailField.text.length <= 0 || [emailTest evaluateWithObject:self.emailField.text]);
    
    if (notValid) {
        [self flashTextfieldRed:self.emailField];
    }
    
    return !notValid;
}
- (BOOL)phoneFieldIsValid {
    BOOL notValid = self.phoneNumberField.text.length < 7;
    
    if (notValid) {
        [self flashTextfieldRed:self.phoneNumberField];
    }
    
    return !notValid;
}

- (void)flashTextfieldRed:(UITextField *)badTextField {
    [UIView animateWithDuration:0.1 animations:^{
        badTextField.backgroundColor = [UIColor colorWithRed:1 green:0.5 blue:0.5 alpha:1];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1 animations:^{
            badTextField.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
        }];
    }];
}

- (void)displayAlertWithTitle:(NSString *)title andMessage:(NSString *)message shoudlDismissContest:(BOOL)dismissContest {
    
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              if (dismissContest) [self dismissContest];
                                                          }];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)dismissContest {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)firstNameNextTap {
    if ([self firstNameFieldIsValid]) {
        [self.lastNameField becomeFirstResponder];
    }
}

- (IBAction)lastNameNextTap {
    if ([self lastNameFieldIsValid]) {
        [self.emailField becomeFirstResponder];
    }
}

- (IBAction)emailNextTap {
    if ([self emailFieldIsValid]) {
        [self.phoneNumberField becomeFirstResponder];
    }
}

- (IBAction)phoneReturnTap {
    if ([self phoneNumberField]) {
        [self sendTap:nil];
    }
}

@end
