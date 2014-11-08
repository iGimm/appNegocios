//
//  AddProductTableViewController.h
//  AppNegocios
//
//  Created by Pedro Contreras Nava on 06/11/14.
//  Copyright (c) 2014 Pedro Contreras Nava. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Categoria.h"
#import "Usuario.h"
@interface AddProductTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>
@property (nonatomic, retain) NSMutableSet *products;
@property (nonatomic,retain) Categoria *categoria;
@property (nonatomic,retain) Usuario *usuario;
@end
