//
//  XMHAwardContentCell.m
//  xmh
//
//  Created by shendengmeiye on 2019/4/1.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHAwardContentCell.h"
#import "SASaleListModel.h"
@interface XMHAwardContentCell ()
@property (nonatomic, strong)UIButton *selectBtn;
@property (nonatomic, strong)UILabel *nameLab;
@property (nonatomic, strong)SaleModel *model;
@property (nonatomic, strong)UIImageView *selectView;
@end
@implementation XMHAwardContentCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        // 初始化子视图
        [self initLayout];
    }
    return self;
    
}
- (void)initLayout
{
    self.selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:self.selectBtn];
    [self.selectBtn addTarget:self action:@selector(selectBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self.contentView);
    }];
    
    self.selectView = [[UIImageView alloc]init];
    [self.selectView setImage:[UIImage imageNamed:@"stgkgl_danxuanweixuan"]];
    [self.contentView addSubview:self.selectView];
    [self.selectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(15, 15));
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(kMargin);
    }];
    
    self.nameLab = [[UILabel alloc]init];
//    self.nameLab.adjustsFontSizeToFitWidth
    self.nameLab.textColor = kLabelText_Commen_Color_6;
    self.nameLab.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.nameLab];
     [self.nameLab sizeToFit];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(self.selectView.mas_right).mas_offset(kMargin);
        make.right.mas_equalTo(self.contentView.mas_right);
    }];
   
    
}
- (void)refreshCellModel:(SaleModel *)model;
{
    _model = model;
    self.nameLab.text = model.name;
    BOOL selected = model.isBaoHan;
    if (selected) {
        [self.selectView setImage:[UIImage imageNamed:@"stgkgl_danxuan"]];
    }else{
        [self.selectView setImage:[UIImage imageNamed:@"stgkgl_danxuanweixuan"]];
    }
    self.selectBtn.selected = selected;
   
}

- (void)selectBtnClick
{
    self.model.isBaoHan = ! self.model.isBaoHan;
    WeakSelf
    if (_selectedAwardType) {
        _selectedAwardType(weakSelf.model);
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
   
    // Configure the view for the selected state
}

@end
