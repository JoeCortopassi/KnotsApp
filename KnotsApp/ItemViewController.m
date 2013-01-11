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

@synthesize imageScrollView, itemList, buttonSpacing, buttonSize, slideShowTimer, currentSlideIndex, scrollViewOverlayButton, pagingButtons, descriptionList, exitButton, playButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.buttonSpacing = 5.0f;
        self.buttonSize = CGSizeMake(30.0, 30.0);
        self.pagingButtons = [[NSMutableArray alloc] initWithCapacity:[[self itemList] count]];
        self.descriptionList = [[NSMutableArray alloc] initWithCapacity:[[self itemList] count]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.imageScrollView.contentSize = CGSizeMake(([[UIScreen mainScreen] bounds].size.width * [self.itemList count]), [[UIScreen mainScreen] bounds].size.height-20);
    self.imageScrollView.pagingEnabled = YES;
    self.imageScrollView.backgroundColor = [UIColor purpleColor];
    
    [self setupPages];
    [self setupScrollViewOverlayButton];
    [self setupButtonsForPaging];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (void) setupPages
{   
    for (int i=0; i<[[self itemList] count]; i++)
    {
        [self setupImageForPageAtIndex:i];
        [self setupDescriptionForPageAtIndex:i];
    }
}


- (void) setupImageForPageAtIndex:(int)index
{
    CGRect bounds = [[UIScreen mainScreen] bounds];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake((index * bounds.size.width), 0, bounds.size.width, bounds.size.height);
    imageView.backgroundColor = (index%2 == 0)?[UIColor greenColor]:[UIColor orangeColor];
    
    [self.imageScrollView addSubview:imageView];
}


- (void) setupDescriptionForPageAtIndex:(int)index
{
    CGRect bounds = [[UIScreen mainScreen] bounds];
    
    UITextView *description = [[UITextView alloc] init];
    description.frame = CGRectMake((index * bounds.size.width), (bounds.size.height * 0.6), bounds.size.width, (bounds.size.height * 0.4));
    description.text = [[[self itemList] objectAtIndex:index] objectForKey:@"description"];
    description.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.5f];
    [description setContentInset:UIEdgeInsetsMake(20.0f, 20.0f, 20.0f, 20.0f)];
    description.textColor = [UIColor colorWithRed:0.9f green:0.9f blue:0.9f alpha:1.0f];
    description.font = [UIFont fontWithName:@"Verdana-Bold" size:14];

    
    [self.imageScrollView addSubview:description];
    [self.descriptionList addObject:description];
}


- (void) setupScrollViewOverlayButton
{
    self.scrollViewOverlayButton = [[UIButton alloc] init];
    self.scrollViewOverlayButton.frame = CGRectMake(0, 0, ([[UIScreen mainScreen] bounds].size.width * [self.itemList count]), [[UIScreen mainScreen] bounds].size.height-20);
    self.scrollViewOverlayButton.backgroundColor = [UIColor clearColor];
    [self.scrollViewOverlayButton addTarget:self
                                     action:@selector(toggleOverlay)
                           forControlEvents:UIControlEventTouchUpInside];
    
    [self.imageScrollView addSubview:self.scrollViewOverlayButton];
}


- (void) setupButtonsForPaging
{
    for (int i=0; i<[[self itemList] count]; i++)
    {
        UIButton *buttonForPage = [self getPagingButtonForIndex:i];
        [self.view addSubview:buttonForPage];
        [self.pagingButtons addObject:buttonForPage];
    }
    
    [self positionPagingButtons:self.pagingButtons];
}


- (NSArray *) itemList
{
    return    @[@{@"picture":@"image1.png", @"description":@"1 Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s"},
                @{@"picture":@"image1.png", @"description":@"2 Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s"},
                @{@"picture":@"image1.png", @"description":@"3 Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s"},
                @{@"picture":@"image1.png", @"description":@"4 Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s"},
                @{@"picture":@"image1.png", @"description":@"5 Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s"},
                @{@"picture":@"image1.png", @"description":@"6 Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s"}];
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


- (void) positionPagingButtons:(NSArray *)buttons
{
    CGRect bounds = [[UIScreen mainScreen] bounds];
    int buttonCount = [[self itemList] count];
    CGFloat sizeNeededForPaging = ((buttonCount * self.buttonSize.width) + ((buttonCount - 1) * self.buttonSpacing));
    
    float startOfpagingButtons = (bounds.size.width - sizeNeededForPaging) / 2;
    
    
    for (int i=0; i<[buttons count]; i++)
    {
        float buttonsXPosition = startOfpagingButtons + ((self.buttonSize.width + self.buttonSpacing) * i);
        float buttonsYPosition = bounds.size.height - (self.buttonSize.height * 2);
        CGRect adjustedFrame = CGRectMake(buttonsXPosition, buttonsYPosition, self.buttonSize.width, self.buttonSize.height);

        [[buttons objectAtIndex:i] setFrame:adjustedFrame];
    }
}


- (void) pagingButtonPressed:(id)sender
{
    self.currentSlideIndex = [sender tag] - 1;
    CGFloat pageXPosition = ([sender tag] * [[UIScreen mainScreen] bounds].size.width);
    [self.imageScrollView setContentOffset:CGPointMake(pageXPosition, 0) animated:YES];
}


- (void) scrollViewOverlayTouched
{
    
}


- (IBAction) autoScrollPages:(id)sender
{
    if (self.slideShowTimer == nil)
    {
        self.slideShowTimer = [NSTimer scheduledTimerWithTimeInterval:1.5
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
    
    if (self.currentSlideIndex == [[self itemList] count]-1)
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


- (void) toggleOverlay
{
    BOOL isHidden = !self.exitButton.hidden;
    
    self.exitButton.hidden = isHidden;
    self.playButton.hidden = isHidden;
    
    for (int i=0; i<[self.itemList count]; i++)
    {
        [[self.pagingButtons objectAtIndex:i] setHidden:isHidden];
        [[self.descriptionList objectAtIndex:i] setHidden:isHidden];
    }
}


-(IBAction)exitItemView:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
