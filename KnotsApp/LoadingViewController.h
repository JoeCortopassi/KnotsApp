//
//  LoadingViewController.h
//  KnotsApp
//
//  Created by Joe Cortopassi on 1/15/13.
//  Copyright (c) 2013 Joe Cortopassi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingViewController : UIViewController
{
    UIImageView *splash;
    UILabel *start;
    UIButton *screenOverlay;
}

@property (nonatomic, strong) UIImageView *splash;
@property (nonatomic, strong) UILabel *start;
@property (nonatomic, strong) UIButton *screenOverlay;

- (void)screenPressed:(id)sender;

@end
