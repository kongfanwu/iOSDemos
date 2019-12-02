//
//  RefundGWCView.h
//  xmh
//
//  Created by ald_ios on 2018/11/14.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RefundGWCView : UIView
@property (nonatomic, copy)void (^RefundGWCViewClearBlock)();
@property (nonatomic, strong)NSMutableArray * dataSource;
- (void)updateRefundGWCViewModelArr:(NSMutableArray *)modelArr;
@end
