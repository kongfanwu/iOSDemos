//
//  MzzTitleAndDetailView.h
//  xmh
//
//  Created by 张英杰 on 2017/12/9.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MzzTitleAndDetailView;
typedef void (^TitleAndDetailClicked) (MzzTitleAndDetailView *view);
@interface MzzTitleAndDetailView : UIView
@property (strong, nonatomic)  UILabel *titleLbl;
@property (strong, nonatomic)  UILabel *detailLbl;
@property (strong, nonatomic)  UIImageView *line1;
@property (strong, nonatomic)  UIImageView *line2;
@property (strong ,nonatomic) UITapGestureRecognizer *tap;
@property (copy, nonatomic)TitleAndDetailClicked click;
- (void)setTitle:(NSString *)title andDetail:(NSString *)detail andClick:(TitleAndDetailClicked)click;
- (void)setTitle:(NSString *)title andDetail:(NSString *)detail;
@end
