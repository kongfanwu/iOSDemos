//
//  LApproveFilterBtnView.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/12.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LApproveFilterBtnView : UIView
@property (nonatomic, assign)BOOL isContainType;
@property (nonatomic, strong)UIButton * btnSure;
@property (nonatomic, copy)NSString * ptype;
@property (nonatomic, copy)NSString * pState;
@end
