//
//  SearchView.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/18.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelfSearchBar.h"

@interface JasonSearchView : UIView<UITextFieldDelegate>
@property (nonatomic, strong) SelfSearchBar *searchBar;
@property (nonatomic, strong) UIImageView *line1;
/** 限制输入长度 */
@property (nonatomic, assign) CGFloat limitLength;
- (instancetype)initWithFrame:(CGRect)frame withPlaceholder:(NSString *)holderStr;
- (void)updateFrame;
- (void)updateHaoKaFrame;

- (void)updateShenPiFrame;
- (void)updateShenPiSearchFrame;

@property (nonatomic, copy) void (^btnSearchBlock)();

@end
