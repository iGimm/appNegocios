//
//  ProductosCollectionViewController.h
//  AppNegocios
//
//  Created by Pedro Contreras Nava on 07/11/14.
//  Copyright (c) 2014 Pedro Contreras Nava. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Usuario.h"
#import "Categoria.h"
#import <CoreData/CoreData.h>
@interface ProductosCollectionViewController : UICollectionViewController <NSFetchedResultsControllerDelegate>
@property (strong,nonatomic) Usuario *usuario;
@property (strong,nonatomic) Categoria *categoria;
@end
