//
//  BillTiYanFuwuCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/23.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLSCourseExper.h"

@interface BillTiYanFuwuCell : UITableViewCell<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *lb;
@property (weak, nonatomic) IBOutlet UIImageView *imGegnduo;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UITableView *tbView;
- (void)freshBillTiYanFuwuCell:(SLSCourseExper *)model;
@property (nonatomic, copy) void (^btnBillTiYanFuwuCellBlock)(NSInteger index, NSInteger whice,NSInteger modelID);

@end
