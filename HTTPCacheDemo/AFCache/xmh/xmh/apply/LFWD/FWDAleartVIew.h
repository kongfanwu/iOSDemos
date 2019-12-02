//
//  FWDAleartVIew.h
//  xmh
//
//  Created by ald_ios on 2019/2/22.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FWDAleartVIew : UIView
@property (nonatomic, copy)void(^FWDAleartVIewDetailBlock)();
@property (nonatomic, copy)void(^FWDAleartVIewRecordBlock)();
@property (nonatomic, copy)void(^FWDAleartVIewDelBlock)();
@end

NS_ASSUME_NONNULL_END
