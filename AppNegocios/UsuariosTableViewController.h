//
//  UsuariosTableViewController.h
//  AppNegocios
//
//  Created by Pedro Contreras Nava on 05/11/14.
//  Copyright (c) 2014 Pedro Contreras Nava. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@class Usuario;
@interface UsuariosTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>
@property (nonatomic,strong) Usuario *usuarioSeleccionado;

@end
