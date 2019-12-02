//
//  DataView.h
//  xmh
//
//  Created by ald_ios on 2018/10/10.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataView : UIView
@property (nonatomic, copy) void (^btnMoreButton)(BOOL select);
/*
 *  有标题的 titles 格式 @[@"标题1",@"标题2"] modelDict @{@"标题1":@[],@"标题1":@[]}
 *  无标题的 titles 格式 nil modelDict @{@"无":@[]}
 */
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles modelDict:(NSDictionary *)modelDict;
- (void)updateDataViewModelDict:(NSDictionary * )modelDict withTitle:(NSArray *)titles;
@end
