//
//  ViewController.m
//  MonthAndWeekDemo
//
//  Created by kfw on 2019/7/1.
//  Copyright © 2019 kfw. All rights reserved.
//

#import "XMHMonthWeekVC.h"
#import "XMHMonthAndWeekView.h"
#import "XMHMonthAndWeekModel.h"
#import "XMHMonthAndWeekBgView.h"

@interface XMHMonthWeekVC ()<UITableViewDataSource,UITableViewDelegate, UIGestureRecognizerDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIPanGestureRecognizer *scopeGesture;
/** <##> */
@property (nonatomic, strong) XMHMonthAndWeekBgView *monthAndWeekView;
/** <##> */
@property (nonatomic, strong) NSDate *currentDate;
/** 月数据 */
@property (nonatomic, strong) NSMutableArray *monthDataArray;
@end

@implementation XMHMonthWeekVC


- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTopView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _monthAndWeekView.bottom, self.view.width, self.view.height - _monthAndWeekView.height - kSafeAreaTop - kSafeAreaBottom) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = UIColor.blueColor;
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self.monthAndWeekView action:@selector(handleScopeGesture:)];
    panGesture.delegate = self;
    panGesture.minimumNumberOfTouches = 1;
    panGesture.maximumNumberOfTouches = 2;
    [self.view addGestureRecognizer:panGesture];
    self.scopeGesture = panGesture;
    
    // While the scope gesture begin, the pan gesture of tableView should cancel.
    [self.tableView.panGestureRecognizer requireGestureRecognizerToFail:panGesture];
}

- (void)loadTopView {
    XMHMonthAndWeekCollectionViewType type = XMHMonthAndWeekCollectionViewTypeMonth;
    CGFloat monthAndWeekViewHeight = type == XMHMonthAndWeekCollectionViewTypeMonth ? 135 + kDateBarHeight : 300 + kDateBarHeight;
    self.monthAndWeekView = [[XMHMonthAndWeekBgView alloc] initWithFrame:CGRectMake(0, kSafeAreaTop, self.view.width, monthAndWeekViewHeight)];
    _monthAndWeekView.type = type;
    _monthAndWeekView.isFold = YES;
    [self.view addSubview:_monthAndWeekView];
    
    __weak typeof(self) _self = self;
    [_monthAndWeekView setFrameDidChangeBlock:^{
        __strong typeof(_self) self = _self;
        self.tableView.frame = CGRectMake(0, self.monthAndWeekView.bottom, self.view.width, self.view.height - self.monthAndWeekView.height - kSafeAreaTop - kSafeAreaBottom);
    }];
   
    [_monthAndWeekView.dateNavBarView setChangeYearBlock:^(NSInteger tag) {
        __strong typeof(_self) self = _self;
        NSUInteger year = self.currentDate.year;
        // 左
        if (tag == 1) {
            year--;
        }
        // 右
        else if (tag == 2) {
            year++;
        }
        self.currentDate = [NSDate dateFromYear:(int)year Month:1 Day:1];
        [self getData];
    }];
    
    
    self.currentDate = [NSDate date];
    [self getData];
}

- (void)getData {
    [_monthAndWeekView.dateNavBarView setYear:_currentDate.getYear];
    
    if (_monthAndWeekView.type == XMHMonthAndWeekCollectionViewTypeWeek) {
        __block NSMutableArray *dataArray = NSMutableArray.new;
        [[_currentDate getAllWeekDate] enumerateObjectsUsingBlock:^(NSArray *item, NSUInteger idx, BOOL * _Nonnull stop) {
            XMHMonthAndWeekModel *model = XMHMonthAndWeekModel.new;
            model.firstDate = item.firstObject;
            model.lastDate = item.lastObject;
            model.title = [NSString stringWithFormat:@"第%@周", [[XMHMonthAndWeekModel sharedformatter] stringFromNumber:@(idx + 1)]];
            model.subTitle = [NSString stringWithFormat:@"%ld/%ld-%ld/%ld", model.firstDate.getMonth, model.firstDate.getDay, model.lastDate.getMonth, model.lastDate.getDay];
            [dataArray addObject:model];
        }];
        _monthAndWeekView.collectionView.dataArray = dataArray;
    } else {
        if (!self.monthDataArray) {
            self.monthDataArray = NSMutableArray.new;
            for (int i = 1; i <= 12; i++) {
                XMHMonthAndWeekModel *model = XMHMonthAndWeekModel.new;
                model.firstDate = [NSDate dateFromYear:1970 Month:i Day:1];
                model.title = [NSString stringWithFormat:@"%ld月", model.firstDate.month];
                [self.monthDataArray addObject:model];
            }
            _monthAndWeekView.collectionView.dataArray = self.monthDataArray;
        }
    }
}

#pragma mark - <UIGestureRecognizerDelegate>

// Whether scope gesture should begin
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    CGPoint point2 = [self.scopeGesture locationInView:self.view];
    if (CGRectContainsPoint(_monthAndWeekView.frame, point2)) {
        return NO;
    }
    else if (CGRectContainsPoint(_tableView.frame, point2)) {
        BOOL shouldBegin = self.tableView.contentOffset.y <= -self.tableView.contentInset.top;
        if (shouldBegin) {
            CGPoint velocity = [self.scopeGesture velocityInView:self.view];
            NSLog(@"%@", NSStringFromCGPoint(velocity));
            // 收起
            if (_monthAndWeekView.isFold) {
                BOOL fold = velocity.y < 0;
                NSLog(@"收起%d", fold);
                return fold;
            }
            // 展开
            else {
                BOOL fold = velocity.y > 0;
                NSLog(@"展开%d", fold);
                return fold;
            }
            
        }
        return shouldBegin;
    }
    return NO;
}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"Cell %ld", indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

@end
