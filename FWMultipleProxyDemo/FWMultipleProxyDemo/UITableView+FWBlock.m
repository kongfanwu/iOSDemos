//
//  UITableView+FWBlock.m
//  FWMultipleProxyDemo
//
//  Created by kfw on 2019/6/24.
//  Copyright © 2019 kfw. All rights reserved.
//

#import "UITableView+FWBlock.h"
#import <objc/runtime.h>

@implementation UITableView (FWBlock)

#pragma mark - UITableView Delegate methods

NSString const *XMHXLFormActionNextParamsKey = @"didSelectRowAtIndexPathBlock";
- (void)setDidSelectRowAtIndexPathBlock:(void (^)(UITableView * _Nonnull tab, NSIndexPath * _Nonnull inde))didSelectRowAtIndexPathBlock {
    [self willChangeValueForKey:@"didSelectRowAtIndexPathBlock"]; // KVO
    objc_setAssociatedObject(self, &XMHXLFormActionNextParamsKey, didSelectRowAtIndexPathBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"didSelectRowAtIndexPathBlock"]; // KVO
}

- (void (^)(UITableView * _Nonnull, NSIndexPath * _Nonnull))didSelectRowAtIndexPathBlock {
    return objc_getAssociatedObject(self, &XMHXLFormActionNextParamsKey);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"---%s", __FUNCTION__);
    if (self.didSelectRowAtIndexPathBlock) self.didSelectRowAtIndexPathBlock(tableView, indexPath);
}

@end
