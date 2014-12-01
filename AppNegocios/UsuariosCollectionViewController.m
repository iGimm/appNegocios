//
//  UsuariosCollectionViewController.m
//  AppNegocios
//
//  Created by Pedro Contreras Nava on 07/11/14.
//  Copyright (c) 2014 Pedro Contreras Nava. All rights reserved.
//

#import "UsuariosCollectionViewController.h"
#import "AppDelegate.h"
#import "Usuario.h"
#import "Categoria.h"
#import "Producto.h"
#import "CreateUserViewController.h"
#import "UsuariosCollectionViewCell.h"
#import "CategoriasCollectionViewController.h"

@interface UsuariosCollectionViewController ()
@property (nonatomic, strong) NSManagedObjectContext * managedObjectContext;
@property (nonatomic,strong)NSFetchedResultsController *fetchedResultsController;
@property (nonatomic,strong) Usuario *usuarioSeleccionado;
@property (nonatomic,strong)NSMutableArray * sectionChanges;
@property (nonatomic,strong)NSMutableArray * itemChanges;

@end

@implementation UsuariosCollectionViewController
@synthesize managedObjectContext = _managedObjectContext;
@synthesize fetchedResultsController = _fetchedResultsController;
@synthesize usuarioSeleccionado;

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *collectionViewLayout = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
    collectionViewLayout.sectionInset = UIEdgeInsetsMake(14, 15, 0, 15);
    
    //UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    _managedObjectContext = [(AppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Usuario" inManagedObjectContext:_managedObjectContext];
    NSError *error =nil;
    //Load items
    
    NSFetchRequest * busqueda = [[NSFetchRequest alloc] init];
    [busqueda setEntity:entityDescription];
    [busqueda setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"nombreUsuario" ascending:YES]]];
    
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:busqueda managedObjectContext:_managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    [_fetchedResultsController setDelegate:self];
    if(![_fetchedResultsController performFetch:&error]){
        [[[UIAlertView alloc] initWithTitle:@"Error"
                                    message:@"Hubo un error al hacer la búsqueda"
                                   delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
        
        NSLog(@"%@",error.localizedDescription);
    }
    
    [self setTitle:@"Secciones"];

    
    // Register cell classes
    //[self.collectionView registerClass:[ProductCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [[_fetchedResultsController sections] count];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *sections = [_fetchedResultsController sections];
    id<NSFetchedResultsSectionInfo>sectionInfo = [sections objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UsuariosCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    Usuario *currentUsuario = [_fetchedResultsController objectAtIndexPath:indexPath];
    
    // Configure the cell
    
    // Configure the cell
    /*cell.layer.borderWidth = 1.0f;
    cell.layer.borderColor = [[UIColor blueColor] CGColor];*/
    cell.labelNombreSeccion.textColor = [UIColor whiteColor];
    cell.labelNombreSeccion.text =  currentUsuario.nombreUsuario;
    cell.labelNombreSeccion.adjustsFontSizeToFitWidth = YES;
    cell.labelNombreSeccion.textAlignment = NSTextAlignmentLeft;
    cell.imageView.image = [UIImage imageNamed:currentUsuario.nombreImagen];
    
    return cell;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    _sectionChanges = [[NSMutableArray alloc] init];
    _itemChanges = [[NSMutableArray alloc] init];
}

- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex
     forChangeType:(NSFetchedResultsChangeType)type {
    NSMutableDictionary *change = [[NSMutableDictionary alloc] init];
    change[@(type)] = @(sectionIndex);
    [_sectionChanges addObject:change];
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    NSMutableDictionary *change = [[NSMutableDictionary alloc] init];
    switch(type) {
        case NSFetchedResultsChangeInsert:
            change[@(type)] = newIndexPath;
            break;
        case NSFetchedResultsChangeDelete:
            change[@(type)] = indexPath;
            break;
        case NSFetchedResultsChangeUpdate:
            change[@(type)] = indexPath;
            break;
        case NSFetchedResultsChangeMove:
            change[@(type)] = @[indexPath, newIndexPath];
            break;
    }
    [_itemChanges addObject:change];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.collectionView performBatchUpdates:^{
        for (NSDictionary *change in _sectionChanges) {
            [change enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                NSFetchedResultsChangeType type = [key unsignedIntegerValue];
                switch(type) {
                    case NSFetchedResultsChangeInsert:
                        [self.collectionView insertSections:[NSIndexSet indexSetWithIndex:[obj unsignedIntegerValue]]];
                        break;
                    case NSFetchedResultsChangeDelete:
                        [self.collectionView deleteSections:[NSIndexSet indexSetWithIndex:[obj unsignedIntegerValue]]];
                        break;
                }
            }];
        }
        for (NSDictionary *change in _itemChanges) {
            [change enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                NSFetchedResultsChangeType type = [key unsignedIntegerValue];
                switch(type) {
                    case NSFetchedResultsChangeInsert:
                        [self.collectionView insertItemsAtIndexPaths:@[obj]];
                        break;
                    case NSFetchedResultsChangeDelete:
                        [self.collectionView deleteItemsAtIndexPaths:@[obj]];
                        break;
                    case NSFetchedResultsChangeUpdate:
                        [self.collectionView reloadItemsAtIndexPaths:@[obj]];
                        break;
                    case NSFetchedResultsChangeMove:
                        [self.collectionView moveItemAtIndexPath:obj[0] toIndexPath:obj[1]];
                        break;
                }
            }];
        }
    } completion:^(BOOL finished) {
        _sectionChanges = nil;
        _itemChanges = nil;
    }];
}

- (IBAction)unwindToList:(UIStoryboardSegue *)segue{
    
    CreateUserViewController *cvc = segue.sourceViewController;
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Usuario" inManagedObjectContext:_managedObjectContext];
    
    
    if([cvc.tfNombreUsuario.text isEqualToString:@""] || [cvc.tfEdadUsuario.text isEqualToString:@""]){
        
        [[[UIAlertView alloc] initWithTitle:@"Datos incompletos"
                                    message:@"Llena todos los datos del usuario"
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
        
    }
    else{
        Usuario * newUsuario = [[Usuario alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:_managedObjectContext];
        
        [newUsuario setNombreUsuario:cvc.tfNombreUsuario.text];
        [newUsuario setEdadUsuario:cvc.tfEdadUsuario.text];
        [newUsuario setNombreImagen:cvc.nombreImagen];
        
    }
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

        if ([segue.identifier isEqualToString:@"showCategoriesFromUser"]) {
            CategoriasCollectionViewController * ccvc = (CategoriasCollectionViewController*)segue.destinationViewController;
            UICollectionViewCell *cell = (UICollectionViewCell *)sender;
            NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
            ccvc.usuario = [_fetchedResultsController objectAtIndexPath:indexPath];
            
        }
}

#pragma mark <UICollectionViewDelegate>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(135, 135);
}

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
