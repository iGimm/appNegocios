//
//  AddProductTableViewController.m
//  AppNegocios
//
//  Created by Pedro Contreras Nava on 06/11/14.
//  Copyright (c) 2014 Pedro Contreras Nava. All rights reserved.
//

#import "AddProductTableViewController.h"
#import "Producto.h"
#import "AppDelegate.h"
#import "CreateProductViewController.h"
#import "Usuario.h"
@interface AddProductTableViewController ()
@property (nonatomic, strong) NSManagedObjectContext * managedObjectContext;
@property (nonatomic,strong)NSFetchedResultsController *fetchedResultsController;
@property AppDelegate *delegate;
@end

@implementation AddProductTableViewController
@synthesize managedObjectContext = _managedObjectContext;
@synthesize fetchedResultsController = _fetchedResultsController;
@synthesize products = _products;

- (void)viewDidLoad {
    _delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [super viewDidLoad];
    [self setTitle:[NSString stringWithFormat:@"Productos de %@",_categoria.nombreCategoria]];
    _managedObjectContext = [(AppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Producto" inManagedObjectContext:_managedObjectContext];
    NSError *error =nil;
    //Load items
    
    NSFetchRequest * busqueda = [[NSFetchRequest alloc] init];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(category.nombreCategoria == %@)", _categoria.nombreCategoria ];
    
    [busqueda setEntity:entityDescription];
    [busqueda setPredicate:predicate];
    [busqueda setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"nombreProducto" ascending:YES]]];
    
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:busqueda managedObjectContext:_managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    [_fetchedResultsController setDelegate:self];
    if(![_fetchedResultsController performFetch:&error]){
        [[[UIAlertView alloc] initWithTitle:@"Error"
                                    message:@"Hubo un error al hacer la búsqueda"
                                   delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
        
        NSLog(@"%@",error.localizedDescription);
    }
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView Data Source and Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[_fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *sections = [_fetchedResultsController sections];
    id<NSFetchedResultsSectionInfo>sectionInfo = [sections objectAtIndex:section];
    return [sectionInfo numberOfObjects];
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete object from database
        [context deleteObject:[self.fetchedResultsController.fetchedObjects  objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        
        
        // Remove device from table view
        //[self.fetchedResultsController.fetchedObjects  removeObjectAtIndex:indexPath.row];
        //[self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
}


- (void)configureCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath {
    
    Producto *currentProducto = [_fetchedResultsController objectAtIndexPath:indexPath];
    
    // Configure the cell
    [cell.textLabel       setText:[currentProducto nombreProducto]];
    
    if([_products containsObject:currentProducto] ){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else cell.accessoryType =UITableViewCellAccessoryNone;
}





-(void)removeProductFromSet:(Producto*)producto{
    [producto removeUsersObject:_usuario];
    [_products removeObject:producto];
}

-(void)addProductToSet:(Producto*)producto{
    [producto addUsersObject:_usuario];
    [_products addObject:producto];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Producto *productoSeleccionado = [_fetchedResultsController objectAtIndexPath:indexPath];
    if([_products containsObject:productoSeleccionado]){
        [self removeProductFromSet:productoSeleccionado];
    }else [self addProductToSet:(Producto*)productoSeleccionado];
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Deque cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    [self.tableView endUpdates];
}


-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller{
    [self.tableView beginUpdates];
}

-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath{
    switch (type) {
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
            
            break;
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationLeft];

            break;
        case NSFetchedResultsChangeMove:
            [self.tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
            break;
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[self.tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"createProductSegue"]) {
        CreateProductViewController *cpvc = segue.destinationViewController;
        cpvc.categoria = _categoria;
        
        
    }
}

- (IBAction)unwindToProduct:(UIStoryboardSegue *)segue{
    
  CreateProductViewController *cpvc = segue.sourceViewController;
    
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Producto" inManagedObjectContext:_managedObjectContext];
    Producto * newProducto = [[Producto alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:_managedObjectContext];

    
    if([cpvc.tfNombreProducto.text isEqualToString:@""]){
        
        [[[UIAlertView alloc] initWithTitle:@"Datos incompletos"
                                    message:@"Llena todos los datos de la categoria"
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
        
    }
    else{
        
        [newProducto setNombreProducto:cpvc.tfNombreProducto.text];
        [newProducto setCategory:_categoria];
        [newProducto setNombreImagen:cpvc.nombreImagen];
        
    }
    
    NSLog(@"UTOP");
    

}


@end
