//
//  LanternMSearchHistoryToastView.h
//  xmh
//
//  Created by ald_ios on 2019/2/13.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LanternMSearchHistoryToastView : UIView
@property (nonatomic ,copy)void (^LanternMSearchHistoryToastViewBlock)();
- (void)updateViewParam:(NSDictionary *)param;
@property (nonatomic ,copy)NSString * itemID;
@end

NS_ASSUME_NONNULL_END
