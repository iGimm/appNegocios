//
//  Categoria.h
//  AppNegocios
//
//  Created by Pedro Contreras Nava on 07/11/14.
//  Copyright (c) 2014 Pedro Contreras Nava. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Producto, Usuario;

@interface Categoria : NSManagedObject

@property (nonatomic, retain) NSString * nombreCategoria;
@property (nonatomic, retain) NSSet *products;
@property (nonatomic, retain) NSSet *users;
@end

@interface Categoria (CoreDataGeneratedAccessors)

- (void)addProductsObject:(Producto *)value;
- (void)removeProductsObject:(Producto *)value;
- (void)addProducts:(NSSet *)values;
- (void)removeProducts:(NSSet *)values;

- (void)addUsersObject:(Usuario *)value;
- (void)removeUsersObject:(Usuario *)value;
- (void)addUsers:(NSSet *)values;
- (void)removeUsers:(NSSet *)values;

@end
