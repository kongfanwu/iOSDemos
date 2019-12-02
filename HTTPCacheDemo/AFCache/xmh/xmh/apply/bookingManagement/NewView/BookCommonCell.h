//
//  BookCommonCell.h
//  xmh
//
//  Created by ald_ios on 2018/10/18.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LolHomeModel;
@interface BookCommonCell : UITableViewCell

/**
 *更新cell数据

 @param model 模型
 @param pageType 页面类型
 */
- (void)updateBookCommonCellModel:(LolHomeModel *)model pageType:(NSString *)pageType;
- (void)updateBookCommonCellModel:(LolHomeModel *)model pageType:(NSString *)pageType isCengJj:(BOOL)isCJ;
@end
