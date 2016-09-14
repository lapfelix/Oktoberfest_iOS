//
//  RootViewController.m
//  okto_ios
//
//  Created by Felix Lapalme on 2016-08-26.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.viewControllers makeObjectsPerformSelector:@selector(view)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.tabBar.items[0].image = [UIImage imageNamed:@"bienvenue"];
    self.tabBar.items[0].selectedImage = [UIImage imageNamed:@"bienvenue_selected"];
    self.tabBar.items[1].image = [UIImage imageNamed:@"beers"];
    self.tabBar.items[1].selectedImage = [UIImage imageNamed:@"beers_selected"];
    self.tabBar.items[2].image = [UIImage imageNamed:@"schedule"];
    self.tabBar.items[2].selectedImage = [UIImage imageNamed:@"schedule_selected"];
    self.tabBar.items[3].image = [UIImage imageNamed:@"map"];
    self.tabBar.items[3].selectedImage = [UIImage imageNamed:@"map_selected"];
    self.tabBar.items[4].image = [UIImage imageNamed:@"infos"];
    self.tabBar.items[4].selectedImage = [UIImage imageNamed:@"infos_selected"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
