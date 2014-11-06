//
//  UsuariosTableViewController.m
//  AppNegocios
//
//  Created by Pedro Contreras Nava on 05/11/14.
//  Copyright (c) 2014 Pedro Contreras Nava. All rights reserved.
//

#import "UsuariosTableViewController.h"
#import "AppDelegate.h"
#import "Usuario.h"
#import "Categoria.h"
#import "Producto.h"
#import "CreateUserViewController.h"
#import "CategoriesTableViewController.h"

@interface UsuariosTableViewController ()
@property (nonatomic, strong) NSManagedObjectContext * managedObjectContext;
@property (nonatomic,strong)NSFetchedResultsController *fetchedResultsController;
@property (nonatomic,strong) Usuario *usuarioSeleccionado;
@end

@implementation UsuariosTableViewController
@synthesize managedObjectContext = _managedObjectContext;
@synthesize fetchedResultsController = _fetchedResultsController;
@synthesize usuarioSeleccionado;
- (void)viewDidLoad {
    [super viewDidLoad];
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

    [self setTitle:@"Usuarios"];

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
    
    Usuario *currentUsuario = [_fetchedResultsController objectAtIndexPath:indexPath];
    
    // Configure the cell
    [cell.textLabel       setText:[currentUsuario nombreUsuario]];
    
    
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


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Usuario *usrSeleccionado = [_fetchedResultsController objectAtIndexPath:indexPath];
    

    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
                  {
    if ([segue.identifier isEqualToString:@"showAddUser"]) {
        
    }else
    if ([segue.identifier isEqualToString:@"showCategoriesFromUser"]) {
        CategoriesTableViewController * cvtc = (CategoriesTableViewController*)segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        cvtc.usuario = [_fetchedResultsController objectAtIndexPath:indexPath];
    }
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
    }

}


@end
