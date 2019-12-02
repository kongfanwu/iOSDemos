//
//  MzzBillDetailCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/11.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MzzBillDetailCell.h"
#import "MzzBillInfoListModel.h"
@interface MzzBillDetailCell()
@property (weak, nonatomic) IBOutlet UILabel *jiaozhengjieguo;
@property (weak, nonatomic) IBOutlet UILabel *yuanshishengyu;
@property (weak, nonatomic) IBOutlet UILabel *jiaozhengcishu;
@property (weak, nonatomic) IBOutlet UILabel *shengyucishu;

@property (weak, nonatomic) IBOutlet UILabel *mingcheng;
@property (weak, nonatomic) IBOutlet UILabel *leixing;
@property (weak, nonatomic) IBOutlet UILabel *shijian;
@property (weak, nonatomic) IBOutlet UILabel *jiaoyidanhao;


@end

@implementation MzzBillDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setupModel:(MzzBillInfoModel *)model andType:(NSString *)type andCardName:(NSString *)cardName{
    [_jiaozhengjieguo setText:[NSString stringWithFormat:@"%@元",model.current]];
     [_jiaozhengcishu setText:[NSString stringWithFormat:@"%ld次",model.alter_num]];
    
   
        [_yuanshishengyu setText:[NSString stringWithFormat:@"%ld元",model.count.integerValue]];
        [_shengyucishu setText:[NSString stringWithFormat:@"%ld次",model.num]];
    
    
    
   
   
    
    [_mingcheng setText:cardName];
    [_leixing setText:model.ly_name];
    [_shijian setText:model.insert_time];
    [_jiaoyidanhao setText:model.ordernum];
//    [_shengyujine setText:[NSString stringWithFormat:@"%@元/%ld次",model.current,model.alter_num]];
}
@end
