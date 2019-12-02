//
//  TJCommonCell1.h
//  xmh
//
//  Created by ald_ios on 2018/12/3.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TJBBModel;
@interface TJCommonCell1 : UITableViewCell
/** 业绩报表更新方法 */
- (void)updateTJCommonCell1BBModel:(TJBBModel *)model;
- (void)updateTJCommonCell1ProductionReportParam:(NSDictionary *)param;
@end
