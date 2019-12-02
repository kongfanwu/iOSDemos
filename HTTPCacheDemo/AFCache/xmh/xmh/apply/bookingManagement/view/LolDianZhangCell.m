//
//  LolYuanGongCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/13.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LolDianZhangCell.h"
#import "LolDianZhangCellSubCell.h"
@interface LolDianZhangCell ()<UITableViewDelegate,UITableViewDataSource>

@end
@implementation LolDianZhangCell{
    
    UITableView * _tb;
    NSMutableArray * _dataArr;
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
    
    return _dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellName1 = @"cell1";
    LolDianZhangCellSubCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName1];
    if (!cell) {
        
        cell = [[[NSBundle mainBundle]loadNibNamed:@"LolDianZhangCellSubCell" owner:nil options:nil]lastObject];
    }
    if (_dataArr.count > indexPath.row) {
        cell.model = _dataArr[indexPath.row];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 105;
}
- (void)updateLolYuanGongCell{

    _tb.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.height);
    [_tb reloadData];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_LolDianZhangCellBlock) {
        _LolDianZhangCellBlock(_dataArr[indexPath.row]);
    }
}
- (void)setModelArr:(NSMutableArray<LolHomeModel *> *)modelArr
{
    _dataArr = modelArr;
    _tb.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.height);
    [_tb reloadData];
}
@end
