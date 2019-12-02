//
//  MzzPickerTextField.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/5.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^DoneBtnOnclick)(UITextField *textField);
typedef void(^CencelBtnOnclick)(UITextField *textField);

@interface MzzPickerTextField : UITextField

@property (nonatomic ,strong)UIPickerView*Picker;
@property (nonatomic,copy)void(^done)(UITextField *);
@property (nonatomic,copy)void(^cencel)(UITextField *);
@property (nonatomic,copy) DoneBtnOnclick doneclick;
@property (nonatomic,copy)CencelBtnOnclick cencelclick;
@property (nonatomic ,copy)NSString *selectStr;
@property (nonatomic, assign) NSInteger selectKey;
@property (nonatomic ,assign)BOOL isStore;
- (void)setupData:(NSArray *)datalist;
@end
