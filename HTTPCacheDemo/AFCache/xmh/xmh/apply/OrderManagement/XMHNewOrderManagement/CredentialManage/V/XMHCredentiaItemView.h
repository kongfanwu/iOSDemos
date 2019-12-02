//
//  XMHCredentiaItemView.h
//  xmh
//
//  Created by KFW on 2019/4/2.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
// 凭证选项view

#import <UIKit/UIKit.h>
#import "XMHCredentiaItemModel.h"

UIKIT_EXTERN CGFloat const XMHCredentiaItemView_MaxHeight;
UIKIT_EXTERN CGFloat const XMHCredentiaItemView_MinHeight;

NS_ASSUME_NONNULL_BEGIN

@interface XMHCredentiaItemView : UIView
/** 销售状态 服务状态 */
@property (nonatomic) XMHCredentiaItemViewType type;
/** did */
@property (nonatomic, copy) void (^didChangeHeightBlock)();
/** 销售数据源 */
@property (nonatomic, strong) NSArray *venditionDataArray;
/** 服务数据源 */
@property (nonatomic, strong) NSArray *serviceDataArray;
/** didSelectItemAtIndexPath */
@property (nonatomic, copy) void (^didSelectItemAtIndexPathBlock)(XMHCredentiaItemView *searchView, NSIndexPath *indexPath, XMHCredentiaItemModel *model);
/** 销售 服务 切换回调*/
@property (nonatomic, copy) void (^didChangeCredentiaTypeBlock)(XMHCredentiaItemView *searchView);
@end

NS_ASSUME_NONNULL_END
