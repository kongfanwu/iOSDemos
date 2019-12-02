//
//  TJStaffInfoView.h
//  xmh
//
//  Created by ald_ios on 2018/12/6.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TJStaffDetailModel,TJCustomerActiveDetailModel;
@interface TJStaffInfoView : UIView
- (void)updateTJStaffInfoViewModel:(TJStaffDetailModel *)model;
- (void)updateTJStaffInfoViewCustomerActiveDetailModel:(TJCustomerActiveDetailModel *)model;
@end
