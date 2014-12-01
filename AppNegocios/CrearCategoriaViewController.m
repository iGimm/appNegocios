//
//  CrearCategoriaViewController.m
//  AppNegocios
//
//  Created by Pedro Contreras Nava on 05/11/14.
//  Copyright (c) 2014 Pedro Contreras Nava. All rights reserved.
//

#import "CrearCategoriaViewController.h"
#import "ImagePickerCollectionViewController.h"
@interface CrearCategoriaViewController ()
@property   ImagePickerCollectionViewController *ipcvc;

@end

@implementation CrearCategoriaViewController
@synthesize nombreImagen = _nombreImagen;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cancelarPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"imagePickerSegue"]) {
        self.ipcvc = segue.destinationViewController;
        self.ipcvc.nombreImagen = _nombreImagen;
        
        
        NSString * resourcePath = [[NSBundle mainBundle] resourcePath];
        NSString * documentsPath = [resourcePath stringByAppendingPathComponent:@"imagenesCategorias"];
        NSError *error;
        NSArray * directoryContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsPath error:&error];
        self.ipcvc.imagesArray = directoryContents;
        
        NSLog(@"%@",directoryContents);
        
    }
}
@end
