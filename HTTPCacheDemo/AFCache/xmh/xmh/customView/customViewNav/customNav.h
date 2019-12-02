//
//  customNav.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/6.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "navLeftBtn.h"

@interface customNav : UIView

//导航标题

@property(nonatomic, strong)UILabel *lbTitle;
//左面按钮
@property(nonatomic, strong)UIButton *btnLet;
//右面按钮
@property(nonatomic, strong)UIButton *btnRight;
@property(nonatomic, strong)UIImageView *lineImageView;//底部的线

/**
 *只有标题
 */
- (instancetype)initWithFrame:(CGRect)frame withTitleStr:(NSString *)titlestr;

/**
 *标题+右边按钮
 */
- (instancetype)initWithFrame:(CGRect)frame withTitleStr:(NSString *)titlestr withRightBtnImag:(NSString *)imagStr;

/**
 *标题+左边按钮+左边图片
 */
- (instancetype)initWithFrame:(CGRect)frame withTitleStr:(NSString *)titlestr withleftTitleStr:(NSString *)leftTitleStr withleftImageStr:(NSString *)leftImageStr;
/**
*标题+左边图片+右面文字
*/
- (instancetype)initWithFrame:(CGRect)frame withTitleStr:(NSString *)titlestr withleftImageStr:(NSString *)leftImageStr withRightStr:(NSString *)rightStr;
/**
 *标题+左边按钮+左边图片+右边按钮
 */
- (instancetype)initWithFrame:(CGRect)frame withTitleStr:(NSString *)titlestr withleftTitleStr:(NSString *)leftTitleStr withleftImageStr:(NSString *)leftImageStr withRightBtnImag:(NSString *)imagStr;
/**
 *标题+左边按钮+左边图片+右边按钮图片文字
 */
- (instancetype)initWithFrame:(CGRect)frame withTitleStr:(NSString *)titlestr withleftTitleStr:(NSString *)leftTitleStr withleftImageStr:(NSString *)leftImageStr withRightBtnImag:(NSString *)imagStr withRightBtnTitle:(NSString *)title;

- (instancetype)initWithFrame:(CGRect)frame withTitleStr:(NSString *)titlestr withleftTitleStr:(NSString *)leftTitleStr withleftImageStr:(NSString *)leftImageStr withRightBtnImag:(NSString *)imagStr withRightBtnTitle:(NSString *)title commenColor:(BOOL)is;

- (instancetype)initWithFrame:(CGRect)frame withTitleStr:(NSString *)titlestr withleftImageStr:(NSString *)leftImageStr withRightStr:(NSString *)rightStr commenColor:(BOOL)is;
@end
