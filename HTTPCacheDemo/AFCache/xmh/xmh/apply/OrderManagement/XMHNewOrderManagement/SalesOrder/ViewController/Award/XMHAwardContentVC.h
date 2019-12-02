//
//  XMHAwardContentVC.h
//  xmh
//
//  Created by 杜彩艳 on 2019/3/31.
//  Copyright © 2019年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SaleModel;
NS_ASSUME_NONNULL_BEGIN

@interface XMHAwardContentVC : UIViewController
@property (nonatomic,copy)NSString *store_code;
@property (nonatomic,assign)NSInteger user_id;
@property (nonatomic, copy)void(^selectedAward)(SaleModel *model);
@end

NS_ASSUME_NONNULL_END
