//
//  SaleServiceCommitDownView.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/15.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "SaleServiceCommitDownView.h"
#import "SaleCommitDownCell.h"


@implementation SaleServiceCommitDownView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _tb.delegate = self;
    _tb.dataSource = self;
    _tbHeight.constant = 10 *40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SaleCommitDownCellindentifier = @"SaleCommitDownCellindentifier";
    SaleCommitDownCell *cell;
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SaleCommitDownCell" owner:nil options:nil] firstObject];
    }else{
        cell  = [tableView dequeueReusableCellWithIdentifier:SaleCommitDownCellindentifier];
    }
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
@end
