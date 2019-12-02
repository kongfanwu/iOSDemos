//
//  BeautyCell3.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/1.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "BeautyCell3.h"
#import "LolUserInfoModel.h"
#import "UserManager.h"
@implementation BeautyCell3{
    WKWebView *_webView;
    
    NSString *cjoin_code;
    NSString *ctoken;
    NSString *coneClick;
    NSString *ctwoClick;
    NSString *ctwoListId;
    NSString *cinId;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubView];
    }
    return self;
}
- (void)initSubView{
    self.backgroundColor = kBackgroundColor;
    
    
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 595)];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    _webView.scrollView.scrollEnabled = NO;
    [self addSubview:_webView];
    
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@beauty/chart.html",SERVER_H5]]]];
}
- (void)refreshBeautyCell3:(NSString *)oneClick
                  twoClick:(NSString *)twoClick
                 twoListId:(NSString *)twoListId
                 join_code:(NSString *)join_code
                      inId:(NSString *)inId{
    
    LolUserInfoModel *model =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString    *token = model.data.token;
    ctoken = token;
    cjoin_code = join_code;
    coneClick = oneClick;
    ctwoClick = twoClick;
    ctwoListId = twoListId;
    cinId = inId;
    [_webView reload];
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
        NSString *js = [NSString stringWithFormat:@"beautyHomeCallJs('%@','%@','%@','%@','%@','%@')",ctoken,coneClick,ctwoClick,ctwoListId,cjoin_code,cinId];
    [XMHWebSignTools loadWebViewJs:webView];
        [_webView evaluateJavaScript:js completionHandler:^(id _Nullable result, NSError * _Nullable error) {
            if (_BeautyCell3Block) {
                _BeautyCell3Block(YES);
            }
        }];
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"错误");
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
