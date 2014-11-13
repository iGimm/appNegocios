//
//  CreateProductViewController.m
//  AppNegocios
//
//  Created by Pedro Contreras Nava on 06/11/14.
//  Copyright (c) 2014 Pedro Contreras Nava. All rights reserved.
//

#import "CreateProductViewController.h"
#import "ImagePickerCollectionViewController.h"

@interface CreateProductViewController ()
@property   ImagePickerCollectionViewController *ipcvc;

@end

@implementation CreateProductViewController
@synthesize nombreImagen = _nombreImagen;

- (void)viewDidLoad {
    [super viewDidLoad];
    _labelNombreCategoria.text = _categoria.nombreCategoria;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cancelarButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"imagePickerSegue"]) {
        self.ipcvc = segue.destinationViewController;
        self.ipcvc.nombreImagen = _nombreImagen;
        
        
    }
}

@end
