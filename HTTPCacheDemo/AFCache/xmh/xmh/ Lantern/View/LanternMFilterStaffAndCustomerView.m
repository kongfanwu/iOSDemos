//
//  LanternMFilterStaffAndCustomerView.m
//  xmh
//
//  Created by ald_ios on 2019/2/27.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LanternMFilterStaffAndCustomerView.h"
#import "TJDatePickView.h"
#import "LanternMSelectStoreView.h"
#import "LanternMYuanGongCell.h"
#import "LanternMYuanGongTbSectionHeader.h"
#import "MzzStoreModel.h"
#define kCollectionViewSectionHeaderH 30
#define kCollectionViewCellH 30
#define kCollectionViewMargin 5
@interface LanternMFilterStaffAndCustomerView ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tbView;
@property (weak, nonatomic) IBOutlet UIView *bg;
@property (weak, nonatomic) IBOutlet UIButton *btnLeft;
@property (weak, nonatomic) IBOutlet UIButton *btnRight;
@property (nonatomic, strong)NSMutableArray * dataSource;
@property (nonatomic, strong)NSArray * nameSource;
@property (nonatomic, assign)NSInteger selectSection;
@property (nonatomic, assign)CGFloat cellHeight;

@property (nonatomic, strong)LanternMSelectStoreView * storeView;
@property (nonatomic, strong)TJDatePickView * datePickView;
@property (nonatomic, strong)NSMutableArray * keySource;
@property (nonatomic, copy)NSString * startTime;
@property (nonatomic, copy)NSString * endTime;
@property (nonatomic, strong)NSMutableArray * selectStores;
@property (nonatomic, strong)NSMutableDictionary * param;
@end
@implementation LanternMFilterStaffAndCustomerView
- (void)awakeFromNib
{
    [super awakeFromNib];
    _btnLeft.layer.cornerRadius = _btnRight.layer.cornerRadius = 3;
    _btnLeft.layer.masksToBounds = _btnRight.layer.masksToBounds = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDown:)];
    [_bg addGestureRecognizer:tap];
    
    _tbView.delegate = self;
    _tbView.dataSource = self;
    _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tbView.backgroundColor = kColorE;
    _tbView.layer.cornerRadius = 5;
    _tbView.layer.masksToBounds = YES;
    
    _dataSource = [[NSMutableArray alloc] init];
    _param = [[NSMutableDictionary alloc] init];
    _nameSource = @[@"检索范围",@"基础信息",@"管理顾客",@"顾客行为",@"工作行为"];
    
}
- (void)tapDown:(UITapGestureRecognizer *)tap
{
    [self removeFromSuperview];
}
- (IBAction)reset:(id)sender
{
    [self removeFromSuperview];
}
- (IBAction)search:(id)sender
{
    [self organizeParam];
    if (_LanternMFilterStaffAndCustomerViewBlock) {
        _LanternMFilterStaffAndCustomerViewBlock(_param.jsonData);
    }
    [self removeFromSuperview];
}
- (TJDatePickView *)datePickView
{
    WeakSelf
    if (!_datePickView) {
        _datePickView = [[TJDatePickView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds cornerRadius:10];
        _datePickView.TJDatePickView = ^(NSString *startTime, NSString *endTime) {
            weakSelf.startTime = startTime;
            weakSelf.endTime = endTime;
            //            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            //            [formatter setDateFormat:@"YYYY.MM.dd"];
            [weakSelf organizeParam];
        };
    }
    return _datePickView;
}
- (void)searchTapNotice:(NSNotification *)not
{
    if ([not.object integerValue]== 0) {
        NSMutableArray * tempArr3 = _resultDic[@"list3"];
        NSMutableArray * tempArr4 = _resultDic[@"list3"];
        BOOL customerBehavior = NO;
        BOOL workBehavior = NO;
        /** 判断是否选择了顾客行为里的条件 */
        for (int i = 0; i < tempArr3.count; i ++) {
            NSMutableDictionary * temp = tempArr3[i];
            for (int j = 0; j < [temp[@"list"] count]; j ++) {
                if ([temp[@"list"][j][@"select"] boolValue]) {
                    customerBehavior = YES;
                }
            }
        }
        /** 判断是否选择了工作行为里的条件 */
        for (int i = 0; i < tempArr4.count; i ++) {
            NSMutableDictionary * temp = tempArr3[i];
            for (int j = 0; j < [temp[@"list"] count]; j ++) {
                if ([temp[@"list"][j][@"select"] boolValue]) {
                    workBehavior = YES;
                }
            }
        }
        if (customerBehavior || workBehavior) {
            [[UIApplication sharedApplication].keyWindow addSubview:self.datePickView];
        }else{
            [self organizeParam];
        }
    }
    
}

- (LanternMSelectStoreView *)storeView
{
    WeakSelf
    if (!_storeView) {
        _storeView = loadNibName(@"LanternMSelectStoreView");
        _storeView.frame = [UIApplication sharedApplication].keyWindow.bounds;
        _storeView.LanternMSelectStoreViewBlock = ^(NSMutableArray * _Nonnull param) {
            weakSelf.selectStores = param;
        };
        [_storeView updateViewParam:_storeArr];
    }
    return _storeView;
}

#pragma mark ------UITableView------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * kLanternMYuanGongCell = @"kLanternMYuanGongCell";
    LanternMYuanGongCell * cell = [tableView dequeueReusableCellWithIdentifier:kLanternMYuanGongCell];
    if (!cell) {
        cell =  [[LanternMYuanGongCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kLanternMYuanGongCell];
    }
    
    cell.LanternMYuanGongCellBlock = ^(NSMutableDictionary *param){
        if ([param[@"name"]isEqualToString:@"所属门店"]) {
            [[UIApplication sharedApplication].keyWindow addSubview:self.storeView];
        }else{
            [[UIApplication sharedApplication].keyWindow addSubview:self.storeView];
        }
    };
    [cell updateSearchType:YES];
    NSMutableArray * tempArr = _resultDic[[NSString stringWithFormat:@"list%ld",_selectSection]];
    [cell updateCellParam:tempArr ];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == _selectSection) {
        return 1;
    }else{
        return 0;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    WeakSelf
    LanternMYuanGongTbSectionHeader * header = loadNibName(@"LanternMYuanGongTbSectionHeader");
    header.frame = CGRectMake(0, 0, SCREEN_WIDTH - 20, 50);
    [header updateViewTitle:_nameSource[section] section:section];
    header.LanternMYuanGongTbSectionHeaderBlock = ^(NSInteger section) {
        weakSelf.selectSection = section;
        [weakSelf.tbView reloadData];
    };
    return header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50.0f;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == _selectSection) {
        CGFloat cellHeight= 0.0;
        NSMutableArray * tempArr = _resultDic[[NSString stringWithFormat:@"list%ld",_selectSection]];
        /** 几组数据 */
        cellHeight = cellHeight + tempArr.count * kCollectionViewSectionHeaderH;
        /** collectionView  cell高度 */
        NSInteger cellCount = 0;
        for (int i = 0; i < tempArr.count; i++) {
            NSDictionary * tempDic = tempArr[i];
            cellCount = [tempDic[@"list"] count];
            if (cellCount%4 ==0) {
                cellHeight = cellHeight + kCollectionViewCellH * (cellCount / 3) + (cellCount/3 + 1) * kCollectionViewMargin;
            }else{
                cellHeight = cellHeight +  kCollectionViewCellH * (cellCount /3 + 1) + (cellCount/3 + 2) * kCollectionViewMargin;
            }
        }
        _cellHeight = cellHeight;
        return cellHeight;
    }else{
        return 0;
    }
}
/** 组织搜索条件 */
- (void)organizeParam
{
//    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    NSMutableString * storeCode = [[NSMutableString alloc] init];
    for (int i = 0; i < _selectStores.count; i++) {
        MzzStoreModel * model = _selectStores[i];
        if ([_selectStores[0] isSelect]) {
            [storeCode appendString:@"all"];
        }else{
            if (model.isSelect) {
                [storeCode appendString:model.store_code];
                [storeCode appendString:@","];
            }
        }
    }
    
    if (storeCode.length > 1) {
        if ([[storeCode substringWithRange:NSMakeRange(storeCode.length - 1, 1)]isEqualToString:@","]) {
            [storeCode replaceCharactersInRange:NSMakeRange(storeCode.length - 1, 1) withString:@""];
        }
    }
    
    [_param setValue:_startTime forKey:@"start_time"];
    [_param setValue:_endTime forKey:@"end_time"];
    [_param setValue:@"all" forKey:@"store_code"];
    
    [self keys:@[@"junior_time",@"age",@"grade",@"role_id"] source:_resultDic[@"list1"]];
    [self keys:@[@"baoyou",@"huodong",@"youxiao",@"xiumian",@"liushi",@"biaozhun"] source:_resultDic[@"list2"]];
    [self keys:@[@"popularzing_rate",@"kjxhdj",@"expend_pro_average",@"in_store"] source:_resultDic[@"list3"]];
    [self keys:@[@"sale",@"expend",@"rec_user_id",@"expend_pro",@"appo_user_id",@"pres"] source:_resultDic[@"list4"]];
    
//    LanternMResultVC * resultVC = [[LanternMResultVC alloc] init];
//    resultVC.searchType = LanternSearchTypeStaff;
//    resultVC.search_where = _param.jsonData;
//    resultVC.paramDic = _resultDic;
//    resultVC.storeArr = _selectStores;
//    [self.navigationController pushViewController:resultVC animated:NO];
    
}
- (void)keys:(NSArray *)keys source:(NSMutableArray *)source
{
    NSArray * keylist1 = keys;
    
    NSMutableArray * list1 = source;
    for (int i = 0; i< keylist1.count; i ++) {
        NSMutableArray * customArr = [[NSMutableArray alloc] init];
        NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
        NSMutableArray * sysArr = [[NSMutableArray alloc] init];
        for (int j = 0; j < [list1[i][@"list"] count]; j++) {
            if ([list1[i][@"list"][j][@"select"] boolValue]) {
                [sysArr addObject:@(j + 1)];
                if ([[list1[i][@"list"][j] allKeys] containsObject:@"custom"]) {
                    [customArr addObject:list1[i][@"list"][j][@"name"]];
                }
            }
            [dict setValue:customArr forKey:@"custom"];
            [dict setValue:sysArr forKey:@"sys"];
        }
        [_param setValue:dict forKey:keylist1[i]];
    }
    
}
@end
