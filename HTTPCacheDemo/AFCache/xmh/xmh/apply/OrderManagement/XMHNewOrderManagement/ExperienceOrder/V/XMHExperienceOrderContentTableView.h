//
//  XMHExperienceOrderContentTableView.h
//  xmh
//
//  Created by KFW on 2019/3/15.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMHBaseTableView.h"
#import "XMHExperienceOrderContentVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMHExperienceOrderContentTableView : XMHBaseTableView

/** 数据源 */
@property (nonatomic, strong) NSArray *dataArray;
/** 标题 */
@property (nonatomic, copy) NSString *titleText;
/** 类型 */
@property (nonatomic) XMHExperienceOrderType type;

/** <#type#> */
@property (nonatomic, copy) void (^didSelectRowAtIndexPathBlock)(XMHExperienceOrderContentTableView *tableView, NSIndexPath *indexPath);

@end

NS_ASSUME_NONNULL_END
