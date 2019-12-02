//
//  BookTbSectionHeader.m
//  xmh
//
//  Created by ald_ios on 2018/10/19.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BookTbSectionHeader.h"
#import "LolHomeModel.h"
#import "LolGuKeStateModelList.h"
@interface BookTbSectionHeader ()
/** 名字 */
@property (weak, nonatomic) IBOutlet UILabel *lbName;
/** 状态 */
@property (weak, nonatomic) IBOutlet UILabel *lbState;
@property (weak, nonatomic) IBOutlet UILabel *lb;
@end
@implementation BookTbSectionHeader
{
    NSDictionary * _stateName;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    _stateName = @{@"1":@"休息",@"2":@"达标",@"3":@"不达标"};
}
- (void)updateBookTbSectionHeaderModel:(LolHomeModel *)model
{
    _lbName.text = model.name;
    _lbState.text = _stateName[[NSString stringWithFormat:@"%ld",model.state]];
    _lbState.textColor = [ColorTools colorCauseByText:_lbState.text];
}
- (void)updateBookTbSectionHeaderOneCustomerModel:(LolGuKeStateModelList *)model
{
    _lbName.text = [NSString stringWithFormat:@"顾客姓名：%@",model.user_name];
    _lb.hidden = NO;
    _lbState.text = _stateName[model.icon];
    _lbState.textColor = [ColorTools colorCauseByText:_lbState.text];
}
@end
