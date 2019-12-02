//
//  RefundTbFooterView.m
//  xmh
//
//  Created by ald_ios on 2018/11/15.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "RefundTbFooterView.h"
#import <YYWebImage/YYWebImage.h>
#import "RefundInfoModel.h"
@interface RefundTbFooterView ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbPlaceHolder;
@property (weak, nonatomic) IBOutlet UITextView *tfCause;
@property (weak, nonatomic) IBOutlet UIImageView *imgPortrait;
@property (weak, nonatomic) IBOutlet UILabel *lbName;

@end

@implementation RefundTbFooterView
- (void)awakeFromNib
{
    [super awakeFromNib];
    _tfCause.delegate = self;
    _imgPortrait.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [_imgPortrait addGestureRecognizer:tap];
}
- (void)updateRefundTbFooterViewModel:(RefundInfoModel *)model
{
    [_imgPortrait yy_setImageWithURL:URLSTR(model.approvalPerson[0].head_img) placeholder:kDefaultJisImage];
    _lbName.text = model.approvalPerson[0].name;
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    _lbPlaceHolder.hidden = YES;
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (_RefundTbFooterViewInputBlock) {
        _RefundTbFooterViewInputBlock(textView.text);
    }
}
- (void)updateRefundTbFooterViewApprovalInfoModel:(ApprovalInfo *)model
{
    [_imgPortrait yy_setImageWithURL:URLSTR(model.head_img) placeholder:kDefaultJisImage];
    _lbName.text = model.name;
}
- (void)tap:(UITapGestureRecognizer *)tapClick
{
    if (_RefundTbFooterViewApprovalTapBlock) {
        _RefundTbFooterViewApprovalTapBlock();
    }
}
@end
