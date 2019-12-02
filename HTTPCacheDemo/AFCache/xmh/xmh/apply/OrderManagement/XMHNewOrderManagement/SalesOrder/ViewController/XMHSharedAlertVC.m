//
//  XMHSharedAlertVC.m
//  xmh
//
//  Created by KFW on 2019/5/20.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHSharedAlertVC.h"
#import <UMShare/UMShare.h>

@interface XMHSharedAlertVC ()
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation XMHSharedAlertVC

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect rect = CGRectMake(0, 0, self.view.width, 334);
    // 左上和右上为圆角
    UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(10, 10)];
    
    CAShapeLayer *cornerRadiusLayer = [[CAShapeLayer alloc ] init];
    cornerRadiusLayer.frame = rect;
    cornerRadiusLayer.path = cornerRadiusPath.CGPath;
    _contentView.layer.mask = cornerRadiusLayer;
}

- (IBAction)wechatShare:(UIButton *)sender {
    [[[MzzHud alloc]initWithTitle:@"" message:@"是否确认分享给你的好友" leftButtonTitle:@"取消" rightButtonTitle:@"确认" click:^(NSInteger index) {
        if (index == 0) return;
        [self shareType:UMSocialPlatformType_WechatSession vc:self webPageUrl:_shareUrl];
    } hiddenCancelBtn:YES]show];
}

- (IBAction)zhifubao:(UIButton *)sender {
}

- (IBAction)cancelClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)shareType:(UMSocialPlatformType)type vc:(id)vc webPageUrl:(NSString *)webPageUrl {
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建网页内容对象
    NSString *thumbURL = [ShareWorkInstance shareInstance].share_join_code.join_logo;
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"您的专属订单！" descr:@"您的专属技师已为您推荐属于您的定制订单，请查看！" thumImage:thumbURL];
    // 19.5.21 孟饶微信通知 更换分享内容
//    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"快来点击领取属于您的优惠券吧" descr:@"超值优惠券，等您来领" thumImage:thumbURL];
    //设置网页地址
    shareObject.webpageUrl = webPageUrl;
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    [[UMSocialManager defaultManager] shareToPlatform:type messageObject:messageObject currentViewController:vc completion:^(id data, NSError *error) {
        if (error) {
//            [XMHProgressHUD showOnlyText:error.description];
            if (self.shareResultBlock) self.shareResultBlock(NO);
        }else{
            if (self.shareResultBlock) self.shareResultBlock(YES);
        }
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

@end
