//
//  XMHACSendAddCustomer.h
//  xmh
//
//  Created by shendengmeiye on 2019/5/14.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMHACSendAddCustomer : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIButton *addCustomerBtn;
/** 添加顾客按钮点击回调 */
@property (nonatomic, copy) void (^sendAddCustomerViewBlock)();
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabLeftlayout;


@end

NS_ASSUME_NONNULL_END
