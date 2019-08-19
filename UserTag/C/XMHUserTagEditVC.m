//
//  XMHUserTagVC.m
//  xmh
//
//  Created by kfw on 2019/8/12.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHUserTagEditVC.h"
#import "XMHUserTagSectionModel.h"
#import "XMHUserTagModel.h"
#import "XMHUserTagCollectionView.h"
#import "XMHUserTagLayout.h"

@interface XMHUserTagEditVC () <XMHUserTagCollectionViewDelegate>
/** <##> */
@property (nonatomic, strong) NSMutableArray <XMHUserTagSectionModel *> *dataArray;
/** <##> */
@property (nonatomic, strong) XMHUserTagCollectionView *collectionView;
/** <##> */
@property (nonatomic, strong) NSMutableArray *selectArray;

@end

@implementation XMHUserTagEditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBackgroundColor;
    self.navView.backgroundColor = kBtn_Commen_Color;
    
    [self.navView setNavViewTitle:@"顾客标签" backBtnShow:YES rightBtnTitle:@"确定"];
    __weak typeof(self) _self = self;
    [self.navView setNavViewBackBlock:^{
        __strong typeof(_self) self = _self;
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [self.navView setNavViewRightBlock:^{
        __strong typeof(_self) self = _self;
        [self sureClick];
    }];
    
    XMHUserTagLayout *layout = [[XMHUserTagLayout alloc] init];
    layout.sectionInsets = UIEdgeInsetsMake(0, 15, 0, 15);
    layout.itemHeight = 40;
    layout.itemSpace = 10;
    layout.lineSpace = 15;
    layout.headerViewHeight = 48;
    
    [layout setWidthComputeBlock:^CGFloat(NSIndexPath * _Nonnull indexPath, CGFloat height) {
        __strong typeof(_self) self = _self;
        XMHUserTagSectionModel *sectionMdoel = self.dataArray[indexPath.section];
        XMHUserTagModel *userTagModel = sectionMdoel.childs[indexPath.item];
        return userTagModel.cellSize.width;
    }];
    
    self.collectionView = [[XMHUserTagCollectionView alloc] initWithFrame:CGRectMake(0, KNaviBarHeight, self.view.width, self.view.height - KNaviBarHeight) collectionViewLayout:layout];
    _collectionView.backgroundColor = UIColor.whiteColor;
    _collectionView.aDelegate = self;
    [self.view addSubview:_collectionView];
    
    [self getData];
}

- (void)getData {
    self.dataArray = NSMutableArray.new;
    
    XMHUserTagSectionModel *sectionModel;
    XMHUserTagModel *userTagModel;

    sectionModel = XMHUserTagSectionModel.new;
    [_dataArray addObject:sectionModel];
    sectionModel.ID = @"1";
    sectionModel.name = @"section0";

    userTagModel = XMHUserTagModel.new;
    [sectionModel.childs addObject:userTagModel];
    userTagModel.ID = @"1";
    userTagModel.name = @"一";

    userTagModel = XMHUserTagModel.new;
    [sectionModel.childs addObject:userTagModel];
    userTagModel.ID = @"2";
    userTagModel.name = @"一二";

    userTagModel = XMHUserTagModel.new;
    [sectionModel.childs addObject:userTagModel];
    userTagModel.ID = @"3";
    userTagModel.name = @"一二三";

    userTagModel = XMHUserTagModel.new;
    [sectionModel.childs addObject:userTagModel];
    userTagModel.ID = @"4";
    userTagModel.name = @"一二三四";

    userTagModel = XMHUserTagModel.new;
    [sectionModel.childs addObject:userTagModel];
    userTagModel.ID = @"5";
    userTagModel.name = @"一二三四五";

    userTagModel = XMHUserTagModel.new;
    [sectionModel.childs addObject:userTagModel];
    userTagModel.ID = @"6";
    userTagModel.name = @"一二三四五六";

    userTagModel = XMHUserTagModel.new;
    [sectionModel.childs addObject:userTagModel];
    userTagModel.ID = @"7";
    userTagModel.name = @"一二三四五六七";

    userTagModel = XMHUserTagModel.new;
    [sectionModel.childs addObject:userTagModel];
    userTagModel.ID = @"8";
    userTagModel.name = @"一二三四五六七";

    userTagModel = XMHUserTagModel.new;
    [sectionModel.childs addObject:userTagModel];
    userTagModel.ID = @"9";
    userTagModel.name = @"一二三四五六七";



    userTagModel = XMHUserTagModel.new;
    userTagModel.type = XMHUserTagModelTypeAdd;
    [sectionModel.childs addObject:userTagModel];
    userTagModel.name = @"自定义";
    
    
    sectionModel = XMHUserTagSectionModel.new;
    sectionModel.ID = @"2";
    [_dataArray addObject:sectionModel];
    sectionModel.name = @"section1";

    userTagModel = XMHUserTagModel.new;
    [sectionModel.childs addObject:userTagModel];
    userTagModel.ID = @"1";
    userTagModel.name = @"一";
    userTagModel.deleteState = YES;

    userTagModel = XMHUserTagModel.new;
    [sectionModel.childs addObject:userTagModel];
    userTagModel.ID = @"2";
    userTagModel.name = @"一二";
    userTagModel.deleteState = YES;

    userTagModel = XMHUserTagModel.new;
    [sectionModel.childs addObject:userTagModel];
    userTagModel.ID = @"3";
    userTagModel.name = @"一二三";
    userTagModel.deleteState = YES;

    userTagModel = XMHUserTagModel.new;
    [sectionModel.childs addObject:userTagModel];
    userTagModel.ID = @"4";
    userTagModel.name = @"一二三四";
    userTagModel.deleteState = YES;
//
    userTagModel = XMHUserTagModel.new;
    userTagModel.deleteState = YES;
    [sectionModel.childs addObject:userTagModel];
    userTagModel.ID = @"5";
    userTagModel.name = @"一二三四五";

    userTagModel = XMHUserTagModel.new;
    userTagModel.deleteState = YES;
    [sectionModel.childs addObject:userTagModel];
    userTagModel.ID = @"6";
    userTagModel.name = @"一二三四五六";

    userTagModel = XMHUserTagModel.new;
    userTagModel.deleteState = YES;
    [sectionModel.childs addObject:userTagModel];
    userTagModel.ID = @"7";
    userTagModel.name = @"一二三四五六七";

    userTagModel = XMHUserTagModel.new;
    userTagModel.type = XMHUserTagModelTypeAdd;
    [sectionModel.childs addObject:userTagModel];
    userTagModel.name = @"自定义";
//
//
    sectionModel = XMHUserTagSectionModel.new;
    sectionModel.type = XMHUserTagSectionModelTypeAdd;
    sectionModel.footerName = @"添加分类";
    [_dataArray addObject:sectionModel];
    
    
    [_dataArray enumerateObjectsUsingBlock:^(XMHUserTagSectionModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj.childs enumerateObjectsUsingBlock:^(XMHUserTagModel * _Nonnull userTagModel, NSUInteger idx, BOOL * _Nonnull stop) {
            if (!(userTagModel.type == XMHUserTagModelTypeAdd)) {
                userTagModel.type = XMHUserTagModelTypeEdit;
            }
        }];
    }];
    
    // 将于选中的标签做选中状态
    for (XMHUserTagSectionModel *selectSectionModel in _selectDataArray) {
        // 遍历编辑section
        for (XMHUserTagSectionModel *sectionModel in _dataArray) {
            // section 相同
            if ([selectSectionModel.ID isEqualToString:sectionModel.ID]) {
                // 遍历选中标签
                for (XMHUserTagModel *selectUserTagMdoel in selectSectionModel.childs) {
                    // 遍历编辑标签
                    for (XMHUserTagModel *userTagMdoel in sectionModel.childs) {
                        // 选中标签与编辑的标签相同
                        if ([selectUserTagMdoel.ID isEqualToString:userTagMdoel.ID]) {
                            userTagMdoel.select = YES;
                            
                            [self addSelectTagUserModel:userTagMdoel sectionModel:sectionModel];
                        }
                    }
                }
            }
        }
    }
    
    _collectionView.dataArray = _dataArray;
    [_collectionView reloadData];
}

- (void)sureClick {
    if (self.sureBlock) self.sureBlock(self.selectArray);
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 获取已存在section. 如果不存在就添加section
 */
- (XMHUserTagSectionModel *)getSelectSectionModel:(XMHUserTagSectionModel *)searchSectionModel {
    XMHUserTagSectionModel *model;
    for (XMHUserTagSectionModel *temModel in self.selectArray) {
        if ([temModel.ID isEqualToString:searchSectionModel.ID]) {
            model = temModel;
            break;
        }
    }
    
    if (IsEmpty(model)) {
        searchSectionModel.childs = nil;
        [self.selectArray addObject:searchSectionModel];
        model = searchSectionModel;
    }
    return model;
}

/**
 添加选中标签
 */
- (void)addSelectTagUserModel:(XMHUserTagModel *)userTagModel sectionModel:(XMHUserTagSectionModel *)sectionMdoel {
    // 获取或添加新section
    XMHUserTagSectionModel *newSectionMdoel = [self getSelectSectionModel:[sectionMdoel mutableCopy]];
    XMHUserTagModel *newUserTagModel = [userTagModel mutableCopy];
    newUserTagModel.select = NO;
    newUserTagModel.deleteState = NO;
    newUserTagModel.type = XMHUserTagModelTypeNormal;
    [newSectionMdoel.childs addObject:newUserTagModel];
}

/**
 移除选中标签
 */
- (void)deleteSelectTagUserModel:(XMHUserTagModel *)userTagModel sectionModel:(XMHUserTagSectionModel *)sectionMdoel {
    // 获取或添加新section
    XMHUserTagSectionModel *newSectionMdoel = [self getSelectSectionModel:[sectionMdoel mutableCopy]];
    for (XMHUserTagModel *tmpModel in [newSectionMdoel.childs mutableCopy]) {
        if ([tmpModel.ID isEqualToString:userTagModel.ID]) {
            [newSectionMdoel.childs removeObject:tmpModel];
        }
    }
    
    // section model没有标签，从数组里移除
    if (newSectionMdoel.childs.count == 0) {
        [_selectArray removeObject:newSectionMdoel];
    }
}

- (void)showAlertPlaceholder:(NSString *)placeholder complete:(void(^)(NSString *text))complete {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    __weak UIAlertController *alertControllerWeak = alertController;
    //以下方法就可以实现在提示框中输入文本；
    
    //在AlertView中添加一个输入框
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = placeholder;
        [textField setValue:kColor9 forKeyPath:@"_placeholderLabel.textColor"];
        textField.backgroundColor = kColorF5F5F5;
    }];
    
    //添加一个取消按钮
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:cancel];
    
    //添加一个确定按钮 并获取AlertView中的第一个输入框 将其文本赋值给BUTTON的title
    UIAlertAction *fixed = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *textField = alertControllerWeak.textFields.firstObject;
        if (complete) complete(textField.text);
    }];
    [alertController addAction:fixed];
    
    [fixed setValue:kColorTheme forKey:@"titleTextColor"];
    [cancel setValue:kColorTheme forKey:@"titleTextColor"];
    
    //present出AlertView
    [self presentViewController:alertController animated:true completion:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        UIViewController *_UIAlertControllerTextFieldViewController = [alertController valueForKeyPath:@"_textFieldViewController"];

        UIView *vcSuperiView = _UIAlertControllerTextFieldViewController.view.superview;
        vcSuperiView.frame = CGRectMake(vcSuperiView.x, vcSuperiView.y - 10, vcSuperiView.width, vcSuperiView.height + 10);

        UITextField *textField = alertController.textFields.firstObject;
        UIView *textFieldBgView = textField.superview;
        UIView *textFieldBgViewSuperView = textFieldBgView.superview;

        for (UIView *v in textFieldBgViewSuperView.subviews) {
            if ([v isKindOfClass:[UIVisualEffectView class]]) {
                [v removeFromSuperview];
            } else if ([v isKindOfClass:[UIView class]]) {
                v.backgroundColor = kColorF5F5F5;
            }
        }
    });
}

#pragma mark - Lazy

- (NSMutableArray *)selectArray {
    if (_selectArray) return _selectArray;
    _selectArray = NSMutableArray.new;
    return _selectArray;
}

#pragma mark - XMHUserTagCollectionViewDelegate

/**
 选中事件
 */
- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    XMHUserTagSectionModel *sectionMdoel = _dataArray[indexPath.section];
    XMHUserTagModel *userTagModel = sectionMdoel.childs[indexPath.item];
    userTagModel.select = !userTagModel.select;
    [_collectionView reloadData];

    if (userTagModel.select) {
        [self addSelectTagUserModel:userTagModel sectionModel:sectionMdoel];
    } else {
        [self deleteSelectTagUserModel:userTagModel sectionModel:sectionMdoel];
    }
}

/**
 删除事件
 */
- (void)deleteCellIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"section:%ld row:%ld", indexPath.section, indexPath.item);
    XMHUserTagSectionModel *sectionModel = _dataArray[indexPath.section];
    XMHUserTagModel *userTagModel = sectionModel.childs[indexPath.item];
    
    [self deleteSelectTagUserModel:userTagModel sectionModel:sectionModel];
    
    [sectionModel.childs removeObjectAtIndex:indexPath.item];
//    [_collectionView reloadData];
    
    [_collectionView deleteItemsAtIndexPaths:@[indexPath]];
}

/**
 添加事件
 */
- (void)addCellIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(self) _self = self;
    [self showAlertPlaceholder:@"请输入自定义标签名称" complete:^(NSString *text) {
        __strong typeof(_self) self = _self;
        XMHUserTagModel *userTagModel = XMHUserTagModel.new;
        userTagModel.type = XMHUserTagModelTypeEdit;
        userTagModel.ID = @"1";
        userTagModel.name = text;
        
        XMHUserTagSectionModel *sectionModel = self.dataArray[indexPath.section];
        sectionModel.ID = @"3";
        [sectionModel.childs insertObject:userTagModel atIndex:sectionModel.childs.count - 1];
        [self.collectionView reloadData];
//        [self.collectionView performBatchUpdates:^{
//            [_collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:sectionModel.childs.count - 1 inSection:indexPath.section]]];
//        } completion:nil];
    }];
}

/**
 添加标签类型事件
 */
- (void)addTagType {
    __weak typeof(self) _self = self;
    [self showAlertPlaceholder:@"请输入自定义分类名称" complete:^(NSString *text) {
        __strong typeof(_self) self = _self;
        
        XMHUserTagSectionModel *sectionModel = XMHUserTagSectionModel.new;
        sectionModel.name = text;
        [self.dataArray insertObject:sectionModel atIndex:self.dataArray.count - 1];
        
        XMHUserTagModel *userTagModel = XMHUserTagModel.new;
        userTagModel.type = XMHUserTagModelTypeAdd;
        [sectionModel.childs addObject:userTagModel];
        userTagModel.name = @"自定义";
        
        self.collectionView.dataArray = self.dataArray;
        [self.collectionView reloadData];
//        [self.collectionView insertSections:[NSIndexSet indexSetWithIndex:indexPath.section]];
    }];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
