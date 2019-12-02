//
//  TJSelectView.h
//  xmh
//
//  Created by ald_ios on 2018/12/5.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TJParamModel;
typedef void (^TJSelectViewDateBlock)(NSString *startTime,NSString *endTime,NSString *title);
@interface TJSelectView : UIView
/** 日期选择 */
@property (nonatomic, copy)void (^TJSelectViewDateBlock)(NSString *startTime,NSString *endTime,NSString *title);
/** 顾客活跃专属 */
@property (nonatomic, copy)void (^TJSelectViewDateCustomerActiveBlock)(NSString *startTime,NSString *endTime,NSString *title,NSString *time_type);
@property (nonatomic, copy)void (^TJSelectViewDataBlock)(TJParamModel *model);
@property (nonatomic, copy)void (^TJSelectViewStoreBlock)(TJParamModel *model);
@property (nonatomic, copy)void (^TJSelectViewCustomerBlock)(TJParamModel *model);

- (instancetype)initWithFrame:(CGRect)frame timeBlock:(TJSelectViewDateBlock)block;
- (void)updateTJSelectViewModelArr:(NSArray *)modelArr type:(NSString *)type;
- (void)updateTJSelectViewSectionTitle:(NSString *)title;
@end
