//
//  BeautyGouWuCheView.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/7.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "BeautyGouWuCheView.h"
#import "BeautGouWuCheCell.h"
#import "ShareWorkInstance.h"
#import "BeautyProjectModel.h"
@implementation BeautyGouWuCheView{
    UIImage *image4;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-74);
    _im1.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.height-277);
    _im2.frame = CGRectMake(0, _im1.bottom, SCREEN_WIDTH,49);
    
    _lb2.textColor = kLabelText_Commen_Color_9;
    _lb2.font = FONT_SIZE(15);
    _lb2.text = @"清空";
    [_lb2 sizeToFit];
    _lb2.frame =CGRectMake(SCREEN_WIDTH-15-_lb2.width, _im2.top+(50-_lb2.height)/2.0, _lb2.width, _lb2.height);
    
    image4 = [UIImage imageNamed:@"beautyshanchu"];
    _im4.image = image4;
    _im4.frame =CGRectMake(_lb2.left -6-image4.size.width, _im2.top+(50-image4.size.height)/2.0, image4.size.width, image4.size.height);
    
    _btn1.frame = CGRectMake(_im4.left, _im2.top+5, _lb2.right - _im4.left, 40);
    [_btn1 addTarget:self action:@selector(delEvent) forControlEvents:UIControlEventTouchUpInside];    
    
    _lb1.textColor = kLabelText_Commen_Color_3;
    _lb1.font = FONT_SIZE(15);
    _lb1.text = @"规划项目";
    [_lb1 sizeToFit];
    _lb1.frame =CGRectMake(15, _im2.top+(50-_lb1.height)/2.0, _lb1.width, _lb1.height);
    
    _line1.backgroundColor = kBackgroundColor;
    _line1.frame = CGRectMake(0, _im2.bottom, SCREEN_WIDTH, 1);
    _tbView1.frame = CGRectMake(0,_line1.bottom,SCREEN_WIDTH,227);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [_im1 addGestureRecognizer:tap];
}

- (void)delEvent{
    [[ShareWorkInstance shareInstance].BeautyProjectList removeAllObjects];
    [_tbView1 reloadData];
    self.hidden = YES;
    if (_BeautyGouWuCheViewDelBlock) {
        _BeautyGouWuCheViewDelBlock();
    }
}
- (void)tapAction:(UITapGestureRecognizer *)tap{
    self.hidden = YES;
}
- (void)refreshBeautyGouWuCheView{
    [_tbView1 reloadData];
    NSMutableArray *arr = [ShareWorkInstance shareInstance].BeautyProjectList;
    if (arr.count == 0) {
        self.hidden = YES;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *BeautGouWuCheCellindentifier = @"BeautGouWuCheCellindentifier";
    BeautGouWuCheCell *cell = [tableView dequeueReusableCellWithIdentifier:BeautGouWuCheCellindentifier];
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BeautGouWuCheCell" owner:nil options:nil] lastObject];
    }
    NSMutableArray *arr = [ShareWorkInstance shareInstance].BeautyProjectList;
    if (indexPath.row < arr.count) {
        BeautyProjectModel *Model = arr[indexPath.row];
        [cell reFreshBeautGouWuCheCell:Model];
    }
    cell.BeautGouWuCheCellAddBlock = ^(BeautyProjectModel *model) {
        if (_BeautGouWuCheAddBlock) {
            _BeautGouWuCheAddBlock(model);
        }
    };
    cell.BeautGouWuCheCellReduceBlock = ^(BeautyProjectModel *model) {
        if (_BeautGouWuCheReduceBlock) {
            _BeautGouWuCheReduceBlock(model);
        }
    };
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableArray *arr = [ShareWorkInstance shareInstance].BeautyProjectList;
    return arr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 69;
}
@end
