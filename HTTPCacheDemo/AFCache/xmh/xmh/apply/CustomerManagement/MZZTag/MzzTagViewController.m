//
//  MzzTagViewController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/11.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MzzTagViewController.h"
#import"KMTagListView.h"
#import "MzzTagCell.h"
#import "MzzCustomerRequest.h"
#import "MzzTags.h"
#import "KMTag.h"
#import "MzzHud.h"

@interface MzzTagViewController ()<KMTagListViewDelegate,UITableViewDelegate,UITableViewDataSource,MzzTagCellDelegate>
@property (strong, nonatomic)NSMutableArray *list;
@property (assign ,nonatomic)BOOL editStyle;
@property (strong, nonatomic)NSMutableArray *sectionTagNotRemove;
@end

@implementation MzzTagViewController
{
    UITableView *_tableview;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatNav];
//    [self creatTagView];
    [self creatTableview];
   
    
}

-(void)creatNav{

    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"顾客标签" withleftImageStr:@"stgkgl_fanhui" withRightStr:@"确认"];
    nav.lbTitle.textColor = [UIColor whiteColor];
    nav.backgroundColor = kBtn_Commen_Color;
    [nav.btnLet addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    nav.btnRight.titleLabel.font = [UIFont systemFontOfSize:13];
    [nav.btnRight addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
}
//计算cell高度
- (CGFloat)cellForRowByCreatTagViewWithNsIndexPath:(NSIndexPath *)indexpath{
   //width与xib保持一致
    KMTagListView *tag = [[KMTagListView alloc]initWithFrame:CGRectMake(10, 100, 280, 0)];
    MzzSectionTags *sectionTags = _sectionTagNotRemove[indexpath.row];
    [tag setupSubViewsWithTitles:sectionTags.not_remove_content_list];
//    NSLog(@"%f",tag.contentSize.height);
    return tag.contentSize.height;
}
- (void)pop{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)sure{
 
    //category_add
    NSMutableArray *category_add = [NSMutableArray array];
    for (int i = 0; i <_sectionTagNotRemove.count; i++) {
        MzzSectionTags *sectionTags = _sectionTagNotRemove[i];
        if (sectionTags.isNewCreat) {
            NSString *name = sectionTags.name;
            NSString *user_id = @"23449";
            NSMutableArray * contentArr = [NSMutableArray array];
            for (int j =0; j<sectionTags.content_list.count; j++) {
                MzzTag *tag = sectionTags.content_list[j];
                if (!tag.is_remove) {
                    NSDictionary *contentDic = @{@"content":tag.content,@"is_select":[NSNumber numberWithInteger:tag.is_select]};
                    [contentArr addObject:contentDic];
                }
            }
            NSDictionary *category =@{@"name":name,@"user_id":user_id,@"content":contentArr};
             [category_add addObject:category];
        }
    }
    
    //content_add
     NSMutableArray *content_add = [NSMutableArray array];
    for (int i = 0; i <_sectionTagNotRemove.count; i++) {
          MzzSectionTags *sectionTags = _sectionTagNotRemove[i];
        for (int j =0; j<sectionTags.content_list.count; j++) {
            MzzTag *tag = sectionTags.content_list[j];
            if (!sectionTags.isNewCreat) {
                if (tag.isNewCreat) {
                    NSDictionary *contentDic = @{@"content":tag.content,@"is_select":[NSNumber numberWithInteger:tag.is_select],@"user_label_id":[NSNumber numberWithInteger:sectionTags.ID]};
                    [content_add addObject:contentDic];
                }
            }
        }
    }
    
    //del
    NSMutableArray *del_id = [NSMutableArray array];
    NSMutableArray *del_content_id = [NSMutableArray array];
    
    for (int i = 0; i <_list.count; i++) {
        MzzSectionTags *sectionTags = _list[i];
        if (sectionTags.isRemove) {
            [del_id addObject:[NSNumber numberWithInteger:sectionTags.ID]];
        }else{
            if (!sectionTags.isNewCreat) {
                for (int j =0; j<sectionTags.content_list.count; j++) {
                    MzzTag *tag = sectionTags.content_list[j];
                    if (tag.is_remove) {
                        [del_content_id addObject: [NSNumber numberWithInteger:tag.content_id]];
                    }
                }
            }
        }
    }
        NSMutableDictionary *del = [NSMutableDictionary dictionary];
        [del setObject:del_id forKey:@"id"];
        [del setObject:del_content_id forKey:@"content_id"];
    
    //select and unselect
    NSMutableArray *unselect_id = [NSMutableArray array];
      NSMutableArray *select_id = [NSMutableArray array];
    for (int i = 0; i <_sectionTagNotRemove.count; i++) {
        MzzSectionTags *sectionTags = _sectionTagNotRemove[i];
            for (int j =0; j<sectionTags.content_list.count; j++) {
                MzzTag *tag = sectionTags.content_list[j];
                if (!tag.isNewCreat) {
                    if (!tag.is_remove) {
                        if (tag.is_edit) {
                            if (tag.is_select) {
                                [select_id addObject:[NSNumber numberWithInteger:tag.content_id]];
                            }else{
                                [unselect_id addObject:[NSNumber numberWithInteger:tag.content_id]];
                            }
                        }
                    }
                }
            }
    }
    NSMutableDictionary *select = [NSMutableDictionary dictionaryWithObjectsAndKeys:select_id,@"content_id", nil];
    NSMutableDictionary *unselect =[NSMutableDictionary dictionaryWithObjectsAndKeys:unselect_id,@"content_id", nil];
    
    
    NSMutableDictionary *request = [NSMutableDictionary dictionary];
     [request setObject:category_add forKey:@"category_add"];
     [request setObject:content_add forKey:@"content_add"];
     [request setObject:del forKey:@"del"];
     [request setObject:select forKey:@"select"];
     [request setObject:unselect forKey:@"unselect"];
    
//    NSMutableDictionary *requestM = [NSMutableDictionary dictionary];
//    [requestM setObject:request.jsonData forKey:@"data"];
    
    [[[MzzHud alloc] initWithTitle:@"提示" message:@"已保存标签信息" centerButtonTitle:@"确定" click:^(NSInteger index) {
        if ([_delegate respondsToSelector:@selector(tagViewController:andTagInfo:)]) {
            [_delegate tagViewController:self andTagInfo:request];
        }
        [self.navigationController popViewControllerAnimated:NO];
    }]show];
}

- (void)setUser_id:(NSString *)user_id{
    _user_id = user_id;
    [self requsetData];
}

- (void)requsetData{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:_user_id,@"user_id", nil];
    [MzzCustomerRequest requestCustomerTagsParams:dic resultBlock:^(MzzTagDatas *lolCalendarModelList, BOOL isSuccess, NSDictionary *errorDic) {
        _list = [NSMutableArray arrayWithArray:lolCalendarModelList.list];
        UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        KMTag *tag= [[KMTag alloc] initWithFrame:CGRectMake(50, 10, 0, 0)];
        [tag setupWithText:@"+添加分类"];
        tag.layer.borderWidth = 1;
        tag.layer.cornerRadius = 1.f;
        tag.layer.borderColor = [ColorTools colorWithHexString:@"f10180"].CGColor;
        [tag.lbl setTextColor:[ColorTools colorWithHexString:@"f10180"]];
        [footView addSubview:tag];
        UITapGestureRecognizer *pan = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(zidingyiClick:)];
        [tag addGestureRecognizer:pan];
        tag.userInteractionEnabled = YES;
        _tableview.tableFooterView = footView;
        [_tableview reloadData];
    }];
   
}
#pragma mark - KMTagListViewDelegate

-(void)ptl_TagListView:(KMTagListView *)tagListView selectContent:(NSString *)content currentIndexPath:(NSIndexPath *)currentIndexPath{
    MzzTag *tagModel = [[MzzTag alloc] init];
    tagModel.is_select = NO; //lol 更改
    tagModel.isNewCreat = YES;
    tagModel.content_is_sys = NO;
    tagModel.content = content;
    MzzSectionTags *sectionTags = _sectionTagNotRemove[currentIndexPath.row];
    [sectionTags.content_list addObject:tagModel];
    [_tableview reloadData];
}

   


//编辑模式的进入和退出
-(void)ptl_TagListView:(KMTagListView *)tagListView enterEditStyle:(BOOL)editStyle{
    if (editStyle) {
        //进入编辑模式
        _editStyle = YES;
        [_tableview reloadData];
    }else{
        //退出编辑模式
        _editStyle = NO;
        [_tableview reloadData];
    }
}

//点击调用
- (void)ptl_TagListView:(KMTagListView*)tagListView didSelectTagView:(KMTag *)tagView selectContent:(NSString *)content currentIndexPath:(NSIndexPath *)currentIndexPath{
        MzzSectionTags *sectionTags = _sectionTagNotRemove[currentIndexPath.row];
        MzzTag *tagModel = sectionTags.not_remove_content_list[tagView.tag];
        tagModel.is_select = tagView.is_select;
        tagModel.is_edit =!tagModel.is_edit;
}
//删除调用
- (void)ptl_TagListView:(KMTagListView*)tagListView didRemoveTagView:(KMTag *)tagView selectContent:(NSString *)content currentIndexPath:(NSIndexPath *)currentIndexPath{
        MzzSectionTags *sectionTags = _sectionTagNotRemove[currentIndexPath.row];
        MzzTag *tagModel = sectionTags.not_remove_content_list[tagView.tag];
        tagModel.is_remove = YES;
//        [_tableview reloadRowsAtIndexPaths:@[currentIndexPath] withRowAnimation:UITableViewRowAnimationNone];
    [_tableview reloadData];
}


- (void)creatTableview{
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav) style:UITableViewStylePlain];
    _tableview.dataSource = self;
    _tableview.delegate = self;
    [self.view addSubview:_tableview];
}

- (void)zidingyiClick:(KMTag *)tag{
    [[[MzzHud alloc]initWithTextFieldTitle:@"请输入分类名称" leftButtonTitle:@"取消" rightButtonTitle:@"确定" click:^(NSInteger index, NSString *text) {
        if (index == 1) {
            MzzSectionTags *sectionTags = [[MzzSectionTags alloc] init];
            sectionTags.isNewCreat = YES;
            sectionTags.is_sys = NO;
            sectionTags.name = text;
            sectionTags.content_list = [NSMutableArray array];
            [_list addObject:sectionTags];
            [_tableview reloadData];
        }
    }]show];
}

#pragma mark - tableviewdelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self cellForRowByCreatTagViewWithNsIndexPath:indexPath];
}

- (void)ptl_TagListView:(KMTagListView*)tagListView heightChange:(CGFloat)height lastList:(NSMutableArray *)lastdataList currentIndexPath:(NSIndexPath *)currentIndexPath{
    //刷新对应行
//    [_tableview reloadRowsAtIndexPaths:@[currentIndexPath] withRowAnimation:UITableViewRowAnimationNone];
    [_tableview reloadData];
}
#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSMutableArray *notRemove = [NSMutableArray array];
    for (int i=0; i<_list.count; i++) {
        MzzSectionTags *sectionTags = _list[i];
        if (!sectionTags.isRemove) {
             NSMutableArray *notRemoveContent = [NSMutableArray array];
            for (int o = 0; o <sectionTags.content_list.count; o++) {
                MzzTag *tag =sectionTags.content_list[o];
                if (!tag.is_remove) {
                    [notRemoveContent addObject:tag];
                }
            }
            sectionTags.not_remove_content_list  = [NSMutableArray arrayWithArray:notRemoveContent];
            [notRemove addObject:sectionTags];
        }
    }
    _sectionTagNotRemove = [NSMutableArray arrayWithArray:notRemove];
    return _sectionTagNotRemove.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ident = @"MzzTagCell";

      MzzTagCell *  cell = [[[NSBundle mainBundle] loadNibNamed:ident owner:nil options:nil] firstObject];

    MzzSectionTags *sectionTags = _sectionTagNotRemove[indexPath.row];
    cell.sectionTags = sectionTags;
    cell.deleagte_ = self;
    cell.editStyle = _editStyle;
    cell.tagListView.editStyle = _editStyle;
    CGRect rect = cell.tagListView .frame;
    rect.size.height = cell.tagListView .contentSize.height;
    cell.tagListView .frame = rect;
    cell.currentIndexPath = indexPath;
    cell.tagListView.delegate_ = self;
    return cell;
}

#pragma mark - Table View Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - MzzTagCellDelegate
-(void)tagcell:(MzzTagCell *)cell removeBtnOnclick:(UIButton *)btn currentIndexPath:(NSIndexPath *)currentIndexPath{
    [[[MzzHud alloc]initWithTitle:@"提示" message:@"确定删除该分组？" leftButtonTitle:@"取消" rightButtonTitle:@"确定" click:^(NSInteger index) {
        if (index ==1) {
            MzzSectionTags *sectionTags =_sectionTagNotRemove[currentIndexPath.row];
            //保存删除的id
//            if (!sectionTags.isNewCreat) {
//                 [_del_id addObject:[NSNumber numberWithInteger:sectionTags.ID]];
                sectionTags.isRemove = YES;
//            }
//            [_list removeObjectAtIndex:currentIndexPath.row];
            [_tableview reloadData];
        }
    }]show];
}

@end
