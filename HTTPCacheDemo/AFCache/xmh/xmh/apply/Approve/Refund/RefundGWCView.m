//
//  RefundGWCView.m
//  xmh
//
//  Created by ald_ios on 2018/11/14.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "RefundGWCView.h"
#import "RefundGWCCell.h"
#import "RefundGWCTbHeader.h"
@interface RefundGWCView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView * tbView;
@property (nonatomic, strong)UIView * bgView;
@property (nonatomic, strong)RefundGWCTbHeader * refundGWCTbHeader;
//@property (nonatomic, strong) NSMutableArray * dataSource;
@end
@implementation RefundGWCView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.bgView];
        [self addSubview:self.tbView];
    }
    return self;
}
- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _bgView.backgroundColor = kColor3;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [_bgView addGestureRecognizer:tap];
        _bgView.alpha = 0.4;
    }
    return _bgView;
}
- (void)tap:(UITapGestureRecognizer *)tap
{
    self.hidden = YES;
}
- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.height - 300, SCREEN_WIDTH, 300) style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tbView.tableFooterView = [[UIView alloc] init];
        _tbView.tableHeaderView = self.refundGWCTbHeader;
        _tbView.backgroundColor = UIColor.whiteColor;
    }
    return _tbView;
}
- (RefundGWCTbHeader *)refundGWCTbHeader
{
    WeakSelf
    if (!_refundGWCTbHeader) {
        _refundGWCTbHeader = loadNibName(@"RefundGWCTbHeader");
        _refundGWCTbHeader.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
        _refundGWCTbHeader.RefundGWCTbHeaderBlock = ^{
            [weakSelf.dataSource removeAllObjects];
            [weakSelf.tbView reloadData];
            [weakSelf clearData];
        };
    }
    return _refundGWCTbHeader;
}
/** 回调外界数据被清空 */
- (void)clearData
{
    if (_RefundGWCViewClearBlock) {
        _RefundGWCViewClearBlock();
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}
- (void)updateRefundGWCViewModelArr:(NSMutableArray *)modelArr
{
    _dataSource = modelArr;
    [_tbView reloadData];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * kRefundGWCCell = @"kRefundGWCCell";
    RefundGWCCell * refundGWCCell = [tableView dequeueReusableCellWithIdentifier:kRefundGWCCell];
    if (!refundGWCCell) {
        refundGWCCell = loadNibName(@"RefundGWCCell");
    }
    [refundGWCCell updateRefundGWCCellModel:_dataSource[indexPath.row]];
    return refundGWCCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0f;
}
- (void)setDataSource:(NSMutableArray *)dataSource
{
    _dataSource = dataSource;
    [_tbView reloadData];
}
@end
