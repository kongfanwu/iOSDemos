//
//  LApproveFilterView.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/27.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LApproveFilterView : UIView
@property (nonatomic, assign)BOOL isContainType;
@property (nonatomic, copy)void (^LApproveFilterViewBlock)(NSObject *obj1,NSObject * obj2);
@end
