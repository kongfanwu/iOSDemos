//
//  SelfSearchBar.h
//  iCardGod
//
//  Created by caoyinliang on 15/11/25.
//  Copyright © 2015年 51credit.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelfSearchBar : UITextField
- (instancetype)initWithFrame:(CGRect)frame;
@property (strong,nonatomic) UIToolbar *accessory;//取消，标题，完成
@property (strong,nonatomic) NSString  *selfTitle;//键盘标题
@property (assign,nonatomic) NSInteger  dateValue;//值，暂时没用到
@property (strong,nonatomic)UIBarButtonItem *left;//取消按钮
@property (nonatomic, copy) void (^btnleftBlock)();//取消按钮block
@property (nonatomic, copy) void (^btnRightBlock)();//完成按钮block
//完成
- (void)doOk;
@end
