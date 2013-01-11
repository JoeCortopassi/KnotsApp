//
//  MenuViewController.m
//  KnotsApp
//
//  Created by Joe Cortopassi on 1/9/13.
//  Copyright (c) 2013 Joe Cortopassi. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

@synthesize menuSlider, pageInformation;


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
    
    self.menuSlider.contentSize = CGSizeMake(([[UIScreen mainScreen] bounds].size.width * [self.pageInformation count]), [[UIScreen mainScreen] bounds].size.height-20);
    self.menuSlider.pagingEnabled = YES;
    
    
    for (int i = 0; i < [self.pageInformation count]; i++)
    {
        MenuItemView *menuItem = [self setupPageSubviewForIndex:i];
        [self.menuSlider addSubview:menuItem];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *) pageInformation
{
    return    @[@{@"title" : @"1st pic", @"picture" : @"pic1.png"},
                @{@"title" : @"2nd pic", @"picture" : @"pic2.png"},
                @{@"title" : @"3rd pic", @"picture" : @"pic3.png"},
                @{@"title" : @"4th pic", @"picture" : @"pic4.png"},
                @{@"title" : @"5th pic", @"picture" : @"pic5.png"},
                @{@"title" : @"6th pic", @"picture" : @"pic6.png"},
                @{@"title" : @"7th pic", @"picture" : @"pic7.png"},
                @{@"title" : @"8th pic", @"picture" : @"pic8.png"},
                @{@"title" : @"9th pic", @"picture" : @"pic9.png"},
                @{@"title" : @"10th pic", @"picture" : @"pic10.png"}];
}

- (MenuItemView *)setupPageSubviewForIndex:(int)index
{
    MenuItemView *menuItem = [[MenuItemView alloc] init];
    menuItem.frame = CGRectMake(([[UIScreen mainScreen] bounds].size.width * index),
                                0,
                                [[UIScreen mainScreen] bounds].size.width,
                                [[UIScreen mainScreen] bounds].size.height-20);
    menuItem.delegate = self;
    menuItem.backgroundColor = [UIColor blueColor];
    
    
    menuItem.coverPhoto.backgroundColor = [UIColor yellowColor];
    menuItem.coverTitle.backgroundColor = [UIColor whiteColor];
    menuItem.coverTitle.text = [[self.pageInformation objectAtIndex:index] objectForKey:@"title"];
    
    
    return menuItem;
}


-(void) showItem:(ItemViewController *)itemViewController
{
    [self.navigationController presentViewController:(UIViewController *)itemViewController animated:YES completion:nil];
}

@end
