//
//  Usuario.h
//  AppNegocios
//
//  Created by Pedro Contreras Nava on 07/11/14.
//  Copyright (c) 2014 Pedro Contreras Nava. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Categoria, Producto;

@interface Usuario : NSManagedObject

@property (nonatomic, retain) NSString * edadUsuario;
@property (nonatomic, retain) NSString * nombreUsuario;
@property (nonatomic, retain) NSSet *categories;
@property (nonatomic, retain) NSSet *products;
@end

@interface Usuario (CoreDataGeneratedAccessors)

- (void)addCategoriesObject:(Categoria *)value;
- (void)removeCategoriesObject:(Categoria *)value;
- (void)addCategories:(NSSet *)values;
- (void)removeCategories:(NSSet *)values;

- (void)addProductsObject:(Producto *)value;
- (void)removeProductsObject:(Producto *)value;
- (void)addProducts:(NSSet *)values;
- (void)removeProducts:(NSSet *)values;

@end
