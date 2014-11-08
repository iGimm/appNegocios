//
//  Producto.h
//  AppNegocios
//
//  Created by Pedro Contreras Nava on 07/11/14.
//  Copyright (c) 2014 Pedro Contreras Nava. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Categoria, Usuario;

@interface Producto : NSManagedObject

@property (nonatomic, retain) NSDate * fechaInicio;
@property (nonatomic, retain) NSDate * fechaTermino;
@property (nonatomic, retain) NSString * nombreProducto;
@property (nonatomic, retain) NSNumber * porcentaje;
@property (nonatomic, retain) Categoria *category;
@property (nonatomic, retain) NSSet *users;
@end

@interface Producto (CoreDataGeneratedAccessors)

- (void)addUsersObject:(Usuario *)value;
- (void)removeUsersObject:(Usuario *)value;
- (void)addUsers:(NSSet *)values;
- (void)removeUsers:(NSSet *)values;

@end
