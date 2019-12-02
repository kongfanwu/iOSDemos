//
//  XMHACShareView.h
//  xmh
//
//  Created by shendengmeiye on 2019/5/20.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMHACShareView : UIView

/** 点击事件 */
@property (nonatomic, copy)void(^shareViewOnlick)(NSInteger index);

/** show出这个弹窗 */
- (void)show;

/** dismiss这个弹窗 */
- (void)dismiss;
@end

NS_ASSUME_NONNULL_END
