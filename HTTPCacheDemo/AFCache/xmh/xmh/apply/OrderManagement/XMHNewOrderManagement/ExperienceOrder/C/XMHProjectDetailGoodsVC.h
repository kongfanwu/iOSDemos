//
//  XMHProjectDetailGoodsVC.h
//  xmh
//
//  Created by KFW on 2019/3/18.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
// 体验制单 项目，产品详情

#import <UIKit/UIKit.h>
#import "CustomerListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMHProjectDetailGoodsVC : UIViewController
/**
 // model 类型是以下其中一个 项目 SLS_Pro 产品 SLGoodModel 体验服务-项目 SLPro_ListM 体验服务-产品 SLGoods_ListM
*/
@property (nonatomic, strong) id model;
/** 选择用户model */
@property (nonatomic, strong) CustomerModel *selectUserModel;
@end

NS_ASSUME_NONNULL_END
