//
//  XMHOrderExamineDetailWebView.h
//  xmh
//
//  Created by shendengmeiye on 2019/3/20.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMHOrderExamineDetailWebView : UIViewController

/**
 The name of the message handler
 */
@property (nonatomic, copy)NSString *addScriptMessageName;

/**
 初始化

 @param title 导航title
 @param url webUrl
 @param js  js
 @return instancetype
 */
- (instancetype)initTitle:(NSString *)title webUrl:(NSString *)url js:(NSString *)js;



@end

NS_ASSUME_NONNULL_END
