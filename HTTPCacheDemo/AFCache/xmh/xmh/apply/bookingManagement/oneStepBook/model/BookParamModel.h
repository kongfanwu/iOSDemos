//
//  BookParamModel.h
//  xmh
//
//  Created by ald_ios on 2018/10/22.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookParamModel : NSObject
/**
 *  来源类型
 *  ghydd=>规划要到店，yyy=>已预约 ，xgyy=>修改预约 ，ahdd=>按时到店，wasdd_pres=>未按时到店(规划处方) ，wasdd_appo=>未按时到店(预约)，ghwdd=>规划外到店 zxjg==>智能助手-执行结果预约界面
 */
@property (nonatomic, copy)NSString * type;
/** 单号 */
@property (nonatomic, copy)NSString * orderNum;
/** 用户id */
@property (nonatomic, copy)NSString * userID;
/** 详情标题 */
@property (nonatomic, copy)NSString * vcTitle;

+ (instancetype)createBookParamModelVCTitle:(NSString *)title type:(NSString *)type orderNum:(NSString *)orderNum userID:(NSString *)userID;
@end
