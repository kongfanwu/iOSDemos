//
//  LanternMSelectStoreView.m
//  xmh
//
//  Created by ald_ios on 2019/2/22.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LanternMSelectStoreView.h"
#import "LanternMStoreCell.h"
#import "LSelectBaseModel.h"
#import "MzzStoreModel.h"
#import "JasonSearchView.h"
@interface LanternMSelectStoreView ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *bg;
@property (weak, nonatomic) IBOutlet UIView *container;
@property (weak, nonatomic) IBOutlet UIButton *btnLeft;
@property (weak, nonatomic) IBOutlet UIButton *btnRight;
@property (weak, nonatomic) IBOutlet UIView *searchContainer;
@property (weak, nonatomic) IBOutlet UITableView *tbView;
@property (weak, nonatomic) JasonSearchView * search;
@property (nonatomic, strong)NSMutableArray * dataSource;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerH;

@end
@implementation LanternMSelectStoreView

- (void)awakeFromNib
{
    [super awakeFromNib];
    _tbView.delegate = self;
    _tbView.dataSource = self;
    _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
//    _dataSource = [[NSMutableArray alloc] init];
    _bg.backgroundColor = [UIColor darkGrayColor];
    _bg.alpha = 0.7;
    _container.layer.cornerRadius = 5;
    _container.layer.masksToBounds = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDown:)];
    [_bg addGestureRecognizer:tap];
    JasonSearchView * search = [[JasonSearchView alloc] initWithFrame:CGRectMake(15, 10, _searchContainer.width - 15 - 55, 34) withPlaceholder:@""];
    search.searchBar.frame = search.bounds;
    [_searchContainer addSubview:search];
    search.searchBar.layer.cornerRadius = 3;
    search.searchBar.layer.masksToBounds = YES;
    
    __weak JasonSearchView * weakSearchView = search;
    search.searchBar.btnRightBlock = ^{
        if (_LanternMSelectStoreViewSearchBlock) {
            _LanternMSelectStoreViewSearchBlock(weakSearchView.searchBar.text);
        }
    };
    _search = search;
//    search.userInteractionEnabled = NO;
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"搜索" forState:UIControlStateNormal];
    btn.titleLabel.font = FONT_SIZE(15);
    [btn setTitleColor:kColor6 forState:UIControlStateNormal];
    btn.frame = CGRectMake(search.right, 0, 55, _searchContainer.height);
    btn.userInteractionEnabled = NO;
    [_searchContainer addSubview:btn];
}

-(void)keyboardWillShow:(NSNotification *)notify
{
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.containerH.constant = self.containerH.constant + 40;
    }];
}
- (void) keyboardWillHide:(NSNotification *)notify {
    // 键盘动画时间
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //视图下沉恢复原状
    [UIView animateWithDuration:duration animations:^{
        self.containerH.constant = self.containerH.constant - 40;
    }];
}
- (IBAction)cancel:(id)sender
{
    [self removeFromSuperview];
}
- (void)tapDown:(UITapGestureRecognizer *)tap
{
    [self removeFromSuperview];
}
- (IBAction)sure:(id)sender
{
    if (_LanternMSelectStoreViewBlock) {
        _LanternMSelectStoreViewBlock(_dataSource);
    }
    [self removeFromSuperview];
}
#pragma mark ------UITableView------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * kLanternMStoreCell = @"kLanternMStoreCell";
    LanternMStoreCell * cell = [tableView dequeueReusableCellWithIdentifier:kLanternMStoreCell];
    if (!cell) {
        cell =  loadNibName(@"LanternMStoreCell");
    }
    [cell updateCellModel:_dataSource[indexPath.row]];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return 10;
    return _dataSource.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MzzStoreModel * model = _dataSource[indexPath.row];
    model.isSelect = !model.isSelect;
    MzzStoreModel * firstModel0 = _dataSource[0];
    if ([firstModel0.store_code isEqualToString:@"all"]) {
        if (indexPath.row == 0) {
            for (int i = 0; i < _dataSource.count; i++) {
                MzzStoreModel * tempModel = _dataSource[i];
                tempModel.isSelect = model.isSelect;
            }
        }else{
            MzzStoreModel * firstModel = _dataSource[0];
            firstModel.isSelect = NO;
        }
    }
    [_tbView reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}
- (void)updateViewParam:(NSMutableArray *)param
{
    _dataSource = param;
    [_tbView reloadData];
}
- (void)updateSelectViewPlaceHolder:(NSString *)placeholder
{
    _search.searchBar.placeholder = placeholder;
}
@end
