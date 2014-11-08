//
//  CategoriasCollectionViewController.h
//  AppNegocios
//
//  Created by Pedro Contreras Nava on 07/11/14.
//  Copyright (c) 2014 Pedro Contreras Nava. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Usuario.h"
@interface CategoriasCollectionViewController : UICollectionViewController <NSFetchedResultsControllerDelegate>
@property (strong,nonatomic) Usuario *usuario;

@end
