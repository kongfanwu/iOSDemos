//
//  TJDateView.h
//  xmh
//
//  Created by ald_ios on 2018/12/4.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TJDateView : UIView
@property (nonatomic, copy)void (^TJDateViewTapBlock)();
@property (nonatomic, strong)UIImage * customImg;
- (void)updateTJDateViewTitle:(NSString *)title;
@end
