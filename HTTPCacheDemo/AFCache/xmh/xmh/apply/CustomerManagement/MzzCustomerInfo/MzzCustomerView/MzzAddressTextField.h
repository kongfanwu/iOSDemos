//
//  MzzAddressTextField.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/21.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^DoneBtnOnclick)(UITextField *textField);
typedef void(^CencelBtnOnclick)(UITextField *textField);
@interface MzzAddressTextField : UITextField
@property (nonatomic,copy)void(^done)(UITextField *);
@property (nonatomic,copy)void(^cencel)(UITextField *);
@property (nonatomic,copy) DoneBtnOnclick doneclick;
@property (nonatomic,copy)CencelBtnOnclick cencelclick;

@end
