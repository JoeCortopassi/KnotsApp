//
//  ItemViewController.h
//  KnotsApp
//
//  Created by Joe Cortopassi on 1/10/13.
//  Copyright (c) 2013 Joe Cortopassi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemViewController : UIViewController
{
    IBOutlet UIScrollView *imageScrollView;
    NSArray *imagesForItem;
    CGFloat buttonSpacing;
    CGSize buttonSize;
    NSTimer *slideShowTimer;
    int currentSlideIndex;
}

@property (nonatomic, strong) UIScrollView *imageScrollView;
@property (nonatomic, strong) NSArray *imagesForItem;
@property (nonatomic, assign) CGFloat buttonSpacing;
@property (nonatomic, assign) CGSize buttonSize;
@property (nonatomic, strong) NSTimer *slideShowTimer;
@property (nonatomic, assign) int currentSlideIndex;

-(IBAction)exitItemView:(id)sender;
-(IBAction)autoScrollPages:(id)sender;
@end
