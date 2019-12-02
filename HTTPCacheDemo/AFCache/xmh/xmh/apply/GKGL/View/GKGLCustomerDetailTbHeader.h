//
//  GKGLCustomerDetailTbHeader.h
//  xmh
//
//  Created by ald_ios on 2019/1/9.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GKGLHomeCustomerModel;
NS_ASSUME_NONNULL_BEGIN

@interface GKGLCustomerDetailTbHeader : UIView
/** 顾客账单回调 */
@property (nonatomic, copy)void (^GKGLCustomerDetailTbHeaderZDBlock)();
/** 顾客画像回调 */
@property (nonatomic, copy)void (^GKGLCustomerDetailTbHeaderHXBlock)();
/** 顾客处方回调 */
@property (nonatomic, copy)void (^GKGLCustomerDetailTbHeaderCFBlock)();
/** 卡项普及回调 */
@property (nonatomic, copy)void (^GKGLCustomerDetailTbHeaderPJBlock)();
/** 顾客头像点击回调 */
@property (nonatomic, copy)void (^GKGLCustomerDetailTbHeaderIconBlock)();

- (void)updateGKGLCustomerDetailTbHeaderModel:(GKGLHomeCustomerModel *)model;
- (void)updateGKGLCustomerDetailTbHeaderParamDic:(NSDictionary *)param;
@end

NS_ASSUME_NONNULL_END
