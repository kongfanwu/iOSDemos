//
//  TJDateView.m
//  xmh
//
//  Created by ald_ios on 2018/12/4.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "TJDateView.h"
#import "TJDataPickCell.h"
#import "TJSectionTbHeader.h"
#import "TJParamModel.h"
#import "DateTools.h"
@interface TJDateView ()
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imgVMore;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *moreRight;

@end
@implementation TJDateView
- (void)awakeFromNib
{
    [super awakeFromNib];
    self.layer.cornerRadius = 5;
     UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    _imgVMore.contentMode =  UIViewContentModeCenter;
    _moreRight.constant = 5;
    [self addGestureRecognizer:tap];
}
- (void)updateTJDateViewTitle:(NSString *)title
{
    _lbTitle.text = title;
}

- (void)tap:(UITapGestureRecognizer *)tap
{
    if (_TJDateViewTapBlock) {
        _TJDateViewTapBlock();
    }
}
- (void)setCustomImg:(UIImage *)customImg
{
    if (customImg) {
        _imgVMore.image =  customImg;
        _imgVMore.height = 16;
        _imgVMore.width = 17;
        _moreRight.constant = 15;
    }
}
@end
