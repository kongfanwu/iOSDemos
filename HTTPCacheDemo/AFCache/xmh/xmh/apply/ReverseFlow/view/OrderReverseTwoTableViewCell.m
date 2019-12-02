//
//  OrderReverseTwoTableViewCell.m
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/12/12.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "OrderReverseTwoTableViewCell.h"

@implementation OrderReverseTwoTableViewCell
{
    float totalMoney;

}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.payOneView.layer.borderColor = kIm_Background_Color_c.CGColor;
    self.payOneView.layer.borderWidth =1.0;
    self.payTwoView.layer.borderColor = kIm_Background_Color_c.CGColor;
    self.payTwoView.layer.borderWidth =1.0;
    self.payThreeView.layer.borderColor = kIm_Background_Color_c.CGColor;
    self.payThreeView.layer.borderWidth =1.0;
    self.payFoureView.layer.borderColor = kIm_Background_Color_c.CGColor;
    self.payFoureView.layer.borderWidth =1.0;
    
    _collectField.layer.borderColor = kIm_Background_Color_c.CGColor;
    _collectField.layer.borderWidth =1.0;
    _collectField.delegate = self;
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(payOneView:)];
    //设置手指字数
    tap1.numberOfTouchesRequired = 1;
    [self.payOneView addGestureRecognizer:tap1];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(payTwoView:)];
    //设置手指字数
    tap2.numberOfTouchesRequired = 1;
    [self.payTwoView addGestureRecognizer:tap2];
    
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(payThreeView:)];
    //设置手指字数
    tap3.numberOfTouchesRequired = 1;
    [self.payThreeView addGestureRecognizer:tap3];
    
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(payFoureView:)];
    //设置手指字数
    tap4.numberOfTouchesRequired = 1;
    [self.payFoureView addGestureRecognizer:tap4];
    
}

/**
 点击支付方式模块

 */
-(void)payOneView:(UITapGestureRecognizer *)sender{
    
    if (_OrderReverseTwoCellBlock) {
        _OrderReverseTwoCellBlock(@"8");
    }
}
-(void)payTwoView:(UITapGestureRecognizer *)sender{
    if (_OrderReverseTwoCellBlock) {
        _OrderReverseTwoCellBlock(@"1");
    }
}
-(void)payThreeView:(UITapGestureRecognizer *)sender{
    
    if (_OrderReverseTwoCellBlock) {
        _OrderReverseTwoCellBlock(@"2");
    }
}
-(void)payFoureView:(UITapGestureRecognizer *)sender{
    
    if (_OrderReverseTwoCellBlock) {
        _OrderReverseTwoCellBlock(@"3");
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (_OrderReverseOneCellBlock) {
        _OrderReverseOneCellBlock(textField.text);
    }
}
-(void)updatedata:(NSMutableArray *)array
{
    if (array.count) {
        for (NSDictionary *dic in array) {
            if ([[dic objectForKey:@"type"]isEqualToString:@"8"]) {
                self.payOneLabel.text = [NSString stringWithFormat:@"%@%@",@"￥",[dic objectForKey:@"price"]];
            }else if ([[dic objectForKey:@"type"]isEqualToString:@"1"]){
                self.payTwoLabel.text = [NSString stringWithFormat:@"%@%@",@"￥",[dic objectForKey:@"price"]];
            }else if ([[dic objectForKey:@"type"]isEqualToString:@"2"]){
                self.payThreeLabel.text = [NSString stringWithFormat:@"%@%@",@"￥",[dic objectForKey:@"price"]];
            }else{
                self.payFoureLabel.text = [NSString stringWithFormat:@"%@%@",@"￥",[dic objectForKey:@"price"]];
            }
            totalMoney += [[dic objectForKey:@"price"]floatValue];
        }
        self.collectField.text = [NSString stringWithFormat:@"%.2f",totalMoney];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
