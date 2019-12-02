//
//  RefundSearchView.h
//  xmh
//
//  Created by ald_ios on 2018/11/12.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RefundSearchView : UIView
@property (nonatomic, copy) void (^RefundSearchViewBlock)(NSString * keyword);
@end
