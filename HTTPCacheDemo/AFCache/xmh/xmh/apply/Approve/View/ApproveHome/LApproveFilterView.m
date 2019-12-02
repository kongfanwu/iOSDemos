//
//  LApproveFilterView.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/27.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LApproveFilterView.h"
#import "JasonSearchView.h"
#import "LWaitCell.h"
@interface LApproveFilterView()<UITableViewDataSource,UITableViewDelegate>

@end
@implementation LApproveFilterView
{
    NSArray * _titles;
    NSArray * _imgs;
    JasonSearchView * _searchView;
    UIView * _view;
    UITableView * _tb;
    NSArray * _stateArr;
    NSArray * _typeArr;
    LWaitCell * _waitcell;
    LWaitCell * _donecell;
    UIView * _view1;
    UIView * _view2;
    UIView * _view3;
    UIView * _view4;
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
        _titles = @[@"搜索",@"筛选"];
        _imgs = @[@"sousuo",@"saixuantubiao"];
        _stateArr = @[@"全部",@"审批完成",@"审批中",@"已撤销"];
        _typeArr = @[@"全部",@"会员冻结",@"调店申请",@"账单校正",@"退款审批",@"完善资料",@"添加顾客",@"升卡续卡",@"已购置换",@"个性制单",@"奖赠审批"];
        [self initSubViews];
//        self.backgroundColor = [UIColor cyanColor];
        _selectState = @"全部";
        _selectType = @"全部";
    }
    return self;
}
- (void)initSubViews
{
    UIView * view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    [self addSubview:view1];
    CGFloat btnW = SCREEN_WIDTH/_titles.count;
    for (int i = 0; i < _titles.count; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:_titles[i] forState:UIControlStateNormal];
        btn.frame = CGRectMake(i * btnW , 0, btnW, 44);
        btn.titleLabel.font = FONT_SIZE(14);
        [btn setImage:[UIImage imageNamed:_imgs[i]] forState:UIControlStateNormal];
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 12, 0, 0);
        [btn setTitleColor:kLabelText_Commen_Color_6 forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [view1 addSubview:btn];
    }
    _view1 = view1;
    UIView * view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    _searchView = [[JasonSearchView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 60, 44)withPlaceholder:@"姓名/手机号"];
    _searchView.searchBar.btnRightBlock = ^{
        
    };
    _searchView.searchBar.btnleftBlock = ^{
      
    };
    [_searchView.searchBar addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [view2 addSubview:_searchView];
    [self addSubview:view2];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    btn.frame = CGRectMake(SCREEN_WIDTH - 60, 0, 60, 44);
    [btn setTitleColor:kLabelText_Commen_Color_6 forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = FONT_SIZE(14);
    [view2 addSubview:btn];
    _view2 = view2;
    view2.hidden = YES;
    
    UIView * view3 = [[UIView alloc] init];
    view3.frame = self.bounds;
    view3.hidden = YES;
    _tb = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, view3.height - 70)];
    _tb.dataSource = self;
    _tb.delegate = self;
    _tb.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tb.tableFooterView = [[UIView alloc] init];
    _view3 = view3;
    [view3 addSubview:_tb];
    [self addSubview:view3];
    
    UIView * view4 = [[UIView alloc] initWithFrame:CGRectMake(0, _tb.bottom, SCREEN_WIDTH, 70)];
    _view4 = view4;
    view4.backgroundColor = [UIColor whiteColor];
    [view3 addSubview:view4];
    UIButton * btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setTitle:@"确定" forState:UIControlStateNormal];
    btn1.frame = CGRectMake(15, 15, SCREEN_WIDTH - 30, 44);
    btn1.titleLabel.font = FONT_SIZE(14);
    [btn1 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    btn1.backgroundColor = kBtn_Commen_Color;
    [view4 addSubview:btn1];
}
- (void)textFieldDidChange:(UITextField *) TextField
{
   
}
- (void)click:(UIButton *)btn
{
    if ([btn.currentTitle isEqualToString:@"搜索"]) {
        _view1.hidden = YES;
        _view2.hidden = NO;
    }else if([btn.currentTitle isEqualToString:@"筛选"]){
        _view1.hidden = YES;
        self.height = _view3.height = _tb.height = SCREEN_HEIGHT - Heigh_Nav;
        _tb.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav);
        _view4.frame = CGRectMake(0, _view3.height - 70, SCREEN_WIDTH, 70);
        _view3.hidden = NO;
        
    }else if ([btn.currentTitle isEqualToString:@"取消"]){
        _view2.hidden = YES;
        _view1.hidden = NO;
    }else{
        self.height = 44;
        _view3.hidden = YES;
        _view1.hidden = NO;
        if (_LApproveFilterViewBlock) {
            _LApproveFilterViewBlock(_selectState,_selectType);
        }
    }
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
    static NSString * waitCell = @"waitCell";
    static NSString * doneCell = @"doneCell";
    
    if (_isContainType) {
        if (!_waitcell) {
            _waitcell =  [[LWaitCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:waitCell];
        }
        _waitcell.titleArr = _typeArr;
        _donecell.LWaitCellBlock = ^(NSInteger ptype,NSString * title) {
//            MzzLog(@".....%@",obj);
//            _selectState = obj;
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
//                _selectState = obj;
            }else{
//                _selectType = obj;
            }
//            MzzLog(@".....%@",obj);
        };
        return _donecell;
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
    lb.font = FONT_SIZE(16);
    lb.textColor = kLabelText_Commen_Color_3;
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
