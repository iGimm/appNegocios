//
//  AddProductTableViewController.h
//  AppNegocios
//
//  Created by Pedro Contreras Nava on 06/11/14.
//  Copyright (c) 2014 Pedro Contreras Nava. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@interface AddProductTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>
@property (nonatomic, retain) NSMutableSet *products;

@end
