//
//  XMHServiceOrderProjectGoodsContentVC.h
//  xmh
//
//  Created by KFW on 2019/3/26.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
// 项目 产品内容vc

#import "XMHServiceOrderBaseContentVC.h"
#import "XMHServiceProjectModel.h"
#import "XMHServiceGoodsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMHServiceOrderProjectGoodsContentVC : XMHServiceOrderBaseContentVC
/**  */
@property (nonatomic, strong) NSArray <XMHServiceProjectModel *> *projectList;
/** <##> */
@property (nonatomic, strong) NSArray <XMHServiceGoodsModel *> *goodsList;
@end

NS_ASSUME_NONNULL_END
