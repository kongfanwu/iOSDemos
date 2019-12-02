//
//  XMHSeverOrderViewController.h
//  xmh
//
//  Created by shendengmeiye on 2019/4/17.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XMHCredentiaServiceOrderMdoel;
@class ABSegmentTitleView;
@class XMHBaseTableView;
NS_ASSUME_NONNULL_BEGIN

@interface XMHSeverOrderViewController : UIViewController
@property(nonatomic, strong) XMHBaseTableView *tableView;
@property(nonatomic, strong) ABSegmentTitleView *titleView;
@property (nonatomic, copy)void (^didSelectSeverModel)(XMHCredentiaServiceOrderMdoel *severModel);
@property (nonatomic, strong) UINavigationController *severOrderNavigationController;
- (instancetype)initWithFrame:(CGRect)frame;
@end

NS_ASSUME_NONNULL_END
