//
//  XMHMarketShareView.h
//  xmh
//
//  Created by ald_ios on 2019/5/20.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMHMarketEnum.h"
#import "XMHMarketModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface XMHMarketShareView : UIView
@property (nonatomic, copy)void (^XMHMarketShareViewBlock)(NSInteger index);
- (void)updateViewModel:(XMHMarketModel *)model type:(XMHMarketVCType)type;
@end

NS_ASSUME_NONNULL_END
