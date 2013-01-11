//
//  ItemViewController.m
//  KnotsApp
//
//  Created by Joe Cortopassi on 1/10/13.
//  Copyright (c) 2013 Joe Cortopassi. All rights reserved.
//

#import "ItemViewController.h"

@interface ItemViewController ()

@end

@implementation ItemViewController

@synthesize imageScrollView, imagesForItem, buttonSpacing, buttonSize, slideShowTimer, currentSlideIndex;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.buttonSpacing = 5.0f;
        self.buttonSize = CGSizeMake(20.0, 20.0);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.imageScrollView.contentSize = CGSizeMake(([[UIScreen mainScreen] bounds].size.width * [self.imagesForItem count]), [[UIScreen mainScreen] bounds].size.height-20);
    self.imageScrollView.pagingEnabled = YES;
    self.imageScrollView.backgroundColor = [UIColor purpleColor];
    [self setupPages];
    [self setupButtonsForPaging];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (void) setupPages
{
    CGRect bounds = [[UIScreen mainScreen] bounds];
    
    for (int i=0; i<[[self imagesForItem] count]; i++)
    {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake((i * bounds.size.width), 0, bounds.size.width, bounds.size.height);
        imageView.backgroundColor = (i%2 == 0)?[UIColor greenColor]:[UIColor orangeColor];
        
        [self.imageScrollView addSubview:imageView];
    }
}


- (void) setupButtonsForPaging
{
    NSMutableArray *buttons = [[NSMutableArray alloc] initWithCapacity:[[self imagesForItem] count]];
    
    
    for (int i=0; i<[[self imagesForItem] count]; i++)
    {
        UIButton *buttonForPage = [self getPagingButtonForIndex:i];
        [self.view addSubview:buttonForPage];
        [buttons addObject:buttonForPage];
    }
    
    [self positionPagingButtons:buttons];

    
}


- (NSArray *) imagesForItem
{
    return    @[@"image1.png",
                @"image2.png",
                @"image3.png",
                @"image4.png",
                @"image5.png",
                @"image6.png"];
}


- (UIButton *) getPagingButtonForIndex:(int)index
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(0, 0, self.buttonSize.width, self.buttonSize.height);
    [button setTitle:[NSString stringWithFormat:@"%i", index+1] forState:UIControlStateNormal];
    button.tag = index;
    [button addTarget:self action:@selector(pagingButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}


- (void) positionPagingButtons:(NSArray *)pagingButtons
{
    CGRect bounds = [[UIScreen mainScreen] bounds];
    int buttonCount = [[self imagesForItem] count];
    CGFloat sizeNeededForPaging = ((buttonCount * self.buttonSize.width) + ((buttonCount - 1) * self.buttonSpacing));
    
    float startOfpagingButtons = (bounds.size.width - sizeNeededForPaging) / 2;
    
    
    for (int i=0; i<[pagingButtons count]; i++)
    {
        float buttonsXPosition = startOfpagingButtons + ((self.buttonSize.width + self.buttonSpacing) * i);
        float buttonsYPosition = bounds.size.height - (self.buttonSize.height * 2);
        CGRect adjustedFrame = CGRectMake(buttonsXPosition, buttonsYPosition, self.buttonSize.width, self.buttonSize.height);

        [[pagingButtons objectAtIndex:i] setFrame:adjustedFrame];
    }
}


- (void) pagingButtonPressed:(id)sender
{
    CGFloat pageXPosition = ([sender tag] * [[UIScreen mainScreen] bounds].size.width);
    [self.imageScrollView setContentOffset:CGPointMake(pageXPosition, 0) animated:YES];
}


- (IBAction) autoScrollPages:(id)sender
{
    if (self.slideShowTimer == nil)
    {
        self.slideShowTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                               target:self
                                                             selector:@selector(playNextSlide)
                                                             userInfo:nil
                                                              repeats:YES];
    }
    else
    {
        [self.slideShowTimer invalidate];
        self.slideShowTimer = nil;
    }
}


- (void) playNextSlide
{
    BOOL shouldAnimate;
    
    if (self.currentSlideIndex == [[self imagesForItem] count]-1)
    {
        self.currentSlideIndex = 0;
        shouldAnimate = NO;
    }
    else
    {
        self.currentSlideIndex++;
        shouldAnimate = YES;
    }
    
    [self.imageScrollView setContentOffset:CGPointMake(self.currentSlideIndex * [[UIScreen mainScreen] bounds].size.width, 0)
                                  animated:shouldAnimate];
}


-(IBAction)exitItemView:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
