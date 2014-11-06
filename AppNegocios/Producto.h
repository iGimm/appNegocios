//
//  Producto.h
//  AppNegocios
//
//  Created by Pedro Contreras Nava on 05/11/14.
//  Copyright (c) 2014 Pedro Contreras Nava. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Producto : NSManagedObject

@property (nonatomic, retain) NSString * nombreProducto;
@property (nonatomic, retain) NSDate * fechaInicio;
@property (nonatomic, retain) NSDate * fechaTermino;
@property (nonatomic, retain) NSNumber * porcentaje;
@property (nonatomic, retain) NSManagedObject *category;

@end
