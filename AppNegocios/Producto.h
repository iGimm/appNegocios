//
//  Producto.h
//  AppNegocios
//
//  Created by Pedro Contreras Nava on 29/11/14.
//  Copyright (c) 2014 Pedro Contreras Nava. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Categoria, FechasProducto, Usuario;

@interface Producto : NSManagedObject

@property (nonatomic, retain) NSString * nombreImagen;
@property (nonatomic, retain) NSString * nombreProducto;
@property (nonatomic, retain) NSNumber * porcentaje;
@property (nonatomic, retain) Categoria *category;
@property (nonatomic, retain) NSSet *users;
@property (nonatomic, retain) NSSet *dates;
@end

@interface Producto (CoreDataGeneratedAccessors)

- (void)addUsersObject:(Usuario *)value;
- (void)removeUsersObject:(Usuario *)value;
- (void)addUsers:(NSSet *)values;
- (void)removeUsers:(NSSet *)values;

- (void)addDatesObject:(FechasProducto *)value;
- (void)removeDatesObject:(FechasProducto *)value;
- (void)addDates:(NSSet *)values;
- (void)removeDates:(NSSet *)values;

@end
