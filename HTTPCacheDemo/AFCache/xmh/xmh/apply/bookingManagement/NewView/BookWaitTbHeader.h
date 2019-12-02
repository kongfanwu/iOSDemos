//
//  BookWaitTbHeader.h
//  xmh
//
//  Created by ald_ios on 2018/10/20.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookWaitTbHeader : UIView
@property (nonatomic, copy) void (^BookWaitTbHeaderBlock)(NSString *selectStr);
@property (nonatomic, copy) void (^BookWaitTbHeaderTapBlock)();
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *left;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *right;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top;
- (void)updateFram;
@end
