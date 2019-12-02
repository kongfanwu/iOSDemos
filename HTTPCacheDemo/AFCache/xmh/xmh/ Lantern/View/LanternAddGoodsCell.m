//
//  LanternAddGoodsCell.m
//  xmh
//
//  Created by ald_ios on 2018/12/29.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LanternAddGoodsCell.h"
#import "LanternPlanInfoListModel.h"
@interface LanternAddGoodsCell ()
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbPrice;
@property (weak, nonatomic) IBOutlet UIButton *btnReduce;
@property (weak, nonatomic) IBOutlet UIButton *btnAdd;
@property (weak, nonatomic) IBOutlet UILabel *lbNum;

@end

@implementation LanternAddGoodsCell
{
    /** 商品选择的数量 */
    NSInteger _goodNum;
    LanternPlanProModel * _lanternPlanProModel;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    /** 初始化参数 */
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _btnReduce.hidden = YES;
    _lbNum.hidden = YES;
    _goodNum = 0;
}
- (void)updateLanternAddGoodsCellModel:(LanternPlanProModel *)model
{
    _lanternPlanProModel = model;
    _lbName.text = model.name;
    _lbPrice.text = [NSString stringWithFormat:@"零售价：￥%@",model.price];
}
/** 减 */
- (IBAction)reduce:(UIButton *)sender
{
    _goodNum --;
    
    if (_goodNum == 0) {
        _btnReduce.hidden = YES;
        _lbNum.hidden = YES;
    }
    _lbNum.text = [NSString stringWithFormat:@"%ld",(long)_goodNum];
    _lanternPlanProModel.selectNum = _lbNum.text;
    if (_LanternAddGoodsCellReduceBlock) {
        _LanternAddGoodsCellReduceBlock(_lanternPlanProModel);
    }
    
}
/** 加 */
- (IBAction)add:(id)sender
{
    _btnReduce.hidden = NO;
    _lbNum.hidden = NO;
    _goodNum ++;
//    if (_goodNum > _lanternPlanProModel.num.integerValue) {
//        [SVProgressHUD showErrorWithStatus:@"数量已超"];
//        _goodNum = _lanternPlanProModel.num.integerValue;
//    }
    _lbNum.text = [NSString stringWithFormat:@"%ld",(long)_goodNum];
    _lanternPlanProModel.selectNum = _lbNum.text;
    if (_LanternAddGoodsCellAddBlock) {
        _LanternAddGoodsCellAddBlock(_lanternPlanProModel);
    }
}

@end
