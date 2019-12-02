//
//  YiGouRenXuanCell.m
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/5/24.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "YiGouRenXuanCell.h"

@implementation YiGouRenXuanCell{
    SAZhiHuanPorModel *_SAZhiHuanPorModel;
    BOOL ifChuzhi;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)freshYiGouRenXuanCell:(SAZhiHuanPorModel *)model withIfChuZhi:(BOOL)ifChuZhi{
    _lbTitle.text = model.name;
    _lbTitle.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchLbTitle:)];
    //设置手指字数
    tap.numberOfTouchesRequired = 1;
    [_lbTitle addGestureRecognizer:tap];
    
    _lb2.text = [NSString stringWithFormat:@"%@",@(model.money)];
    _SAZhiHuanPorModel = model;
    ifChuzhi = ifChuZhi;
    _btnShop.layer.borderWidth = 1;
    _btnShop.layer.cornerRadius = 15;
    _btnShop.layer.borderColor = [kBtn_Commen_Color CGColor];
    
    _btnQuanBu.layer.borderWidth = 1;
    _btnQuanBu.layer.cornerRadius = 15;
    _btnQuanBu.layer.borderColor = [kBackgroundColor CGColor];
    
    if (model.isShow) {
        _btnReduce.hidden = NO;
        _lbnum.hidden = NO;
        _btnAdd.hidden = NO;
        if (ifChuZhi) {
            _lb3.hidden = YES;
            _lb4.hidden = YES;
            _lb5.hidden = YES;
            _lb6.hidden = YES;
            _btnReduce.hidden = YES;
            _lbnum.hidden = YES;
            _btnAdd.hidden = YES;
            _btnQuanBu.hidden = YES;
            _lb15.hidden = YES;
            _texF15.hidden = NO;
            _texF15.delegate = self;
            _texF15.text = model.totalPrice = [NSString stringWithFormat:@"%@",@(model.money)];
        }else{
            _lb3.hidden = NO;
            _lb4.hidden = NO;
            _lb5.hidden = NO;
            _lb6.hidden = NO;
            _texF15.hidden = YES;
            _lb15.hidden = NO;
            if (model.isQuanBuHuiShou) {
                _lb15.text = model.totalPrice = [NSString stringWithFormat:@"%@",@(model.money)];
            } else {
                model.totalPrice =[NSString stringWithFormat:@"%@",@(model.numDisPlay * model.price)];
                _lb15.text = model.totalPrice;
            }
        }
        if (model.show_jz == 0) {
            _lb11.hidden = YES;
            _btn1.hidden = YES;
            _lb12.hidden = YES;
            _btn2.hidden = YES;
            _lb13.hidden = YES;
            self.hsToBotemConstraint.constant = 70;
        }else{
            _lb11.hidden = NO;
            _btn1.hidden = NO;
            _lb12.hidden = NO;
            _btn2.hidden = NO;
            _lb13.hidden = NO;
            self.hsToBotemConstraint.constant = 50;
        }
        _lb14.hidden = NO;
        _lb15.hidden = NO;
        _btnShop.hidden = NO;
        _btnShop.hidden = NO;
        _lb4.text = [NSString stringWithFormat:@"%@",@(model.nums)];
        _lb6.text = [NSString stringWithFormat:@"%@",@(model.y_price)];
        _lbnum.text = [NSString stringWithFormat:@"%@",@(model.numDisPlay)];
        
        if (model.isHuiShou) {
            _btn1.selected = YES;
            _btn2.selected = NO;
        } else {
            _btn1.selected = NO;
            _btn2.selected = YES;
        }
    } else {
        _btnReduce.hidden = YES;
        _lbnum.hidden = YES;
        _btnAdd.hidden = YES;
        _lb3.hidden = YES;
        _lb4.hidden = YES;
        _lb5.hidden = YES;
        _lb6.hidden = YES;
        
        _lb11.hidden = YES;
        _btn1.hidden = YES;
        _lb12.hidden = YES;
        _btn2.hidden = YES;
        _lb13.hidden = YES;
        _lb14.hidden = YES;
        _lb15.hidden = YES;
        _btnShop.hidden = YES;
        _btnQuanBu.hidden = YES;
        _texF15.hidden = YES;
    }
    [_btnMore addTarget:self action:@selector(btnMoreYiGouRenXuanEvent) forControlEvents:UIControlEventTouchUpInside];
    [_btnReduce addTarget:self action:@selector(btnReduceEvent) forControlEvents:UIControlEventTouchUpInside];
    [_btnAdd addTarget:self action:@selector(btnAddEvent) forControlEvents:UIControlEventTouchUpInside];
    [_btnQuanBu addTarget:self action:@selector(btnQuanBuEvent) forControlEvents:UIControlEventTouchUpInside];
    [_btnShop addTarget:self action:@selector(btnYiGouRenXuanCellEvent) forControlEvents:UIControlEventTouchUpInside];
}
//点击标题手势
-(void)touchLbTitle:(UITapGestureRecognizer *)sender{
    _SAZhiHuanPorModel.isShow = !_SAZhiHuanPorModel.isShow;
    if (_btnMoreYiGouRenXuanCellBlock) {
        _btnMoreYiGouRenXuanCellBlock(_SAZhiHuanPorModel);
    }
}
- (void)btnQuanBuEvent{
    _SAZhiHuanPorModel.numDisPlay =_SAZhiHuanPorModel.nums;
    if (_btnQuanBuYiGouRenXuanCellBlock) {
        _btnQuanBuYiGouRenXuanCellBlock(_SAZhiHuanPorModel);
    }
}
- (void)btnMoreYiGouRenXuanEvent{
    _SAZhiHuanPorModel.isShow = !_SAZhiHuanPorModel.isShow;
    if (_btnMoreYiGouRenXuanCellBlock) {
        _btnMoreYiGouRenXuanCellBlock(_SAZhiHuanPorModel);
    }
}
- (void)btnReduceEvent{
    if (_SAZhiHuanPorModel.numDisPlay > 0) {
        _SAZhiHuanPorModel.numDisPlay --;
    }
    if (_btnReduceYiGouRenXuanCellBlock) {
        _btnReduceYiGouRenXuanCellBlock(_SAZhiHuanPorModel,1);
    }
}
- (void)btnAddEvent{
    if (_SAZhiHuanPorModel.numDisPlay >=_SAZhiHuanPorModel.nums) {
        [MzzHud toastWithTitle:@"温馨提示" message:@"已选到最大次数"];
        return;
    }
    _SAZhiHuanPorModel.numDisPlay ++;
    if (_btnReduceYiGouRenXuanCellBlock) {
        _btnReduceYiGouRenXuanCellBlock(_SAZhiHuanPorModel,2);
    }
}
- (void)btnYiGouRenXuanCellEvent{
    if (ifChuzhi) {
        _SAZhiHuanPorModel.numDisPlay = 1;
    }
    if (_btnShopYiGouRenXuanCellBlock) {
        _btnShopYiGouRenXuanCellBlock(_SAZhiHuanPorModel);
    }
}
- (IBAction)btn1Event:(UIButton *)sender {
    _SAZhiHuanPorModel.isHuiShou = YES;
    _btn1.selected = YES;
    _btn2.selected = NO;
}
- (IBAction)btn2Event:(UIButton *)sender {
    _SAZhiHuanPorModel.isHuiShou = NO;
    _btn1.selected = NO;
    _btn2.selected = YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    _texF15.text = textField.text;
    _SAZhiHuanPorModel.totalPrice = [NSString stringWithFormat:@"%@",_texF15.text];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
