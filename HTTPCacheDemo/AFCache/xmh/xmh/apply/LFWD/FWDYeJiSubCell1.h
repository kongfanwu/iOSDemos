//
//  FWDYeJiSubCell1.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/11.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLJishiSearchModel.h"
@interface FWDYeJiSubCell1 : UITableViewCell<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UITextField *tf;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (strong, nonatomic)MLJiShiModel * model;
@property (copy, nonatomic)void (^FWDYeJiSubCellDelBlock)(MLJiShiModel * model);
@end
