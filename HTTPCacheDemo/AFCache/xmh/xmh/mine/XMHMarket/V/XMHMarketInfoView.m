//
//  XMHMarketInfoView.m
//  xmh
//
//  Created by ald_ios on 2019/5/20.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHMarketInfoView.h"
#import <YYWebImage/YYWebImage.h>
#import "XMHMarketModel.h"
@interface XMHMarketInfoView ()
@property (weak, nonatomic) IBOutlet UIImageView *banner;
@property (weak, nonatomic) IBOutlet UILabel *lbTItle;
/** 原价 */
@property (weak, nonatomic) IBOutlet UILabel *lbYprice;
/** 现价 */
@property (weak, nonatomic) IBOutlet UILabel *lbXprice;
@property (weak, nonatomic) IBOutlet UIImageView *qCode;
@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet UIView *qybContainer;
@property (weak, nonatomic) IBOutlet UILabel *qybTitle;
@property (weak, nonatomic) IBOutlet UILabel *qybName;
@property (weak, nonatomic) IBOutlet UILabel *qybYear;
@property (strong, nonatomic)NSDictionary * titleDic;
@property (strong, nonatomic)NSDictionary * imgDic;
@property (weak, nonatomic) IBOutlet UILabel *vipSubTitleLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bannerHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewTop;
@end
@implementation XMHMarketInfoView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;
    _titleDic = @{@"1":@"普通权益包",@"2":@"银卡权益包",@"3":@"金卡权益包",@"4":@"铂金权益包",@"5":@"钻石权益包",@"6":@"至尊权益包",@"7":@"女皇权益包"};
    _imgDic = @{@"1":@"yxewm_putong",@"2":@"yxewm_yinka",@"3":@"yxewm_jinka",@"4":@"yxewm_bojin",@"5":@"yxewm_zuanshi",@"6":@"yxewm_zhizun",@"7":@"yxewm_nvwang"};
    _qybTitle.font = FONT_BOLD_SIZE(16);
    _qybName.font = FONT_SIZE(10);
    _qybYear.font = FONT_SIZE(8);
    _qybYear.layer.borderWidth = 0.5;
    _qybYear.layer.cornerRadius = 2;
    
}
- (void)updateViewModel:(XMHMarketModel *)model type:(XMHMarketVCType)type
{
    _vipSubTitleLab.hidden = YES;
    if (type == XMHMarketVCTypeSMLL) {
        _lbYprice.hidden = _line.hidden = YES;
        [_banner yy_setImageWithURL:URLSTR(model.info.pic1) placeholder:kDefaultImage];
        _lbTItle.text = model.info.name;
        [_qCode yy_setImageWithURL:URLSTR(model.img) placeholder:kDefaultImage];
        _lbXprice.text = [NSString stringWithFormat:@"¥%@",model.info.price];
    }
    if (type == XMHMarketVCTypeXMYL) {
        [_banner yy_setImageWithURL:URLSTR(model.info.pic_banner) placeholder:kDefaultImage];
        _lbTItle.text = model.info.name;
        [_qCode yy_setImageWithURL:URLSTR(model.img) placeholder:kDefaultImage];
        _lbXprice.text = [NSString stringWithFormat:@"¥%@",model.info.present_price];
        _lbYprice.text = [NSString stringWithFormat:@"¥%@",model.info.original_price];
    }
    if (type == XMHMarketVCTypeLKLB) {
        [_banner yy_setImageWithURL:URLSTR(model.info.pic_banner) placeholder:kDefaultImage];
        _lbTItle.text = model.info.name;
        [_qCode yy_setImageWithURL:URLSTR(model.img) placeholder:kDefaultImage];
        _lbXprice.text = [NSString stringWithFormat:@"¥%@",model.info.join_price];
        _lbYprice.text = [NSString stringWithFormat:@"¥%@",model.info.price_y];
    }
    if (type == XMHMarketVCTypeQYB) {
        _lbYprice.hidden = _line.hidden = YES;
        _qybContainer.hidden = NO;
        _qybContainer.backgroundColor = [UIColor clearColor];
        _qybTitle.text = _titleDic[model.info.type];
        _qybName.text = model.info.name;
        _lbTItle.text = model.info.title;
        _lbTItle.text = model.info.title;
        NSString * imgName = _imgDic[model.info.type];
        _banner.image = UIImageName(imgName);
        _banner.layer.cornerRadius = 5;
        _banner.layer.masksToBounds = YES;
        [_qCode yy_setImageWithURL:URLSTR(model.img) placeholder:kDefaultImage];
        _lbXprice.text = model.info.sale_price;
        _qybYear.text = [NSString stringWithFormat:@"%@年有效期",model.info.validity];
        if (model.info.type.integerValue == 1) {
            _qybTitle.textColor = _qybName.textColor = _qybYear.textColor = [UIColor whiteColor];
            _qybYear.layer.borderColor = [UIColor whiteColor].CGColor;
        }
        if (model.info.type.integerValue == 2) {
            _qybTitle.textColor = _qybName.textColor = _qybYear.textColor = [UIColor whiteColor];
            _qybYear.layer.borderColor = [UIColor whiteColor].CGColor;
        }
        if (model.info.type.integerValue == 3) {
            _qybTitle.textColor = _qybName.textColor = _qybYear.textColor = [ColorTools colorWithHexString:@"#7A4F00"];
            _qybYear.layer.borderColor = [ColorTools colorWithHexString:@"#7A4F00"].CGColor;
        }
        if (model.info.type.integerValue == 4) {
            _qybTitle.textColor = _qybName.textColor = _qybYear.textColor = [ColorTools colorWithHexString:@"#8B6033"];
            _qybYear.layer.borderColor = [ColorTools colorWithHexString:@"#8B6033"].CGColor;
        }
        if (model.info.type.integerValue == 5) {
            _qybTitle.textColor = _qybName.textColor = _qybYear.textColor = [ColorTools colorWithHexString:@"#803100"];
            _qybYear.layer.borderColor = [ColorTools colorWithHexString:@"#803100"].CGColor;
        }
        if (model.info.type.integerValue == 6) {
            _qybTitle.textColor = _qybName.textColor = _qybYear.textColor = [UIColor whiteColor];
            _qybYear.layer.borderColor = [UIColor whiteColor].CGColor;
        }
        if (model.info.type.integerValue == 7) {
            _qybTitle.textColor = _qybName.textColor = _qybYear.textColor = [ColorTools colorWithHexString:@"#E4B867"];
            _qybYear.layer.borderColor = [ColorTools colorWithHexString:@"#E4B867"].CGColor;
        }
        
    }
    if (type == XMHMarketVCTypeVIP) {
        _lbYprice.hidden = _line.hidden = YES;
        _vipSubTitleLab.hidden = NO;
        [_banner yy_setImageWithURL:URLSTR(model.info.share_pic) placeholder:kDefaultImage];
        _lbTItle.text = model.info.name;
        _lbTItle.numberOfLines = 1;
        [_qCode yy_setImageWithURL:URLSTR(model.img) placeholder:kDefaultImage];
        _lbXprice.text = [NSString stringWithFormat:@"¥%@",model.info.price];
        _vipSubTitleLab.text = model.info.des;
        _bannerHeight.constant = 270;
        _viewTop.constant = 15;
        NSString *priceStr = [NSString stringWithFormat:@"活动价: ¥%@",model.info.price];
        NSMutableAttributedString * attrStr =  [[NSMutableAttributedString alloc] initWithString:priceStr];
        // 改变颜色
        [attrStr addAttributes:@{NSForegroundColorAttributeName:kColor9,NSFontAttributeName:FONT_SIZE(12)} range:NSMakeRange(0,4)];
        _lbXprice.attributedText = attrStr;
    }
}
@end
