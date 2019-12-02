//
//  BookTbSectionHeader.h
//  xmh
//
//  Created by ald_ios on 2018/10/19.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LolHomeModel,LolGuKeStateModelList;
@interface BookTbSectionHeader : UIView

/**
 *更新数据

 @param model 模型
 */
- (void)updateBookTbSectionHeaderModel:(LolHomeModel *)model;

/**
 *更新数据

 @param model 单个顾客Model
 */
- (void)updateBookTbSectionHeaderOneCustomerModel:(LolGuKeStateModelList *)model;
@end
