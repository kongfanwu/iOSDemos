//
//  LApproveFilterBtnView.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/12.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LApproveFilterBtnView.h"
#import "LWaitCell.h"
@interface LApproveFilterBtnView ()<UITableViewDataSource,UITableViewDelegate>

@end
@implementation LApproveFilterBtnView
{
       UITableView * _tb;
    LWaitCell * _waitcell;
    LWaitCell * _donecell;
    NSArray * _stateArr;
    NSArray * _typeArr;
    NSString * _selectState;
    NSString * _selectType;
}
- (void)setIsContainType:(BOOL)isContainType{
    _isContainType = isContainType;
    [_tb reloadData];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _stateArr = @[@"全部",@"审批完成",@"审批中",@"已撤销"];
//        _typeArr = @[@"全部",@"会员冻结",@"调店申请",@"账单校正",@"退款审批",@"完善资料",@"添加顾客",@"升卡续卡",@"已购置换",@"个性制单",@"奖赠审批"];
        _typeArr = @[@"全部",@"会员冻结",@"调店申请",@"退款审批",@"完善资料"];//fix bug 5627
        _selectState = @"全部";
        _selectType = @"全部";
        self.backgroundColor = kBackgroundColor;
        [self createTableView];
    }
    return self;
}
- (void)createTableView
{
    _tb = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.height - 70)];
    _tb.dataSource = self;
    _tb.delegate = self;
    _tb.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tb.tableFooterView = [[UIView alloc] init];
    _tb.backgroundColor = kBackgroundColor;
    [self addSubview:_tb];
    
    
    UIView * view4 = [[UIView alloc] initWithFrame:CGRectMake(0, _tb.bottom, SCREEN_WIDTH, 70)];
    view4.backgroundColor = [UIColor whiteColor];
    UIButton * btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setTitle:@"确定" forState:UIControlStateNormal];
    btn1.frame = CGRectMake(15, 15, SCREEN_WIDTH - 30, 44);
    btn1.titleLabel.font = FONT_SIZE(14);
    btn1.backgroundColor = kBtn_Commen_Color;
    _btnSure = btn1;
    [view4 addSubview:btn1];
    [self addSubview:view4];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_isContainType) {//待我审批的
        return 1;
    }else{
        return 2;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeakSelf
    static NSString * waitCell = @"waitCell";
    static NSString * doneCell = @"doneCell";
    
    if (_isContainType) {
        if (!_waitcell) {
            _waitcell =  [[LWaitCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:waitCell];
        }
        _waitcell.titleArr = _typeArr;
        _waitcell.LWaitCellBlock = ^(NSInteger ptype,NSString * title) {
            weakSelf.ptype = [weakSelf typeSortByName:title];
             MzzLog(@"type...............%@",[weakSelf typeSortByName:title]);
        };
        return _waitcell;
    }else{
        _donecell = [tableView dequeueReusableCellWithIdentifier:doneCell];
        if (!_donecell) {
            _donecell =  [[LWaitCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:doneCell];
        }
        if (indexPath.section ==0) {
            _donecell.titleArr = _stateArr;
            
        }else{
            _donecell.titleArr = _typeArr;
        }
        _donecell.LWaitCellBlock = ^(NSInteger ptype,NSString * title) {
            if (indexPath.section ==0) {
                weakSelf.pState =  [weakSelf typeSortByName:title];
                MzzLog(@"state...............%@",[weakSelf typeSortByName:title]);
            }else{
                weakSelf.ptype =  [weakSelf typeSortByName:title];
                 MzzLog(@"type...............%@",[weakSelf typeSortByName:title]);
            }
        };
        return _donecell;
    }
}
- (NSString *)typeSortByName:(NSString *)name
{
    if ([name isEqualToString:@"全部"]) {
        return @"";
    }else if ([name isEqualToString:@"审批完成"]){
        return @"1";
    }else if ([name isEqualToString:@"审批中"]){
        return @"0";
    }else if ([name isEqualToString:@"已撤销"]){
        return @"2";
    }else if ([name isEqualToString:@"会员冻结"]){
        return @"1";
    }else if ([name isEqualToString:@"调店申请"]){
        return @"2";
    }else if ([name isEqualToString:@"退款审批"]){
        return @"3";
    }else if ([name isEqualToString:@"账单校正"]){
        return @"4";
    }else if ([name isEqualToString:@"完善资料"]){
        return @"5";
    }else if ([name isEqualToString:@"个性制单"]){
        return @"6";
    }else if ([name isEqualToString:@"已购置换"]){
        return @"7";
    }else if ([name isEqualToString:@"升卡续卡"]){
        return @"8";
    }else if ([name isEqualToString:@"添加顾客"]){
        return @"92";
    }else if ([name isEqualToString:@"奖赠审批"]){
        return @"10";
    }else{
        return @"";
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel * lb = [[UILabel alloc] init];
    if (_isContainType) {
        lb.text = @"类型";
    }else{
        if (section ==0) {
            lb.text = @"状态";
        }else{
            lb.text = @"类型";
        }
    }
    lb.font = FONT_SIZE(15);
    lb.textColor = kColor6;
    [lb sizeToFit];
    lb.frame = CGRectMake(15, 15, lb.width, lb.height);
    [view addSubview:lb];
    return view;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isContainType) {
        if (_typeArr.count%3 ==0) {
            return  (40 + 15)* _typeArr.count/3;
        }else{
            return  (40 + 15)* (_typeArr.count/3 + 1);
        }
    }else{
        if (indexPath.section == 0) {
            if (_stateArr.count%3 ==0) {
                return  (40 + 15)* _stateArr.count/3;
            }else{
                return  (40 + 15)* (_stateArr.count/3 + 1);
            }
        }else{
            if (_typeArr.count%3 ==0) {
                return  (40 + 15)* _typeArr.count/3;
            }else{
                return  (40 + 15)* (_typeArr.count/3 + 1);
            }
        }
    }
}
@end
