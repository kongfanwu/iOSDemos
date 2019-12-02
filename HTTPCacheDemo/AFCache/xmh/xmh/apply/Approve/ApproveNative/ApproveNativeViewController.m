//
//  ApproveNativeViewController.m
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/5/21.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "ApproveNativeViewController.h"
#import "FWDRecordCell.h"
#import "MzzAwardView.h"
#import <YYModel/YYModel.h>
#import "LolUserInfoModel.h"
#import "UserManager.h"
#import "MzzCustomerRequest.h"
#import "OrderManagementViewController.h"
@interface ApproveNativeViewController ()<UITextViewDelegate>
@property (strong ,nonatomic)MzzAwardView *awardView;
@property (nonatomic ,strong)NSMutableArray <SaleModel *>* list;
@property (strong ,nonatomic)NSMutableArray *awardList;
@property (strong ,nonatomic)UILabel *placeholder;
@property (strong ,nonatomic)UITextView *textView;
@property (strong ,nonatomic)NSMutableArray <UIImage*> *imgs;

@end

@implementation ApproveNativeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatNav];
    [self setupUI];
    
}
- (void)creatNav{
    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"审批意见" withleftImageStr:@"stgkgl_fanhui" withRightStr:@"确定"];
    nav.backgroundColor = kColorTheme;
    nav.lbTitle.textColor = [UIColor whiteColor];
    [nav.btnRight setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nav.btnLet addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    [nav.btnRight addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
}
- (void)pop{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)submit:(UIButton *)sender{
    sender.enabled = NO;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        sender.enabled = YES;
//    });
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"account_id"]  = [NSString stringWithFormat:@"%ld",infomodel.data.ID];
    params[@"join_code"]  =[_data objectForKey:@"join_code"];
    params[@"type"]  =[_data objectForKey:@"type"];
    params[@"code"] =[_data objectForKey:@"code"];
    params[@"reason"] =_textView.text;
    params[@"award"] =_awardList.jsonData;
    [MzzCustomerRequest requestApprovalChangeStateParams:params resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        sender.enabled = YES;
        if (isSuccess) {
            [MzzHud toastWithTitle:@"提示" message:@"审批成功"  complete:^{
                //注释掉是为了订单管理的审批 审批通过后留在详情页 所以直接返回到上一页就好
//                for (UIViewController *temp in self.navigationController.viewControllers) {
//                    if ([temp isKindOfClass:[OrderManagementViewController class]]) {
//                        [self.navigationController popToViewController:temp animated:NO];
//                        return ;
//                    }
//                }
//                if (_BackBlock) {
//                    _BackBlock();
//                }
                [self.navigationController popViewControllerAnimated:NO];
            }];
        }else{
            [MzzHud toastWithTitle:@"提示" message:@"审批失败"  complete:^{
                
            }];
        }
    }];
}
- (void)setData:(NSDictionary *)data{
    _data = data;
    _list  = [NSMutableArray array];
    NSArray *arr = [data objectForKey:@"y_award"];
    if (arr.count > 0) {
        for (NSDictionary *dic in arr ) {
            SaleModel *model = [SaleModel yy_modelWithDictionary:dic];
            NSString*num = [dic objectForKey:@"num"];
            NSString*price = [dic objectForKey:@"price"];
            model.mzzAwardCount =num.integerValue;
            model.mzzAwardTotlePrice =price.integerValue;
            [_list addObject:model];
        }
    }
    
}

-(void)setupUI{
    WeakSelf;
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UIScrollView *bgView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, Heigh_View_normal)];
    [self.view addSubview:bgView];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    _textView.delegate = self;
    [bgView addSubview:_textView];
    
    _placeholder = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 25)];
    [_textView addSubview:_placeholder];
    _placeholder.text = @"请输入审批理由（非必填）";
    _placeholder.font = [UIFont systemFontOfSize:13];
    _placeholder.textColor = kLabelText_Commen_Color_6;
    
    FWDRecordCell * cell = [[[NSBundle mainBundle]loadNibNamed:@"FWDRecordCell" owner:nil options:nil]lastObject];
    cell.name.text = @"请添加图片";
    cell.tip.text = @"最多上传4张";
    cell.frame = CGRectMake(0, _textView.bottom + 10, SCREEN_WIDTH, 180);
    cell.FWDRecordCellBlock = ^(NSMutableArray *imgs) {
        _imgs = imgs;
    };
    [bgView addSubview:cell];
    
    
    if ( [[_data objectForKey:@"type"] isEqualToString:@"3"]) {
        _awardView  = [[[NSBundle mainBundle]loadNibNamed:@"MzzAwardView" owner:nil options:nil]firstObject];
        
        NSString *user_ID =  [_data objectForKey:@"user_id"];
        NSString *store_code =  _store_code;
        _awardView.user_id =user_ID.integerValue;
        _awardView.store_code = store_code;
        _awardView.frame = CGRectMake(0, cell.bottom + 10 , SCREEN_WIDTH, 80);
        [_awardView setAwardCommit:^(NSMutableArray<SaleModel *> *list, BOOL ifdele) {
            weakSelf.awardView.height = 80 + list.count * 44;
            bgView.contentSize = CGSizeMake(SCREEN_WIDTH, weakSelf.awardView.bottom + 10);
            //奖赠数据保存
            _awardList = [NSMutableArray array];
            for (SaleModel *model in list) {
                NSMutableDictionary *modeldic = [NSMutableDictionary dictionary];
                [modeldic setObject:model.code forKey:@"code"];
                [modeldic setObject:[NSString stringWithFormat:@"%ld",model.uid] forKey:@"id"];
                [modeldic setObject:model.name forKey:@"name"];
                [modeldic setObject:[NSString stringWithFormat:@"%ld",model.mzzAwardCount] forKey:@"num"];
                [modeldic setObject:[NSString stringWithFormat:@"%ld",model.mzzAwardTotlePrice] forKey:@"price"];
                [modeldic setObject:model.cardType forKey:@"type"];
                if (model.unit) {
                    [modeldic setObject:model.unit forKey:@"uint"];
                }
                [weakSelf.awardList addObject:modeldic];
            }
        }];
        _awardView.list = _list;
         [bgView addSubview:_awardView];
         bgView.contentSize = CGSizeMake(SCREEN_WIDTH, _awardView.bottom + 10);
    }else{
         bgView.contentSize = CGSizeMake(SCREEN_WIDTH, cell.bottom + 10);
    }
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    _placeholder.hidden = YES;
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    if (textView.text.length ==0) {
        _placeholder.hidden = NO;
    }
    return YES;
}
@end
