//
//  XMHFormTaskCreateBaseVC.m
//  xmh
//
//  Created by kfw on 2019/6/12.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHFormTaskCreateBaseVC.h"

@interface XMHFormTaskCreateBaseVC ()
@end

@implementation XMHFormTaskCreateBaseVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initConfig];
    }
    return self;
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self){
        [self initConfig];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initConfig];
    }
    
    return self;
}

- (void)initConfig {
    self.bottomViewState = XMHFormTaskBottomViewStateSave;
    self.type = XMHFormTaskCreateVCTypeCreate;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBackgroundColor;
    
    [self initNavViews];

    [self.view addSubview:self.bottomView];
    
    self.tableView.frame = CGRectMake(10, self.navView.bottom, self.view.width - 20, self.view.height - self.navView.bottom - self.bottomView.height - kSafeAreaBottom);
    self.tableView.tableFooterView = UIView.new;
    self.tableView.backgroundColor = UIColor.clearColor;
    self.tableView.separatorColor = kSeparatorColor;
}

#pragma mark - Lazy

- (LNavView *)navView
{
    WeakSelf
    if (!_navView) {
        _navView = loadNibName(@"LNavView");
        _navView.frame = CGRectMake(0, 0, SCREEN_WIDTH, KNaviBarHeight);
        _navView.backgroundColor = kColorTheme;
        _navView.NavViewBackBlock = ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
    }
    return _navView;
}

- (UIView *)bottomView {
    if (_bottomView) return _bottomView;
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height - 69 - kSafeAreaBottom, self.view.width, 69)];
    _bottomView.backgroundColor = UIColor.whiteColor;
    
    self.saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [_saveButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [_saveButton setBackgroundImage:[UIImage imageWithColor:kColorTheme size:CGSizeMake(10, 20)] forState:UIControlStateNormal];
    [_saveButton setBackgroundImage:[UIImage imageWithColor:kColor9 size:CGSizeMake(10, 20)] forState:UIControlStateDisabled];
    _saveButton.titleLabel.font = FONT_SIZE(17);
    [_saveButton addTarget:self action:@selector(saveClick:) forControlEvents:UIControlEventTouchUpInside];
    [_saveButton cornerRadius:3];
    [_bottomView addSubview:_saveButton];
    [_saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(44);
        make.centerY.equalTo(_bottomView);
    }];
    _saveButton.enabled = NO;
    
    self.deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
    [_deleteButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [_deleteButton setBackgroundImage:[UIImage imageWithColor:kColorTheme size:CGSizeMake(10, 20)] forState:UIControlStateNormal];
    _deleteButton.titleLabel.font = FONT_SIZE(17);
    [_deleteButton addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
    [_deleteButton cornerRadius:3];
    [_bottomView addSubview:_deleteButton];
    [_deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(44);
        make.centerY.equalTo(_bottomView);
    }];
    
    self.bottomViewState = XMHFormTaskBottomViewStateSave; // 触发setter
    
    return _bottomView;
}

- (void)initNavViews
{
    [self.view addSubview:self.navView];
    [self.navView setNavViewTitle:@"创建日常任务" backBtnShow:YES rightBtnTitle:@"确认"];
    WeakSelf
    self.navView.NavViewRightBlock = ^{
        [weakSelf submitClick];
    };
}

- (void)setBottomViewState:(XMHFormTaskBottomViewState)bottomViewState {
    _bottomViewState = bottomViewState;
    
    if (self.bottomViewState == XMHFormTaskBottomViewStateSave) {
        _saveButton.hidden = NO;
        _deleteButton.hidden = YES;
    } else {
        _saveButton.hidden = YES;
        _deleteButton.hidden = NO;
    }
}

#pragma mark - Click
/**
 确认
 */
- (void)submitClick {}

/**
 保存
 */
- (void)saveClick:(UIButton *)sender {}

/**
 删除
 */
- (void)deleteClick:(UIButton *)sender {}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [super tableView:tableView numberOfRowsInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CGFloat headerHeight = [self tableView:tableView heightForHeaderInSection:section];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, headerHeight)];
    headerView.backgroundColor = UIColor.clearColor;
    return headerView;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableView *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 下面这几行代码是用来设置cell的上下行线的位置
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    //按照作者最后的意思还要加上下面这一段，才能做到底部线控制位置，所以这里按stackflow上的做法添加上吧。
    if([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]){
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - XLFormViewControllerDelegate

-(UITableViewRowAnimation)insertRowAnimationForRow:(XLFormRowDescriptor *)formRow{
    return UITableViewRowAnimationAutomatic;
}
-(UITableViewRowAnimation)deleteRowAnimationForRow:(XLFormRowDescriptor *)formRow {
    return UITableViewRowAnimationAutomatic;
}
-(UITableViewRowAnimation)insertRowAnimationForSection:(XLFormSectionDescriptor *)formSection {
    return UITableViewRowAnimationAutomatic;
}
-(UITableViewRowAnimation)deleteRowAnimationForSection:(XLFormSectionDescriptor *)formSection {
    return UITableViewRowAnimationAutomatic;
}

#pragma mark - Tool

/**
 根据tag搜索表单section

 @param tag section tag
 @param block secton：XLFormSectionDescriptor index:索引
 @return XLFormSectionDescriptor
 */
- (XLFormSectionDescriptor *)searchSectionTag:(NSString *)tag block:(nullable void(^)(XLFormSectionDescriptor *section, NSUInteger index))block {
    XLFormSectionDescriptor *newSection;
    NSInteger index = - 1;
    for (XLFormSectionDescriptor *section in self.form.formSections) {
        if ([section.multivaluedTag isEqualToString:tag]) {
            newSection = section;
            index = [self.form.formSections indexOfObject:section];
            break;
        }
    }
    if (block && newSection && index != -1) block(newSection, index);
    return newSection;
}

/**
 表单校验
 
 @return YES：通过 NO：未通过
 */
- (BOOL)formValidation {
    NSArray *validationArray = [self formValidationErrors];
    if (validationArray.count) {
        [validationArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            XLFormValidationStatus * validationStatus = [[obj userInfo] objectForKey:XLValidationStatusErrorKey];
            NSLog(@"验证未通过Tag：%@", validationStatus.rowDescriptor.tag);
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[self.form indexPathOfFormRow:validationStatus.rowDescriptor]];
            [cell animateCell];
        }];
        return NO;
    }
    return YES;
}

@end
