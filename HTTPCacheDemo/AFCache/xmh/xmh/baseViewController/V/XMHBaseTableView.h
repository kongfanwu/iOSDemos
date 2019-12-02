//
//  XMHBaseTableView.h
//  xmh
//
//  Created by KFW on 2019/4/3.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+EmptyDataSet.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMHBaseTableView : UITableView <UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

/** 空的att */
//@property (nonatomic, strong) NSAttributedString *titleForEmptyAttributed;
/** 默认图功能是否可用， 默认NO：不可用 */
@property (nonatomic) BOOL emptyEnable;
/** 空图片名 */
@property (nonatomic, copy) NSString *tmptyImageName;
/** 点击回调 */
@property (nonatomic, copy) void (^emptyDataDidTapView)(XMHBaseTableView *tableView, UIView *view);


@end

NS_ASSUME_NONNULL_END
