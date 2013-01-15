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
    UIImageView *leftArrow;
    UIImageView *rightArrow;
    UIButton *leftArrowButton;
    UIButton *rightArrowButton;
    int currentSlideIndex;
}

@property (nonatomic, strong) UIScrollView *menuSlider;
@property (nonatomic, strong) NSDictionary *pageInformation;
@property (nonatomic, strong) NSArray *knotKeys;
@property (nonatomic, strong) UIImageView *leftArrow;
@property (nonatomic, strong) UIImageView *rightArrow;
@property (nonatomic, strong) UIButton *leftArrowButton;
@property (nonatomic, strong) UIButton *rightArrowButton;
@property (nonatomic, assign) int currentSlideIndex;
@end
