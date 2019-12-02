//
//  GKGLAddCustomerCell.m
//  xmh
//
//  Created by ald_ios on 2019/1/8.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "GKGLAddCustomerCell.h"
#import "GKGLCellModel.h"
@interface GKGLAddCustomerCell ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UITextField *tfValue;
@property (weak, nonatomic) IBOutlet UIImageView *imgMore;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tfValueR;

@end
@implementation GKGLAddCustomerCell
{
    GKGLCellModel * _model;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _tfValue.delegate = self;
}
- (void)updateGKGLAddCustomerCellModel:(GKGLCellModel *)model
{
    _model = model;
    _lbName.text = model.title;
    _tfValue.placeholder = model.placeHolder;
    _tfValue.text = model.value;
    if (model.cellType == CellTypeInput) {
        _imgMore.hidden = YES;
    }else{
        _tfValue.userInteractionEnabled = NO;
    }
    if ([model.title isEqualToString:@"手机号："]) {
        _tfValue.keyboardType = UIKeyboardTypeNumberPad;
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    _model.value = textField.text;
    if (_GKGLAddCustomerCellBlock) {
        _GKGLAddCustomerCellBlock(_model);
    }
}
- (void)updateCellCustomerInfoParam:(NSDictionary *)param indexPath:(NSIndexPath *)indexPath
{
    _imgMore.hidden = YES;
    _tfValueR.constant = 0;
    _tfValue.textColor = kColor6;
    NSString * defaultStr = @"------";
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:{
                _lbName.text = @"顾客姓名：";
                _tfValue.text = [param[@"name"] length] > 0?param[@"name"]:defaultStr;
            }
                
                break;
            case 1:{
                _lbName.text = @"手机号：";
                _tfValue.text = [param[@"mobile"] length] > 0?param[@"mobile"]:defaultStr;
            }
                
                break;
            case 2:{
                _lbName.text = @"顾客属性：";
                if ([param[@"imp"] integerValue] == 1) {
                    _tfValue.text = @"已有卡项顾客";
                }else if ([param[@"imp"] integerValue] == 0){
                    _tfValue.text = @"未导入数据新顾客";
                }else{}
                
            }
                
                break;
            case 3:{
                _lbName.text = @"所属门店：";
                _tfValue.text = [param[@"store_name"] length] > 0?param[@"store_name"]:defaultStr;
            }
                
                break;
            case 4:{
                _lbName.text = @"归属技师：";
                _tfValue.text = [param[@"jis_name"] length] > 0?param[@"jis_name"]:defaultStr;
            }
                
                break;
            case 5:{
                _lbName.text = @"最后到店：";
                _tfValue.text = [param[@"last_fw_time"] length] > 0?param[@"last_fw_time"]:defaultStr;
            }
                
                break;
            default:
                break;
        }
    }else if (indexPath.section == 1){
        _tfValue.userInteractionEnabled = NO;
        switch (indexPath.row) {
            case 0:{
                _lbName.text = @"微信号：";
                _tfValue.text = [param[@"wx"] length] > 0?param[@"wx"]:defaultStr;
            }
                
                break;
            case 1:{
                _lbName.text = @"生日：";
                _tfValue.text = [param[@"birthday"] length] > 0?param[@"birthday"]:defaultStr;
            }
                
            default:
                break;
        }
    }else if (indexPath.section == 2){
        _tfValue.userInteractionEnabled = NO;
        switch (indexPath.row) {
            case 0:{
                _lbName.text = @"会员等级：";
                _tfValue.text = [param[@"grade_name"] length] > 0?param[@"grade_name"]:defaultStr;
            }
                
                break;
            case 1:{
                _lbName.text = @"归属导购：";
                _tfValue.text = [param[@"dao_name"] length] > 0?param[@"dao"]:defaultStr;
            }
                
                break;
            case 2:{
                _lbName.text = @"进店时间：";
                _tfValue.text = [param[@"jd_time"] length] > 0?param[@"jd_time"]:defaultStr;
            }
                
                break;
            case 3:{
                _lbName.text = @"最后消费：";
                _tfValue.text = [param[@"last_shop_time"] length] > 0?param[@"last_shop_time"]:defaultStr;
            }
                
                break;
            default:
                break;
        }
    }else if (indexPath.section == 3){
        switch (indexPath.row) {
            case 0:{
                _lbName.text = @"现住地区：";
                _tfValue.text = [param[@"area_name"] length] > 0?param[@"area_name"]:defaultStr;
            }
                
                break;
            case 1:{
                _lbName.text = @"详细地址：";
                _tfValue.text = [param[@"address"] length] > 0?param[@"address"]:defaultStr;
            }
                
                break;
            case 2:{
                _lbName.text = @"工作单位：";
                _tfValue.text = [param[@"company"] length] > 0?param[@"company"]:defaultStr;
            }
                
                break;
            case 3:{
                _lbName.text = @"担任职务：";
                _tfValue.text = [param[@"post"] length] > 0?param[@"post"]:defaultStr;
            }
                
                break;
            default:
                break;
        }
    }else{}
}
@end
