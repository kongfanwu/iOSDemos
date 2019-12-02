//
//  CustomerReportCell.h
//  xmh
//
//  Created by ald_ios on 2018/12/5.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TJCustomerModel,TJCustomerActiveModel,TJCustomerActiveDetailModel,TJExpendModel,TJCashModel;
@interface CustomerReportCell : UITableViewCell
- (void)updateCustomerReportCellModel:(TJCustomerModel *)model;
//- (void)updateCustomerReportCellTopModel:(TJCustomerTopModel *)model;
- (void)updateCustomerReportCellCustomerActiveModel:(TJCustomerActiveModel *)model;
- (void)updateCustomerReportCellCustomerActiveDetailModel:(TJCustomerActiveDetailModel *)model row:(NSInteger)row;

- (void)updateCustomerReportCellExpendModel:(TJExpendModel *)model;

- (void)updateCustomerReportCellCashModel:(TJCashModel *)model;

- (void)updateCustomerReportCellProParam:(NSDictionary *)param;

@end
