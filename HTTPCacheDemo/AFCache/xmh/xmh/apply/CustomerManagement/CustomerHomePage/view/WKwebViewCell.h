//
//  WKwebViewCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/28.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
@interface WKwebViewCell : UITableViewCell
@property (nonatomic ,weak) id <WKNavigationDelegate,WKUIDelegate> WKDelegate;
- (void)loadRequestwith:(NSString *)url;
-(void)evaluatJs:(NSString *)js;
- (void)reloadWkWithMainrole:(NSInteger)mainRole;
@property (nonatomic ,copy) void (^webHeight)(CGFloat height);
@end
