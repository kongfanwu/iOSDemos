//
//  BeautyCell3.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/1.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface BeautyCell3 : UITableViewCell<WKUIDelegate,WKNavigationDelegate>

@property (nonatomic, copy) void (^BeautyCell3Block)(BOOL isOK);

- (void)refreshBeautyCell3:(NSString *)oneClick
                  twoClick:(NSString *)twoClick
                 twoListId:(NSString *)twoListId
                 join_code:(NSString *)join_code
                      inId:(NSString *)inId;
@end
