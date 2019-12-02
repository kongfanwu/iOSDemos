//
//  XMHServiceChuFangModel.h
//  xmh
//
//  Created by KFW on 2019/3/26.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
// 处方model

#import "XMHServiceBaseModel.h"
#import "XMHServiceProjectModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMHServiceChuFangModel : XMHServiceBaseModel
/** <##> */
@property (nonatomic, copy) NSString *name;
/** <##> */
@property (nonatomic, strong) NSArray <XMHServiceProjectModel *>*pro_list;
@end


NS_ASSUME_NONNULL_END
