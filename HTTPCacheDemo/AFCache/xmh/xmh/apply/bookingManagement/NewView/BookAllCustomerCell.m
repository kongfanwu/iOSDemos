//
//  BookAllCustomerCell.m
//  xmh
//
//  Created by ald_ios on 2018/10/19.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BookAllCustomerCell.h"
#import "LolHomeGuKeModel.h"
@interface BookAllCustomerCell ()
/** 用户名 */
@property (weak, nonatomic) IBOutlet UILabel *lbName;
/** 状态 */
@property (weak, nonatomic) IBOutlet UIImageView *imvState;
/** 预约总项目/服务项目数 */
@property (weak, nonatomic) IBOutlet UILabel *lbValue;
@end
@implementation BookAllCustomerCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}
- (void)updateBookAllCustomerCellModel:(LolHomeGuKeModel *)model
{
    _lbName.text = model.name;
    if ([model.state isEqualToString:@"2"]) {
        _imvState.image = UIImageName(@"styygl_dabiao");
    }else if ([model.state isEqualToString:@"3"]){
        _imvState.image = UIImageName(@"styygl_budabiao");
    }else{}
    _lbValue.text = [NSString stringWithFormat:@"%@/%@",@(model.num),@(model.pro_num)];
}
@end
