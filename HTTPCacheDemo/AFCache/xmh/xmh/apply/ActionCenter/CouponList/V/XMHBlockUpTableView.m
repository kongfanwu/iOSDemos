//
//  XMHBlockUpTableView.m
//  xmh
//
//  Created by shendengmeiye on 2019/7/4.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHBlockUpTableView.h"
@interface XMHBlockUpTableView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
/** 列表数据 */
@property (nonatomic,strong) NSMutableArray *listData;
@end

@implementation XMHBlockUpTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (self) {
            _listData = [NSMutableArray array];
            self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
            self.tableView.delegate = self;
            self.tableView.dataSource = self;
            self.tableView.rowHeight = UITableViewAutomaticDimension;
            self.tableView.estimatedRowHeight = 44.f;
            self.tableView.tableFooterView = [UIView new];
            [self addSubview:self.tableView];
        }
    }
    return self;
}

-(void)setDataArr:(NSArray *)dataArr
{
    _dataArr = dataArr;
    // 处理数据
    NSMutableArray *nameArr = [NSMutableArray array];
    NSMutableArray *listArr = [NSMutableArray array];
    for (NSDictionary *dict in dataArr) {
        NSString *name = [dict safeObjectForKey:@"name"];
        NSMutableArray *list = [dict safeObjectForKey:@"list"];
        [nameArr safeAddObject:name];
        [listArr safeAddObject:list];
       
       
    }
    [_listData safeAddObject:nameArr];
    [_listData safeAddObject:listArr];
    
    [self.tableView reloadData];
    
}
#pragma mark - UITableView Datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[_listData safeObjectAtIndex:0] count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    self.tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
    
    return [self getHeaderHInSection:section];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGFloat h = [self tableView:tableView heightForHeaderInSection:section];
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, h)];
    UILabel *headerLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 15, self.width, 21)];
    headerLab.text = [_listData safeObjectAtIndex:0][section];
    [headerView addSubview:headerLab];
    NSArray *arr = [_listData safeObjectAtIndex:1];
    NSArray *titleArr = [arr safeObjectAtIndex:section];
    CGFloat labW = (self.width - 72) * 0.5;
    CGFloat labH = 21;
    CGFloat height_Space = 5;
    CGFloat width_Space = 32;
    for (int i = 0 ; i < [[_listData safeObjectAtIndex:1][section] count]; i++) {
        NSInteger index = i % 2;
        NSInteger page = i / 2;
        UILabel *lab = UILabel.new;
        lab.tag = i;
        lab.frame = CGRectMake(index * (labW + width_Space) + 20, page  * (labH + height_Space) + headerLab.bottom + 5, labW, labH);
        lab.text = [NSString stringWithFormat:@"%@",[titleArr safeObjectAtIndex:i]];
        lab.font = [UIFont systemFontOfSize:13];
        lab.textColor = kColor9;
        [headerView addSubview:lab];
       
    }
    return headerView;
}

- (CGFloat)getHeaderHInSection:(NSInteger)section
{
    
    CGFloat labH = 21;
    CGFloat height_Space = 5;
   
    CGFloat headerH = 0;
    CGFloat headerLabH = 36;
    for (int i = 0 ; i < [[_listData safeObjectAtIndex:1][section] count]; i++) {
        NSInteger page = i / 2;
        headerH = page  * (labH + height_Space) + headerLabH + 5 + labH;
    }
    return headerH;
}
@end
