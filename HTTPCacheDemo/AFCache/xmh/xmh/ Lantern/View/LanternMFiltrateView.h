//
//  LanternMFiltrateView.h
//  xmh
//
//  Created by ald_ios on 2019/2/19.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LanternMFiltrateView : UIView
@property (nonatomic, copy)void (^LanternMFiltrateViewSearchBlock)(NSString * text);
@property (nonatomic, strong)NSMutableArray * dataSource;
@end

NS_ASSUME_NONNULL_END
