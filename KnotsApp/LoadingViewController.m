//
//  LoadingViewController.m
//  KnotsApp
//
//  Created by Joe Cortopassi on 1/15/13.
//  Copyright (c) 2013 Joe Cortopassi. All rights reserved.
//

#import "LoadingViewController.h"

@interface LoadingViewController ()

@end

@implementation LoadingViewController

@synthesize splash, start, screenOverlay;

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
    
    CGRect bounds = [[UIScreen mainScreen] bounds];
    
    self.splash = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default-568h@2x.png"]];
    self.splash.frame = CGRectMake(0, -20, bounds.size.width, bounds.size.height);
    
    self.start = [[UILabel alloc] init];
    self.start.frame = CGRectMake(0, 0, 230.0, 50.0);
    self.start.center = CGPointMake((bounds.size.width/2)+55, bounds.size.height-45.0);
    self.start.textColor = [UIColor whiteColor];
    self.start.backgroundColor = [UIColor clearColor];
    self.start.font = [UIFont fontWithName:@"Verdana-Bold" size:20];
    self.start.text = @"Press to Start";
    
    self.screenOverlay = [[UIButton alloc] init];
    self.screenOverlay.frame = bounds;
    self.screenOverlay.backgroundColor = [UIColor clearColor];
    [self.screenOverlay addTarget:self action:@selector(screenPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [self.view addSubview:self.splash];
    [self.view addSubview:self.start];
    [self.view addSubview:self.screenOverlay];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)screenPressed:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:NO];
}

@end
