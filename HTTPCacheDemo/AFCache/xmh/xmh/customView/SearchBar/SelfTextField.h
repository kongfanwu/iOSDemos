//
//  SelfTextField.h
//  caodaren
//
//  Created by caoyinliang on 15/8/19.
//  Copyright (c) 2015年 caoyinliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelfTextField : UITextField

@property (strong,nonatomic) UIToolbar *accessory;//取消，标题，完成
@property (strong,nonatomic) NSString  *selfTitle;//键盘标题
@property (assign,nonatomic) NSInteger  dateValue;//值，暂时没用到
@property (nonatomic, copy) void (^btnRightBlock)();//完成按钮block
@end
