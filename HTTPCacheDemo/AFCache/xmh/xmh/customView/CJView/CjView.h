//
//  CjView.h
//  xmh
//
//  Created by ald_ios on 2018/9/26.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CjView : UIView
@property (nonatomic, copy) void (^CjViewBlock)(NSString * twoClick,NSString *twoListId);
@property (nonatomic, copy) void (^CJViewBlock)(NSDictionary * cjDict);
@property (nonatomic, assign) BOOL isOrderManager;
- (instancetype)initWithFrame:(CGRect)frame isOnline:(BOOL)isOnline;
- (instancetype)initWithFrame:(CGRect)frame isOrder:(BOOL)isOrder;
- (void)setCJParam:(NSMutableDictionary *)cjDict;
@end
