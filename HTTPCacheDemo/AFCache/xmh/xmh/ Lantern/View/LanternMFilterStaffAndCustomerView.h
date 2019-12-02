//
//  LanternMFilterStaffAndCustomerView.h
//  xmh
//
//  Created by ald_ios on 2019/2/27.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LanternMFilterStaffAndCustomerView : UIView
@property (nonatomic, strong)NSMutableDictionary * resultDic;
@property (nonatomic, strong)NSMutableArray * storeArr;
@property (nonatomic, copy)void (^LanternMFilterStaffAndCustomerViewBlock)(NSString * text);
@end

NS_ASSUME_NONNULL_END
