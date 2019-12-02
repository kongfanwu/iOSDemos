//
//  BookChartSelectStoreView.h
//  xmh
//
//  Created by ald_ios on 2019/3/18.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BookChartSelectStoreView : UIView
@property (nonatomic, copy) void (^BookChartSelectStoreViewBlock)();
- (void)updateViewParam:(NSMutableDictionary *)param;
@end

NS_ASSUME_NONNULL_END
