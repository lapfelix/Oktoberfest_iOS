//
//  OKTBaseCoreDataTableViewController+FetchedResultsController.h
//  okto_ios
//
//  Created by Felix Lapalme on 2016-08-27.
//  Copyright © 2016 Felix Lapalme. All rights reserved.
//

#import "OKTBaseTableViewController.h"
@import CoreData;

@protocol OKTViewControllerCellConfigurationProtocol

- (void)configureCell:(id)cell atIndexPath:(NSIndexPath*)indexPath;

@end

@interface OKTBaseTableViewController (FetchedResultsController) <NSFetchedResultsControllerDelegate, OKTViewControllerCellConfigurationProtocol>

@end
