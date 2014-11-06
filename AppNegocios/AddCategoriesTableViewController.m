//
//  AddCategoriesTableViewController.m
//  AppNegocios
//
//  Created by Pedro Contreras Nava on 05/11/14.
//  Copyright (c) 2014 Pedro Contreras Nava. All rights reserved.
//

#import "AddCategoriesTableViewController.h"
#import "Categoria.h"
#import "AppDelegate.h"
#import "CrearCategoriaViewController.h"

@interface AddCategoriesTableViewController ()
@property (nonatomic, strong) NSManagedObjectContext * managedObjectContext;
@property (nonatomic,strong)NSFetchedResultsController *fetchedResultsController;
@end

@implementation AddCategoriesTableViewController
@synthesize managedObjectContext = _managedObjectContext;
@synthesize fetchedResultsController = _fetchedResultsController;
@synthesize categories = _categories;

- (void)viewDidLoad {
    [super viewDidLoad];
    _categories = [NSMutableSet new];
    _managedObjectContext = [(AppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Categoria" inManagedObjectContext:_managedObjectContext];
    NSError *error =nil;
    //Load items
    
    NSFetchRequest * busqueda = [[NSFetchRequest alloc] init];
    [busqueda setEntity:entityDescription];
    [busqueda setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"nombreCategoria" ascending:YES]]];
    
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:busqueda managedObjectContext:_managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    [_fetchedResultsController setDelegate:self];
    if(![_fetchedResultsController performFetch:&error]){
        [[[UIAlertView alloc] initWithTitle:@"Error"
                                    message:@"Hubo un error al hacer la búsqueda"
                                   delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
        
        NSLog(@"%@",error.localizedDescription);
    }
    
    [self setTitle:@"Categorias"];
    
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
    
    Categoria *currentCategoria = [_fetchedResultsController objectAtIndexPath:indexPath];
    
    // Configure the cell
    [cell.textLabel       setText:[currentCategoria nombreCategoria]];
    
    
}

-(void)addCategory:(Categoria*)categoria{
    [_categories addObject:categoria];
    NSLog(@"%@",_categories);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Categoria *categoriaSeleccionada = [_fetchedResultsController objectAtIndexPath:indexPath];
    [self addCategory:(Categoria*)categoriaSeleccionada];
    
    
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

- (IBAction)unwindToAddCategorie:(UIStoryboardSegue *)segue{
    CrearCategoriaViewController *ccvc = segue.sourceViewController;
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Categoria" inManagedObjectContext:_managedObjectContext];
    
    
    if([ccvc.tfNombreCategoria.text isEqualToString:@""]){
        
        [[[UIAlertView alloc] initWithTitle:@"Datos incompletos"
                                    message:@"Llena todos los datos de la categoria"
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
        
    }
    else{
        Categoria * newCategoria = [[Categoria alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:_managedObjectContext];
        
        [newCategoria setNombreCategoria:ccvc.tfNombreCategoria.text];
    }

    
}


@end
