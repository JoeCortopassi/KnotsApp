//
//  ItemViewController.h
//  KnotsApp
//
//  Created by Joe Cortopassi on 1/10/13.
//  Copyright (c) 2013 Joe Cortopassi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemViewController : UIViewController <UIScrollViewDelegate>
{
    IBOutlet UIScrollView *imageScrollView;
    NSDictionary *itemList;
    CGFloat buttonSpacing;
    CGSize buttonSize;
    NSTimer *slideShowTimer;
    int currentSlideIndex;
    UIButton *scrollViewOverlayButton;
    IBOutlet UIButton *exitButton;
    IBOutlet UIButton *playButton;
    NSMutableArray *pagingButtons;
    NSMutableArray *descriptionList;
    NSString *selectedKnot;
    UIColor *selectionColor;
}

@property (nonatomic, strong) UIScrollView *imageScrollView;
@property (nonatomic, strong) NSDictionary *itemList;
@property (nonatomic, assign) CGFloat buttonSpacing;
@property (nonatomic, assign) CGSize buttonSize;
@property (nonatomic, strong) NSTimer *slideShowTimer;
@property (nonatomic, assign) int currentSlideIndex;
@property (nonatomic, strong) UIButton *scrollViewOverlayButton;
@property (nonatomic, strong) UIButton *exitButton;
@property (nonatomic, strong) UIButton *playButton;
@property (nonatomic, strong) NSMutableArray *pagingButtons;
@property (nonatomic, strong) NSMutableArray *descriptionList;
@property (nonatomic, strong) NSString *selectedKnot;
@property (nonatomic, strong) UIColor *selectionColor;

-(IBAction)exitItemView:(id)sender;
-(IBAction)autoScrollPages:(id)sender;
@end
