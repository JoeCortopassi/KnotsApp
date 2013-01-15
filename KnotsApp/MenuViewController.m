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

@synthesize menuSlider, pageInformation,knotKeys, leftArrow, rightArrow, currentSlideIndex;


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
    
    
    self.leftArrow = [[UIButton alloc] init];
    [self.leftArrow setImage:[UIImage imageNamed:@"left_arrow.png"] forState:UIControlStateNormal];
    self.leftArrow.frame = CGRectMake(10, [[UIScreen mainScreen] bounds].size.height-65, 12.5, 25.0);
    //self.leftArrow.center = CGPointMake(20, [[UIScreen mainScreen] bounds].size.height*0.42);
    self.leftArrow.alpha = 0.4f;
    self.leftArrow.hidden = YES;
    [self.leftArrow addTarget:self action:@selector(leftPageArrowTouched) forControlEvents:UIControlEventTouchUpInside];
    
    self.rightArrow = [[UIButton alloc] init];
    [self.rightArrow setImage:[UIImage imageNamed:@"right_arrow.png"] forState:UIControlStateNormal];
    self.rightArrow.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width-22.5, [[UIScreen mainScreen] bounds].size.height-65, 12.5, 25.0);
    //self.rightArrow.center = CGPointMake([[UIScreen mainScreen] bounds].size.width-20, [[UIScreen mainScreen] bounds].size.height*0.42);
    self.rightArrow.alpha = 0.4f;
    [self.rightArrow addTarget:self action:@selector(rightPageArrowTouched) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:self.leftArrow];
    [self.view addSubview:self.rightArrow];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSDictionary *) pageInformation
{
    return    @{@"squareKnot"       : @{@"title" : @"Square Knot",      @"picture" : @"squareKnot5.jpg",        @"name" : @"squareKnot"},
                @"cloveHitch"       : @{@"title" : @"Clove Hitch",      @"picture" : @"cloveHitch5.jpg",        @"name" : @"cloveHitch"},
                @"hitchingTie"      : @{@"title" : @"Hitching Tie",     @"picture" : @"hitchingTie6.jpg",       @"name" : @"hitchingTie"},
                @"bowline"          : @{@"title" : @"Bowline",          @"picture" : @"bowline6.jpg",           @"name" : @"bowline"},
                @"overhandLoop"     : @{@"title" : @"Overhand Loop",    @"picture" : @"overhandLoop4.jpg",      @"name" : @"overhandLoop"},
                @"cowHitch"         : @{@"title" : @"Cow Hitch",        @"picture" : @"cowHitch6.jpg",          @"name" : @"cowHitch"},
                @"transomKnot"      : @{@"title" : @"Transom Knot",     @"picture" : @"transomKnot6.jpg",       @"name" : @"transomKnot"},
                @"sheetBend"        : @{@"title" : @"Sheet Bend",       @"picture" : @"sheetBend5.jpg",         @"name" : @"sheetBend"},
                @"butterflyLoop"    : @{@"title" : @"Butterfly Loop",   @"picture" : @"butterflyLoop7.jpg",     @"name" : @"butterflyLoop"},
                @"heavingLineKnot"  : @{@"title" : @"Heaving Line Knot",@"picture" : @"heavingLineKnot8.jpg",   @"name" : @"heavingLineKnot"}};
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
    }
    else if (slide == [self.pageInformation count]-1)
    {
        self.rightArrow.hidden = YES;
    }
    else
    {
        self.leftArrow.hidden = NO;
        self.rightArrow.hidden = NO;
    }
    
    
    self.currentSlideIndex = slide;
}

@end
