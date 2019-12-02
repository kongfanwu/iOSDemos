//
//  LYuanGongBigCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/22.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LYuanGongBigCell.h"
#import "LolHomeModel.h"
#import "LYuanGongTbHeader.h"
#import "LYuanGongSubCell.h"
@interface LYuanGongBigCell ()<UITableViewDelegate,UITableViewDataSource>

@end
@implementation LYuanGongBigCell
{
    UITableView * _tb;
    NSMutableArray * _dataArr;
    LYuanGongTbHeader * _header;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initSubViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (void)initSubViews{
    UITableView * tb = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 250) style:UITableViewStylePlain];
    tb.scrollEnabled = NO;
    tb.delegate = self;
    tb.dataSource = self;
    _tb = tb;
    [self addSubview:tb];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    LolHomeModel * model = _dataArr[section];
    return model.pro.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LolHomeModel * model = _dataArr[indexPath.section];
    LGuKeDetail * gukeModel = model.pro[indexPath.row];
    static NSString * cellName1 = @"cell1";
    LYuanGongSubCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName1];
    if (!cell){
        cell = [[[NSBundle mainBundle]loadNibNamed:@"LYuanGongSubCell" owner:nil options:nil]lastObject];
    }
    if (model.pro.count > 0) {
        cell.model = gukeModel;
    }
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    _header = [[[NSBundle mainBundle]loadNibNamed:@"LYuanGongTbHeader" owner:nil options:nil] lastObject];
    _header.model = _dataArr[section];
    return _header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    LolHomeModel * model = _dataArr[indexPath.row];
//    return 44 + model.pro.count * 67.5;
    return 67.5;
}
- (void)setModelArr:(NSMutableArray<LolHomeModel *> *)modelArr
{
    _dataArr = modelArr;
    _tb.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.height);
    [_tb reloadData];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LolHomeModel * model = _dataArr[indexPath.section];
    LGuKeDetail * gukeModel = model.pro[indexPath.row];
    if (_LYuanGongBigCellBlock) {
        _LYuanGongBigCellBlock(_dataArr[indexPath.section],gukeModel);
    }
}
@end
