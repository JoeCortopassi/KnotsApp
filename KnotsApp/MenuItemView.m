//
//  MenuItemView.m
//  KnotsApp
//
//  Created by Joe Cortopassi on 1/9/13.
//  Copyright (c) 2013 Joe Cortopassi. All rights reserved.
//

#import "MenuItemView.h"
#import "ItemViewController.h"

@implementation MenuItemView

@synthesize coverPhoto, coverTitle, imageOverlayButton, delegate, selectedItemViewController;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        self.selectedItemViewController = nil;
        
        CGRect bounds = [[UIScreen mainScreen] bounds];
        self.coverPhoto = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, bounds.size.width, bounds.size.height)];
        [self addSubview:self.coverPhoto];
        
        self.imageOverlayButton = [[UIButton alloc] initWithFrame:self.coverPhoto.frame];
        self.imageOverlayButton.backgroundColor = [UIColor clearColor];
        [self.imageOverlayButton addTarget:self
                                    action:@selector(menuItemSelected:)
                          forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.imageOverlayButton];
        
        self.coverTitle = [[UITextView alloc] initWithFrame:CGRectMake(0, (bounds.size.height * 0.85), bounds.size.width, (bounds.size.height * 0.15)-20)];
        [self.coverTitle setContentInset:UIEdgeInsetsMake(20.0f, 20.0f, 20.0f, 20.0f)];
        self.coverTitle.font = [UIFont fontWithName:@"Verdana-Bold" size:20];
        self.coverTitle.textColor = [UIColor colorWithRed:0.9f green:0.9f blue:0.9f alpha:1.0f];
        
        [self.coverTitle setTextAlignment: NSTextAlignmentCenter];
        [self addSubview:self.coverTitle];
    }
    
    return self;
}





- (void)menuItemSelected:(id)sender
{
    self.selectedItemViewController = [[ItemViewController alloc] init];
    self.selectedItemViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self.delegate showItem:self.selectedItemViewController];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
