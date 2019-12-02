//
//  UITableViewCell+ZHCreate.m
//
//  Created by 孔凡伍 on 2018/5/15.
//  Copyright © 2018年 潇潇. All rights reserved.
//

#import "UITableViewCell+ZHCreate.h"
#import <objc/runtime.h>

@implementation UITableViewCell (ZHCreate)

NSString const *ZHCreateModelKey = @"model";
- (void)setModel:(id)model {
    [self willChangeValueForKey:@"model"]; // KVO
    objc_setAssociatedObject(self, &ZHCreateModelKey, model, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"model"]; // KVO
}

- (id)model {
    return objc_getAssociatedObject(self, &ZHCreateModelKey);
}

NSString const *ZHCreateIndexPathKey = @"indexPath";
- (void)setIndexPath:(NSIndexPath *)indexPath {
    [self willChangeValueForKey:@"indexPath"]; // KVO
    objc_setAssociatedObject(self, &ZHCreateIndexPathKey, indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"indexPath"]; // KVO
}

- (NSIndexPath *)indexPath {
    return objc_getAssociatedObject(self, &ZHCreateIndexPathKey);
}

+ (__kindof instancetype)createCellWithTable:(UITableView *)tableView {
    return [self createCellWithTable:tableView identifier:NSStringFromClass(self.class)];
}

+ (__kindof instancetype)createCellWithTable:(UITableView *)tableView identifier:(NSString *)identifier {
    return [self createCellWithTable:tableView identifier:identifier complete:nil];
}

+ (__kindof instancetype)createCellWithTable:(UITableView *)tableView complete:(void(^)(__kindof id cell))complete {
    return [self createCellWithTable:tableView identifier:NSStringFromClass(self.class) complete:complete];
}

+ (__kindof instancetype)createCellWithTable:(UITableView *)tableView identifier:(NSString *)identifier complete:(void(^)(__kindof id cell))complete {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        if (complete) complete(cell);
    }
    return cell;
}

- (void)configureWithModel:(id)model {
    [self configureWithModel:model width:[UIScreen mainScreen].bounds.size.width];
}

/**
 *  配置数据
 *  Category 会覆盖 UITableViewCell 相同方法。一般使用的都是 UITableViewCell 子类，子类重写此方法，会优先调用子类的方法。
 */
- (void)configureWithModel:(id)model width:(CGFloat)width {
    self.model = model;
}

+ (CGFloat)heightForModel:(id)model {
    return [self heightForModel:model width:[UIScreen mainScreen].bounds.size.width];
}

/**
 *  返回cell行高
 */
+ (CGFloat)heightForModel:(id)model width:(CGFloat)width
{
    return 44.f;
}

@end
