//
//  WorkChoiceView.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/14.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserManager.h"
#import "COrganizeModel.h"
#import "ZhuzhiModel.h"

@interface WorkChoiceView : UIView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UIButton *btnReSet;
@property (nonatomic, strong)UIButton *btnSure;
@property (nonatomic, assign)BOOL isOnLine;
@property (nonatomic, copy)void(^positionBlock)(NSString *btnTitleStr);
@property (nonatomic, copy)void(^WorkChoiceViewCellClickBlock)(NSString *cellTitleStr);

@property (nonatomic, copy)void(^WorkChoiceViewBlock)(NSString *join_code,NSString *oneClick,NSString *twoClick,NSString * twoListId,NSString *inId,NSInteger level,NSInteger main_role,NSString *title1,NSString *title2,List *listInfo);
@property (nonatomic, copy)void(^WorkChoiceBlock)(COrganizeModel * model);
@property (nonatomic, copy)void(^WorkChoiceViewCancleBlock)(void);

/**
 *初始化视图、职位标题
 */
- (instancetype)initWithFrame:(CGRect)frame;
//- (instancetype)initWithFrame:(CGRect)frame isOnLine:(BOOL)isOnline;
@end
