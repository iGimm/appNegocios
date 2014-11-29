//
//  FechasProducto.h
//  AppNegocios
//
//  Created by Pedro Contreras Nava on 29/11/14.
//  Copyright (c) 2014 Pedro Contreras Nava. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Producto;

@interface FechasProducto : NSManagedObject

@property (nonatomic, retain) NSDate * fechaInicio;
@property (nonatomic, retain) NSDate * fechaFin;
@property (nonatomic, retain) Producto *producto;

@end
