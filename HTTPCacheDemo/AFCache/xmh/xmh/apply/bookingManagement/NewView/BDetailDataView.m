//
//  BDetailDataView.m
//  xmh
//
//  Created by ald_ios on 2018/10/18.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BDetailDataView.h"
#import "LolCalendarModelList.h"
@interface BDetailDataView ()
/** 选择日期 */
@property (weak, nonatomic) IBOutlet UILabel *lb1;
/** 预约服务人次 */
@property (weak, nonatomic) IBOutlet UILabel *lb2;
/** 达标人数 */
@property (weak, nonatomic) IBOutlet UILabel *lb3;
/** 预约服务人数 */
@property (weak, nonatomic) IBOutlet UILabel *lb4;
/** 预约服务项目 */
@property (weak, nonatomic) IBOutlet UILabel *lb5;
/** 达标率 */
@property (weak, nonatomic) IBOutlet UILabel *lb6;
@end

@implementation BDetailDataView
- (void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = [UIColor blueColor];
}
- (void)updateBDetailDataViewModel:(LolCalendarModelList *)model isMonth:(BOOL)isMonth
{
    _lb1.text = [NSString stringWithFormat:@"选择日期：%@",model.date];
    _lb5.text = [NSString stringWithFormat:@"预约服务人次：%ld",model.serv_num];
    _lb3.text = [NSString stringWithFormat:@"达标人数：%ld",model.standard];
    _lb2.text = [NSString stringWithFormat:@"预约服务人数：%ld",model.num];
    _lb4.text = [NSString stringWithFormat:@"预约服务项目：%ld",model.pro_num];
    _lb6.text = [NSString stringWithFormat:@"达标率：%@",model.probability];
    if (!isMonth) {
        _lb3.hidden = YES;
        _lb6.hidden = YES;
    }
}
@end
