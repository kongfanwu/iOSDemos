//
//  LFreezeCell4.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/5.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LFreezeCell4.h"
#import "LSponsorApproceModel.h"
#import <YYWebImage/YYWebImage.h>
#import "UIView+FTCornerdious.h"

@interface LFreezeCell4()
/** <##> */
@property (nonatomic, strong) UIView *bgView;
@end

@implementation LFreezeCell4
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initSubViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = kColorF5F5F5;
    }
    return self;
}
- (void)initSubViews
{
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH - 20, 130)];
    [self.contentView addSubview:_bgView];
    _bgView.backgroundColor = UIColor.whiteColor;
    
    [UIView addRadiusWithView:_bgView roundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    
    
    _lb1 = [[UILabel alloc] init];
    _lb1.font = FONT_BOLD_SIZE(15);
    _lb1.textColor = kLabelText_Commen_Color_3;
    _lb1.text = @"审批人";
    [_lb1 sizeToFit];
    _lb1.frame = CGRectMake(15, 15, _lb1.width, _lb1.height);
    [_bgView addSubview:_lb1];
    
    _lb2 = [[UILabel alloc] init];
    _lb2.font = FONT_BOLD_SIZE(15);
    _lb2.textColor = kLabelText_Commen_Color_6;
    _lb2.textAlignment = NSTextAlignmentCenter;
    [_bgView addSubview:_lb2];
    
    _imgV = [[UIImageView alloc] init];
    _imgV.userInteractionEnabled = YES;
    [_imgV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addApprovl)]];
    [_bgView addSubview:_imgV];
}
- (void)setApprocePersonList:(NSArray *)approcePersonList
{
    _approcePersonList = approcePersonList;
    
    _imgV.frame = CGRectMake(15, _lb1.bottom + 10, 45, 45);
    [_imgV cornerRadius:_imgV.width / 2.f];
    
    LApprocePersonModel * model = approcePersonList[0];
    _approcePersonList = approcePersonList;
    if (approcePersonList.count == 1) {
        _lb2.text = model.name;
        [_lb2 sizeToFit];
        _lb2.frame = CGRectMake(_lb1.left, _imgV.bottom + 10 , _lb2.width, _lb1.height);
        
        [_imgV yy_setImageWithURL:[NSURL URLWithString:model.head_img] placeholder:kDefaultJisImage];
    }else{
        _imgV.image = [UIImage imageNamed:@"stspyytajiantupian"];
    }
}
- (void)addApprovl
{
    if (_approcePersonList.count > 1) {
        if (_LFreezeCell4Block) {
            _LFreezeCell4Block();
        }
    }else{
        [XMHProgressHUD showOnlyText:@"无审批人"];
    }
}
- (void)setModel:(LApprocePersonModel *)model
{
    _model = model;
    _imgV.frame = CGRectMake(15, _lb1.bottom + 10, 45, 45);
    _lb2.text = model.name;
    [_lb2 sizeToFit];
    _lb2.frame = CGRectMake(_lb1.left, _imgV.bottom + 10 , _lb2.width, _lb1.height);
    [_imgV yy_setImageWithURL:[NSURL URLWithString:model.head_img] placeholder:kDefaultJisImage];
    
}
@end
