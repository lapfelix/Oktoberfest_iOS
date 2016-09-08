//
//  ContestDoneViewController.m
//  okto_ios
//
//  Created by Guillaume Paquet on 2016-09-07.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "ContestDoneViewController.h"

@interface ContestDoneViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *universityTextField;
- (IBAction)sendTap:(UIButton *)sender;

@end

@implementation ContestDoneViewController

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

- (IBAction)sendTap:(UIButton *)sender {
    
    if (_nameTextField.text && _nameTextField.text.length > 0 && _emailTextField.text && _emailTextField.text.length > 0 && _universityTextField.text && _universityTextField.text.length > 0) {
        [self displayAlertWithTitle:@"Coucours réussi" andMessage:@"Vos données ont été envoyées" shoudlDismissContest:YES];
    } else {
        [self displayAlertWithTitle:@"Données manquantes" andMessage:@"Il y a des champs manquants" shoudlDismissContest:NO];
    }
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
    [self.navigationController dismissViewControllerAnimated:NO completion:nil];
}

@end
