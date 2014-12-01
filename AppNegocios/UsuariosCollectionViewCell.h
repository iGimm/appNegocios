//
//  ProductCollectionViewCell.h
//  AppNegocios
//
//  Created by Pedro Contreras Nava on 07/11/14.
//  Copyright (c) 2014 Pedro Contreras Nava. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UsuariosCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UILabel *labelNombreSeccion;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *labelPorcentaje;

@end
