//
//  HeaderViewCollectionReusableView.h
//  AppNegocios
//
//  Created by Pedro Contreras Nava on 11/11/14.
//  Copyright (c) 2014 Pedro Contreras Nava. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderViewCollectionReusableView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *sectionTitle;

@end
