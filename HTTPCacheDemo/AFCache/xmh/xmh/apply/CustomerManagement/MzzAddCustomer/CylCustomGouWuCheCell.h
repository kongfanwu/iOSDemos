//
//  CylCustomGouWuCheCell.h
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/5/21.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CylCustomGouWuCheCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UIButton *btnDel;

- (void)freshCylCustomGouWuCheCell:(NSDictionary *)dic;

- (void)freshCylCustomTimeGouWuCheCell:(NSDictionary *)dic;

- (void)freshCylCustomNumGouWuCheCell:(NSDictionary *)dic;

- (void)freshCylCustomGoodsGouWuCheCell:(NSDictionary *)dic;

- (void)freshCylCustomTicketGouWuCheCell:(NSDictionary *)dic;

@property (nonatomic ,copy)void(^btnCylCustomGouWuCheCellDelBlock)(NSDictionary *dic);
@end
