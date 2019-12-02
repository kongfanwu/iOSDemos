//
//  RemarkView.m
//  xmh
//
//  Created by ald_ios on 2018/10/22.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "RemarkView.h"
@interface RemarkView ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbLimit;
@property (weak, nonatomic) IBOutlet UILabel *lbPlaceholder;
@property (weak, nonatomic) IBOutlet UITextView *txvRemark;

@end
@implementation RemarkView
{
  
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    _txvRemark.delegate = self;
}
- (void)updateRemarkViewContent:(NSString *)content
{
    _txvRemark.text = content;
    _lbLimit.text = [NSString stringWithFormat:@"%ld/300",content.length];
    _lbPlaceholder.hidden = YES;
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    _lbPlaceholder.hidden = YES;
    
}
- (void)textViewDidChange:(UITextView *)textView
{
    if (!(textView.text.length > 300)) {
         _lbLimit.text = [NSString stringWithFormat:@"%ld/300",textView.text.length];
    }else{
        textView.text = [textView.text substringToIndex:300];
        [XMHProgressHUD showOnlyText:@"超过字符限制"];
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (_RemarkViewBlock) {
        _RemarkViewBlock(textView.text);
    }
}
@end
