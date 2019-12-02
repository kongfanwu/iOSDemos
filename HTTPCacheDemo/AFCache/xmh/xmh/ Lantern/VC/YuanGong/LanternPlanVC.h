//
//  LanternPlanVC.h
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/12/25.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "BaseCommonViewController.h"

typedef NS_ENUM(NSUInteger, ComeFrome) {
    ComeFromeHome,
    ComeFromeDetail
};
@interface LanternPlanVC : BaseCommonViewController
/** 1、销售 2、消耗 */
@property (nonatomic, copy)NSString * type;
/** 日期：2018-09 */
@property (nonatomic, copy)NSString * date;
/** 是否是修改 */
@property (nonatomic, copy)NSString * isSave;
/** 修改 id */
@property (nonatomic, copy)NSString * editID;







@property (nonatomic, assign)ComeFrome comeFrom;
@end
