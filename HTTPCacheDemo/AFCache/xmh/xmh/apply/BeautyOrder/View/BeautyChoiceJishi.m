//
//  BeautyChoiceJishi.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/20.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "BeautyChoiceJishi.h"
#import "BeautyJianGeWeakCell.h"//间隔cell、星期cell
#import "ShareWorkInstance.h"
#import "BeautyRequest.h"
#import "LolUserInfoModel.h"
#import "UserManager.h"
#import "XMHUserManager.h"
@implementation BeautyChoiceJishi{
    NSIndexPath         *_lastindexPath;
    NSArray             *_arrJianGe;
    NSArray             *_arrWeek;
    NSArray             *_arrChoose;
    NSArray             *_arrYiGou;
    NSArray             *_arrGuKe;

    NSInteger           _typeInteger;
    NSString            *_jianGe;
    NSString            *_week;
    NSString            *_choosePaiHang; //选择排行
    NSString            *_chooseLeiBie; //选择顾客类别

    BeautyChoiseJishiList            *_jishiModel;
    NSArray             *_arrJishi;
    NSArray             *_arrjoincode;
    NSString            *_pinPaiStr;
    /** 选择的品牌 */
    Join_Code * _selectJoinCode;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    _im1.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT- 236-49);
    _im2.frame = CGRectMake(0, SCREEN_HEIGHT - 236-49, SCREEN_WIDTH,49);
    _line1.backgroundColor = kBackgroundColor;
    _line1.frame = CGRectMake(0, _im2.bottom, SCREEN_WIDTH, 1);
    _tbView1.frame = CGRectMake(0,_line1.bottom,SCREEN_WIDTH,235);
    _lb1.text = @"选择美容师";
    _lb1.textColor = kLabelText_Commen_Color_3;
    [_lb1 sizeToFit];
    _lb1.frame = CGRectMake(15, _im2.top+(50-_lb1.height)/2.0, _lb1.width, _lb1.height);
    
    _btn2.frame = CGRectMake(SCREEN_WIDTH - 16 - 45, _im2.top+(50-40)/2.0, 45, 40);
    [_btn2 setTitleColor:kBtn_Commen_Color forState:UIControlStateNormal];
    [_btn2 addTarget:self action:@selector(btnSureEvent) forControlEvents:UIControlEventTouchUpInside];
    
    _btn1.frame = CGRectMake(_btn2.left - 16 - 30 , _im2.top+(50-40)/2.0, 45, 40);
    [_btn1 setTitleColor:kBtn_Commen_Color forState:UIControlStateNormal];
    [_btn1 addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [_im1 addGestureRecognizer:tap];
    
    BeautyRequest *_choiseJishiRequest = [[BeautyRequest alloc]init];
    [_choiseJishiRequest requestBeautyChoiseJishi:[ShareWorkInstance shareInstance].store_code resultBlock:^(BeautyChoiseJishiModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _arrJishi = model.data.list;
            [_tbView1 reloadData];
        }
    }];
    
    LolUserInfoModel *model = [UserManager getObjectUserDefaults:userLogInInfo];
    _arrjoincode = model.data.join_code;
//    _arrjoincode = [[XMHUserManager sharedXMHUserManager]getUserJoinCodes];
}
- (void)refreshBeautyChoiceJishiJiange{
    _lb1.text = @"按间隔";
    _arrJianGe = @[@"1天",@"2天",@"3天",@"4天",@"5天",@"6天",@"7天",@"8天",@"9天",@"10天"];
    _typeInteger = 1;
    [_tbView1 reloadData];
}
- (void)refreshBeautyChoiceJishiWeek{
    _lb1.text = @"按星期";
    _arrWeek = @[@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期日"];
    _typeInteger = 2;
    [_tbView1 reloadData];
}
- (void)refreshBeautyChoiceJishi{
    _lb1.text = @"选择美容师";
    _typeInteger = 3;
    [_tbView1 reloadData];
}
- (void)refreshWorkChoicePinPai{
    _lb1.text = @"请选择";
    _typeInteger = 4;
    [_tbView1 reloadData];
}
-(void)refreshWorkChoose
{
    _lb1.text = @"请选择排行";
    _arrChoose = @[@"按业绩排序",@"按消耗排序",@"按客次排序",@"按项目数排序",@"按预约数排序",@"按有效客数排序",@"按引流客数排序",@"按人均接待排序",@"按人均操作排序",@"按客均项目数排序",@"按客均单价排序"];
    _typeInteger = 5;
    [_tbView1 reloadData];
}
-(void)refreshYigouZhiHuan
{
    _lb1.text = @"";
    _arrYiGou = @[@"多退",@"少补",@"等值"];
    _typeInteger = 6;
    [_tbView1 reloadData];
}
- (void)refreshGuKeLeiBie:(NSArray *)arr withTitle:(NSString *)title{
    _lb1.text = title;
    _arrGuKe = arr;
    _typeInteger = 7;
    [_tbView1 reloadData];
}

- (void)btnSureEvent{
    switch (_typeInteger) {
        case 1:
        {
            if (_JiangeBlock) {
                _JiangeBlock(_jianGe);
            };
        }
            break;
        case 2:
        {
            if (_WeekBlock) {
                _WeekBlock(_week);
            };
        }
            break;
        case 3:
        {
            if (_JishiBlock) {
                _JishiBlock(_jishiModel);
            };
        }
            break;
            case 4:
        {
            if (_workChoicePinPaiViewBlock) {
                _workChoicePinPaiViewBlock(_pinPaiStr);
            }
            
            if (_workChoicePinPaiChangeViewBlock) {
                _workChoicePinPaiChangeViewBlock(_selectJoinCode);
            }
        }
            break;
        case 5:
        {
            if (_chooseBlock) {
                _chooseBlock(_choosePaiHang);
            }
        }
        case 6:
        {
            if (_YiGouBlock) {
                _YiGouBlock(_choosePaiHang);
            }
        }
            break;
        case 7:
        {
            if (_GuKeBlock) {
                _GuKeBlock(_chooseLeiBie);
            }
        }
            break;
        default:
            break;
    }
    [self tapAction:nil];
}
- (void)tapAction:(UITapGestureRecognizer *)tap{
    self.hidden = YES;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *BeautyJianGeWeakCellindentifier = @"BeautyJianGeWeakCellindentifier";
    BeautyJianGeWeakCell *cell;
    
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BeautyJianGeWeakCell" owner:nil options:nil] lastObject];
    }else{
       cell = [tableView dequeueReusableCellWithIdentifier:BeautyJianGeWeakCellindentifier];
    }
    switch (_typeInteger) {
        case 1:
            {
                if (indexPath.row<_arrJianGe.count) {
                    [cell refreshBeautyJianGeWeakCell:_arrJianGe[indexPath.row]];
                }
                return cell;
            }
            break;
        case 2:
        {
            if (indexPath.row<_arrWeek.count) {
                [cell refreshBeautyJianGeWeakCell:_arrWeek[indexPath.row]];
            }
            return cell;
        }
            break;
        case 3:
        {
            if (indexPath.row <_arrJishi.count) {
                BeautyChoiseJishiList *model = _arrJishi[indexPath.row];
                [cell reFreshBeautyChoicejishiCell:model];
            }
            return cell;
        }
            break;
        case 4:
        {
            if (indexPath.row <_arrjoincode.count) {
                Join_Code *info = _arrjoincode[indexPath.row];
                [cell refreshWorkChoiceCell:info.name];
            }
            return cell;
        }
            break;
        case 5:
        {
            if (indexPath.row <_arrChoose.count) {
                if (indexPath.row<_arrChoose.count) {
                    [cell refreshWorkChoiceCell:_arrChoose[indexPath.row]];
                }
            }
            return cell;
        }
            break;
        case 6:
        {
            if (indexPath.row <_arrYiGou.count) {
                if (indexPath.row<_arrYiGou.count) {
                    [cell refreshWorkChoiceCell:_arrYiGou[indexPath.row]];
                }
            }
            return cell;
        }
            break;
        case 7:
        {
            if (indexPath.row <_arrGuKe.count) {
                if (indexPath.row<_arrGuKe.count) {
                    [cell refreshWorkChoiceCell:_arrGuKe[indexPath.row]];
                }
            }
            return cell;
        }
            break;
        default:
            break;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (_typeInteger) {
        case 1:
        {
            if (_lastindexPath) {
                BeautyJianGeWeakCell *cell1 = [_tbView1 cellForRowAtIndexPath: _lastindexPath];
                [cell1 refreshBeautyJianGeWeakCellWithSelect:NO];
            }
            BeautyJianGeWeakCell *cell1 = [_tbView1 cellForRowAtIndexPath: indexPath];
            [cell1 refreshBeautyJianGeWeakCellWithSelect:YES];
            _lastindexPath = indexPath;
            if (indexPath.row<_arrJianGe.count) {
                _jianGe = _arrJianGe[indexPath.row];
            }
        }
            break;
        case 2:
        {
            if (_lastindexPath) {
                BeautyJianGeWeakCell *cell1 = [_tbView1 cellForRowAtIndexPath: _lastindexPath];
                [cell1 refreshBeautyJianGeWeakCellWithSelect:NO];
            }
            BeautyJianGeWeakCell *cell1 = [_tbView1 cellForRowAtIndexPath: indexPath];
            [cell1 refreshBeautyJianGeWeakCellWithSelect:YES];
            _lastindexPath = indexPath;
            if (indexPath.row<_arrWeek.count) {
                _week = _arrWeek[indexPath.row];
            }
        }
            break;
        case 3:
        {
            if (_lastindexPath) {
                BeautyJianGeWeakCell *cell1 = [_tbView1 cellForRowAtIndexPath: _lastindexPath];
                 [cell1 refreshBeautyJianGeWeakCellWithSelect:NO];
            }
            BeautyJianGeWeakCell *cell1 = [_tbView1 cellForRowAtIndexPath: indexPath];
             [cell1 refreshBeautyJianGeWeakCellWithSelect:YES];
            _lastindexPath = indexPath;
            if (indexPath.row <_arrJishi.count) {
                BeautyChoiseJishiList *model = _arrJishi[indexPath.row];
                 _jishiModel = model;
            }
        }
            break;
        case 4:
        {
            if (_lastindexPath) {
                BeautyJianGeWeakCell *cell1 = [_tbView1 cellForRowAtIndexPath: _lastindexPath];
                cell1.lb1.textColor = kLabelText_Commen_Color_3;
            }
            BeautyJianGeWeakCell *cell1 = [_tbView1 cellForRowAtIndexPath: indexPath];
            cell1.lb1.textColor = kBtn_Commen_Color;
            if (indexPath.row <_arrjoincode.count) {
                Join_Code *info = _arrjoincode[indexPath.row];
                _pinPaiStr = info.name;
                _selectJoinCode = info;
            }
        }
            break;
        case 5:
        {
            if (_lastindexPath) {
                BeautyJianGeWeakCell *cell1 = [_tbView1 cellForRowAtIndexPath: _lastindexPath];
                cell1.lb1.textColor = kLabelText_Commen_Color_3;
            }
            BeautyJianGeWeakCell *cell1 = [_tbView1 cellForRowAtIndexPath: indexPath];
            cell1.lb1.textColor = kBtn_Commen_Color;
            if (indexPath.row <_arrChoose.count) {
                _choosePaiHang = _arrChoose[indexPath.row];
            }
        }
            break;
        case 6:
        {
            if (_lastindexPath) {
                BeautyJianGeWeakCell *cell1 = [_tbView1 cellForRowAtIndexPath: _lastindexPath];
                cell1.lb1.textColor = kLabelText_Commen_Color_3;
            }
            BeautyJianGeWeakCell *cell1 = [_tbView1 cellForRowAtIndexPath: indexPath];
            cell1.lb1.textColor = kBtn_Commen_Color;
            if (indexPath.row <_arrYiGou.count) {
                _choosePaiHang = _arrYiGou[indexPath.row];
            }
        }
            break;
        case 7:
        {
            if (_lastindexPath) {
                BeautyJianGeWeakCell *cell1 = [_tbView1 cellForRowAtIndexPath: _lastindexPath];
                cell1.lb1.textColor = kLabelText_Commen_Color_3;
            }
            BeautyJianGeWeakCell *cell1 = [_tbView1 cellForRowAtIndexPath: indexPath];
            cell1.lb1.textColor = kBtn_Commen_Color;
            if (indexPath.row <_arrGuKe.count) {
                _chooseLeiBie = _arrGuKe[indexPath.row];
            }
        }
            break;
        default:
            break;
    }
 }
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (_typeInteger) {
        case 1:
        {
            return _arrJianGe.count;
        }
            break;
        case 2:
        {
            return _arrWeek.count;
        }
            break;
        case 3:
        {
            return _arrJishi.count;
        }
            break;
        case 4:
        {
            return _arrjoincode.count;
        }
            break;
        case 5:
        {
            return _arrChoose.count;
        }
            break;
        case 6:
        {
            return _arrYiGou.count;
        }
            break;
        case 7:
        {
            return _arrGuKe.count;
        }
            break;
        default:
            break;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
@end
