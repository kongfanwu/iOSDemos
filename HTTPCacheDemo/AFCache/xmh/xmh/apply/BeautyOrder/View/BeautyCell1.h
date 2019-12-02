//
//  BeautyCell1.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/30.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BeautyHomeListModel.h"
#import "BeautyHomeDModel.h"
#import "BeautyHomeUModel.h"

@interface BeautyCell1 : UITableViewCell
/**
 *刷新员工cell
 */
- (void)reloadBeautyCell1YuanGong:(BeautyHomeDModel *)model;

- (void)reloadBeautyCell1_1YuanGong:(BeautyHomeUModel *)model;

@end
