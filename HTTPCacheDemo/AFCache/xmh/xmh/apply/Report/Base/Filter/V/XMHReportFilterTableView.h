//
//  XMHFilterTableView.h
//  xmh
//
//  Created by ald_ios on 2019/7/3.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMHReportFilterTableView : UITableView
@property (nonatomic, strong) NSMutableArray *dataArray;
/** 全选 */
- (void)allCheck;
/** 全不选 */
- (void)allUnCheck;
/** 反选 */
- (void)allInvertiCheck;
@end

NS_ASSUME_NONNULL_END
