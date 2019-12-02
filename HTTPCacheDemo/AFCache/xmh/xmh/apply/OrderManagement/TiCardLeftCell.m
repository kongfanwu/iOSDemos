//
//  TiCardLeftCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/13.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "TiCardLeftCell.h"
#import "TiCardSubCell.h"

@implementation TiCardLeftCell{
    SLTi_CardModel *_model;
    NSArray *_arrstored_card;
    NSArray *_arrcard_num;
    NSArray *_arrcard_time;
    
    TiCardType _type;
    
    NSMutableArray *_lbArr;
    
    SLCard_Num *_selectCard_num_model;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}
- (void)freshTiCardLeftCell:(SLTi_CardModel *)model{
    
    _model = model;
    _arrstored_card = model.stored_card;
    _arrcard_num = model.card_num;
    _arrcard_time = model.card_time;
    
    if (_indexArr.count==0) {
        for (int i = 0; i < _arrstored_card.count + _arrcard_num.count + _arrcard_time.count; i ++) {
            [_indexArr addObject:@"no"];
        }
    }
    
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
    if (indexPath.row < _arrstored_card.count) {
        SLStored_Card *SLStored_Cardmodel = _arrstored_card[indexPath.row];
        cell.lbtitle.text = SLStored_Cardmodel.name;
        cell.btn1.tag = indexPath.row;
        cell.btn2.tag = indexPath.row;
        cell.btn3.tag = indexPath.row;
        cell.lb2.tag = indexPath.row+1000;
        cell.lb3.tag = indexPath.row+2000;
        [_lbArr addObject:cell.lb2];
        [_lbArr addObject:cell.lb3];
        [cell.btn1 addTarget:self action:@selector(SLStored_Cardbtn1Event:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btn2 addTarget:self action:@selector(SLStored_Cardbtn2Event:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btn3 addTarget:self action:@selector(SLStored_Cardbtn3Event:) forControlEvents:UIControlEventTouchUpInside];
        
        [self toShowCell:cell andWithIndexPath:indexPath];
        
        
    }else if ((_arrstored_card.count <= indexPath.row) && (indexPath.row < (_arrstored_card.count + _arrcard_num.count))){
        SLCard_Num *SLCard_Nummodel = _arrcard_num[indexPath.row - _arrstored_card.count];
        cell.lbtitle.text = SLCard_Nummodel.name;
        if (SLCard_Nummodel.selected) {
             cell.lbtitle.textColor = kColorTheme;
        }else{
            cell.lbtitle.textColor = kColor3;
        }
        cell.btn1.tag = indexPath.row;
        cell.btn2.tag = indexPath.row - _arrstored_card.count;
        cell.btn3.tag = indexPath.row - _arrstored_card.count;
        cell.lb2.tag = indexPath.row - _arrstored_card.count+3000;
        cell.lb3.tag = indexPath.row - _arrstored_card.count+4000;
        [_lbArr addObject:cell.lb2];
        [_lbArr addObject:cell.lb3];
        [cell.btn1 addTarget:self action:@selector(SLStored_Numbtn1Event:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btn2 addTarget:self action:@selector(SLCard_Numbtn2Event:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btn3 addTarget:self action:@selector(SLCard_Numbtn3Event:) forControlEvents:UIControlEventTouchUpInside];
        
        [self toShowCell:cell andWithIndexPath:indexPath];
        
        
    }else if (((_arrstored_card.count + _arrcard_num.count) <= indexPath.row) && (indexPath.row) < (_arrstored_card.count + _arrcard_num.count + _arrcard_time.count)){
        SLCard_Time *SLCard_Timemodel = _arrcard_time[indexPath.row - (_arrstored_card.count + _arrcard_num.count)];
        cell.lbtitle.text = SLCard_Timemodel.name;
        cell.btn1.tag = indexPath.row;
        cell.btn2.tag = indexPath.row - (_arrstored_card.count + _arrcard_num.count);
        cell.btn3.tag = indexPath.row - (_arrstored_card.count + _arrcard_num.count);
        cell.lb2.tag = indexPath.row - (_arrstored_card.count + _arrcard_num.count)+5000;
        cell.lb3.tag = indexPath.row - (_arrstored_card.count + _arrcard_num.count)+6000;
        [self toShowCell:cell andWithIndexPath:indexPath];
        
        [_lbArr addObject:cell.lb2];
        [_lbArr addObject:cell.lb3];
        [cell.btn1 addTarget:self action:@selector(SLStored_Timebtn1Event:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btn2 addTarget:self action:@selector(SLCard_Timebtn2Event:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btn3 addTarget:self action:@selector(SLCard_Timebtn3Event:) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;
}
-(void)toShowCell:(TiCardSubCell *)cell andWithIndexPath:(NSIndexPath *)indexPath
{
    NSString *status = _indexArr[indexPath.row];
    if ([status isEqualToString:@"yes"]) {
        cell.btn2.hidden = NO;
        cell.btn3.hidden = NO;
        cell.lb2.hidden = NO;
        cell.lb3.hidden = NO;
    }else{
        cell.btn2.hidden = YES;
        cell.btn3.hidden = YES;
        cell.lb2.hidden = YES;
        cell.lb3.hidden = YES;
    }
}
//点击储值卡
- (void)SLStored_Cardbtn1Event:(UIButton *)sender{
    
    NSString *status = _indexArr[sender.tag];
    if ([status isEqualToString:@"no"]) {
        [_indexArr replaceObjectAtIndex:sender.tag withObject:@"yes"];
    }else{
        [_indexArr replaceObjectAtIndex:sender.tag withObject:@"no"];
    }
    [_tbView reloadData];
    if (_btnShowLeftCellBlock) {
        _btnShowLeftCellBlock(stored_cardType,_indexArr,sender.tag);
    }
}
//点击任务卡
-(void)SLStored_Numbtn1Event:(UIButton *)sender{
    for (int i = 0; i< _arrcard_num.count; i++) {
        SLCard_Num * cardModel = _arrcard_num[i];
        if (sender.tag == i) {
            cardModel.selected = YES;
        }else{
            cardModel.selected = NO;
        }
    }
    
    NSString *status = _indexArr[sender.tag];
    if ([status isEqualToString:@"no"]) {
        [_indexArr replaceObjectAtIndex:sender.tag withObject:@"no"];
    }else{
        [_indexArr replaceObjectAtIndex:sender.tag withObject:@"no"];
    }
    [_tbView reloadData];
    if (_btnShowLeftCellBlock) {
        _btnShowLeftCellBlock(card_numType,_indexArr,sender.tag);
    }
}
//点击时间卡
-(void)SLStored_Timebtn1Event:(UIButton *)sender{
    NSString *status = _indexArr[sender.tag];
    if ([status isEqualToString:@"no"]) {
        [_indexArr replaceObjectAtIndex:sender.tag withObject:@"no"];
    }else{
        [_indexArr replaceObjectAtIndex:sender.tag withObject:@"no"];
    }
    [_tbView reloadData];
    if (_btnShowLeftCellBlock) {
        _btnShowLeftCellBlock(card_timeType,_indexArr,sender.tag);
    }
}
- (void)SLStored_Cardbtn2Event:(UIButton *)sender{
    [self changeBtnTitleColor:sender.tag+1000];
    if (_btnTiCardLeftCellBlock) {
        _btnTiCardLeftCellBlock(stored_cardType,sender.tag,1);
    }
}
- (void)SLStored_Cardbtn3Event:(UIButton *)sender{
    [self changeBtnTitleColor:sender.tag+2000];
    if (_btnTiCardLeftCellBlock) {
        _btnTiCardLeftCellBlock(stored_cardType,sender.tag,2);
    }
}
//
- (void)SLCard_Numbtn2Event:(UIButton *)sender{
    [self changeBtnTitleColor:sender.tag+3000];
    if (_btnTiCardLeftCellBlock) {
        _btnTiCardLeftCellBlock(card_numType,sender.tag,1);
    }
}
- (void)SLCard_Numbtn3Event:(UIButton *)sender{
    [self changeBtnTitleColor:sender.tag+4000];
    if (_btnTiCardLeftCellBlock) {
        _btnTiCardLeftCellBlock(card_numType,sender.tag,2);
    }
}
//
- (void)SLCard_Timebtn2Event:(UIButton *)sender{
    [self changeBtnTitleColor:sender.tag+5000];
    if (_btnTiCardLeftCellBlock) {
        _btnTiCardLeftCellBlock(card_timeType,sender.tag,1);
    }
}
- (void)SLCard_Timebtn3Event:(UIButton *)sender{
    [self changeBtnTitleColor:sender.tag+6000];
    if (_btnTiCardLeftCellBlock) {
        _btnTiCardLeftCellBlock(card_timeType,sender.tag,2);
    }
}
- (void)changeBtnTitleColor:(NSInteger)tag{
    for (UILabel *lb in _lbArr) {
        if (lb.tag== tag) {
            [lb setTextColor:kBtn_Commen_Color];
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
    return (_arrstored_card.count + _arrcard_num.count + _arrcard_time.count);
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *index = _indexArr[indexPath.row];
    if ([index isEqualToString:@"yes"]) {
        return 120;
    }
    return 40;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
