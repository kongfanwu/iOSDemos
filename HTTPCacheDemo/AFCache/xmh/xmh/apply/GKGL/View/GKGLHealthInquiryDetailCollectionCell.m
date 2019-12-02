//
//  GKGLHealthInquiryDetailCollectionCell.m
//  xmh
//
//  Created by ald_ios on 2019/1/17.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "GKGLHealthInquiryDetailCollectionCell.h"
#import "LolMarkView.h"
#import "NSString+Costom.h"
@interface GKGLHealthInquiryDetailCollectionCell ()
@property (weak, nonatomic) IBOutlet LolMarkView *imgBiaoQian;
@property (weak, nonatomic) IBOutlet UILabel *lbName;

@end
@implementation GKGLHealthInquiryDetailCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}
- (void)updateCellParam:(NSDictionary *)param
{
    _lbName.text = @"你好你好你好你";
    if ([param[@"is"] integerValue] == 0) {
        [_imgBiaoQian lolMarkViewImageName:@"GKGL_biaoqian_weixuan" Title:@""];
        _lbName.textColor = kColorC;
    }else if ([param[@"is"] integerValue] == 1){
        [_imgBiaoQian lolMarkViewImageName:@"GKGL_biaoqian" Title:@""];
        _lbName.textColor = [ColorTools colorWithHexString:@"#FF9072"];
    }else{}
    _lbName.text = param[@"option"];
}
- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    [self setNeedsLayout];
    [self layoutIfNeeded];
    CGSize size = [self.contentView systemLayoutSizeFittingSize:layoutAttributes.size];
    CGRect newframe = layoutAttributes.frame;
    newframe.size.width = ceil(size.width);
    layoutAttributes.frame = newframe;
    return layoutAttributes;
}
- (void)updateCellPortrayalParam:(NSDictionary *)param
{
    [_imgBiaoQian lolMarkViewImageName:@"GKGL_biaoqian" Title:@""];
    _lbName.text = param[@"name"];
    _lbName.textColor = [ColorTools colorWithHexString:@"#FF9072"];
}
@end
