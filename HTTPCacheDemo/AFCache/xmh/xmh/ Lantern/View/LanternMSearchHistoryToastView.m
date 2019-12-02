//
//  LanternMSearchHistoryToastView.m
//  xmh
//
//  Created by ald_ios on 2019/2/13.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LanternMSearchHistoryToastView.h"
#import "LanternMToastCell.h"
@interface LanternMSearchHistoryToastView ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tbView;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (nonatomic, strong) NSMutableArray * dataSource;

@end
@implementation LanternMSearchHistoryToastView
- (void)awakeFromNib
{
    [super awakeFromNib];
    _dataSource = [[NSMutableArray alloc] init];
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    _tbView.delegate = self;
    _tbView.dataSource = self;
}
- (IBAction)btnClick:(id)sender {
    if (_LanternMSearchHistoryToastViewBlock) {
        _LanternMSearchHistoryToastViewBlock();
    }
}
#pragma mark ------UITableView------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * kLanternMToastCell = @"kLanternMToastCell";
    LanternMToastCell * toastCell = [tableView dequeueReusableCellWithIdentifier:kLanternMToastCell];
    if (!toastCell) {
        toastCell =  loadNibName(@"LanternMToastCell");
    }
    [toastCell updateCellParam:_dataSource[indexPath.row]];
    return toastCell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//        return 10;
    return _dataSource.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 25.0f;
}
- (void)updateViewParam:(NSDictionary *)param
{
    _itemID = param[@"id"];
    [_dataSource removeAllObjects];
    [_dataSource addObjectsFromArray:[param[@"history"] componentsSeparatedByString:@","]];
    [_dataSource removeObject:@","];
    [_dataSource removeObject:@""];
    _lbName.text = param[@"name"];
    [_tbView reloadData];
}
@end
