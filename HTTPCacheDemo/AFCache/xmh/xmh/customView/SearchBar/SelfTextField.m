//
//  SelfTextField.m
//  caodaren
//
//  Created by caoyinliang on 15/8/19.
//  Copyright (c) 2015年 caoyinliang. All rights reserved.
//

#import "SelfTextField.h"

@implementation SelfTextField
{
    UILabel *title;
    NSString *_tempStr;
}

- (UIToolbar *)inputAccessoryView{
    if(!_accessory)
    {
        CGRect rx = [ UIScreen mainScreen ].bounds;
        UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, WIDTH_SELF, 44)];
        toolBar.barStyle = UIBarStyleDefault;
        
        UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(doCancel)];
        [left setTintColor:[UIColor blackColor]];
        
        UIBarButtonItem *spaceBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                      target:nil
                                                                                      action:nil];
        title =[[UILabel alloc]initWithFrame:CGRectMake(80, 0, rx.size.width - 160, 44)];
        title.text = _tempStr;
        title.textAlignment = NSTextAlignmentCenter;
        spaceBarItem.customView = title;
        
        UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doOk)];
        [right setTintColor:[UIColor blackColor]];
        
        toolBar.items = [NSArray arrayWithObjects:left,spaceBarItem,right,nil];
        _accessory = toolBar;
        return _accessory;
    }
    return _accessory;
}
- (void)setSelfTitle:(NSString *)selfTitle
{
    _tempStr = selfTitle?selfTitle:@"";
    title.text = selfTitle;
}
//取消
- (void)doCancel{
    [self resignFirstResponder];
}
//完成
- (void)doOk{
    [self resignFirstResponder];
    if (_btnRightBlock) {
        _btnRightBlock();
    }
}
@end
