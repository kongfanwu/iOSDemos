//
//  XMHOrderListBaseCell.m
//  xmh
//
//  Created by shendengmeiye on 2019/3/8.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHOrderListBaseCell.h"

@interface XMHOrderListBaseCell ()
@property (nonatomic, copy)NSString *title;
@property (nonatomic, assign)BOOL isSale;
@end

@implementation XMHOrderListBaseCell
- (IBAction)firstBtnClick:(id)sender {

    if (_firstBtnClickBlock) {
        UIButton *btn = sender;
        _firstBtnClickBlock(btn.titleLabel.text);
    }
}
- (IBAction)seconBtnClick:(id)sender {
    if (_seconBtnClickBlock) {
        UIButton *btn = sender;
        _seconBtnClickBlock(btn.titleLabel.text);
    }
}
- (IBAction)threeBtnClick:(id)sender {
    if (_threeBtnClickBlock) {
         UIButton *btn = sender;
        _threeBtnClickBlock(btn.titleLabel.text);
    }
}
- (IBAction)fourBtnClick:(id)sender {
    if (_fourBtnClickBlock) {
        UIButton *btn = sender;
        _fourBtnClickBlock(btn.titleLabel.text);
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.bgView.layer.cornerRadius = 5;
    self.backgroundColor =  kBackgroundColor;
    self.firstBtn.layer.cornerRadius = self.seconBtn.layer.cornerRadius = self.threeBtn.layer.cornerRadius =self.fourBtn.layer.cornerRadius =4;
    self.firstBtn.layer.borderWidth = self.seconBtn.layer.borderWidth = self.threeBtn.layer.borderWidth = self.fourBtn.layer.borderWidth = 1;
    self.firstBtn.layer.borderColor = self.seconBtn.layer.borderColor =  self.threeBtn.layer.borderColor = self.fourBtn.layer.borderColor =kBtn_Commen_Color.CGColor;
    
    [self.threeBtn setTitleColor:kBtn_Commen_Color forState:UIControlStateNormal];
    [self.seconBtn setTitleColor:kBtn_Commen_Color forState:UIControlStateNormal];
    [self.firstBtn setTitleColor:kBtn_Commen_Color forState:UIControlStateNormal];
    [self.fourBtn setTitleColor:kBtn_Commen_Color forState:UIControlStateNormal];
    self.segmentLab.textColor = kBackgroundColor_FF9072;
    
}

- (void)refreshBaseCellSeverModel:(XMHOrderSeverModel *)model orderType:(NSInteger)orderType
{
     // zt :  列表状态： 0全部，1待结算，2已结算，3已完成
     //  主角色 - 1管理层，2财务人员，3店经理，4技术店长，5销售店长，6售前店长，7前台，8售后美容师，9售前美容师，10售中美容师，11导购
    NSInteger role = [ShareWorkInstance shareInstance].share_join_code.framework_function_main_role;
    self.isSale = NO;
//    self.type = model.zt_name;
    self.segmentLab.text = model.zt_name;
    self.segmentLab.textColor = kPortraitCellTitle_9072;
    self.orderTypeLab.text = [NSString stringWithFormat:@"开单类型:  %@",model.type_name];
    self.nameLab.text = [NSString stringWithFormat:@"%@:  %@",model.user_name,model.mobile];
    self.orderPesonLab.text = [NSString stringWithFormat:@"开单人:  %@",model.inper_name];
    self.moneyLab.text = [NSString stringWithFormat:@"金额:  %@",model.z_price];
    self.proLab.text = [NSString stringWithFormat:@"项目名称:  %@",[XMHOrderListBaseCell proNameStr:model]];
    self.createTimeLab.text = [NSString stringWithFormat:@"下单时间:  %@",model.stime];
 
    if (role == 11) {//导购什么按钮都不能看到
        self.firstBtn.hidden = YES;
        self.seconBtn.hidden = YES;
        self.threeBtn.hidden = YES;
        self.fourBtn.hidden = YES;
        return;
    }
    if ([model.zt integerValue] == 2) {//已结算
        [self.firstBtn setTitle:@"账单" forState:UIControlStateNormal];
        [self.seconBtn setTitle:@"补齐业绩" forState:UIControlStateNormal];
        [self.threeBtn setTitle:@"服务记录" forState:UIControlStateNormal];
        self.firstBtn.hidden = NO;
        self.seconBtn.hidden = NO;
        self.threeBtn.hidden = NO;

        if (role == 1 ||
            role == 11 ||
            role == 3) {
            self.threeBtn.hidden = YES;
            [self.seconBtn setTitle:@"服务记录" forState:UIControlStateNormal];
        }
    }else if ([model.zt integerValue] == 1){//待结算
        [self.firstBtn setTitle:@"账单" forState:UIControlStateNormal];
        [self.seconBtn setTitle:@"撤销" forState:UIControlStateNormal];
        [self.threeBtn setTitle:@"结算" forState:UIControlStateNormal];
        [self.fourBtn setTitle:@"服务记录" forState:UIControlStateNormal];
        self.firstBtn.hidden = NO;
        if (role == 1 || role == 11) {
            self.seconBtn.hidden = NO;
            self.threeBtn.hidden = YES;
            self.fourBtn.hidden = YES;
            [self.seconBtn setTitle:@"服务记录" forState:UIControlStateNormal];
        }
        if (role == 3 || role == 7) {
            self.seconBtn.hidden = NO;
            self.threeBtn.hidden = NO;
            self.fourBtn.hidden = NO;
        }else{
            self.seconBtn.hidden = NO;
            self.threeBtn.hidden = NO;
            self.fourBtn.hidden = YES;
            [self.threeBtn setTitle:@"服务记录" forState:UIControlStateNormal];
        }
        
    }else if ([model.zt integerValue] == 3){//已完成
        [self.firstBtn setTitle:@"账单" forState:UIControlStateNormal];
        [self.seconBtn setTitle:@"服务记录" forState:UIControlStateNormal];
        self.firstBtn.hidden = NO;
        self.seconBtn.hidden = NO;
    }
}
- (void)refreshBaseCellSaleModel:(XMHOrderSaleModel *)model orderType:(NSInteger)orderType
{
    //销售凭证列表状态：0=>'全部' 1=>'待付款',10=>'已收款',5=>'未付清','6'=>'已完成'
    //  主角色 - 1管理层，2财务人员，3店经理，4技术店长，5销售店长，6售前店长，7前台，8售后美容师，9售前美容师，10售中美容师，11导购
    NSInteger role = [ShareWorkInstance shareInstance].share_join_code.framework_function_main_role;
    self.isSale = YES;
//    self.type = model.order_type_name;
    self.segmentLab.text = model.order_type_name;
    self.nameLab.text = [NSString stringWithFormat:@"%@:  %@",model.user_name,model.user_mobile];
    self.orderTypeLab.text = [NSString stringWithFormat:@"开单类型:  %@",model.type_name];
    self.orderPesonLab.text = [NSString stringWithFormat:@"开单人:  %@",model.saler];
//    self.moneyLab.text = [NSString stringWithFormat:@"实付金额:  ￥%@",model.heji];
    self.moneyLab.text = [NSString stringWithFormat:@"实付金额:  ￥%@",model.amount];
    self.proLab.text = [NSString stringWithFormat:@"下单时间:  %@",model.insert_time];
    self.createTimeLab.hidden = YES;
    
    if (role == 11) {//导购什么按钮都不能看到
        self.firstBtn.hidden = YES;
        self.seconBtn.hidden = YES;
        self.threeBtn.hidden = YES;
        self.fourBtn.hidden = YES;
        return;
    }
    
    if ([model.order_type_name isEqualToString:@"待付款"]) {//
        [self.firstBtn setTitle:@"账单" forState:UIControlStateNormal];
        [self.seconBtn setTitle:@"结算" forState:UIControlStateNormal];
        [self.threeBtn setTitle:@"撤销" forState:UIControlStateNormal];
        self.firstBtn.hidden = NO;
       
        if (role == 7 ||role == 3 ) { //三个按钮都可以看到
            self.seconBtn.hidden = NO;
            self.threeBtn.hidden = NO;
        }else{//只能看到账单、撤销
             self.seconBtn.hidden = NO;
             self.threeBtn.hidden = YES;
             [self.seconBtn setTitle:@"撤销" forState:UIControlStateNormal];
        }
         self.moneyLab.text = [NSString stringWithFormat:@"应付金额:  ￥%@",model.heji];
    }else if ([model.order_type_name isEqualToString:@"已收款"]){//
        [self.firstBtn setTitle:@"账单" forState:UIControlStateNormal];
        self.firstBtn.hidden = NO;
        /* 1、role=1,3不能看到补齐业绩和补齐项目
           2、只有role = 7能看到补齐项目
         */
        if (role == 1 || role == 3) {
            self.seconBtn.hidden = YES;
        }else{
            self.seconBtn.hidden = NO;
            if (model.order_type == 10 ) {//,10=>'已收款未补齐项目',11=>'已收款未补齐业绩
                if (role == 7) {
                    [self.seconBtn setTitle:@"补齐项目" forState:UIControlStateNormal];
                }
            }else if (model.order_type == 11){
                 [self.seconBtn setTitle:@"补齐业绩" forState:UIControlStateNormal];
            }
        }
        
    }else if ([model.order_type_name isEqualToString:@"未还清"]){//
        [self.firstBtn setTitle:@"账单" forState:UIControlStateNormal];
        [self.seconBtn setTitle:@"还款" forState:UIControlStateNormal];
        [self.threeBtn setTitle:@"终止" forState:UIControlStateNormal];
        self.firstBtn.hidden = NO;
       
        
        if (role == 3 || role == 7) { //可以看到还款按钮
            self.seconBtn.hidden = NO;
            self.threeBtn.hidden = NO;
        }else{//只能看到账单、撤销
            self.seconBtn.hidden = YES;
            self.threeBtn.hidden = YES;
        }
        self.moneyLab.text = [NSString stringWithFormat:@"应付金额:  ￥%@",model.heji];
        self.proLab.text = [NSString stringWithFormat:@"实付金额:  %@",model.amount];
        self.createTimeLab.text = [NSString stringWithFormat:@"下单时间:  %@",model.insert_time];
        self.createTimeLab.hidden = NO;
    }else if ([model.order_type_name isEqualToString:@"已完成"]){//
        [self.firstBtn setTitle:@"账单" forState:UIControlStateNormal];
        self.firstBtn.hidden = NO;
    }
    
   
}
/**
 重置cell
 */
- (void)resetCell
{
    self.nameLab.text = nil;
    self.orderPesonLab.text = nil;
    self.moneyLab.text = nil;
    self.proLab.text = nil;
    self.createTimeLab.text = nil;
    self.segmentLab.text = nil;
    self.orderTypeLab.text = nil;
    self.firstBtn.hidden = YES;
    self.seconBtn.hidden = YES;
    self.threeBtn.hidden = YES;
    self.fourBtn.hidden = YES;
    
}
+ (NSString *)proNameStr:(XMHOrderSeverModel *)model {
    NSMutableString *str = NSMutableString.new;
    [model.pro_list enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == model.pro_list.count - 1 && IsEmpty(model.goods_list)) {
            [str appendFormat:@"%@", obj];
        } else {
            [str appendFormat:@"%@、", obj];
        }
    }];
    
    [model.goods_list enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == model.goods_list.count - 1) {
            [str appendFormat:@"%@", obj];
        } else {
            [str appendFormat:@"%@、", obj];
        }
    }];
    return str;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
