//
//  LolJiShiTimeView.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/14.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LolJiShiTimeView.h"
#import "DaiYuYueModel.h"
@implementation LolJiShiTimeView
-(void)setModel:(LolJiShiTimeModel *)model{
    _lb1.text = [NSString stringWithFormat:@"服务技师:%@",model.name];
    _lb2.text = [NSString stringWithFormat:@"服务时间:%@",model.time];
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

            [content appendString:@","];
            [content appendString:model.name];
        }else{
            [content appendString:@","];
//            [content appendString:model.pres_string]; //原来是按照这个显示的
            [content appendString:model.name];//产品现在让这么显示
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
@end
