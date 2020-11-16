//
//  UITableView+XMHConvenient.m
//  XMHUIKit
//
//  Created by kfw on 2019/12/16.
//  Copyright © 2019 神灯智能. All rights reserved.
//

#import "UITableView+XMHConvenient.h"

@implementation UITableView (XMHConvenient)

+ (UITableView *(^)(UIView *, CGRect, UITableViewStyle, id <UITableViewDelegate, UITableViewDataSource>))xmhNewAndSuperViewAndFrameAndStyleAndDelegate {
    return ^UITableView *(UIView *superView, CGRect frame, UITableViewStyle style, id <UITableViewDelegate, UITableViewDataSource> delegate) {
        UITableView *tableView = [[self alloc] initWithFrame:frame style:style];
        tableView.dataSource = delegate;
        tableView.delegate = delegate;
        [superView addSubview:tableView];
        return tableView;
    };
}

@end
