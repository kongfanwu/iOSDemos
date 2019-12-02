//
//  XMHExperienceOrderContentTableView.m
//  xmh
//
//  Created by KFW on 2019/3/15.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHExperienceOrderContentTableView.h"
#import "XMHExperienceOrderContentVC.h"
#import "XMHOrderProjectCell.h"
#import "UITableView+XMHEmptyData.h"
@interface XMHExperienceOrderContentTableView() <UITableViewDelegate, UITableViewDataSource>

@end

@implementation XMHExperienceOrderContentTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.estimatedRowHeight = 100;
        self.rowHeight = UITableViewAutomaticDimension;
        self.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        self.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    }
    return self;
}

#pragma mark - UITableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [tableView tableViewDisplayWithMsg:@"" ifNecessaryForRowCount:_dataArray.count];
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"XMHOrderProjectCell";
    XMHOrderProjectCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil) {
        cell = [[XMHOrderProjectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [cell configModel:_dataArray[indexPath.row]];
    return cell;
}

#pragma mark - UITableView Delegate methods
// 2019/4/19产品删除
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 17 + 20;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    CGFloat headerHeight = [self tableView:tableView heightForHeaderInSection:section];
//    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, headerHeight)];
//    headerView.backgroundColor = UIColor.whiteColor;
//
//    UILabel *textLabel = [[UILabel alloc] init];
//    textLabel.textColor = kColor3;
//    textLabel.font = FONT_SIZE(17);
//
//    if (_type == XMHExperienceOrderTypeProject) {
//        textLabel.text = @"项目服务";
//    } else if (_type == XMHExperienceOrderTypeGoods) {
//        textLabel.text = @"产品服务";
//    } else if (_type == XMHExperienceOrderTypeExperience) {
//        textLabel.text = @"体验服务";
//    }
//
//    [headerView addSubview:textLabel];
//    [textLabel sizeToFit];
//    textLabel.frame = CGRectMake(15, (headerView.height - textLabel.height) / 2.f, textLabel.width, textLabel.height);
//    return headerView;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return UIView.new;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.didSelectRowAtIndexPathBlock) self.didSelectRowAtIndexPathBlock(self, indexPath);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
