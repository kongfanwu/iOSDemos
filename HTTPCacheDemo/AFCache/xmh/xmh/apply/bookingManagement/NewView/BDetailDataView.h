//
//  BDetailDataView.h
//  xmh
//
//  Created by ald_ios on 2018/10/18.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LolCalendarModelList;
@interface BDetailDataView : UIView

/**
 *更新数据

 @param model 模型
 @param isMonth 是否为整月
 */
- (void)updateBDetailDataViewModel:(LolCalendarModelList *)model isMonth:(BOOL)isMonth;
@end
