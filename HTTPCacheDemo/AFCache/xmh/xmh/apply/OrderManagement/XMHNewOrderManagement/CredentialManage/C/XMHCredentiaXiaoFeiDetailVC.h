//
//  XMHCredentiaXiaoFeiDetailVC.h
//  xmh
//
//  Created by KFW on 2019/4/8.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
// 配合消费 配合耗卡

#import "BaseCommonViewController.h"

typedef NS_ENUM(NSInteger, XMHCredentiaXiaoFeiDetailVCType) {
    XMHCredentiaXiaoFeiDetailVCTypeXiaoFei, // 配合消费
    XMHCredentiaXiaoFeiDetailVCTypeHaoKa, // 配合耗卡
};

NS_ASSUME_NONNULL_BEGIN

@interface XMHCredentiaXiaoFeiDetailVC : BaseCommonViewController
/* 默认 XMHCredentiaXiaoFeiDetailVCTypeXiaoFei */
@property (nonatomic) XMHCredentiaXiaoFeiDetailVCType type;
/** 搜索的开始 结束时间 */
@property (nonatomic, copy) NSString *startDate, *endDate;
@end

NS_ASSUME_NONNULL_END
