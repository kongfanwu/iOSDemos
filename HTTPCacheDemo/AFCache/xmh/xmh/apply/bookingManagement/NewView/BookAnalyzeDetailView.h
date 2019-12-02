//
//  BookAnalyzeDetailView.h
//  xmh
//
//  Created by ald_ios on 2019/3/8.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LolCalendarModelList;
NS_ASSUME_NONNULL_BEGIN

@interface BookAnalyzeDetailView : UIView

/**
 更新View

 @param model 模型
 @param isMonth 是否是整月
 @param isFront 是否是当前日期之前
 */
- (void)updateBookAnalyzeDetailViewModel:(LolCalendarModelList *)model isMonth:(BOOL)isMonth isFront:(BOOL)isFront;
@end

NS_ASSUME_NONNULL_END
