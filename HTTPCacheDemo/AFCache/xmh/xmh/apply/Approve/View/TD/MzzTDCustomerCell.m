//
//  MzzTDCustomerCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/2.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MzzTDCustomerCell.h"
#import <YYWebImage/YYWebImage.h>
@interface MzzTDCustomerCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImg;
//@property (weak, nonatomic) IBOutlet UIImageView *selectImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (strong, nonatomic)SPStoreUserModel *model;
@property (strong ,nonatomic)SPUserModel *umodel;
@end
@implementation MzzTDCustomerCell
{
    SPUserModel *_selectumodel;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    [self.contentView setBackgroundColor:[UIColor redColor]];
    _iconImg.layer.cornerRadius = 45 / 2.f;
    _iconImg.layer.masksToBounds = YES;
    [_iconImg setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click)];
    [_iconImg addGestureRecognizer:tap];
    
}
-(void)setData:(SPStoreUserModel *)model{
    _model = model;
    [_nameLbl setText:model.name];
    [_iconImg yy_setImageWithURL:[NSURL URLWithString:model.headimgurl] placeholder:kDefaultCustomerImage];
    [_selectImg setHidden:!model.isSelected];
}

- (void)click{
    _model.isSelected = !_model.isSelected;
    _umodel.isSelected = !_umodel.isSelected;
    if (_model) {
        [_selectImg setHidden:!_selectImg.hidden];
    }
    if (_umodel) {
//        _selectumodel.isSelected = NO;
//        _umodel.isSelected = YES;
//        _selectumodel = _umodel;
         [_selectImg setHidden:!_umodel.isSelected];
        if (_MzzTDCustomerCellBlock) {
            _MzzTDCustomerCellBlock(_selectImg,_umodel);
        }
        
    }
  
}

-(void)setBillData:(SPUserModel *)model{
    _umodel = model;
    [_nameLbl setText:model.name];
    [_iconImg yy_setImageWithURL:[NSURL URLWithString:model.headimgurl] placeholder:kDefaultCustomerImage];
    [_selectImg setHidden:!model.isSelected];
}
@end
