//
//  SelfSearchBar.m
//  iCardGod
//
//  Created by caoyinliang on 15/11/25.
//  Copyright © 2015年 51credit.com. All rights reserved.
//

#import "SelfSearchBar.h"

@implementation SelfSearchBar{
    CGRect  _selfFrame;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _selfFrame = frame;
    }
    return self;
}

- (UIToolbar *)inputAccessoryView{
    if(!_accessory)
    {
        CGRect rx = [ UIScreen mainScreen ].bounds;
        UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, WIDTH_SELF, 44)];
        toolBar.barStyle = UIBarStyleDefault;
        
        _left = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(doCancel)];
        [_left setTintColor:[UIColor blackColor]];
        
        UIBarButtonItem *spaceBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                      target:nil
                                                                                      action:nil];
        UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(80, 0, rx.size.width - 160, 44)];
        title.text = _selfTitle;
        title.textAlignment = NSTextAlignmentCenter;
        spaceBarItem.customView = title;
        
        UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doOk)];
        [right setTintColor:[UIColor blackColor]];
        
        toolBar.items = [NSArray arrayWithObjects:_left,spaceBarItem,right,nil];
        _accessory = toolBar;
        return _accessory;
    }
    return _accessory;
}
- (void)doCancel{
//    self.text = nil;
    [self resignFirstResponder];
    if (_btnleftBlock) {
        _btnleftBlock();
    }
}
//完成
- (void)doOk{
    [self resignFirstResponder];
    if (_btnRightBlock) {
        _btnRightBlock();
    }
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds{
    CGRect rect = CGRectMake(10, (bounds.size.height - self.leftView.height) / 2.f, self.leftView.width, self.leftView.height);
    return rect;
}
- (CGRect)editingRectForBounds:(CGRect)bounds{
    CGRect rect = CGRectMake(25, 0, _selfFrame.size.width - 10 - 20, 35);
    return rect;
}
- (void)drawPlaceholderInRect:(CGRect)rect{
     UIEdgeInsets insets = {10, 10, 10, 10};
    [super drawPlaceholderInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

@end
