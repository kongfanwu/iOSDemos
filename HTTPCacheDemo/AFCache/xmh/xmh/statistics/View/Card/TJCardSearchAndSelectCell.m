//
//  TJCardSearchAndSelectCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/28.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "TJCardSearchAndSelectCell.h"
#import "TJAlertCell.h"
@interface TJCardSearchAndSelectCell ()<UITableViewDelegate,UITableViewDataSource>
@end
@implementation TJCardSearchAndSelectCell
{
    UIView * _alertView;
    UITableView * _tb;
    UIButton * _selectBtn;
    NSArray * _paiArr;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _btn3.layer.cornerRadius = 2;
    _btn3.layer.borderWidth = 0.5;
    _btn3.layer.borderColor = kBtn_Commen_Color.CGColor;
    [_btn1 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [_btn2 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self initSubViews];
    _paiArr = @[@"成交人数",@"成交金额",@"成交次数",@"卡项普及率"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(TJCardListModel *)model
{
    _lb1.text = [NSString stringWithFormat:@"%@人",model.total_renshu];
    _lb2.text = [NSString stringWithFormat:@"%@元",model.total_money];
    _lb3.text = [NSString stringWithFormat:@"%@次",model.total_cishu];
    _lb4.text = [NSString stringWithFormat:@"%@%@",model.total_bfb,@"%"];
}
- (void)initSubViews
{
    if (!_alertView) {
        _alertView = [[UIView alloc] init];
        _alertView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        UIWindow * w = [UIApplication sharedApplication].keyWindow;
        [w addSubview:_alertView];
        _alertView.hidden = YES;
    }
    [self initBlackGroundView];
    [self createTableView];
}
- (void)initBlackGroundView
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH)];
    view.backgroundColor = [UIColor darkGrayColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [view addGestureRecognizer:tap];
    view.alpha = 0.7;
    [_alertView addSubview:view];
}
- (void)click:(UIButton *)btn
{
    _alertView.hidden = NO;
    _selectBtn = btn;
    [_tb reloadData];
    
}
- (void)tap{
    _alertView.hidden = YES;
}
- (void)createTableView
{
    _tb = [[UITableView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT/2, SCREEN_WIDTH, SCREEN_HEIGHT/2) style:UITableViewStylePlain];
    _tb.dataSource = self;
    _tb.delegate = self;
    _tb.tableFooterView = [[UIView alloc] init];
    [_alertView addSubview:_tb];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_selectBtn.tag ==100) {
        return _cardTopModel.list.count;
    }else{
        return _paiArr.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellName = @"cell";
    TJAlertCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"TJAlertCell" owner:nil options:nil]lastObject];
    }
    if (_selectBtn.tag ==100) {
        TJCardTopSubModel * topModel = _cardTopModel.list[indexPath.row];
        cell.lbTitle.text = topModel.name;
    }else{
          cell.lbTitle.text = _paiArr[indexPath.row];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (void)setCardTopModel:(TJCardTopModel *)cardTopModel
{
    _cardTopModel = cardTopModel;
    [_tb reloadData];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TJAlertCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (_selectBtn.tag ==100) { //选卡
         TJCardTopSubModel * topModel = _cardTopModel.list[indexPath.row];
        [_btn3 setTitle:cell.lbTitle.text forState:UIControlStateNormal];
        if (_TJCardBlock) {
            _TJCardBlock(topModel);
        }
    }else{//列表排序
        [_btn2 setTitle:cell.lbTitle.text forState:UIControlStateNormal];
        if (_TJPaiXuBlock) {
            _TJPaiXuBlock([NSString stringWithFormat:@"%ld",indexPath.row]);
        }
    }
    _alertView.hidden = YES;
}
@end
