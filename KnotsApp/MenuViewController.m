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

@synthesize menuSlider, pageInformation,knotKeys;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.knotKeys = [self.pageInformation allKeys];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.menuSlider.contentSize = CGSizeMake(([[UIScreen mainScreen] bounds].size.width * [self.pageInformation count]), [[UIScreen mainScreen] bounds].size.height-20);
    self.menuSlider.pagingEnabled = YES;
    
    
    for (int i = 0; i < [self.pageInformation count]; i++)
    {
        MenuItemView *menuItem = [self setupPageSubviewForIndex:i];
        menuItem.coverPhoto.backgroundColor = (i%2 == 0)?[UIColor yellowColor]:[UIColor cyanColor];
        [self.menuSlider addSubview:menuItem];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSDictionary *) pageInformation
{
    return    @{@"squareKnot" : @{@"title" : @"Square Knot", @"picture" : @"squareKnot5.jpg", @"name" : @"squareKnot"},
                @"cloveHitch" : @{@"title" : @"Clove Hitch", @"picture" : @"cloveHitch6.jpg", @"name" : @"cloveHitch"},
                @"hitchingTie": @{@"title" : @"Hitching Tie", @"picture" : @"hitchingTie6.jpg", @"name" : @"hitchingTie"}};
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

@end
