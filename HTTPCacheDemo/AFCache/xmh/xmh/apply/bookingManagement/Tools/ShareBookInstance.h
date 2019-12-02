//
//  ShareBookInstance.h
//  xmh
//
//  Created by 李晓明 on 2017/12/7.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SkipPageType.h"
#import "DaiYuYueModel.h"
#import "LolJiShiTimeModel.h"
@interface ShareBookInstance : NSObject
//详情页跳转由来
@property (nonatomic, assign)SkipPageType pageType;

// 规划外到店 已预约 修改预约 按时到店 未按时到店 规划外到店 需要 下面两个参数
//用户id  共有参数
@property (nonatomic, copy)NSString * userId;
//项目编码
@property (nonatomic, copy)NSString * ordernum;


//待预约模型  只有待预约界面跳转到详情页才需要
@property (nonatomic, strong)DaiYuYueModel * daiYuYueModel;
+ (ShareBookInstance *)shareInstance;

@property(nonatomic , strong)LolJiShiTimeModel * jiShiTimeModel;

@end
