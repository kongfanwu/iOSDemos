//
//  BookProjectCell.m
//  xmh
//
//  Created by ald_ios on 2018/10/22.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BookProjectCell.h"
#import "DaiYuYueModel.h"
@interface BookProjectCell ()
/** 选择按钮 */
@property (weak, nonatomic) IBOutlet UIButton *btn;
/** 名称 */
@property (weak, nonatomic) IBOutlet UILabel *lb1;
/** 服务技师 */
@property (weak, nonatomic) IBOutlet UILabel *lb2;
/** 剩余次数 */
@property (weak, nonatomic) IBOutlet UILabel *lb3;
/** 服务项目 */
@property (weak, nonatomic) IBOutlet UILabel *lb4;
/** 固话时间 */
@property (weak, nonatomic) IBOutlet UILabel *lb5;

/**
    只显示个字段时
    lb2  剩余次数
    lb3  服务时长

 */
@end
@implementation BookProjectCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)updateBookProjectCellModel:(DaiYuYueModel *)model
{
    _lb1.text = model.name;
    if ([model.type isEqualToString:@"pres"]) {
        _lb2.text = [NSString stringWithFormat:@"服务技师：%@",model.jis_name];
        _lb3.text = [NSString stringWithFormat:@"剩余次数：%@",@(model.num - model.num1)];
        _lb4.text = [NSString stringWithFormat:@"服务项目：%@",model.pres_string];
        _lb5.text = [NSString stringWithFormat:@"规划时间：%@",model.stime];
    }
    if ([model.type isEqualToString:@"pro"]) {
        _lb2.text = [NSString stringWithFormat:@"剩余次数：%@",@(model.num - model.num1)];
        _lb3.text = [NSString stringWithFormat:@"服务时长：%ld",model.shichang];
        _lb4.hidden = YES;
        _lb5.hidden = YES;
    }
    if ([model.type isEqualToString:@"goods"]) {
        _lb2.text = [NSString stringWithFormat:@"剩余次数：%@",@(model.num - model.num1)];
        _lb3.text = [NSString stringWithFormat:@"服务时长：%ld",model.shichang];
        _lb4.hidden = YES;
        _lb5.hidden = YES;
    }
    if (model.isSelected) {
        [_btn setImage:UIImageName(@"styygl_duoxuanyixuan") forState:UIControlStateNormal];
    }else{
        [_btn setImage:UIImageName(@"styygl_duoxuanweixuan") forState:UIControlStateNormal];
    }
    
}
@end
