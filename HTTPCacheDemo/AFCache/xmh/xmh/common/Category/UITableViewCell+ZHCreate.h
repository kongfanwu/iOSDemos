//
//  UITableViewCell+ZHCreate.h
//
//  Created by 孔凡伍 on 2018/5/15.
//  Copyright © 2018年 潇潇. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZHTableViewCellProtocol <NSObject>

@optional
/**
 创建cell
 
 @param tableView tableView
 @return cell
 */
+ (__kindof instancetype)createCellWithTable:(UITableView *)tableView;

/**
 创建cell
 
 @param tableView tableView
 @param identifier 标识符
 @return cell
 */
+ (__kindof instancetype)createCellWithTable:(UITableView *)tableView identifier:(NSString *)identifier;

/**
 创建cell
 
 @param tableView tableView
 @param complete 第一次创建完回调。复用不回调
 @return cell
 */
+ (__kindof instancetype)createCellWithTable:(UITableView *)tableView complete:(void(^)(__kindof id cell))complete;

/**
 创建cell
 
 @param tableView tableView
 @param identifier 标识符
 @param complete 第一次创建完回调。复用不回调
 @return cell
 */
+ (__kindof instancetype)createCellWithTable:(UITableView *)tableView identifier:(NSString *)identifier complete:(void(^)(__kindof id cell))complete;

@end

@interface UITableViewCell (ZHCreate) <ZHTableViewCellProtocol>

/** cell model */
@property (nonatomic, strong) id model;

/** indexPath */
@property (nonatomic, strong) NSIndexPath *indexPath;

/**
 *  配置数据
 */
- (void)configureWithModel:(id)model NS_REQUIRES_SUPER;

- (void)configureWithModel:(id)model width:(CGFloat)width NS_REQUIRES_SUPER;

+ (CGFloat)heightForModel:(id)model;

/**
 *  获取行高
 */
+ (CGFloat)heightForModel:(id)model width:(CGFloat)width;

@end
