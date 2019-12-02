//
//  XMHCouponCell.m
//  xmh
//
//  Created by shendengmeiye on 2019/3/27.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHCouponCell.h"
#import "SATicketListModel.h"
#import "DateTools.h"
#import "UIButton+EnlargeTouchArea.h"
@interface XMHCouponCell()
@property (nonatomic, strong)UILabel *lab;
@property (nonatomic, strong)UIView *bgView;
@property (nonatomic, strong)UIImageView *bgImageView;
@property (nonatomic, strong)UILabel *nameLab;
@property (nonatomic, strong)UILabel *timeLab;
@property (nonatomic, strong)UILabel *limitLab;
@property (nonatomic, strong)UILabel *priceLab;
@property (nonatomic, strong)UIButton *selectBtn;
@property (nonatomic, strong)UILabel *store;
@property (nonatomic, strong)UIView *labView;
@property (nonatomic, strong)SATicketModel *model;
@property (nonatomic, strong)UIView *contenView;
@end

@implementation XMHCouponCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initSubViews];
    }
    return self;
}

- (void)updateCellModel:(SATicketModel *)model cellType:(NSInteger )tag
{
    self.model = model;
    if (tag == 0) {
//        self.bgView.backgroundColor = [ColorTools colorWithHexString:@"#E92866"];
        self.selectBtn.selected = model.selected;
        [self.selectBtn setImage:[UIImage imageNamed:@"stgkgl_danxuanweixuan"] forState:UIControlStateNormal];
        [self.selectBtn setImage:[UIImage imageNamed:@"stgkgl_danxuan"] forState:UIControlStateSelected];

        
        if (model.type == 1) {
            _lab.text = @"代金券";
            _priceLab.text = [NSString stringWithFormat:@"%@元",model.money];
            [self.bgImageView setImage:[UIImage imageNamed:@"ddglst_piaoquan"]];
        }else if (model.type == 3){
            _lab.text = @"现金券";
            _priceLab.text = [NSString stringWithFormat:@"%@元",model.price];
             [self.bgImageView setImage:[UIImage imageNamed:@"ddglst_xianjinquan"]];
        }else if(model.type == 4) {
            _lab.text = @"折扣券";
            _priceLab.text = [NSString stringWithFormat:@"%@折",model.discount];
           [self.bgImageView setImage:[UIImage imageNamed:@"ddglst_zhekouquan"]];
        }else if (model.type == 5){
            _lab.text = @"礼品券";
            _priceLab.text = model.name;
            [self.bgImageView setImage:[UIImage imageNamed:@"ddglst_lipinquan"]];
            
        }
    }
    if (tag == 1) {
        self.bgView.backgroundColor = kColorC;
        _labView.backgroundColor = _limitLab.textColor = _nameLab.backgroundColor = _priceLab.textColor = _timeLab.textColor = kColorC;
        self.selectBtn.hidden = YES;
        // 更新布局
        
        [self.nameLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contenView.mas_right).mas_offset(-kMargin);
            make.centerY.mas_equalTo(self.priceLab.mas_centerY);
        }];

        [self.store mas_updateConstraints:^(MASConstraintMaker *make) {
           make.right.mas_equalTo(self.contenView.mas_right).mas_offset(-kMargin);
        }];
        
        if (model.type == 1) {
            _lab.text = @"代金券";
            _priceLab.text = [NSString stringWithFormat:@"%@元",model.money];
            [self.bgImageView setImage:[UIImage imageNamed:@"ddglst_piaoquanbukequan"]];
        }else if (model.type == 3){
            _lab.text = @"现金券";
            _priceLab.text = [NSString stringWithFormat:@"%@元",model.price];
            [self.bgImageView setImage:[UIImage imageNamed:@"ddglst_xianjinquanbukeyong"]];
        }else if(model.type == 4) {
            _lab.text = @"折扣券";
            _priceLab.text = [NSString stringWithFormat:@"%@折",model.discount];
            [self.bgImageView setImage:[UIImage imageNamed:@"ddglst_zhekouquanbukeyong"]];
        }else if (model.type == 5){
            _lab.text = @"礼品券";
            _priceLab.text = model.name;
            [self.bgImageView setImage:[UIImage imageNamed:@"ddglst_lipiquanbukexuan"]];
            
        }
    }
    
    NSArray *startArr = [model.start_time componentsSeparatedByString:@" "];
    NSString *start = [startArr safeObjectAtIndex:0];
    NSArray *endArr = [model.end_time componentsSeparatedByString:@" "];
    NSString *end = [endArr safeObjectAtIndex:0];
    NSString *title = [NSString stringWithFormat:@"有效期: %@-%@",[start stringByReplacingOccurrencesOfString:@"-" withString:@"."],[end stringByReplacingOccurrencesOfString:@"-" withString:@"."]];
    _timeLab.text = title;
    _nameLab.text = [NSString stringWithFormat:@" %@ ",model.name];
   

}
- (void)initSubViews
{

    self.bgImageView = [[UIImageView alloc]init];
    self.bgImageView.image = [UIImage imageNamed:@"youhuiquan_zhekouquan"];
    [self.contentView addSubview:self.bgImageView];
    self.bgImageView.userInteractionEnabled = YES;
   
//    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(7);
//        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-7);
//        make.top.mas_equalTo(10);
//        make.bottom.mas_equalTo(0);
//    }];
        [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(kMargin);
            make.right.mas_equalTo(self.mas_right).mas_offset(-kMargin);
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-7);
            make.top.mas_equalTo(self.mas_top);
        }];
  
    
//    UIView *labView = [[UIView alloc]init];
//    labView.backgroundColor  = [ColorTools colorWithHexString:@"#FC558B"];
//    [self.contentView addSubview:labView];
//    self.labView = labView;
//    [labView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.bgView.mas_left);
//        make.width.mas_equalTo(55);
//        make.top.bottom.mas_equalTo(self.bgView);
//    }];
//    self.lab = [[UILabel alloc]init];
////    self.lab.text = @"现金券";
//    self.lab.textAlignment = NSTextAlignmentCenter;
//    self.lab.lineBreakMode = NSLineBreakByWordWrapping;//换行模式自动换行
//    self.lab.numberOfLines = 0;
//    self.lab.font = [UIFont systemFontOfSize:22];
//    self.lab.textColor = [UIColor whiteColor];
//    [labView addSubview:self.lab];
//
//    [self.lab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(10);
//        make.width.mas_equalTo(35);
//        make.top.bottom.mas_equalTo(labView);
//    }];
    
    UIView *contenView = [[UIView alloc]init];
    contenView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:contenView];
    [contenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(70);
        make.top.mas_equalTo(self.bgImageView.mas_top).mas_offset(5);
        make.right.mas_equalTo(self.bgImageView.mas_right).mas_offset(-5);
        make.bottom.mas_equalTo(self.bgImageView.mas_bottom).mas_offset(-5);
        
    }];
    self.contenView = contenView;
    self.selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.selectBtn setImage:[UIImage imageNamed:@"stgkgl_danxuanweixuan"] forState:UIControlStateNormal];
    [self.selectBtn setImage:[UIImage imageNamed:@"stgkgl_danxuan"] forState:UIControlStateSelected];
    [contenView addSubview:self.selectBtn];
    [self.selectBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(contenView.mas_right).mas_offset(-kMargin);
        make.width.height.mas_equalTo(15);
        make.centerY.mas_equalTo(contenView.centerY);
    }];
    
    [self.selectBtn setEnlargeEdgeWithTop:100 right:30 bottom:40 left:100];
    
    self.priceLab = [[UILabel alloc]init];
    self.priceLab.textColor = [ColorTools colorWithHexString:@"#FC558B"];
    self.priceLab.font = [UIFont systemFontOfSize:22];
    [contenView addSubview:self.priceLab];
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(contenView.mas_left).mas_offset(kMargin);
        make.top.mas_equalTo(20);
        make.height.mas_equalTo(31);
        make.width.mas_equalTo(100);
    }];
    
    self.nameLab = [[UILabel alloc]init];
    self.nameLab.backgroundColor = [ColorTools colorWithHexString:@"#FC558B"];
    self.nameLab.layer.cornerRadius = 2;
    self.nameLab.maskToBounds = YES;
    self.nameLab.textAlignment = NSTextAlignmentRight;
    self.nameLab.textColor = [UIColor whiteColor];
    [contenView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.selectBtn.mas_left).mas_offset(-kMargin);
        make.centerY.mas_equalTo(self.priceLab.mas_centerY);
    }];
    
    UILabel *store = [[UILabel alloc]init];
    store.text = @"限门店使用";
    store.textAlignment = NSTextAlignmentRight;
    store.textColor = kLabelText_Commen_Color_9;
    store.font = [UIFont systemFontOfSize:12];
    self.store = store;
    [contenView addSubview:self.store];
    [self.store mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(contenView.mas_right).mas_offset(-50);
//        make.bottom.mas_equalTo(-23);
         make.top.mas_equalTo(self.nameLab.mas_bottom).mas_offset(9);
    }];
    [store sizeToFit];
    
    
    self.timeLab = [[UILabel alloc]init];
    self.timeLab.text = @"";
    self.timeLab.textColor = kLabelText_Commen_Color_9;
    self.timeLab.font = [UIFont systemFontOfSize:12];
    [contenView addSubview:self.timeLab];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(store.mas_left).mas_equalTo(-kMargin);
        make.left.mas_equalTo(contenView.mas_left).mas_offset(kMargin);
        make.top.mas_equalTo(self.nameLab.mas_bottom).mas_offset(9);
//        make.bottom.mas_equalTo(-23);
    }];
    
}
- (void)btnClick
{
     self.model.selected = !self.model.selected;
    if (self.selectedDetail) {
        self.selectedDetail(self.model);
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
