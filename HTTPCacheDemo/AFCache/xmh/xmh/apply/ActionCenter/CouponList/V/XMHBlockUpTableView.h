//
//  XMHBlockUpTableView.h
//  xmh
//
//  Created by shendengmeiye on 2019/7/4.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMHBlockUpTableView : UIView<UITableViewDelegate, UITableViewDataSource>
/** 数据源 */
@property (nonatomic, strong) NSArray *dataArr;
@end

NS_ASSUME_NONNULL_END
