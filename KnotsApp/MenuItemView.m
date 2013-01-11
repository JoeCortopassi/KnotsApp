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
        self.coverPhoto = [[UIImageView alloc] initWithFrame:CGRectMake(10.0, 10.0, bounds.size.width - 20.0, (bounds.size.height * 0.66))];
        [self addSubview:self.coverPhoto];
        
        self.imageOverlayButton = [[UIButton alloc] initWithFrame:self.coverPhoto.frame];
        self.imageOverlayButton.backgroundColor = [UIColor clearColor];
        [self.imageOverlayButton addTarget:self
                                    action:@selector(menuItemSelected:)
                          forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.imageOverlayButton];
        
        self.coverTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, (bounds.size.height * 0.77), bounds.size.width-40, 50)];
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
