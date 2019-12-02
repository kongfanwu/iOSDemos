//
//  LanternMYuanGongTbSectionHeader.h
//  xmh
//
//  Created by ald_ios on 2019/2/20.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LanternMYuanGongTbSectionHeader : UIView
@property (nonatomic, copy)void (^LanternMYuanGongTbSectionHeaderBlock)(NSInteger section);
@property (nonatomic, copy)void (^LanternMYuanGongTbSectionHeaderTapBlock)(NSMutableDictionary * param);
- (void)updateViewTitle:(NSString *)title;
- (void)updateViewTitle:(NSString *)title section:(NSInteger)section;
- (void)updateViewParam:(NSMutableDictionary *)param;
@end

NS_ASSUME_NONNULL_END
