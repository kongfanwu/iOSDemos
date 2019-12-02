//
//  BookCommonCell2.h
//  xmh
//
//  Created by ald_ios on 2018/10/19.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LolGuKeStateModel;
@interface BookCommonCell2 : UITableViewCell

/**
 *更新数据

 @param model 模型
 */
- (void)updateBookCommonCellModel:(LolGuKeStateModel *)model;
@end
