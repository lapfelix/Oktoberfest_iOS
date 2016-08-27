//
//  OKTBaseCoreDataTableViewController.h
//  okto_ios
//
//  Created by Felix Lapalme on 2016-08-27.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NSFetchedResultsController;

@interface OKTBaseTableViewController : UITableViewController

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end
