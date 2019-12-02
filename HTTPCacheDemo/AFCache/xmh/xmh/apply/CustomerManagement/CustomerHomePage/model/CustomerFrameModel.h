//
//  CustomerFrameModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/4.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomerListModel.h"
@interface CustomerFrameModel : NSObject
@property (nonatomic ,strong)CustomerModel *customerModel;
//头像
@property (nonatomic,assign,readonly)CGRect iconUrlFrame;
//姓名
@property (nonatomic,assign,readonly)CGRect nameFrame;
//等级
@property (nonatomic,assign,readonly)CGRect levelFrame;
//门店
@property (nonatomic,assign,readonly)CGRect storeFrame;
//技师
@property (nonatomic,assign,readonly)CGRect waiterFrame;
//调至门店
@property (nonatomic,assign,readonly)CGRect toFrame;
//调至门店类型
@property (nonatomic,assign,readonly)CGRect toTypeFrame;
//顾客状态
@property (nonatomic,assign,readonly)CGRect statusFrame;
//完善状态
@property(nonatomic,assign,readonly)CGRect btnFrame;
//行高
@property (nonatomic,assign,readonly)CGFloat rowHeight;

//通过customerModel 初始化frame模型
+(instancetype)customerFrameWithCustomerModel:(CustomerListModel *)customerModel;
@end
