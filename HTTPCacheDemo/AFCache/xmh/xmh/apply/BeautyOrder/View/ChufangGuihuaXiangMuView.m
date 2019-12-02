//
//  ChufangGuihuaXiangMuView.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/2.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "ChufangGuihuaXiangMuView.h"
#import "ChufangGuiHuaXiangMuCell.h"
#import "ShareWorkInstance.h"
//#import "MzzOrganizationCell.h"
#import "MzzChuFangXiangMuCell.h"
@interface ChufangGuihuaXiangMuView()<UITableViewDelegate,UITableViewDataSource>
@end
@implementation ChufangGuihuaXiangMuView{
    NSMutableArray *_arrsource;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
    
    _lb1.textColor = kLabelText_Commen_Color_3;
    _lb1.font = FONT_BOLD_SIZE(15);
    _lb1.text = @"规划项目";
    [_lb1 sizeToFit];
    _lb1.frame =CGRectMake(15,15, _lb1.width, _lb1.height);
    
    _lb2.textColor = kLabelText_Commen_Color_3;
    _lb2.font = FONT_SIZE(15);
    _lb2.text = @"项目名称";
    [_lb2 sizeToFit];
    _lb2.frame =CGRectMake(15,_lb1.bottom+20, _lb2.width, _lb2.height);
    
    CGFloat width = SCREEN_WIDTH/2.0/3.0;
    
    _lb5.textColor = kLabelText_Commen_Color_3;
    _lb5.font = FONT_SIZE(15);
    _lb5.text = @"时长";
    [_lb5 sizeToFit];
    _lb5.textAlignment = NSTextAlignmentCenter;
    _lb5.frame =CGRectMake(SCREEN_WIDTH -width-15,_lb2.top,width, _lb5.height);
    
    _lb4.textColor = kLabelText_Commen_Color_3;
    _lb4.font = FONT_SIZE(15);
    _lb4.text = @"金额";
    [_lb4 sizeToFit];
    _lb4.textAlignment = NSTextAlignmentCenter;
    _lb4.frame =CGRectMake(_lb5.left - width,_lb2.top, width, _lb4.height);
    
    _lb3.textColor = kLabelText_Commen_Color_3;
    _lb3.font = FONT_SIZE(15);
    _lb3.text = @"次数";
    [_lb3 sizeToFit];
    _lb3.textAlignment = NSTextAlignmentCenter;
    _lb3.frame =CGRectMake(_lb4.left - width,_lb2.top, width, _lb3.height);
    
    _arrsource = [ShareWorkInstance shareInstance].BeautyProjectList;
    _tbview.frame = CGRectMake(0,_lb2.bottom+10,SCREEN_WIDTH,_arrsource.count*25+10);
    [_tbview registerNib:[UINib nibWithNibName:@"ChufangGuiHuaXiangMuCell" bundle:nil] forCellReuseIdentifier:@"ChufangGuiHuaXiangMuCellindentifier"];
    
    _line1.frame = CGRectMake(0, _tbview.bottom, SCREEN_WIDTH, 1);
    _line1.backgroundColor = kBackgroundColor;
    
    _lb6.textColor = kLabelText_Commen_Color_3;
    _lb6.font = FONT_SIZE(15);
    _lb6.text = @"处方实际时长/次";
    [_lb6 sizeToFit];
    _lb6.frame =CGRectMake(15,_line1.bottom+10, _lb6.width, 30);
    
    _text1.frame = CGRectMake(SCREEN_WIDTH - 10, _lb6.top, 100, 30);
    _text1.center = CGPointMake(_lb5.center.x, _text1.center.y);
    _text1.right = SCREEN_WIDTH - 22;
//    _text1.backgroundColor = kColorTheme;
    _text1.textAlignment = NSTextAlignmentRight;
    _line2.frame = CGRectMake(0, _text1.bottom+10, SCREEN_WIDTH, 10);
    _line2.backgroundColor = kBackgroundColor;
}
- (float)getChufangGuihuaXiangMuViewHeight{
    
    return _line2.bottom;
}
- (void)freshTiem:(NSString *)timeStr{
    _text1.text = timeStr;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *BeautGouWuCheCellindentifier = @"ChufangGuiHuaXiangMuCellindentifier";
    MzzChuFangXiangMuCell *cell = [[NSBundle mainBundle] loadNibNamed:@"MzzChuFangXiangMuCell" owner:nil options:nil].firstObject;
//    MzzOrganizationCell * cell = [[NSBundle mainBundle] loadNibNamed:@"MzzOrganizationCell" owner:nil options:nil].firstObject;
//    if (!cell)
//    {
//        cell = [[[NSBundle mainBundle] loadNibNamed:@"ChufangGuiHuaXiangMuCell" owner:nil options:nil] lastObject];
//    }
    
    if (indexPath.row < _arrsource.count) {
        BeautyProjectModel *Model = _arrsource[indexPath.row];
        [cell refreshChufangGuiHuaXiangMuCell:Model];
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrsource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 25;
}
@end
