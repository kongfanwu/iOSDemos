//
//  BillConfirmHeader.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/28.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BillConfirmHeader : UIView

@property (weak, nonatomic) IBOutlet UILabel *lbTitle;

@property (weak, nonatomic) IBOutlet UIButton *btn1;

@property (nonatomic, copy) void (^btnBillConfirmHeaderBlock)(NSString *state,BOOL boolState);

@end
