//
//  LanternMTopView.h
//  xmh
//
//  Created by ald_ios on 2019/1/30.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LanternMTopView : UIView
- (void)updateLanternMTopViewIndex:(NSInteger)index;
@property (nonatomic, copy)void (^LanternMTopViewBlock)(NSInteger index);
@end

NS_ASSUME_NONNULL_END
