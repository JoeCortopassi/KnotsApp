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

@synthesize imageScrollView, itemList, buttonSpacing, buttonSize, slideShowTimer, currentSlideIndex, scrollViewOverlayButton, pagingButtons, descriptionList, exitButton, playButton, selectedKnot, selectionColor;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.buttonSpacing = 5.0f;
        self.buttonSize = CGSizeMake(30.0, 30.0);
        self.pagingButtons = [[NSMutableArray alloc] initWithCapacity:[[[self itemList] objectForKey:self.selectedKnot] count]];
        self.descriptionList = [[NSMutableArray alloc] initWithCapacity:[[[self itemList] objectForKey:self.selectedKnot] count]];
        self.selectionColor = [UIColor colorWithRed:(94.0/255.0) green:(161.0/255.0) blue:(226.0/255.0) alpha:1.0];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.imageScrollView.contentSize = CGSizeMake(([[UIScreen mainScreen] bounds].size.width * [[self.itemList objectForKey:self.selectedKnot] count]), [[UIScreen mainScreen] bounds].size.height-20);
    self.imageScrollView.pagingEnabled = YES;
    self.imageScrollView.backgroundColor = [UIColor blackColor];
    self.imageScrollView.delegate = self;
    
    [self setupPages];
    [self setupScrollViewOverlayButton];
    [self setupButtonsForPaging];
    self.currentSlideIndex = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (void) setupPages
{   
    for (int i=0; i<[[[self itemList] objectForKey:self.selectedKnot] count]; i++)
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
    imageView.backgroundColor = [UIColor blackColor];
    
    NSString *imageFileName = [(NSDictionary *)[(NSArray *)[self.itemList objectForKey:self.selectedKnot] objectAtIndex:index] objectForKey:@"picture"];
    
    UIImage *image = [UIImage imageNamed:imageFileName];
    imageView.image = image;
    
    [self.imageScrollView addSubview:imageView];
}


- (void) setupDescriptionForPageAtIndex:(int)index
{
    CGRect bounds = [[UIScreen mainScreen] bounds];
    
    UITextView *description = [[UITextView alloc] init];
    description.frame = CGRectMake((index * bounds.size.width), (bounds.size.height * 0.85), bounds.size.width, (bounds.size.height * 0.15));
    description.text = [(NSDictionary *)[(NSArray *)[(NSDictionary *)self.itemList objectForKey:self.selectedKnot] objectAtIndex:index] objectForKey:@"description"];
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
    self.scrollViewOverlayButton.frame = CGRectMake(0, 0, ([[UIScreen mainScreen] bounds].size.width * [[self.itemList objectForKey:self.selectedKnot] count]), [[UIScreen mainScreen] bounds].size.height-20);
    self.scrollViewOverlayButton.backgroundColor = [UIColor clearColor];
    [self.scrollViewOverlayButton addTarget:self
                                     action:@selector(toggleOverlay)
                           forControlEvents:UIControlEventTouchUpInside];
    
    [self.imageScrollView addSubview:self.scrollViewOverlayButton];
}


- (void) setupButtonsForPaging
{
    for (int i=0; i<[[[self itemList] objectForKey:self.selectedKnot] count]; i++)
    {
        UIButton *buttonForPage = [self getPagingButtonForIndex:i];
        [self.view addSubview:buttonForPage];
        [self.pagingButtons addObject:buttonForPage];
    }
    
    [self positionPagingButtons:self.pagingButtons];
}


- (NSDictionary *) itemList
{
    NSArray *squareKnot = @[@{@"picture" : @"squareKnot1.jpg", @"description" : @""},
                            @{@"picture" : @"squareKnot2.jpg", @"description" : @""},
                            @{@"picture" : @"squareKnot3.jpg", @"description" : @""},
                            @{@"picture" : @"squareKnot4.jpg", @"description" : @""},
                            @{@"picture" : @"squareKnot5.jpg", @"description" : @""},
                            @{@"picture" : @"squareKnot6.jpg", @"description" : @""}];
    
    NSArray *cloveHitch = @[@{@"picture" : @"cloveHitch1.jpg", @"description" : @""},
                            @{@"picture" : @"cloveHitch2.jpg", @"description" : @""},
                            @{@"picture" : @"cloveHitch3.jpg", @"description" : @""},
                            @{@"picture" : @"cloveHitch4.jpg", @"description" : @""},
                            @{@"picture" : @"cloveHitch5.jpg", @"description" : @""},
                            @{@"picture" : @"cloveHitch6.jpg", @"description" : @""}];
    
    NSArray *hitchingTie    = @[@{@"picture" : @"hitchingTie1.jpg", @"description" : @""},
                                @{@"picture" : @"hitchingTie2.jpg", @"description" : @""},
                                @{@"picture" : @"hitchingTie3.jpg", @"description" : @""},
                                @{@"picture" : @"hitchingTie4.jpg", @"description" : @""},
                                @{@"picture" : @"hitchingTie5.jpg", @"description" : @""},
                                @{@"picture" : @"hitchingTie6.jpg", @"description" : @""},
                                @{@"picture" : @"hitchingTie7.jpg", @"description" : @""}];
    
    NSArray *bowline    = @[@{@"picture" : @"bowline1.jpg", @"description" : @""},
                            @{@"picture" : @"bowline2.jpg", @"description" : @""},
                            @{@"picture" : @"bowline3.jpg", @"description" : @""},
                            @{@"picture" : @"bowline4.jpg", @"description" : @""},
                            @{@"picture" : @"bowline5.jpg", @"description" : @""},
                            @{@"picture" : @"bowline6.jpg", @"description" : @""},
                            @{@"picture" : @"bowline7.jpg", @"description" : @""}];
    
    NSArray *overhandLoop   = @[@{@"picture" : @"overhandLoop1.jpg", @"description" : @""},
                                @{@"picture" : @"overhandLoop2.jpg", @"description" : @""},
                                @{@"picture" : @"overhandLoop3.jpg", @"description" : @""},
                                @{@"picture" : @"overhandLoop4.jpg", @"description" : @""},
                                @{@"picture" : @"overhandLoop5.jpg", @"description" : @""}];
    
    NSArray *cowHitch   = @[@{@"picture" : @"cowHitch1.jpg", @"description" : @""},
                            @{@"picture" : @"cowHitch2.jpg", @"description" : @""},
                            @{@"picture" : @"cowHitch3.jpg", @"description" : @""},
                            @{@"picture" : @"cowHitch4.jpg", @"description" : @""},
                            @{@"picture" : @"cowHitch5.jpg", @"description" : @""},
                            @{@"picture" : @"cowHitch6.jpg", @"description" : @""},
                            @{@"picture" : @"cowHitch7.jpg", @"description" : @""}];
    
    NSArray *transomKnot= @[@{@"picture" : @"transomKnot1.jpg", @"description" : @""},
                            @{@"picture" : @"transomKnot2.jpg", @"description" : @""},
                            @{@"picture" : @"transomKnot3.jpg", @"description" : @""},
                            @{@"picture" : @"transomKnot4.jpg", @"description" : @""},
                            @{@"picture" : @"transomKnot5.jpg", @"description" : @""},
                            @{@"picture" : @"transomKnot6.jpg", @"description" : @""}];
    
    NSArray *sheetBend  = @[@{@"picture" : @"squareKnot1.jpg", @"description" : @""},
                            @{@"picture" : @"squareKnot2.jpg", @"description" : @""},
                            @{@"picture" : @"squareKnot3.jpg", @"description" : @""},
                            @{@"picture" : @"squareKnot4.jpg", @"description" : @""},
                            @{@"picture" : @"sheetBend5.jpg", @"description" : @""},
                            @{@"picture" : @"sheetBend6.jpg", @"description" : @""}];
    
    NSArray *butterflyLoop= @[@{@"picture" : @"butterflyLoop1.jpg", @"description" : @""},
                            @{@"picture" : @"butterflyLoop2.jpg", @"description" : @""},
                            @{@"picture" : @"butterflyLoop3.jpg", @"description" : @""},
                            @{@"picture" : @"butterflyLoop4.jpg", @"description" : @""},
                            @{@"picture" : @"butterflyLoop5.jpg", @"description" : @""},
                            @{@"picture" : @"butterflyLoop6.jpg", @"description" : @""},
                            @{@"picture" : @"butterflyLoop7.jpg", @"description" : @""},
                            @{@"picture" : @"butterflyLoop8.jpg", @"description" : @""}];
    
    NSArray *heavingLineKnot= @[@{@"picture" : @"heavingLineKnot1.jpg", @"description" : @""},
                                @{@"picture" : @"heavingLineKnot2.jpg", @"description" : @""},
                                @{@"picture" : @"heavingLineKnot3.jpg", @"description" : @""},
                                @{@"picture" : @"heavingLineKnot4.jpg", @"description" : @""},
                                @{@"picture" : @"heavingLineKnot5.jpg", @"description" : @""},
                                @{@"picture" : @"heavingLineKnot6.jpg", @"description" : @""},
                                @{@"picture" : @"heavingLineKnot7.jpg", @"description" : @""},
                                @{@"picture" : @"heavingLineKnot8.jpg", @"description" : @""}];
    
    
    NSDictionary *knotList  = @{@"squareKnot" : squareKnot,
                                @"cloveHitch" : cloveHitch,
                                @"hitchingTie": hitchingTie,
                                @"bowline": bowline,
                                @"overhandLoop" : overhandLoop,
                                @"cowHitch" : cowHitch,
                                @"transomKnot" : transomKnot,
                                @"sheetBend" : sheetBend,
                                @"butterflyLoop" : butterflyLoop,
                                @"heavingLineKnot" : heavingLineKnot};

    return knotList;
}


- (UIButton *) getPagingButtonForIndex:(int)index
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, self.buttonSize.width, self.buttonSize.height);
    button.titleLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:18];
    [button setTitle:[NSString stringWithFormat:@"%i", index+1] forState:UIControlStateNormal];
    button.tag = index;
    [button addTarget:self action:@selector(pagingButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}


- (void) positionPagingButtons:(NSArray *)buttons
{
    CGRect bounds = [[UIScreen mainScreen] bounds];
    int buttonCount = [[[self itemList] objectForKey:self.selectedKnot] count];
    CGFloat sizeNeededForPaging = ((buttonCount * self.buttonSize.width) + ((buttonCount - 1) * self.buttonSpacing));
    
    float startOfpagingButtons = (bounds.size.width - sizeNeededForPaging) / 2;
    
    
    for (int i=0; i<[buttons count]; i++)
    {
        float buttonsXPosition = startOfpagingButtons + ((self.buttonSize.width + self.buttonSpacing) * i);
        float buttonsYPosition = bounds.size.height - (self.buttonSize.height * 2.3);
        CGRect adjustedFrame = CGRectMake(buttonsXPosition, buttonsYPosition, self.buttonSize.width, self.buttonSize.height);

        [[buttons objectAtIndex:i] setFrame:adjustedFrame];
    }
}


- (void) pagingButtonPressed:(id)sender
{
    self.currentSlideIndex = [sender tag];
    CGFloat pageXPosition = ([sender tag] * [[UIScreen mainScreen] bounds].size.width);
    [self.imageScrollView setContentOffset:CGPointMake(pageXPosition, 0) animated:YES];
}


- (void) setCurrentSlideIndex:(int)newCurrentSlideIndex
{
    [self pagingButtonColoredAsSelectedAtIndex:newCurrentSlideIndex];
    
    currentSlideIndex = newCurrentSlideIndex;
}


-(void) pagingButtonColoredAsSelectedAtIndex:(int)index
{
    for (int i=0; i<[self.pagingButtons count]; i++)
    {
        [[self.pagingButtons objectAtIndex:i] setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    
    [[self.pagingButtons objectAtIndex:index] setTitleColor:self.selectionColor forState:UIControlStateNormal];
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

        [self.playButton setTitleColor:self.selectionColor forState:UIControlStateNormal];
    }
    else
    {
        [self.slideShowTimer invalidate];
        self.slideShowTimer = nil;
        
        [self.playButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}


- (void) playNextSlide
{
    BOOL shouldAnimate;
    
    if (self.currentSlideIndex == [[[self itemList] objectForKey:self.selectedKnot] count]-1)
    {
        self.currentSlideIndex = 0;
        shouldAnimate = NO;
    }
    else
    {
        self.currentSlideIndex++;
        shouldAnimate = NO;
    }
    
    [self.imageScrollView setContentOffset:CGPointMake(self.currentSlideIndex * [[UIScreen mainScreen] bounds].size.width, 0)
                                  animated:shouldAnimate];
}


- (void) toggleOverlay
{
    BOOL isHidden = !self.exitButton.hidden;
    
    self.exitButton.hidden = isHidden;
    self.playButton.hidden = isHidden;
    
    for (int i=0; i<[[self.itemList objectForKey:self.selectedKnot] count]; i++)
    {
        [[self.pagingButtons objectAtIndex:i] setHidden:isHidden];
        [[self.descriptionList objectAtIndex:i] setHidden:isHidden];
    }
}


-(IBAction)exitItemView:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    int slide = floor((scrollView.contentOffset.x - [[UIScreen mainScreen] bounds].size.width / 2) / [[UIScreen mainScreen] bounds].size.width)+1;
    
    self.currentSlideIndex = slide;
}
@end
