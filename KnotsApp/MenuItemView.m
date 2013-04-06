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


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        self.selectedItemViewController = nil;
        
        CGRect bounds = [[UIScreen mainScreen] bounds];
        self.coverPhoto = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, bounds.size.width, bounds.size.height)];

        
        self.imageOverlayButton = [[UIButton alloc] initWithFrame:self.coverPhoto.frame];
        self.imageOverlayButton.backgroundColor = [UIColor clearColor];
        [self.imageOverlayButton addTarget:self
                                    action:@selector(menuItemSelected:)
                          forControlEvents:UIControlEventTouchUpInside];
        
        
        self.coverTitle = [[UITextView alloc] init];
        self.coverTitle.frame = CGRectMake(0, 0, bounds.size.width, 75.0);
        [self.coverTitle setContentInset:UIEdgeInsetsMake(10.0f, 20.0f, 20.0f, 20.0f)];
        self.coverTitle.font = [UIFont fontWithName:@"Verdana-Bold" size:20];
        self.coverTitle.textColor = [UIColor colorWithRed:0.9f green:0.9f blue:0.9f alpha:1.0f];
        self.coverTitle.scrollEnabled = NO;
        [self.coverTitle setEditable:NO];
        [self.coverTitle setUserInteractionEnabled:NO];
        [self.coverTitle setTextAlignment: NSTextAlignmentCenter];
        
        
        
        
        [self addSubview:self.coverPhoto];
        [self addSubview:self.imageOverlayButton];
        [self addSubview:self.coverTitle];
        [self setupLabelCoverDescription];
    }
    
    return self;
}



- (void)setupLabelCoverDescription
{
    CGRect bounds = [[UIScreen mainScreen] bounds];
    
    self.coverDescription = [[UITextView alloc] init];
    self.coverDescription.frame = CGRectMake(0, bounds.size.height-150.0f, bounds.size.width, 150.0);
    self.coverDescription.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.5f];
    [self.coverDescription setContentInset:UIEdgeInsetsMake(10.0f, 20.0f, 20.0f, 20.0f)];
    self.coverDescription.font = [UIFont fontWithName:@"Verdana-Bold" size:14];
    self.coverDescription.textColor = [UIColor colorWithRed:0.9f green:0.9f blue:0.9f alpha:1.0f];
    self.coverDescription.scrollEnabled = NO;
    [self.coverDescription setEditable:NO];
    [self.coverDescription setUserInteractionEnabled:NO];
    [self.coverDescription setTextAlignment: NSTextAlignmentJustified];
    
    [self addSubview:self.coverDescription];
}


- (void)menuItemSelected:(id)sender
{
    self.selectedItemViewController = [[ItemViewController alloc] init];
    self.selectedItemViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    // set the knot selection string. Hard coded for testing
    self.selectedItemViewController.selectedKnot = self.itemName;
    
    [self.delegate showItem:self.selectedItemViewController];
}

@end
