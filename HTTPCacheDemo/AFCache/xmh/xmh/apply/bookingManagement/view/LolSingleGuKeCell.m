//
//  LolSingleGuKeCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/23.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LolSingleGuKeCell.h"
#import "LolSingleGuKeSubCell.h"
#import "LGuKeStateHeaderView.h"
@interface LolSingleGuKeCell ()<UITableViewDelegate,UITableViewDataSource>

@end
@implementation LolSingleGuKeCell
{
    UITableView * _tb;
    NSMutableArray * _tmpArr;
    LGuKeStateHeaderView * _header;
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
        _tmpArr  = [[NSMutableArray alloc] init];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (void)initSubViews
{
    UITableView * tb = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 250) style:UITableViewStylePlain];
    tb.scrollEnabled = NO;
    tb.delegate = self;
    tb.dataSource = self;
    _tb = tb;
    [self addSubview:tb];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tmpArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellName1 = @"cell1";
    LolSingleGuKeSubCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName1];
    if (!cell) {
        
        cell = [[[NSBundle mainBundle]loadNibNamed:@"LolSingleGuKeSubCell" owner:nil options:nil]lastObject];
    }
    cell.model = _tmpArr[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    _header = [[[NSBundle mainBundle]loadNibNamed:@"LGuKeStateHeaderView" owner:nil options:nil] lastObject];
    _header.model =  _model;
    return _header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 54.0f;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_LolSingleGuKeCellBlock ) {
        _LolSingleGuKeCellBlock(_model.list[indexPath.row],indexPath.row);
    }
}
- (void)setModel:(LolGuKeStateModelList *)model{
    _model = model;
    [_tmpArr removeAllObjects];
    for (LolGuKeStateModel * stateModel in model.list) {
        if (stateModel.pro.length > 0) {
            [_tmpArr addObject:stateModel];
        }
    }
     _tb.frame = CGRectMake(0, 0, SCREEN_WIDTH, _tmpArr.count * 65 + 54);
    [_tb reloadData];
}
@end
