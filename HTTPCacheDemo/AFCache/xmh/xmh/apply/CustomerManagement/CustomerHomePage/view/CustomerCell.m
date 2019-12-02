//
//  CustomerCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/4.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "CustomerCell.h"
#import "CustomerListModel.h"
#import "CustomerFrameModel.h"
#import <YYWebImage/YYWebImage.h>
#import "MzzProgressView.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
@interface CustomerCell()
//头像
@property (nonatomic,strong)UIImageView *iconUrlImg;
//姓名
@property (nonatomic,weak)UILabel *nameLbl;
//等级
@property (nonatomic,weak)UILabel *levelLbl;
//门店
@property (nonatomic,weak)UILabel *storeLbl;
//技师
@property (nonatomic,weak)UILabel *waiterLbl;
//调至门店
@property (nonatomic,weak)UILabel *toLbl;
//调至门店类型
@property (nonatomic,weak)UILabel *toTypeLbl;
//顾客状态1
@property (nonatomic,weak)UIButton *status1Btn;
//顾客状态2
@property (nonatomic,weak)UIButton *status2Btn;
//顾客状态3
@property (nonatomic,weak)UIButton *status3Btn;
//完善状态
@property(nonatomic,weak)UIButton *btn;

@property (nonatomic ,weak)MzzProgressView *progress;
@property (nonatomic ,strong)UIView *line;
@property (nonatomic ,strong)UIView *bottomLine;
@end

@implementation CustomerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(instancetype)tableView:(UITableView *)tableView CellWithCustomerFrame:(CustomerFrameModel *)CustomerFrame{
    static NSString *ID =@"customCell";
    CustomerCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[CustomerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.customerFrame = CustomerFrame;
    return cell;
}
- (void)setupUI{
    if (_iconUrlImg == nil) {
        UIImageView *iconImageView = [[UIImageView alloc]init];
        iconImageView.layer.cornerRadius = 57/2;
        iconImageView.layer.masksToBounds = YES;
        //       iconImageView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:iconImageView];
        self.iconUrlImg = iconImageView;
    }
    
    if (_nameLbl == nil) {
        UILabel *nameLbl = [[UILabel alloc]init];
        nameLbl.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:nameLbl];
        self.nameLbl=nameLbl;
    }
    
    if (_levelLbl == nil) {
        UILabel *levelLbl = [[UILabel alloc]init];
        levelLbl.font = [UIFont systemFontOfSize:11];
        levelLbl.textColor = [ColorTools colorWithHexString:@"999999"];
        [self.contentView addSubview:levelLbl];
        self.levelLbl=levelLbl;
    }
    
    if (_storeLbl == nil) {
        UILabel *storeLbl = [[UILabel alloc]init];
        storeLbl.font = [UIFont systemFontOfSize:11];
        storeLbl.textColor = [ColorTools colorWithHexString:@"999999"];
        [self.contentView addSubview:storeLbl];
        self.storeLbl=storeLbl;
    }
    
    if (_waiterLbl == nil) {
        UILabel *waiterLbl = [[UILabel alloc]init];
        waiterLbl.textColor = [ColorTools colorWithHexString:@"999999"];
        waiterLbl.font = [UIFont systemFontOfSize:11];
        [self.contentView addSubview:waiterLbl];
        self.waiterLbl=waiterLbl;
    }
    
    if (_toLbl == nil) {
        UILabel *toLbl = [[UILabel alloc]init];
        toLbl.textColor = [ColorTools colorWithHexString:@"999999"];
        toLbl.font = [UIFont systemFontOfSize:11];
        [self.contentView addSubview:toLbl];
        self.toLbl=toLbl;
    }
    
    if (_line == nil) {
        //调至门店添加横线
        _line = [[UIView alloc] initWithFrame:CGRectMake(20, -10, 300, 1)];
        _line.backgroundColor =kSeparatorLineColor;
        _line.hidden  = YES;
        [self.toLbl addSubview:_line];
    }
   
    if (_bottomLine == nil) {
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor =kSeparatorLineColor;
        [self.contentView addSubview:_bottomLine];
    }
    
    if (_toTypeLbl == nil) {
        UILabel *toTypeLbl = [[UILabel alloc]init];
        toTypeLbl.textColor = [ColorTools colorWithHexString:@"999999"];
        toTypeLbl.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:toTypeLbl];
        self.toTypeLbl=toTypeLbl;
    }
    
    if (_status1Btn == nil) {
        UIButton *status1Btn = [[UIButton alloc] init];
        status1Btn.titleLabel .font =[UIFont systemFontOfSize:11];
        [status1Btn setTitle:@"活动" forState:UIControlStateNormal];
        [status1Btn setTitleColor:kLabelText_Commen_Color_6 forState:UIControlStateNormal];
        [status1Btn sizeToFit];
        [self.contentView addSubview:status1Btn];
        self.status1Btn=status1Btn;
    }
    
   
    
    if (_status2Btn == nil) {
        UIButton *status2Btn = [[UIButton alloc] init];
        status2Btn.titleLabel .font =[UIFont systemFontOfSize:11];
        [status2Btn setTitle:@"休眠" forState:UIControlStateNormal];
        [status2Btn setTitleColor:kLabelText_Commen_Color_6 forState:UIControlStateNormal];
        [status2Btn sizeToFit];
        [self.contentView addSubview:status2Btn];
        self.status2Btn=status2Btn;
    }
   
    
    if (_status3Btn == nil) {
        UIButton *status3Btn = [[UIButton alloc] init];
        status3Btn.titleLabel .font =[UIFont systemFontOfSize:11];
        [status3Btn setTitle:@"流失" forState:UIControlStateNormal];
        [status3Btn setTitleColor:kLabelText_Commen_Color_6 forState:UIControlStateNormal];
        [status3Btn sizeToFit];
        [self.contentView addSubview:status3Btn];
        self.status3Btn=status3Btn;
    }
   
    
    if (_btn == nil) {
        UIButton *btn = [[UIButton alloc] init];
        btn.titleLabel .font =[UIFont systemFontOfSize:12];
        [btn setTitle:@"完善资料" forState:UIControlStateNormal];
        [btn setTitleColor:kBtn_Commen_Color forState:UIControlStateNormal];
        [btn sizeToFit];
        [self.contentView addSubview:btn];
        [btn.layer setMasksToBounds:YES];
        [btn.layer setCornerRadius:2.0]; //设置矩形四个圆角半径
        [btn addTarget:self action:@selector(pushController:) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor = [ColorTools colorWithHexString:@"#FEF2F8"];
        self.btn=btn;
    }
    
    if (_progress == nil) {
        MzzProgressView *progress = [[MzzProgressView alloc] init];
        _progress = progress;
        [self.contentView addSubview:progress];
    }
}

- (void)pushController:(UIButton * )btn{
    if (self.btnclick) {
        self.btnclick(btn);
    }
}
-(void)setCustomerFrame:(CustomerFrameModel *)customerFrame{
    _customerFrame = customerFrame;

    [self setupUI];
    //设置frame
    [self settingFrame:customerFrame];
    //设置数据
    [self settingData:_customerFrame.customerModel];
}
-(void)settingData:(CustomerModel *)customerModel{

    [_iconUrlImg yy_setImageWithURL:[NSURL URLWithString:customerModel.headimgurl] placeholder:kDefaultCustomerImage];
    if (customerModel.uname) {
        [_nameLbl setText:[@"姓名：" stringByAppendingString:customerModel.uname]];
    }
    NSString *dengji =  [NSString stringWithFormat:@"等级：%@",customerModel.grade_name];
    
    [_levelLbl setText:dengji] ;
    
    if (customerModel.mdname) {
        [_storeLbl setText:[@"门店：" stringByAppendingString:customerModel.mdname]];
    }
    if (customerModel.jis) {
         [_waiterLbl setText:[@"技师：" stringByAppendingString:customerModel.jis_name]];
    }
   
    if (customerModel.tdname) {
        _line.hidden = NO;
        [_toLbl setText:[@"调至门店：" stringByAppendingString:customerModel.tdname]];
    }
    if (customerModel.tdtype) {
         [_toTypeLbl setText:[@"调店类型：" stringByAppendingString:customerModel.tdtype]];
    }
    if (customerModel.bfb >=0) {
        [_progress setProgress:customerModel.bfb animatied:YES];
    }else{
         [_progress setProgress:0 animatied:YES];
    }
    
}
-(void)settingFrame:(CustomerFrameModel *)frameModel{
    
    _iconUrlImg.frame = frameModel.iconUrlFrame;
    _iconUrlImg.contentMode = UIViewContentModeScaleToFill;
    _nameLbl.frame = frameModel.nameFrame;
    _levelLbl.frame = frameModel.levelFrame;
    _storeLbl.frame = frameModel.storeFrame;
    _waiterLbl.frame = frameModel.waiterFrame;
    _bottomLine.frame = CGRectMake(0, frameModel.rowHeight, SCREEN_WIDTH, 0.5);
    if (frameModel.customerModel.tdname) {
        _toLbl.frame = frameModel.toFrame;
        _toTypeLbl.frame = frameModel.toTypeFrame;
    }
    _status1Btn.frame = CGRectMake(CGRectGetMinX(frameModel.statusFrame), 0, CGRectGetWidth(frameModel.statusFrame)/3, CGRectGetHeight(frameModel.statusFrame));
     _status2Btn.frame = CGRectMake(CGRectGetMaxX(_status1Btn.frame), 0, CGRectGetWidth(frameModel.statusFrame)/3, CGRectGetHeight(frameModel.statusFrame));
     _status3Btn.frame = CGRectMake(CGRectGetMaxX(_status2Btn.frame), 0, CGRectGetWidth(frameModel.statusFrame)/3, CGRectGetHeight(frameModel.statusFrame));
    
    _progress.frame = CGRectMake(CGRectGetMinX(_status1Btn.frame)+ 5 , CGRectGetMaxY(_status3Btn.frame) - 12, 95, 3);
    _btn.frame = frameModel.btnFrame;
}
@end
