//
//  CreateProductViewController.h
//  AppNegocios
//
//  Created by Pedro Contreras Nava on 06/11/14.
//  Copyright (c) 2014 Pedro Contreras Nava. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Categoria.h"
#import "Producto.h"

@interface CreateProductViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *tfNombreProducto;
@property (weak, nonatomic) IBOutlet UILabel *labelNombreCategoria;
@property (strong,nonatomic) Categoria* categoria;

@end
