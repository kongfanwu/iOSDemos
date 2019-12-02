//
//  MzzZhiHuanDuoTui.h
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/5/15.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMJDropdownMenu.h"
@interface MzzZhiHuanDuoTui : UIView
@property (weak, nonatomic) IBOutlet UITextField *huishoujine;
@property (weak, nonatomic) IBOutlet UITextField *zhihuanjine;
@property (weak, nonatomic) IBOutlet UITextField *chajialeixing;
@property (weak, nonatomic) IBOutlet UITextField *yingtuikuanxiang;
@property (weak, nonatomic) IBOutlet UITextField *zuizhongdingjia;
@property (weak, nonatomic) IBOutlet LMJDropdownMenu *tuikuanguishu;

@end
