//
//  SearchView.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/30.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchView : UIView
@property (nonatomic, copy)void(^searchViewBlock)();
@property (nonatomic, strong)UIButton * btnCancel;
@property (nonatomic, strong)UISearchBar * bar;
@property (nonatomic, strong)UITextField * textField;
- (instancetype)initWithFrame:(CGRect)frame cancelBtn:(BOOL)cancelBtn;
@end
