//
//  UITableView+FWBlock.h
//  FWMultipleProxyDemo
//
//  Created by kfw on 2019/6/24.
//  Copyright © 2019 kfw. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface UITableView (FWBlock)
/** <#type#> */
@property (nonatomic, copy) void (^didSelectRowAtIndexPathBlock)(UITableView *tableView, NSIndexPath *indexPath);
@end

NS_ASSUME_NONNULL_END
