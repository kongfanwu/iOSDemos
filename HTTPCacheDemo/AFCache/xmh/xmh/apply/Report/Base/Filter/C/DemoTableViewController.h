//
//  DemoTableViewController.h
//  TreeTableView
//
//  Created by mayan on 2018/5/11.
//  Copyright © 2018年 mayan. All rights reserved.
//

#import "MYTreeTableViewController.h"

@interface DemoTableViewController : MYTreeTableViewController

@property (nonatomic, strong)NSMutableArray * dataSource;
- (void)commitItemClick;

// 点击右上角 全选
- (void)allCheckItemClick;

- (void)allUnCheckItemClick;

// 点击右上角 全部展开
- (void)allExpandItemClick;

// 反选
- (void)allInvertiCheck;
@end
