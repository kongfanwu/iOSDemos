//
//  BookCommonCell2.m
//  xmh
//
//  Created by ald_ios on 2018/10/19.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BookCommonCell2.h"
#import "LolGuKeStateModelList.h"
@interface BookCommonCell2 ()
/** 项目 */
@property (weak, nonatomic) IBOutlet UILabel *lb1;
/** 时间 */
@property (weak, nonatomic) IBOutlet UILabel *lb2;
/** 状态 */
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnWidth;

@end

@implementation BookCommonCell2
{
    NSDictionary * _stateName;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    _stateName = @{@"xgyy":@"修改预约",@"yyy":@"已预约",@"asdd":@"按时到店",@"ghwdd":@"规划外到店",@"wasdd_pres":@"未按时到店",@"wasdd_appo":@"未按时到店",@"zrdd":@"自然到店",@"wasdd":@"未按时到店"};
    _btn.layer.cornerRadius = 3;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)updateBookCommonCellModel:(LolGuKeStateModel *)model
{
    _lb1.text = model.pro;
    _lb2.text = model.date;
    _btn.backgroundColor = [ColorTools colorWithHexString:@"#FFF3F0"];
    NSString * btnTitle = _stateName[model.state];
    CGFloat btnW = [btnTitle stringWidthWithFont:FONT_SIZE(10)];
    [_btn setTitle:btnTitle forState:UIControlStateNormal];
    [_btn setTitleColor:[ColorTools colorWithHexString:@"#FF9072"] forState:UIControlStateNormal];
    _btnWidth.constant = btnW + 10;
}
@end
