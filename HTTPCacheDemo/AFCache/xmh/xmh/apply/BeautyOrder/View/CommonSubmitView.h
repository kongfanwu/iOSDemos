//
//  CommonSubmitView.h
//  xmh
//
//  Created by ald_ios on 2018/11/2.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonSubmitView : UIView
@property (nonatomic, copy) void (^CommonSubmitViewBlock)();
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;
/** 更新按钮文字 */
- (void)updateCommonSubmitViewTitle:(NSString *)title;
@end
