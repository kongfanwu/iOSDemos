//
//  XMHSegmentVCModel.h
//  xmh
//
//  Created by KFW on 2019/3/14.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMHSegmentVCModel : NSObject
/** 是否可编辑  NO 不可编辑 默认YES */
@property (nonatomic) BOOL edit;
/** 子集合 */
@property (nonatomic, strong) NSArray <XMHSegmentVCModel *> *childList;
/** 是否选中状态 YES:选中状态*/
@property (nonatomic) BOOL select;
/** 选项内容 */
@property (nonatomic, copy) NSString *text;
/** 通知数 */
@property (nonatomic, assign) NSUInteger badge;
/** 内容VC */
@property (nonatomic, strong) UIViewController *contentVC;

@end

NS_ASSUME_NONNULL_END
