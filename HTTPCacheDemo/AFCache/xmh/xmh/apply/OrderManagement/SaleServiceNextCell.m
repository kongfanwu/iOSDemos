//
//  SaleServiceNextCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/10.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "SaleServiceNextCell.h"
#import "MLJishiSearchModel.h"
@implementation SaleServiceNextCell
{
    NSMutableDictionary * _dict;
    NSIndexPath * _index;
    UIButton * _selectBTN;
    BOOL choose;
    MLJiShiModel * model;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self selectClick:_btn2];
    _btnOne.tag = 10000;
    _btnTwo.tag = 10001;
    _btnThree.tag = 10002;
    _btnFoure.tag = 10003;
}
- (void)setModelDict:(NSMutableDictionary *)modelDict
{
    _modelDict = modelDict;
    _lb1.text = modelDict[@"name"];
    NSString * time = modelDict[@"shichang"];
    if (time.length <=0) {
        _lb4.text = @"0分钟";
    }else{
        _lb4.text = [NSString stringWithFormat:@"%@分钟",time];
    }
    _lb3.text = @"服务技师:";
    _lb3.textColor = kLabelText_Commen_Color_9;
    NSMutableArray * jisArr = modelDict[@"jis"];
    if (jisArr.count) {
        for (int i = 0; i < jisArr.count; i ++) {
            model = jisArr[i];
            if (i ==0) {
                _lb8.text = model.name;
                _lb9.hidden = YES;
                _lb10.hidden = YES;
                _lb11.hidden = YES;
                _btnTwo.hidden=YES;
                _btnThree.hidden=YES;
                _btnFoure.hidden=YES;
                _addConstraint.constant = 8;
            }
            if (i ==1) {
                _lb9.hidden = NO;
                _btnTwo.hidden=NO;
                _lb10.hidden = YES;
                _btnThree.hidden=YES;
                _lb9.text = model.name;
                _lb11.hidden=YES;
                _btnFoure.hidden=YES;
                _addConstraint.constant = 28+8;
            }
            if (i ==2) {
                _lb10.hidden = NO;
                _btnThree.hidden=NO;
                _lb10.text = model.name;
                _lb11.hidden=YES;
                _btnFoure.hidden=YES;
                _addConstraint.constant = 56+8;
            }
            if (i ==3){
                _lb11.text=model.name;
                _lb11.hidden = NO;
                _btnFoure.hidden=NO;
                _addConstraint.constant = 84+8;
            }
        }
    }else{
        _lb8.hidden=YES;
        _lb9.hidden = YES;
        _lb10.hidden = YES;
        _lb11.hidden = YES;
        _btnOne.hidden=YES;
        _btnTwo.hidden=YES;
        _btnThree.hidden=YES;
        _btnFoure.hidden=YES;
        _addConstraint.constant = -8;
    }
    
    if ([modelDict.allKeys containsObject:@"goods_code"]) {
        _selectBtnContainerView.hidden = NO;
    }else{
        _selectBtnContainerView.hidden = YES;
    }

}
- (IBAction)btnYesEvent:(UIButton *)sender {
    
}
- (IBAction)btnNoEvent:(UIButton *)sender {
    
}

- (IBAction)btnAdd:(UIButton *)sender {
    
    if (_btnSaleServiceNextBlock) {
        _btnSaleServiceNextBlock(_modelDict);
    }

}
- (IBAction)btnDel:(UIButton *)sender { 
    if (_btnSaleServiceNextDelBlock) {
        _btnSaleServiceNextDelBlock();
    }
}
//删除技师
- (IBAction)btnDelJis:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if (_btntDeljisBlock) {
        _btntDeljisBlock(btn.tag,_modelDict);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)selectClick:(UIButton *)sender {
    _selectBTN.selected = NO;
    sender.selected = YES;
    _selectBTN = sender;
    NSLog(@"%@",_selectBTN.titleLabel.text);
    if ([_selectBTN.titleLabel.text isEqualToString:@"是"]) {
        [_modelDict setObject:@(1) forKey:@"is_end"];
    }else{
        [_modelDict setObject:@(0) forKey:@"is_end"];
    }
}

@end
