//
//  BookTimeVC.m
//  xmh
//
//  Created by ald_ios on 2018/10/22.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BookTimeVC.h"
/** View */
#import "BookTimeSubmiitView.h"
#import "BookTimeJisView.h"
#import "BookTimeWeekView.h"
/** 通用 */
#import "BookRequest.h"
/** Model */
#import "CustomerMessageModel.h"
#import "BookJisTimeList.h"

/** Cell */
#import "BookTimeCollectionCell.h"
/** VC */
#import "BookDateVC.h"

@interface BookTimeVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong)BookTimeSubmiitView * submitView;
@property (nonatomic, strong)BookTimeJisView * jisView;
@property (nonatomic, strong)BookTimeWeekView * weekView;
@property (nonatomic, strong)UICollectionView * bookTimeCollectionView;
@property (nonatomic, strong)NSMutableArray * selectTimeArr;
@property (nonatomic, copy)NSString * selectDate;
 /** 参数日期 */
@property (nonatomic, copy)NSString * paramDate;
@end

@implementation BookTimeVC
{
    BookJisTimeList * _jisTimeList;
    NSInteger _needNum;
//    NSString * _selectDate;
   
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _selectTimeArr = [[NSMutableArray alloc] init];
    [self.navView setNavViewTitle:@"服务技师时间" backBtnShow:YES];
    self.navView.backgroundColor = kBtn_Commen_Color;
    
    _needNum = [self needMaxNum];
    _paramDate = [self dateToString:[NSDate date] withDateFormat:@"yyyy-MM-dd"];
    
    [self.view addSubview:self.bookTimeCollectionView];
    [self.bookTimeCollectionView addSubview:self.jisView];
    [self.bookTimeCollectionView addSubview:self.weekView];
    [self.view addSubview:self.submitView];
    
    [self requestJisTimeData];
}
- (BookTimeSubmiitView *)submitView
{
    WeakSelf
//    __weak NSMutableArray * weakArr = _selectTimeArr;
//    __weak NSString * weakDate = _selectDate;
    if (!_submitView) {
        _submitView = loadNibName(@"BookTimeSubmiitView");
        _submitView.frame = CGRectMake(0, SCREEN_HEIGHT - 50 - kSafeAreaBottom, SCREEN_WIDTH, 50);
    }
    _submitView.BookTimeSubmiitViewBlock = ^{
        [[[MzzHud alloc]initWithTitle:@"" message:@"您是否确认预约此时间进行服务" leftButtonTitle:@"放弃预约" rightButtonTitle:@"立即预约" click:^(NSInteger index) {
            if (index == 1) {
                if (weakSelf.BookTimeVCBlock) {
                    weakSelf.BookTimeVCBlock(weakSelf.selectTimeArr,weakSelf.paramDate);
                }
                [weakSelf.navigationController popViewControllerAnimated:NO];
            }
        }]show];
    };
    return _submitView;
}
- (BookTimeJisView *)jisView
{
    if (!_jisView) {
        _jisView = loadNibName(@"BookTimeJisView");
        _jisView.frame = CGRectMake(15, -(77 + 56 + 30) + 10, SCREEN_WIDTH - 30, 77);
    }
    return _jisView;
}
- (BookTimeWeekView *)weekView
{
    WeakSelf
    if (!_weekView) {
        _weekView = loadNibName(@"BookTimeWeekView");
        _weekView.frame = CGRectMake(15, _jisView.bottom + 15, SCREEN_WIDTH - 30, 56);
        _weekView.BookTimeWeekViewDateBlock = ^(NSString *date) {
            
        };
        
        __weak typeof(self) _self = self;
        _weekView.BookTimeWeekViewMoreBlock = ^{
            __strong typeof(_self) self = _self;
            BookDateVC * bookDateVC = [[BookDateVC alloc] init];
            /** 返回来年月日 */
            bookDateVC.BookDateVCBlock = ^(NSString *date) {
                self.selectDate = date;
                self.paramDate = date;
                [weakSelf.weekView updateBookTimeWeekViewDate:date];
                [weakSelf requestJisTimeData];
            };
            bookDateVC.selectDate = weakSelf.selectDate;
            [weakSelf.navigationController pushViewController:bookDateVC animated:YES];
        };
        _weekView.BookTimeWeekViewDateBlock = ^(NSString *date) {
            weakSelf.paramDate = date;
            [weakSelf requestJisTimeData];
        };
    }
    return _weekView;
}
- (UICollectionView *)bookTimeCollectionView
{
    if (!_bookTimeCollectionView) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake((SCREEN_WIDTH - 15 *2 - 10 * 4)/5, 45);;
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(10, 15, 0, 15);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _bookTimeCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav - 50 - kSafeAreaBottom) collectionViewLayout:layout];
        _bookTimeCollectionView.delegate = self;
        _bookTimeCollectionView.dataSource = self;
        _bookTimeCollectionView.contentInset = UIEdgeInsetsMake((77 + 56 + 30), 0, 0, 0);
        _bookTimeCollectionView.showsHorizontalScrollIndicator = NO;
        [_bookTimeCollectionView registerNib:[UINib nibWithNibName:@"BookTimeCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"BookTimeCollectionCell"];
        _bookTimeCollectionView.backgroundColor = [UIColor whiteColor];
        _bookTimeCollectionView.pagingEnabled = NO;
    }
    return _bookTimeCollectionView;
}
#pragma mark ------UICollectionViewDelegate------
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BookTimeCollectionCell * timeCell =  [collectionView dequeueReusableCellWithReuseIdentifier:@"BookTimeCollectionCell" forIndexPath:indexPath];
    if (!timeCell) {
        timeCell = loadNibName(@"BookTimeCollectionCell");
    }
    [timeCell updateBookTimeCollectionCellModel:_jisTimeList.calendar[indexPath.row]];
    return timeCell;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _jisTimeList.calendar.count;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    for (BookJisTime * jisTime in _jisTimeList.calendar) {
        jisTime.isSelect = NO;
    }
    [_selectTimeArr removeAllObjects];
    
    if (_jisTimeList.calendar[indexPath.row].state.integerValue != 1) {
        return;
    }
    BookJisTime * jisTime = _jisTimeList.calendar[indexPath.item];
    jisTime.isSelect = YES;
    if (jisTime.state.integerValue == 1) {
        jisTime.isSelect = YES;
        [_selectTimeArr addObject:jisTime.time];
        for (NSInteger i = indexPath.row + 1; i< indexPath.row + _needNum; i++) {
            BookJisTime * jisTimeNext = _jisTimeList.calendar[i];
            jisTimeNext.isSelect = YES;
            [_selectTimeArr addObject:jisTimeNext.time];
        }
    }else{

    }
    MzzLog(@"item.....%ld......%@......%@......%d",indexPath.item,jisTime.state,jisTime.time,jisTime.isSelect);
    [_bookTimeCollectionView reloadData];
    [_submitView updateBookTimeSubmiitView:[NSString stringWithFormat:@"%@ %@-%@",_paramDate,_selectTimeArr[0],[_selectTimeArr lastObject]]];
}
/** 通过时长判断需要几个时间段 */
- (NSInteger)needMaxNum
{
    if (_maxTime == 0) {
        return 1;
    }
    if (_maxTime%30 == 0) {
        return _maxTime/30;
    }else{
        return _maxTime/30 + 1;
    }
}
- (BOOL)canUseIndex:(NSInteger)index
{
    BOOL canUse = YES;
    if ((index + _needNum - 1) >= _jisTimeList.calendar.count) {
        return NO;
    }
    for (NSInteger i = index; i< index + _needNum; i++) {
        if (_jisTimeList.calendar[i].state.integerValue != 1) {
            canUse = NO;
        }
    }
    return canUse;
}
- (NSString *)dateToString:(NSDate *)date withDateFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
}
#pragma mark ------网络请求------
- (void)requestJisTimeData
{
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setValue:_paramDate?_paramDate:@"" forKey:@"time"];
    [params setValue:@(_customerModel.uid)?@(_customerModel.uid):@"" forKey:@"user_id"];
    [params setValue:_customerModel.store_code?_customerModel.store_code:@"" forKey:@"store_code"];
    [BookRequest requestJisTimeParam:params resultBlock:^(BookJisTimeList *timeList, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _jisTimeList = timeList;
            /** 过滤数据不可预约的置灰 */
            for (int i = 0; i < _jisTimeList.calendar.count; i++) {
                BookJisTime * jisTime = _jisTimeList.calendar[i];
                if (jisTime.state.integerValue == 1 && ![self canUseIndex:i]) {
                    jisTime.state = [NSString stringWithFormat:@"%@",@"5"];
                }
                jisTime.isSelect = NO;
            }
            [_jisView updateBookTimeJisViewModel:timeList];
            [_bookTimeCollectionView reloadData];
        }else{}
    }];
}
@end
