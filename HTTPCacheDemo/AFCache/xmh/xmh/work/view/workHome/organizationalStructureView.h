//
//  organizationalStructureView.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/4.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "COrganizeModel.h"
#import "ZuZhiChoiceModel.h"
#import "ZhuzhiModel.h"
@interface organizationalStructureView : UIView
@property (strong, nonatomic)  UILabel *lb1;
@property (strong, nonatomic)  UIImageView *im1;
@property (strong, nonatomic)  UILabel *lb2;
@property (strong, nonatomic)  UIImageView *im2;
@property (strong, nonatomic)  UIImageView *line;
@property (strong, nonatomic)  UIButton *btn1;
@property (copy, nonatomic)  NSString *title2Str;
@property (assign, nonatomic)BOOL isOnLine;
@property (nonatomic, copy)void(^organizeStructureBlock)(COrganizeModel * model);
@property (nonatomic, copy)void(^organizationalStructureViewBlock)(NSString *join_code,NSString *oneClick,NSString *twoClick,NSString * twoListId,NSString *inId,NSInteger level,NSInteger main_role,List*listInfo);
- (instancetype)initWithFrame:(CGRect)frame;
- (void)refreshOrganizationalStructureView:(NSString *)title1 withTitle2:(NSString *)title2;

- (void)freshorganizationalView:(ZuZhiChoiceModel *)choiceModel;

@end
