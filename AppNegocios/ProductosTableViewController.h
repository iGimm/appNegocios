//
//  ProductosTableViewController.h
//  AppNegocios
//
//  Created by Pedro Contreras Nava on 06/11/14.
//  Copyright (c) 2014 Pedro Contreras Nava. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Usuario.h"
@class Categoria;
@interface ProductosTableViewController : UITableViewController<NSFetchedResultsControllerDelegate>
@property (strong,nonatomic) Usuario *usuario;
@property (strong,nonatomic) Categoria *categoria;


@end
