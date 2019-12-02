//
//  BillTiYanFuwuCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/23.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "BillTiYanFuwuCell.h"
#import "TiCardSubCell.h"

@implementation BillTiYanFuwuCell{
    SLSCourseExper *_model;
    NSMutableArray *_lbArr;
    SLCourseExperList *SLCourseExperListmodel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)freshBillTiYanFuwuCell:(SLSCourseExper *)model{
    _model = model;
    if (model.isShow) {
        _bgView.backgroundColor = kBtn_Commen_Color;
        _lb.textColor = [UIColor whiteColor];
        _imGegnduo.image = [UIImage imageNamed:@"beautyshang"];
    }else{
        _bgView.backgroundColor = kBackgroundColor;
        _lb.textColor = kLabelText_Commen_Color_3;
        _imGegnduo.image = [UIImage imageNamed:@"gengduo"];
    }
    _lbArr = [[NSMutableArray alloc]init];
    _tbView.dataSource = self;
    _tbView.delegate = self;
    _tbView.hidden = !model.isShow;
    _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tbView reloadData];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *TiCardSubCellindentifier = @"TiCardSubCellindentifier";
    TiCardSubCell *cell;
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TiCardSubCell" owner:nil options:nil] firstObject];
    }else{
        cell  = [_tbView dequeueReusableCellWithIdentifier:TiCardSubCellindentifier];
    }
    if (indexPath.row < _model.list.count) {
        SLCourseExperListmodel = _model.list[indexPath.row];
        cell.lbtitle.text = SLCourseExperListmodel.name;
        cell.btn2.tag = indexPath.row;
        cell.btn3.tag = indexPath.row;
        cell.lb2.tag = indexPath.row+1000;
        cell.lb3.tag = indexPath.row+2000;
        [_lbArr addObject:cell.lb2];
        [_lbArr addObject:cell.lb3];
        [cell.btn2 addTarget:self action:@selector(SLCourseExperbtn2Event:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btn3 addTarget:self action:@selector(SLCourseExperbtn3Event:) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;
}
- (void)SLCourseExperbtn2Event:(UIButton *)sender{
    [self changeBtnTitleColor:sender.tag+1000];
    if (_btnBillTiYanFuwuCellBlock) {
        _btnBillTiYanFuwuCellBlock(sender.tag,1,SLCourseExperListmodel.ID);
    }
}
- (void)SLCourseExperbtn3Event:(UIButton *)sender{
    [self changeBtnTitleColor:sender.tag+2000];
    if (_btnBillTiYanFuwuCellBlock) {
        _btnBillTiYanFuwuCellBlock(sender.tag,2,SLCourseExperListmodel.ID);
    }
}
- (void)changeBtnTitleColor:(NSInteger)tag{
    for (UILabel *lb in _lbArr) {
        if (lb.tag== tag) {
            [lb setTextColor:RGBColor(51, 51, 51)];
        }else{
            [lb setTextColor:[ColorTools colorWithHexString:@"999999"]];
        }
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _model.list.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
