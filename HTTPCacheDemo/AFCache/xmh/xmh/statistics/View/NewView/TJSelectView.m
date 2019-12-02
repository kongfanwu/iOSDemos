//
//  TJSelectView.m
//  xmh
//
//  Created by ald_ios on 2018/12/5.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "TJSelectView.h"
#import "TJDataPickCell.h"
#import "TJSectionTbHeader.h"
#import "TJParamModel.h"
#import "DateTools.h"
#import "TJDatePickView.h"
@interface TJSelectView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)UIView *bgView;
@property (strong, nonatomic)UITableView *tbView;
@property (strong, nonatomic)TJSectionTbHeader * sectionTbHeader;
@property (strong, nonatomic)NSArray * modelArr;
@property (strong, nonatomic)TJDatePickView * tJDatePickView;
@property (strong, nonatomic)NSArray * titleArr;
@end
@implementation TJSelectView
{
    NSString * _type;
}
- (instancetype)initWithFrame:(CGRect)frame timeBlock:(TJSelectViewDateBlock)block
{
    if (self = [super initWithFrame:frame]){
        [self addSubview:self.bgView];
        [self addSubview:self.tbView];
        _titleArr = @[@"今日",@"本周",@"本月",@"上月"];
        NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
        [formatter1 setDateFormat:@"YYYY-MM-dd"];
        NSString * startTime = [DateTools getCurrentTimesFormatter:formatter1];
        NSString * endTime = [DateTools getCurrentTimesFormatter:formatter1];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY.MM.dd"];
//        NSString * title = [NSString stringWithFormat:@"%@-%@",[DateTools getCurrentTimesFormatter:formatter],[DateTools getCurrentTimesFormatter:formatter]];
        /** 默认显示今日 */
        block(startTime,endTime,_titleArr[0]);
        
//        block(startTime,endTime,title);
        
    }
    return self;
}
- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _bgView.alpha = 0.4;
        _bgView.backgroundColor = [UIColor blackColor];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [self addGestureRecognizer:tap];
        [_bgView addGestureRecognizer:tap];
    }
    return _bgView;
}
- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 320, SCREEN_WIDTH, 320) style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.tableHeaderView = self.sectionTbHeader;
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tbView;
}
-(TJSectionTbHeader *)sectionTbHeader
{
    if (!_sectionTbHeader) {
        _sectionTbHeader = loadNibName(@"TJSectionTbHeader");
    }
    return _sectionTbHeader;
}
- (TJDatePickView *)tJDatePickView
{
    WeakSelf
    if (!_tJDatePickView) {
        _tJDatePickView = [[TJDatePickView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _tJDatePickView.TJDatePickView = ^(NSString *startTime, NSString *endTime) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"YYYY.MM.dd"];
            NSString *title = [NSString stringWithFormat:@"%@-%@",[DateTools getStringFromString:startTime Formatter:formatter],[DateTools getStringFromString:endTime Formatter:formatter]];
            if (weakSelf.TJSelectViewDateBlock) {
                weakSelf.TJSelectViewDateBlock(startTime,endTime,title);
            }
            if (weakSelf.TJSelectViewDateCustomerActiveBlock) {
                weakSelf.TJSelectViewDateCustomerActiveBlock(startTime,endTime,title,@"4");
            }
        };
    }
    return _tJDatePickView;
}
- (void)updateTJSelectViewSectionTitle:(NSString *)title
{
    [_sectionTbHeader updateTJSectionTbHeaderTitle:title];
}
- (void)tap:(UITapGestureRecognizer *)tap
{
    [self removeFromSuperview];
}
#pragma mark ------UITableView------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * kTJDataPickCell = @"kTJDataPickCell";
    TJDataPickCell * tJDataPickCell = [tableView dequeueReusableCellWithIdentifier:kTJDataPickCell];
    if (!tJDataPickCell) {
        tJDataPickCell = loadNibName(@"TJDataPickCell");
    }
    [tJDataPickCell updateTJDataPickCellModel:_modelArr[indexPath.row]];
    return tJDataPickCell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _modelArr.count;
}
- (void)updateTJSelectViewModelArr:(NSArray *)modelArr type:(NSString *)type;
{
    _modelArr = modelArr;
    _type = type;
    [_tbView reloadData];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TJParamModel * model = _modelArr[indexPath.row];
    model.selected = YES;
    for (int i = 0; i < _modelArr.count; i++) {
        TJParamModel * subModel = _modelArr[i];
        if (![model isEqual:subModel]) {
            subModel.selected = NO;
        }
    }
    [_tbView reloadData];
    [self removeFromSuperview];
    if ([_type isEqualToString:@"日期"]) {
        [_sectionTbHeader updateTJSectionTbHeaderTitle:@"请选择日期"];
        [self pickDateAtIndexPath:indexPath];
    }
    if ([_type isEqualToString:@"数据"]) {
        [_sectionTbHeader updateTJSectionTbHeaderTitle:@"数据选择"];
        [self pickDataAtIndexPath:indexPath];
    }
    if ([_type isEqualToString:@"门店"]) {
        [_sectionTbHeader updateTJSectionTbHeaderTitle:@"请选择"];
        [self pickStoreAtIndexPath:indexPath];
    }
    if ([_type isEqualToString:@"顾客"]) {
        [_sectionTbHeader updateTJSectionTbHeaderTitle:@"请选择"];
        [self pickCustomerAtIndexPath:indexPath];
    }
}
/** 选择日期 */
- (void)pickDateAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * title = @"";
    if (indexPath.row < 4) {
        title = _titleArr[indexPath.row];
    }
   
    /** 今日 */
    if (indexPath.row == 0) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY.MM.dd"];
//        NSString *title = [NSString stringWithFormat:@"%@-%@",[DateTools getCurrentTimesFormatter:formatter],[DateTools getCurrentTimesFormatter:formatter]];
        NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
        [formatter1 setDateFormat:@"YYYY-MM-dd"];
        if (_TJSelectViewDateBlock) {
            _TJSelectViewDateBlock([DateTools getCurrentTimesFormatter:formatter1],[DateTools getCurrentTimesFormatter:formatter1],title);
        }
        if (_TJSelectViewDateCustomerActiveBlock) {
            _TJSelectViewDateCustomerActiveBlock([DateTools getCurrentTimesFormatter:formatter1],[DateTools getCurrentTimesFormatter:formatter1],title,@"0");
        }
        
    }
    /** 本周 */
    if (indexPath.row == 1) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY.MM.dd"];
//        NSString *title = [NSString stringWithFormat:@"%@-%@",[DateTools getStringFromString:[DateTools getFirstAndLastDayOfThisWeek][0] Formatter:formatter],[DateTools getStringFromString:[DateTools getFirstAndLastDayOfThisWeek][1] Formatter:formatter]];
        if (_TJSelectViewDateBlock) {
            _TJSelectViewDateBlock([DateTools getFirstAndLastDayOfThisWeek][0],[DateTools getFirstAndLastDayOfThisWeek][1],title);
        }
        if (_TJSelectViewDateCustomerActiveBlock) {
            _TJSelectViewDateCustomerActiveBlock([DateTools getFirstAndLastDayOfThisWeek][0],[DateTools getFirstAndLastDayOfThisWeek][1],title,@"1");
        }
        
    }
    /** 本月 */
    if (indexPath.row == 2) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY.MM.dd"];
//        NSString *title = [NSString stringWithFormat:@"%@-%@",[DateTools getStringFromString:[DateTools getFirstAndLastDayOfThisMonth][0] Formatter:formatter],[DateTools getStringFromString:[DateTools getFirstAndLastDayOfThisMonth][1] Formatter:formatter]];
        if (_TJSelectViewDateBlock) {
            _TJSelectViewDateBlock([DateTools getFirstAndLastDayOfThisMonth][0],[DateTools getFirstAndLastDayOfThisMonth][1],title);
        }
        if (_TJSelectViewDateCustomerActiveBlock) {
            _TJSelectViewDateCustomerActiveBlock([DateTools getFirstAndLastDayOfThisMonth][0],[DateTools getFirstAndLastDayOfThisMonth][1],title,@"2");
        }
        
    }
    /** 上月 */
    if (indexPath.row == 3) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY.MM.dd"];
//        NSString *title = [NSString stringWithFormat:@"%@-%@",[DateTools getStringFromString:[DateTools getFirstAndLastDayOfLastMonth][0] Formatter:formatter],[DateTools getStringFromString:[DateTools getFirstAndLastDayOfLastMonth][1] Formatter:formatter]];
        if (_TJSelectViewDateBlock) {
            _TJSelectViewDateBlock([DateTools getFirstAndLastDayOfLastMonth][0],[DateTools getFirstAndLastDayOfLastMonth][1],title);
        }
        if (_TJSelectViewDateCustomerActiveBlock) {
            _TJSelectViewDateCustomerActiveBlock([DateTools getFirstAndLastDayOfLastMonth][0],[DateTools getFirstAndLastDayOfLastMonth][1],title,@"3");
        }
        
    }
    /** 历史 */
    if (indexPath.row == 4) {
        UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;
        [keyWindow addSubview:self.tJDatePickView];
    }
}
/** 数据选择 */
- (void)pickDataAtIndexPath:(NSIndexPath *)indexPath
{
    TJParamModel * model = _modelArr[indexPath.row];
    if (_TJSelectViewDataBlock) {
        _TJSelectViewDataBlock(model);
    }
}
/** 门店选择 */
- (void)pickStoreAtIndexPath:(NSIndexPath *)indexPath
{
    TJParamModel * model = _modelArr[indexPath.row];
    if (_TJSelectViewStoreBlock) {
        _TJSelectViewStoreBlock(model);
    }
}
/** 顾客选择 */
- (void)pickCustomerAtIndexPath:(NSIndexPath *)indexPath
{
    TJParamModel * model = _modelArr[indexPath.row];
    if (_TJSelectViewCustomerBlock) {
        _TJSelectViewCustomerBlock(model);
    }
}
@end
