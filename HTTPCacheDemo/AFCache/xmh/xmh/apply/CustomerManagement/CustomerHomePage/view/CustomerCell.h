//
//  CustomerCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/4.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^BtnOnclick)(UIButton *btn);
@class CustomerFrameModel;
@interface CustomerCell : UITableViewCell
@property(nonatomic ,strong)CustomerFrameModel *customerFrame;
@property(nonatomic, copy)BtnOnclick btnclick;
//cell创建方法
+(instancetype)tableView:(UITableView *)tableView CellWithCustomerFrame:(CustomerFrameModel *)CustomerFrame;

@end
