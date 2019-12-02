//
//  FWDYeJiCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/11.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "FWDYeJiCell.h"
#import "FWDYeJiSubCell.h"
#import "FWDYeJiSubCell1.h"
#import "MLJishiSearchModel.h"
#import "SLSearchManagerModel.h"
#import "MzzStoreModel.h"
#import "FWDYeJGuiShuModel.h"
@interface FWDYeJiCell ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@end
@implementation FWDYeJiCell
{
    UITableView * _tb;
    NSArray * _titles;
    MzzStoreModel * _selectStoreModel;
    NSIndexPath *indext;
}
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _titles = @[@"业绩归属",@"门店归属",@"店长归属",@"员工归属"];
        self.backgroundColor = [UIColor clearColor];
        [self initSubViews];
    }
    return self;
}
- (void)initSubViews
{
    [self createTableView];
}
- (void)createTableView
{
    UILabel * lb = [[UILabel alloc] init];
    lb.text = @"业绩划分";
    lb.font = FONT_SIZE(14);
    lb.backgroundColor = [UIColor whiteColor];
    lb.textAlignment = NSTextAlignmentCenter;
    lb.frame = CGRectMake(0, 0, SCREEN_WIDTH-30, 30);
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:lb.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(6,6)];
    //创建 layer
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = lb.bounds;
    //赋值
    maskLayer.path = maskPath.CGPath;
    lb.layer.mask = maskLayer;
    _tb = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160) style:UITableViewStylePlain];
    _tb.delegate = self;
    _tb.dataSource = self;
    _tb.tableHeaderView = lb;
//    _tb.backgroundColor = [UIColor clearColor];
    _tb.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tb.scrollEnabled = NO;
    [self.contentView addSubview:_tb];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row <= 3) {
        FWDYeJiSubCell * cell = [[[NSBundle mainBundle]loadNibNamed:@"FWDYeJiSubCell" owner:nil options:nil]lastObject];
        cell.lbTitle.text = _titles[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row < 3) {
            [cell.btn setTitle:@"请选择" forState:UIControlStateNormal];
            if (indexPath.row == 1) {
                cell.imgV.hidden = YES;
            }
        }else{
            cell.imgV.hidden = YES;
            cell.btn.hidden = YES;
        }
        cell.btn.tag = indexPath.row;
        indext = indexPath;
        [cell.btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
       
        if (indexPath.row ==0) {
            FWDYeJGuiShuModel * model = _selectDic[@"yeji"];
            if (model) {
                [cell.btn setTitle:model.showName forState:UIControlStateNormal];
            }
        }else if (indexPath.row == 1){
            MzzStoreModel * model = _selectDic[@"mendian"][0];
            if (model) {
                [cell.btn setTitle:model.store_name forState:UIControlStateNormal];
            }
        }else if (indexPath.row ==2){
            SLManagerModel * model = _selectDic[@"dianzhang"];
            if (model) {
            [cell.btn setTitle:model.name forState:UIControlStateNormal];
            }
        }else{
            cell.imgV.hidden = YES;
            cell.imgV.image = [UIImage imageNamed:@"xuanzejishi.png"];
            cell.imgVConstrant.constant = 20;
            cell.imgConstrantHight.constant =20;
            cell.btn.hidden = YES;
            [cell.btn setTitle:@"" forState:UIControlStateNormal];
            cell.imgV.userInteractionEnabled = YES;
            //创建手势oneview
            UITapGestureRecognizer *tap0 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickTap:)];
            //设置手指字数
            tap0.numberOfTouchesRequired = 1;
            [cell.imgV addGestureRecognizer:tap0];
        }
        return cell;
    }else{
        FWDYeJiSubCell1 * cell = [[[NSBundle mainBundle]loadNibNamed:@"FWDYeJiSubCell1" owner:nil options:nil]lastObject];
        cell.model = _MrenjisArr[indexPath.row - 4];
        if (indexPath.row ==4) {
            [cell.btn setTitle:@"" forState:UIControlStateNormal];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (_FWDYeJiCellGuiShuBlock) {
            _FWDYeJiCellGuiShuBlock(_MrenjisArr);
        }
        cell.FWDYeJiSubCellDelBlock = ^(MLJiShiModel *model) {
            if (indexPath.row ==4) {
                return ;
            }
            [_MrenjisArr removeObject:model];
            [_tb reloadData];
            _tb.frame = CGRectMake(0, 0, SCREEN_WIDTH, (4 + _MrenjisArr.count)* 25+26);
            if (_FWDYeJiCellDelBlock) {
                _FWDYeJiCellDelBlock(_MrenjisArr);
            }
        };
        cell.tf.delegate = self;
        return cell;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4 + _MrenjisArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 25;
}
- (void)click:(UIButton *)btn
{
    if (_FWDYeJiCellBlock) {
        _FWDYeJiCellBlock(btn.tag);
    }
}
-(void)clickTap:(UITapGestureRecognizer *)sender{
    if (_FWDYeJiCellBlock) {
        _FWDYeJiCellBlock(indext.row);
    }
}
- (void)setMrenjisArr:(NSMutableArray *)MrenjisArr
{
    _MrenjisArr = MrenjisArr;
    _tb.frame = CGRectMake(0, 0, SCREEN_WIDTH, (4 + MrenjisArr.count)* 25+26);
    [_tb reloadData];
}
- (void)setSelectDic:(NSMutableDictionary *)selectDic
{
    _selectDic = selectDic;
    [_tb reloadData];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    CGFloat total = 0.0;
    NSArray * cells =  [_tb visibleCells];
    for (int i = 0; i< cells.count; i++) {
        UITableViewCell * cell = cells[i];
        if ([cell isKindOfClass:[FWDYeJiSubCell1 class]]) {
            MLJiShiModel * jis = _MrenjisArr[i-4];
            FWDYeJiSubCell1 * subCell = (FWDYeJiSubCell1 *)cell;
            total = total + subCell.tf.text.floatValue;
            jis.bfb = subCell.tf.text.floatValue;
        }
    }
    if (_FWDYeJiCellGuiShuBlock) {
        _FWDYeJiCellGuiShuBlock(_MrenjisArr);
    }
    
}
@end
