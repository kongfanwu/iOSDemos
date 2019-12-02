//
//  BeautyCFAnalyzeCell1.m
//  xmh
//
//  Created by ald_ios on 2019/3/29.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BeautyCFAnalyzeCell1.h"
#import "RolesTools.h"
@interface BeautyCFAnalyzeCell1 ()
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UILabel *lb5;
@property (weak, nonatomic) IBOutlet UILabel *lb6;
@property (weak, nonatomic) IBOutlet UIImageView *more;
@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineBottomH;

@end
@implementation BeautyCFAnalyzeCell1

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _lb1.font = FONT_SIZE(15);
    _lb6.font = FONT_SIZE(13);
    _lb2.font = _lb3.font = _lb4.font = _lb5.font = FONT_SIZE(11);
    
    _lb1.textColor = kColor3;
    _lb2.textColor = _lb3.textColor = _lb4.textColor = _lb5.textColor = kColor9;
    _lb6.textColor = [ColorTools colorWithHexString:@"#FFAF19"];
    _line.backgroundColor = kSeparatorColor;
    _lineBottomH.constant = kSeparatorHeight;
}
- (void)updateCellParam:(NSMutableDictionary *)param
{
    _lb1.text = param[@"name"]?param[@"name"]:@"";
    _lb2.text = [NSString stringWithFormat:@"月均消耗金额：%@元",param[@"yjxhje"]?param[@"yjxhje"]:@""];
    _lb3.text = [NSString stringWithFormat:@"活动顾客数：%@人",param[@"hdgks"]?param[@"hdgks"]:@""];
    _lb4.text = [NSString stringWithFormat:@"到店次数：%@次",param[@"ddcs"]?param[@"ddcs"]:@""];
    _lb5.text = [NSString stringWithFormat:@"消耗项目数：%@个",param[@"xhxms"]?param[@"xhxms"]:@""];
    _lb6.text = [NSString stringWithFormat:@"总负债：%@元",param[@"zfz"]?param[@"zfz"]:@""];
}
- (void)updateCellShowByMainRole:(NSInteger )mainRole
{
    if (mainRole == 8 || mainRole == 9 || mainRole == 10||mainRole == 11) {
        _more.hidden = YES;
    }
}
@end
