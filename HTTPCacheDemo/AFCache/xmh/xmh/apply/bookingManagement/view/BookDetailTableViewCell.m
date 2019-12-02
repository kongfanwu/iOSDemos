//
//  BookDetailTableViewCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/6.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "BookDetailTableViewCell.h"
#import "CustomerBookProjectModel.h"
#import "CustomerMessageModel.h"
#import "DaiYuYueModel.h"
#import "LolJiShiTimeModel.h"
#import "LolDetailModel.h"
@implementation BookDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)updateBookDetailTableViewCellProjectModel:(CustomerBookProjectModel *)projectModel customerModel:(CustomerMessageModel *)customerMessageModel indexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        _lb1.text = [NSString stringWithFormat:@"服务项目:%@",projectModel.pro_list];
        _lb2.text = [NSString stringWithFormat:@"服务时长:%ld",(long)projectModel.max_time];
    }else if(indexPath.row == 1){
        _lb1.text = [NSString stringWithFormat:@"服务技师:%@",customerMessageModel.jis_name];
        _lb2.text = [NSString stringWithFormat:@"服务时间:%@",projectModel.appo_data];
    }
}
- (void)updateBookDetailTableViewCellDaiYuYueModel:(DaiYuYueModel *)daiYuYueModel{
    _lb1.text = [NSString stringWithFormat:@"服务项目:%@",daiYuYueModel.name];
    _lb2.text = [NSString stringWithFormat:@"服务时长:%ld",(long)daiYuYueModel.shichang];
}
- (void)setJiShiTimeModel:(LolJiShiTimeModel *)jiShiTimeModel{
    _jiShiTimeModel = jiShiTimeModel;
    _lb1.text = [NSString stringWithFormat:@"服务技师:%@",jiShiTimeModel.name?jiShiTimeModel.name:@""];
    _lb2.text = [NSString stringWithFormat:@"服务时间:%@",jiShiTimeModel.time?jiShiTimeModel.time:@""];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
- (void)setModelArr:(NSMutableArray<DaiYuYueModel *> *)modelArr{
    NSMutableString * content = [[NSMutableString alloc] init];
    NSInteger  maxTime = 0;
    for (int i = 0; i < modelArr.count; i++) {
        DaiYuYueModel * model = modelArr[i];
        //如果是项目
        if ([model.type isEqualToString:@"pro_rec"]) {
            if (modelArr.count ==1) {
                maxTime = model.shichang;
            }
            if (i-1>=0) {
                if (modelArr[i].shichang > modelArr[i-1].shichang) {
                    maxTime = modelArr[i].shichang;
                }
            }
            [content appendString:@","];
            [content appendString:model.name];
        }else{
//            [content appendString:model.pres_string];
            [content appendString:@","];
            [content appendString:model.name];
        }
        if (modelArr.count >= 1) {
            if (modelArr[i].shichang > maxTime) {
                maxTime = modelArr[i].shichang;
            }
        }
    }
    [content replaceCharactersInRange:NSMakeRange(0, 1) withString:@""];
    _lb1.text = [NSString stringWithFormat:@"服务项目:%@",content];
    _lb2.text = [NSString stringWithFormat:@"服务时长:%ld 分钟",maxTime];
}
- (void)setDetailModel:(LolDetailModel *)detailModel{
    _detailModel = detailModel;
    _lb1.text = [NSString stringWithFormat:@"服务项目:%@",detailModel.pro_list];
    _lb2.text = [NSString stringWithFormat:@"服务时长:%ld 分钟",detailModel.max_time];
}
@end
