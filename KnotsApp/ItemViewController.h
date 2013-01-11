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
    NSArray *itemList;
    CGFloat buttonSpacing;
    CGSize buttonSize;
    NSTimer *slideShowTimer;
    int currentSlideIndex;
    UIButton *scrollViewOverlayButton;
    IBOutlet UIButton *exitButton;
    IBOutlet UIButton *playButton;
    NSMutableArray *pagingButtons;
    NSMutableArray *descriptionList;
}

@property (nonatomic, strong) UIScrollView *imageScrollView;
@property (nonatomic, strong) NSArray *itemList;
@property (nonatomic, assign) CGFloat buttonSpacing;
@property (nonatomic, assign) CGSize buttonSize;
@property (nonatomic, strong) NSTimer *slideShowTimer;
@property (nonatomic, assign) int currentSlideIndex;
@property (nonatomic, strong) UIButton *scrollViewOverlayButton;
@property (nonatomic, strong) UIButton *exitButton;
@property (nonatomic, strong) UIButton *playButton;
@property (nonatomic, strong) NSMutableArray *pagingButtons;
@property (nonatomic, strong) NSMutableArray *descriptionList;

-(IBAction)exitItemView:(id)sender;
-(IBAction)autoScrollPages:(id)sender;
@end
