//
//  Categoria.h
//  AppNegocios
//
//  Created by Pedro Contreras Nava on 05/11/14.
//  Copyright (c) 2014 Pedro Contreras Nava. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Producto;

@interface Categoria : NSManagedObject

@property (nonatomic, retain) NSString * nombreCategoria;
@property (nonatomic, retain) NSSet *users;
@property (nonatomic, retain) NSSet *products;
@end

@interface Categoria (CoreDataGeneratedAccessors)

- (void)addUsersObject:(NSManagedObject *)value;
- (void)removeUsersObject:(NSManagedObject *)value;
- (void)addUsers:(NSSet *)values;
- (void)removeUsers:(NSSet *)values;

- (void)addProductsObject:(Producto *)value;
- (void)removeProductsObject:(Producto *)value;
- (void)addProducts:(NSSet *)values;
- (void)removeProducts:(NSSet *)values;

@end
