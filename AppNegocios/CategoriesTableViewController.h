//
//  CategoriesTableViewController.h
//  AppNegocios
//
//  Created by Pedro Contreras Nava on 05/11/14.
//  Copyright (c) 2014 Pedro Contreras Nava. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "Usuario.h"
#import "Categoria.h"
#import "Producto.h"

@interface CategoriesTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>
@property (strong,nonatomic) Usuario *usuario;

@end
