//
//  MenuViewController.h
//  KnotsApp
//
//  Created by Joe Cortopassi on 1/9/13.
//  Copyright (c) 2013 Joe Cortopassi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuItemView.h"


@interface MenuViewController : UIViewController <MenuItemViewDelegate, UIScrollViewDelegate>
{
    IBOutlet UIScrollView *menuSlider;
    NSArray *knotKeys;
    NSDictionary *pageInformation;
    UIButton *leftArrow;
    UIButton *rightArrow;
    int currentSlideIndex;
}

@property (nonatomic, strong) UIScrollView *menuSlider;
@property (nonatomic, strong) NSDictionary *pageInformation;
@property (nonatomic, strong) NSArray *knotKeys;
@property (nonatomic, strong) UIButton *leftArrow;
@property (nonatomic, strong) UIButton *rightArrow;
@property (nonatomic, assign) int currentSlideIndex;
@end
