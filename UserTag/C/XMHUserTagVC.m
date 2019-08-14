//
//  XMHUserTagVC.m
//  xmh
//
//  Created by kfw on 2019/8/12.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHUserTagVC.h"
#import "XMHUserTagSectionModel.h"
#import "XMHUserTagModel.h"
#import "XMHUserTagCollectionView.h"
#import "XMHUserTagLayout.h"
#import "XMHUserTagEditVC.h"

@interface XMHUserTagVC () <XMHUserTagCollectionViewDelegate>
/** <##> */
@property (nonatomic, strong) NSMutableArray <XMHUserTagSectionModel *> *dataArray;
/** <##> */
@property (nonatomic, strong) XMHUserTagCollectionView *collectionView;
@end

@implementation XMHUserTagVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        _type = XMHUserTagVCTypeLook;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBackgroundColor;
    
    self.navView.backgroundColor = kBtn_Commen_Color;
    [self.navView setNavViewTitle:@"顾客管理" backBtnShow:YES rightBtnTitle:@"编辑"];
    __weak typeof(self) _self = self;
    [self.navView setNavViewRightBlock:^{
        __strong typeof(_self) self = _self;
        XMHUserTagEditVC *vc = XMHUserTagEditVC.new;
        vc.selectDataArray = self.dataArray;
        [self.navigationController pushViewController:vc animated:YES];
        
        [vc setSureBlock:^(NSMutableArray<XMHUserTagSectionModel *> * _Nonnull selectDataArray) {
            __strong typeof(_self) self = _self;
            self.dataArray = selectDataArray;
            self.collectionView.dataArray = self.dataArray;
            [self.collectionView reloadData];
        }];
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
    
    
    sectionModel = XMHUserTagSectionModel.new;
    sectionModel.ID = @"2";
    [_dataArray addObject:sectionModel];
    sectionModel.name = @"section1";
    
    userTagModel = XMHUserTagModel.new;
    [sectionModel.childs addObject:userTagModel];
    userTagModel.ID = @"1";
    userTagModel.name = @"一";
    
    _collectionView.dataArray = _dataArray;
    [_collectionView reloadData];
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
