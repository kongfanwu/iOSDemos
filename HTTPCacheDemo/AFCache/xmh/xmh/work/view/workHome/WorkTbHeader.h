//
//  WorkTbHeader.h
//  xmh
//
//  Created by ald_ios on 2018/9/11.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WorkHeardManagerModel;
@interface WorkTbHeader : UIView
@property (nonatomic, strong)WorkHeardManagerModel *workModel;
@property (nonatomic, assign)NSInteger role;
@property (nonatomic, assign)BOOL selectMore;//是否点击更多按钮

@property (nonatomic, copy) void (^btnMoreButton)(BOOL select);
-(void)initManagerUI;

- (instancetype)initWithFrame:(CGRect)frame withType:(NSInteger)type andHeadArray:(WorkHeardManagerModel *)model;
-(void)updateView:(NSInteger)type withModel:(WorkHeardManagerModel *)model withSelect:(BOOL)select;

@end
