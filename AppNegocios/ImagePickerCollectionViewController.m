//
//  ImagePickerCollectionViewController.m
//  AppNegocios
//
//  Created by Pedro Contreras Nava on 12/11/14.
//  Copyright (c) 2014 Pedro Contreras Nava. All rights reserved.
//

#import "ImagePickerCollectionViewController.h"
#import "ImageCollectionViewCell.h"
#import "CreateUserViewController.h"

@interface ImagePickerCollectionViewController ()

@end

@implementation ImagePickerCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor whiteColor];


    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    

    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _imagesArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    
    NSLog(@"%ld",indexPath.row);
    // Configure the cell
    UIImage *imagen = [UIImage imageNamed:[_imagesArray objectAtIndex:indexPath.row]];
    
    
    cell.imageView.image = imagen;
    
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",[_imagesArray objectAtIndex:indexPath.row]);
    _nombreImagen = [_imagesArray objectAtIndex:indexPath.row];
    ImageCollectionViewCell *imageCell = (ImageCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    imageCell.imageView.alpha = .50;
    SEL setImage = @selector(setNombreImagen:);
    
    [[self parentViewController] performSelector:setImage withObject:_nombreImagen afterDelay:0];
    /*ImageCollectionViewCell *cell = (ImageCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    cell.layer.borderWidth = 1.0f;
    cell.layer.borderColor = [[UIColor blueColor] CGColor];*/

}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"des");
    ImageCollectionViewCell *imageCell = (ImageCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    imageCell.imageView.alpha = 1;

}

#pragma mark <UICollectionViewDelegate>


// Uncomment this method to specify if the specified item should be highlighted during tracking

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
