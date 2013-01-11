//
//  MenuItemView.h
//  KnotsApp
//
//  Created by Joe Cortopassi on 1/9/13.
//  Copyright (c) 2013 Joe Cortopassi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ItemViewController;

@protocol MenuItemViewDelegate <NSObject>
- (void) showItem:(ItemViewController *)itemViewController;
@end

@interface MenuItemView : UIView
{
    UIImageView *coverPhoto;
    UITextView *coverTitle;
    UIButton *imageOverlayButton;
    ItemViewController *selectedItemViewController;
}

@property (nonatomic, strong) UIImageView *coverPhoto;
@property (nonatomic, strong) UITextView *coverTitle;
@property (nonatomic, strong) UIButton *imageOverlayButton;
@property (nonatomic, assign) id<MenuItemViewDelegate> delegate;
@property (nonatomic, strong) ItemViewController *selectedItemViewController;

- (void)menuItemSelected:(id)sender;
@end
