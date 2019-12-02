//
//  BookAnalyzeDetailView.m
//  xmh
//
//  Created by ald_ios on 2019/3/8.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BookAnalyzeDetailView.h"
#import "LolCalendarModelList.h"
@interface BookAnalyzeDetailView ()
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;

@property (weak, nonatomic) IBOutlet UILabel *lb5;
@property (weak, nonatomic) IBOutlet UILabel *lb6;
@property (weak, nonatomic) IBOutlet UILabel *lb7;
@property (weak, nonatomic) IBOutlet UILabel *lb8;
@end
@implementation BookAnalyzeDetailView

- (void)updateBookAnalyzeDetailViewModel:(LolCalendarModelList *)model isMonth:(BOOL)isMonth isFront:(BOOL)isFront
{
   
    /** 是整月 */
    if (isMonth) {
        _lb1.text = [NSString stringWithFormat:@"选择日期：%@",model.date];
        _lb2.text = [NSString stringWithFormat:@"预约服务项目数：%ld",model.pro_num];
        _lb3.text = [NSString stringWithFormat:@"预约服务人数：%ld",model.num];
        _lb4.text = [NSString stringWithFormat:@"达标天数：%ld",model.standard];
        _lb7.text = [NSString stringWithFormat:@"预约服务人次：%ld",model.serv_num];
        _lb8.text = [NSString stringWithFormat:@"达标率：%@",model.probability];
         _lb5.hidden = _lb6.hidden = YES;
        _lb8.hidden = NO;
    }else{
        NSString * name = @"";
        if (isFront) {
            name = @"执行：";
        }else{
            name = @"预约：";
        }
        _lb1.text = [NSString stringWithFormat:@"选择日期：%@",model.date];
        _lb2.text = [NSString stringWithFormat:@"%@%@",name,model.info];
        _lb3.text = [NSString stringWithFormat:@"预约服务人数：%ld",model.num];
        _lb4.text = [NSString stringWithFormat:@"预约服务项目数：%ld",model.pro_num];
        _lb7.text = [NSString stringWithFormat:@"预约服务人次：%ld",model.serv_num];
        _lb5.hidden = _lb6.hidden = _lb8.hidden  = YES;
        
    }
}
@end
