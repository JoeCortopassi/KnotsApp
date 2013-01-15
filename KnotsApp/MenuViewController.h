//
//  MenuViewController.h
//  KnotsApp
//
//  Created by Joe Cortopassi on 1/9/13.
//  Copyright (c) 2013 Joe Cortopassi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuItemView.h"


@interface MenuViewController : UIViewController <MenuItemViewDelegate>
{
    IBOutlet UIScrollView *menuSlider;
    NSArray *knotKeys;
    NSDictionary *pageInformation;
}

@property (nonatomic, strong) UIScrollView *menuSlider;
@property (nonatomic, strong) NSDictionary *pageInformation;
@property (nonatomic, strong) NSArray *knotKeys;
@end
