//
//  XMHServiceProjectModel.h
//  xmh
//
//  Created by KFW on 2019/3/26.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
// 项目

#import "XMHServiceBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMHServiceProjectModel : XMHServiceBaseModel
/** 项目code */
@property (nonatomic, copy) NSString *pro_code;
/** 项目剩余次数 处方项目可用次数 */
//@property (nonatomic, copy) NSString *num;
/** 处方项目已用次数 */
@property (nonatomic, copy) NSString *num1;
/** 项目时长 */
@property (nonatomic) NSInteger shichang;
/** 项目名称 */
@property (nonatomic, copy) NSString *name;
/** 项目价格 */
@property (nonatomic, copy) NSString *price;


@end

NS_ASSUME_NONNULL_END
