//
//  BookDetailTableViewCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/6.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomerBookProjectModel,CustomerMessageModel,DaiYuYueModel,LolJiShiTimeModel,LolDetailModel;
@interface BookDetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIImageView *imgvMore;
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (strong, nonatomic)LolJiShiTimeModel * jiShiTimeModel;
@property (strong, nonatomic)LolDetailModel * detailModel;
@property (strong, nonatomic) NSMutableArray<DaiYuYueModel *> * modelArr;
- (void)updateBookDetailTableViewCellProjectModel:(CustomerBookProjectModel *)projectModel customerModel:(CustomerMessageModel *)customerMessageModel indexPath:(NSIndexPath *)indexPath;
- (void)updateBookDetailTableViewCellDaiYuYueModel:(DaiYuYueModel *)daiYuYueModel;
@end
