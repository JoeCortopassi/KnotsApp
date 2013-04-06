//
//  MenuViewController.m
//  KnotsApp
//
//  Created by Joe Cortopassi on 1/9/13.
//  Copyright (c) 2013 Joe Cortopassi. All rights reserved.
//

#import "MenuViewController.h"
#import "ItemViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

@synthesize menuSlider, pageInformation,knotKeys, leftArrow, rightArrow, leftArrowButton, rightArrowButton, currentSlideIndex;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.currentSlideIndex = 0;
    self.menuSlider.contentSize = CGSizeMake(([[UIScreen mainScreen] bounds].size.width * [self.pageInformation count]), [[UIScreen mainScreen] bounds].size.height-20);
    self.menuSlider.pagingEnabled = YES;
    self.menuSlider.delegate = self;
    
    
    for (int i = 0; i < [self.pageInformation count]; i++)
    {
        MenuItemView *menuItem = [self setupPageSubviewForIndex:i];
        menuItem.coverPhoto.backgroundColor = (i%2 == 0)?[UIColor yellowColor]:[UIColor cyanColor];
        [self.menuSlider addSubview:menuItem];
    }
    
    
    [self setupPagingArrows];
}

- (void)setupPagingArrows
{
    self.leftArrow = [[UIImageView alloc] init];
    [self.leftArrow setImage:[UIImage imageNamed:@"left_arrow.png"]];
    self.leftArrow.alpha = 0.4f;
    self.leftArrow.hidden = YES;
    self.leftArrow.frame = CGRectMake(10,
                                      20,
                                      12.5,
                                      25.0);
    
    
    self.leftArrowButton = [[UIButton alloc] init];
    self.leftArrowButton.enabled = NO;
    [self.leftArrowButton addTarget:self action:@selector(leftPageArrowTouched) forControlEvents:UIControlEventTouchUpInside];
    self.leftArrowButton.frame = CGRectMake(0,
                                            5,
                                            52.5,
                                            45.0);
    
    
    self.rightArrow = [[UIImageView alloc] init];
    [self.rightArrow setImage:[UIImage imageNamed:@"right_arrow.png"]];
    self.rightArrow.alpha = 0.4f;
    self.rightArrow.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width-22.5,
                                       20,
                                       12.5,
                                       25.0);
    
    
    self.rightArrowButton = [[UIButton alloc] init];
    [self.rightArrowButton setBackgroundImage:nil forState:UIControlStateNormal];
    [self.rightArrowButton addTarget:self action:@selector(rightPageArrowTouched) forControlEvents:UIControlEventTouchUpInside];
    self.rightArrowButton.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width-52.5,
                                             5,
                                             52.5,
                                             45.0);
    
    
    [self.view addSubview:self.leftArrow];
    [self.view addSubview:self.leftArrowButton];
    [self.view addSubview:self.rightArrow];
    [self.view addSubview:self.rightArrowButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSDictionary *) pageInformation
{
    // TODO: For the love of Pete, change this to knot objects.
    return    @{@"squareKnot"       : @{@"title" : @"Square Knot",
                                        @"description" : @"A bend knot that has stood the test of time, the square knot is most effectively used to secure a rope around an object. When finished with slip-knots, this is most commonly seen in the tying of shoes.",
                                        @"picture" : @"squareKnot5.jpg",
                                        @"name" : @"squareKnot"},
                
                @"cloveHitch"       : @{@"title" : @"Clove Hitch",
                                        @"description" : @"An essential knot, the clove hitch is commonly used for everything from securing a climber to an anchor, to tying a horse to a post. As an added bonus, it is easy to adjust and untie.",
                                        @"picture" : @"cloveHitch5.jpg",
                                        @"name" : @"cloveHitch"},
                
                @"hitchingTie"      : @{@"title" : @"Hitching Tie",
                                        @"description" : @"A quick and easy slip knot that is just as easy to tie as it is to untie, the hitching tie is an all purpose knot helpful in almost any situation.",
                                        @"picture" : @"hitchingTie6.jpg",
                                        @"name" : @"hitchingTie"},
                
                @"bowline"          : @{@"title" : @"Bowline",
                                        @"description" : @"A simple way to make a fixed loop at the end of a rope, that is both easy to tie and untie. Popularly used in sailing, the bowline is also used in rescue operations as well.",
                                        @"picture" : @"bowline6.jpg",
                                        @"name" : @"bowline"},
                
                @"overhandLoop"     : @{@"title" : @"Overhand Loop",
                                        @"description" : @"Easiest way you will find to tie a fixed loop in a rope, the overhand loop is useful for providing attachment points in a line, and can even be used in the middle of a line.",
                                        @"picture" : @"overhandLoop4.jpg",
                                        @"name" : @"overhandLoop"},
                
                @"cowHitch"         : @{@"title" : @"Cow Hitch",
                                        @"description" : @"Similar to the half hitch, the cow hitch is used to secure a line, most commonly to a post or ring. Another great use is found in mines, were it's used to suspend power lines from the ceiling.",
                                        @"picture" : @"cowHitch6.jpg",
                                        @"name" : @"cowHitch"},
                
                @"transomKnot"      : @{@"title" : @"Transom Knot",
                                        @"description" : @"The transom knot is a great knot used to secure two rods or sticks together, in the form of a cross or 'X'. Helpful for a variety of camping uses, it is also used in kite making.",
                                        @"picture" : @"transomKnot6.jpg",
                                        @"name" : @"transomKnot"},
                
                @"sheetBend"        : @{@"title" : @"Sheet Bend",
                                        @"description" : @"Need to join two separate ropes into a single, longer rope? The sheet bend is an essential. More secure (but less easy to undo) than the square knot.",
                                        @"picture" : @"sheetBend5.jpg",
                                        @"name" : @"sheetBend"},
                
                @"butterflyLoop"    : @{@"title" : @"Butterfly Loop",
                                        @"description" : @"A useful knot for making fixed loops in the middle of a line, it has the added benefit of applying equal load to each line, or even isolating a damaged piece of rope.",
                                        @"picture" : @"butterflyLoop7.jpg",
                                        @"name" : @"butterflyLoop"},
                
                @"heavingLineKnot"  : @{@"title" : @"Heaving Line Knot",
                                        @"description" : @"Ever tried to throw a piece of rope, only to have it fall far short of your goal? Use the heaving line knot to add some extra weight to the end of the rope, making it easier to throw.",
                                        @"picture" : @"heavingLineKnot8.jpg",
                                        @"name" : @"heavingLineKnot"}};
}

- (NSArray *) knotKeys
{
    return    @[@"bowline",
                @"butterflyLoop",
                @"cloveHitch",
                @"cowHitch",
                @"heavingLineKnot",
                @"hitchingTie",
                @"overhandLoop",
                @"sheetBend",
                @"squareKnot",
                @"transomKnot"];
}

- (MenuItemView *)setupPageSubviewForIndex:(int)index
{
    MenuItemView *menuItem = [[MenuItemView alloc] init];
    menuItem.backgroundColor = [UIColor blackColor];
    menuItem.delegate = self;
    menuItem.frame = CGRectMake(([[UIScreen mainScreen] bounds].size.width * index),
                                0,
                                [[UIScreen mainScreen] bounds].size.width,
                                [[UIScreen mainScreen] bounds].size.height-20);

    menuItem.coverPhoto.image = [self imageForMenuItemAtIndex:index];
    
    menuItem.coverTitle.text = [[self.pageInformation objectForKey:[self.knotKeys objectAtIndex:index]] objectForKey:@"title"];
    menuItem.coverTitle.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.5f];
    
    menuItem.coverDescription.text = [[self.pageInformation objectForKey:[self.knotKeys objectAtIndex:index]] objectForKey:@"description"];
    
    menuItem.itemName = [[self.pageInformation objectForKey:[self.knotKeys objectAtIndex:index]] objectForKey:@"name"];
    
    return menuItem;
}


- (UIImage *) imageForMenuItemAtIndex:(int)index
{
    NSString *fileName = [[self.pageInformation objectForKey:[self.knotKeys objectAtIndex:index]] objectForKey:@"picture"];
    UIImage *image = [UIImage imageNamed:fileName];
    
    return image;
}


-(void) showItem:(ItemViewController *)itemViewController
{
    [self.navigationController presentViewController:(UIViewController *)itemViewController animated:YES completion:nil];
}


- (void) rightPageArrowTouched
{
    CGFloat pageXPosition = ((self.currentSlideIndex+1) * [[UIScreen mainScreen] bounds].size.width);
    [self.menuSlider setContentOffset:CGPointMake(pageXPosition, 0) animated:YES];
}


- (void) leftPageArrowTouched
{
    CGFloat pageXPosition = ((self.currentSlideIndex-1) * [[UIScreen mainScreen] bounds].size.width);
    [self.menuSlider setContentOffset:CGPointMake(pageXPosition, 0) animated:YES];
}


- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    int slide = floor((scrollView.contentOffset.x - [[UIScreen mainScreen] bounds].size.width / 2) / [[UIScreen mainScreen] bounds].size.width)+1;
    
    
    if (slide == 0)
    {
        self.leftArrow.hidden = YES;
        self.leftArrowButton.enabled = NO;
    }
    else if (slide == [self.pageInformation count]-1)
    {
        self.rightArrow.hidden = YES;
        self.rightArrowButton.enabled = NO;
    }
    else
    {
        self.leftArrow.hidden = NO;
        self.leftArrowButton.enabled = YES;
        self.rightArrow.hidden = NO;
        self.rightArrowButton.enabled = YES;
    }
    
    
    self.currentSlideIndex = slide;
}

@end