//
//  XMHSearchView.h
//  xmh
//
//  Created by kfw on 2019/8/21.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
// 搜索基类

/* 基本使用方式
 - (void)normal {
    XMHSearchView *searchView = [[XMHSearchView alloc] initWithFrame:CGRectMake(0, 100, self.view.width, 54)];
    searchView.type = XMHSearchViewTypeNormal;
    searchView.contentEdgeInset = UIEdgeInsetsMake(10, 10, 10, 10);
    searchView.textField.placeholder = @"请输入名称";
    [self.view addSubview:searchView];
 }
 
 - (void)textFieldLeftView {
    XMHSearchView *searchView = [[XMHSearchView alloc] initWithFrame:CGRectMake(0, 200, self.view.width, 44)];
    searchView.type = XMHSearchViewTypeTextFieldLeftView;
    searchView.contentEdgeInset = UIEdgeInsetsMake(10, 10, 10, 10);
    searchView.textFieldMaxNumberOfCharacters = 5;
    searchView.textField.placeholder = @"请输入名称2";
    [self.view addSubview:searchView];
 }
 
 - (void)search {
    XMHSearchView *searchView = [[XMHSearchView alloc] initWithFrame:CGRectMake(0, 300, self.view.width, 54)];
    searchView.type = XMHSearchViewTypeSearch;
    searchView.searchButtonContentInset = UIEdgeInsetsMake(0, 10, 0, 10);
    //    searchView.textFieldEdgeInset = UIEdgeInsetsMake(0, 10, 0, 10);
    searchView.focusSpacing = 5;
    searchView.textField.placeholder = @"请输入名称3";
    [searchView.searchButton setTitle:@"搜索搜索搜索" forState:UIControlStateNormal];
    [self.view addSubview:searchView];
 }
 */

/* 内部结构及属性说明
                          XMHSearchView
 +-----------------------------------------------------------------+
 |               ContentView / contentEdgeInset                    |
 |    +-------------------------------------------------------+    |
 |    |          textFieldEdgeInset       |+-----------------+|    |
 |    |    +-------------------------+    ||    UIButton /   ||    |
 |    |    |     UITextField         |    ||  searchButton   ||    |
 |    |    |                         |    ||  ContentInset   ||    |
 |    |    +-------------------------+    ||                 ||    |
 |    |                                   |+-----------------+|    |
 |    +-------------------------------------------------------+    |
 |                                                                 |
 +-----------------------------------------------------------------+
 */
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// 样式类型
typedef NS_ENUM(NSInteger, XMHSearchViewType){
    XMHSearchViewTypeNormal,            // 只有搜索框
    XMHSearchViewTypeTextFieldLeftView, // textField 有leftView
    XMHSearchViewTypeSearch,            // textField 有leftView 右侧有搜索按钮
};

@interface XMHSearchView : UIView

/** 内容view */
@property (nonatomic, strong, readonly) UIView *contentView;
/** textField */
@property (nonatomic, strong, readonly) UITextField *textField;
/** textFieldLeftView  */
@property (nonatomic, strong, readonly) UIView *textFieldLeftView;
/** textFieldLeftImageView */
@property (nonatomic, strong, readonly) UIImageView *textFieldLeftImageView;
/** 搜索按钮 */
@property (nonatomic, strong, readonly) UIButton *searchButton;

/** 样式类型 默认 XMHSearchViewTypeSearch */
@property (nonatomic) XMHSearchViewType type;
/** 内容外间距 */
@property (nonatomic) UIEdgeInsets contentEdgeInset;
/** 搜索框外间距 */
@property (nonatomic) UIEdgeInsets textFieldEdgeInset;
/** 搜索按钮内间距
 top bottom 推荐设置 0 与 contentView高度相同。
 left right 决定按钮宽度。按钮宽度 = left + 文字内容宽 + right
 */
@property (nonatomic) UIEdgeInsets searchButtonContentInset;
/* 最大输入字符限制，默认NSIntegerMax。 */
@property (nonatomic) NSInteger textFieldMaxNumberOfCharacters;
/** 输入框左边图片名 默认 order_search */
@property (nonatomic, copy) NSString *leftSearchImageName;
/** 初始焦点与输入框左边图片间距 默认 5.f */
@property (nonatomic) CGFloat focusSpacing;

// 如果回调不够用，可使用 UITextField+BlocksKit.h 增加 Block 回调。或自行增加功能方法。

/** return 回调 */
@property (nonatomic, copy) void (^searchBlock)(XMHSearchView *searchView, NSString *text);
/** 情况输入框搜索text回调 */
@property (nonatomic, copy) void (^clearSearchTextBlock)(XMHSearchView *searchView);
/** 输入实时回调 */
@property (nonatomic, copy) void (^changeSearchTextBlock)(XMHSearchView *searchView);

@end

NS_ASSUME_NONNULL_END
