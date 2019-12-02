//
//  WKwebViewCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/28.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "WKwebViewCell.h"
#import <WebKit/WebKit.h>
@interface WKwebViewCell()<WKNavigationDelegate,WKUIDelegate>

@property(nonatomic ,strong)WKWebView *web;

@end


@implementation WKwebViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    if (_web ==nil) {
        _web = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        _web.backgroundColor = [UIColor whiteColor];
        _web.scrollView.scrollEnabled = NO;
        [self.contentView addSubview:_web];
    }
}

-(void)setWKDelegate:(id<WKNavigationDelegate,WKUIDelegate>)WKDelegate{
    _WKDelegate = WKDelegate;
    _web.UIDelegate = self.WKDelegate;
    _web.navigationDelegate = self.WKDelegate;
}
- (void)loadRequestwith:(NSString *)url{
    [_web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}

- (void)reloadWkWithMainrole:(NSInteger)mainRole{
    self.web.height = 10;
    if (mainRole ==6 || mainRole ==9 || mainRole ==10 || mainRole ==11) {
        [self loadRequestwith:[NSString stringWithFormat:@"%@gk/bar.html",SERVER_H5]];
    }else{
        [self loadRequestwith:[NSString stringWithFormat:@"%@gk/callios.html",SERVER_H5]];
    }
}
-(void)setWebHeight:(void (^)(CGFloat))webHeight{
    _webHeight = webHeight;
}
-(void)evaluatJs:(NSString *)js{
    [_web evaluateJavaScript:js completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        [_web evaluateJavaScript:@"document.body.scrollHeight" completionHandler:^(id data, NSError * _Nullable error) {
            CGFloat height = [data floatValue];
            if (self.webHeight) {
                self.web.height = height;
                self.webHeight(height);
            }
        }];
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
 
}
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    
}
@end
