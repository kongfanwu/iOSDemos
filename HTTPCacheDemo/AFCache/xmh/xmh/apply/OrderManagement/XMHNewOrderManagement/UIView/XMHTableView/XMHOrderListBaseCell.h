//
//  XMHOrderListBaseCell.h
//  xmh
//
//  Created by shendengmeiye on 2019/3/8.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMHOrderListSeverModel.h"
#import "XMHOrderListSaleModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMHOrderListBaseCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *segmentLab;
@property (weak, nonatomic) IBOutlet UILabel *orderTypeLab;

@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *orderPesonLab;
@property (weak, nonatomic) IBOutlet UILabel *moneyLab;
@property (weak, nonatomic) IBOutlet UILabel *proLab;
@property (weak, nonatomic) IBOutlet UILabel *createTimeLab;
@property (weak, nonatomic) IBOutlet UIView *btnBgView;
@property (weak, nonatomic) IBOutlet UIButton *firstBtn;
@property (weak, nonatomic) IBOutlet UIButton *seconBtn;
@property (weak, nonatomic) IBOutlet UIButton *threeBtn;
@property (weak, nonatomic) IBOutlet UIButton *fourBtn;

@property (nonatomic,copy)void (^firstBtnClickBlock)(NSString *title);
@property (nonatomic,copy)void (^seconBtnClickBlock)(NSString *title);
@property (nonatomic,copy)void (^threeBtnClickBlock)(NSString *title);
@property (nonatomic,copy)void (^fourBtnClickBlock)(NSString *title);
/**
 重置cell
 */
- (void)resetCell;

/**
 cell赋值

 @param model XMHOrderSeverModel
 @param orderType 服务凭证列表状态： 0全部，1待结算，2已结算，3已完成
 */
- (void)refreshBaseCellSeverModel:(XMHOrderSeverModel *)model orderType:(NSInteger)orderType;

/**
 cell赋值
 
 @param model XMHOrderSeverModel
 @param orderType 销售凭证列表状态：0=>'全部' 1=>'待付款',10=>'已收款',5=>'未付清','6'=>'已完成'
 */
- (void)refreshBaseCellSaleModel:(XMHOrderSaleModel *)model orderType:(NSInteger)orderType;
@end

NS_ASSUME_NONNULL_END
