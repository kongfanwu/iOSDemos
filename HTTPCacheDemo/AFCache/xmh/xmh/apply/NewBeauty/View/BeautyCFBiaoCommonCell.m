//
//  BeautyCFBiaoCommonCell.m
//  xmh
//
//  Created by ald_ios on 2019/3/26.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BeautyCFBiaoCommonCell.h"
@interface BeautyCFBiaoCommonCell ()
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UILabel *lb5;
@property (weak, nonatomic) IBOutlet UILabel *lb6;
@property (weak, nonatomic) IBOutlet UILabel *lb7;
@property (weak, nonatomic) IBOutlet UILabel *lb8;
@property (weak, nonatomic) IBOutlet UIView *bg;

@end
@implementation BeautyCFBiaoCommonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _lb1.font = FONT_SIZE(16);
    _lb2.font = _lb3.font = _lb4.font = _lb5.font = _lb6.font = _lb7.font = _lb8.font = FONT_SIZE(11);
    
    _lb2.textColor = _lb3.textColor = _lb4.textColor = _lb5.textColor = _lb6.textColor = _lb7.textColor = _lb8.textColor = kColor9;
    _lb1.textColor = kColor3;
    _bg.layer.cornerRadius = 5;
    _bg.layer.masksToBounds = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

- (void)updateCellStoreParam:(NSMutableDictionary *)param
{
    _lb8.hidden = YES;
    _lb1.text = param[@"store_name"]?param[@"store_name"]:@"";
    _lb2.text = [NSString stringWithFormat:@"总负债金额：%@元",param[@"zfz"]?param[@"zfz"]:@""];
    _lb3.text = [NSString stringWithFormat:@"月均消耗金额：%@元",param[@"yjxhje"]?param[@"yjxhje"]:@""];
    _lb4.text = [NSString stringWithFormat:@"活动顾客数：%@",param[@"hdgks"]?param[@"hdgks"]:@""];
    _lb5.text = [NSString stringWithFormat:@"到店次数：%@",param[@"ddcs"]?param[@"ddcs"]:@""];
    _lb6.text = [NSString stringWithFormat:@"消耗项目数：%@",param[@"xhxms"]?param[@"xhxms"]:@""];
    _lb7.text = [NSString stringWithFormat:@"当月处方数：%@个",param[@"dycfs"]?param[@"dycfs"]:@""];
    
}
- (void)updateCellCustomerParam:(NSMutableDictionary *)param
{
    _lb1.text = param[@"user_name"]?param[@"user_name"]:@"";
    _lb2.text = [NSString stringWithFormat:@"手机号：%@",param[@"mobile"]?param[@"mobile"]:@""];
    _lb3.text = [NSString stringWithFormat:@"处方名称：%@",param[@"pres_name"]?param[@"pres_name"]:@""];
    _lb4.text = [NSString stringWithFormat:@"规划金额：%@",param[@"amount"]?param[@"amount"]:@""];
    _lb5.text = [NSString stringWithFormat:@"处方规划项目数：%@",param[@"cfghxms"]?param[@"cfghxms"]:@""];
    _lb6.text = [NSString stringWithFormat:@"处方内容：%@",param[@"cfnr"]?param[@"cfnr"]:@""];
    NSString * zt = @"";
    if ([param[@"zt"] integerValue] == 1) {/** 未完成 */
        zt = @"进行中";
        _lb7.textColor = [ColorTools colorWithHexString:@"#48C2AF"];
    }else if ([param[@"zt"] integerValue] == 2){/** 已终止 */
        zt = @"已终止";
        _lb7.textColor = [ColorTools colorWithHexString:@"#FF9072"];
    }else if ([param[@"zt"] integerValue] == 3){/** 已完成 */
        zt = @"已完成";
        _lb7.textColor = kColorC;
    }else{}
    
    _lb7.text = zt;
    _lb8.text = [NSString stringWithFormat:@"规划次数%@/%@",param[@"num1"]?param[@"num1"]:@"",param[@"num"]?param[@"num"]:@""];
}

@end
