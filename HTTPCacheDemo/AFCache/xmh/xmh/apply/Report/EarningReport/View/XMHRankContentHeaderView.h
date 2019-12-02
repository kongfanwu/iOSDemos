//
//  XMHRankContentHeaderView.h
//  xmh
//
//  Created by shendengmeiye on 2019/7/6.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMHRankContentHeaderView : UIView

/**
 赋值

 @param type 销售/消耗
 @param model model
 */
- (void)updateHeaderViewhWithType:(XMHRankContentType)type model:(nullable id)model;
@end

NS_ASSUME_NONNULL_END
