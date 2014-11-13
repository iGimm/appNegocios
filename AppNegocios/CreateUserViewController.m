//
//  CreateUserViewController.m
//  AppNegocios
//
//  Created by Pedro Contreras Nava on 05/11/14.
//  Copyright (c) 2014 Pedro Contreras Nava. All rights reserved.
//

#import "CreateUserViewController.h"
#import "ImagePickerCollectionViewController.h"

@interface CreateUserViewController ()
@property   ImagePickerCollectionViewController *ipcvc;
@end

@implementation CreateUserViewController
@synthesize nombreImagen = _nombreImagen;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)cancelPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)doneButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"unwindToList" sender:self];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"imagePickerSegue"]) {
        self.ipcvc = segue.destinationViewController;
        self.ipcvc.nombreImagen = _nombreImagen;
        
        
    }
}

@end
