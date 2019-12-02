//
//  XMHProgressHUD.m
//  xmh
//
//  Created by ald_ios on 2019/5/15.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHProgressHUD.h"
#import "UIImage+GIFImage.h"
@implementation XMHProgressHUD
/** 加载动画 */
+ (void)showGifImage
{
    [SVProgressHUD setShouldTintImages:false];
    [SVProgressHUD setImageViewSize:CGSizeMake(90, 85)];
    [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD showImage:[UIImage imageWithGIFNamed:@"xmhLoading"] status:@""];
}
/** 只展示文字 */
+ (void)showOnlyText:(NSString *)text;
{
    [self dismiss]; // 防止文字为白色
    [SVProgressHUD setInfoImage:UIImageName(@"1")];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showInfoWithStatus:text];
}

/**
 只展示文字

 @param text text
 @param delay 延迟秒
 @param completion 消失回调
 */
+ (void)showOnlyText:(NSString *)text delay:(NSTimeInterval)delay completion:(void(^)(void))completion {
    [SVProgressHUD setMinimumDismissTimeInterval:delay];
    [self showOnlyText:text];
    [SVProgressHUD dismissWithDelay:delay completion:^{
        [SVProgressHUD setMinimumDismissTimeInterval:0];
        if (completion) completion();
    }];
}

/** 取消 */
+ (void)dismiss
{
    [SVProgressHUD dismiss];
}

@end
