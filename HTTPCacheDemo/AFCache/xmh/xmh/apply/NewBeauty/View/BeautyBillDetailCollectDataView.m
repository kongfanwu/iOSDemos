//
//  BeautyBillDetailCollectDataView.m
//  xmh
//
//  Created by ald_ios on 2019/3/25.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BeautyBillDetailCollectDataView.h"
@interface BeautyBillDetailCollectDataView ()
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UILabel *lb5;
@property (weak, nonatomic) IBOutlet UILabel *lb6;
@property (weak, nonatomic) IBOutlet UIProgressView *p;

@end
@implementation BeautyBillDetailCollectDataView
- (void)awakeFromNib
{
    [super awakeFromNib];
    _lb1.textColor = kColor3;
    _lb2.textColor = _lb3.textColor = _lb4.textColor = _lb5.textColor = kColor9;
    _lb6.textColor = [ColorTools colorWithHexString:@"#FF9072"];
    
    _lb1.font = FONT_SIZE(16);
    _lb2.font = _lb3.font = _lb4.font = _lb5.font = FONT_SIZE(11);
    _lb6.font = FONT_SIZE(15);
    
    _lb5.text = @"预计总消耗周期";
}
- (void)updateViewParam:(NSMutableDictionary *)param
{
    _lb1.text = [NSString stringWithFormat:@"总负债：%@",param[@"zfz"]?param[@"zfz"]:@""];
    _lb2.text = [NSString stringWithFormat:@"月均做项目数：%@",param[@"yjzxms"]?param[@"yjzxms"]:@""];
    _lb3.text = [NSString stringWithFormat:@"月均耗卡单价：%@",param[@"yjhkdj"]?param[@"yjhkdj"]:@""];
    _lb4.text = [NSString stringWithFormat:@"月到店频次：%@",param[@"yddpc"]?param[@"yddpc"]:@""];
    _lb6.text = [NSString stringWithFormat:@"%@天-%@天",param[@"min"]?param[@"min"]:@"",param[@"sum"]?param[@"sum"]:@""];
}

@end
