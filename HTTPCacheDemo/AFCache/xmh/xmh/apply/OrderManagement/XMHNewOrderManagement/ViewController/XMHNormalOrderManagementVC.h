//
//  XMHNormalOrderManagementVC.h
//  xmh
//
//  Created by shendengmeiye on 2019/3/11.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BaseViewController1.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMHNormalOrderManagementVC : BaseViewController1

/**
 切换制单
 
 @param index 0 销售制单 1 服务制单
 */
- (void)selectedSegmentIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
