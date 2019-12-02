//
//  SuggestViewController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/17.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "SuggestViewController.h"
#import "MineRequest.h"
#import "LolUserInfoModel.h"
#import "UserManager.h"
#import "TZImagePickerController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "TZImageManager.h"
#import "TZLocationManager.h"
#import "CollectionViewCell.h"
#import "Base64.h"
#import "ShareWorkInstance.h"
#import "RestrictionInput.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

@interface SuggestViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *tv;

@property (weak, nonatomic) IBOutlet UILabel *lbLoadImg;
@property (weak, nonatomic) IBOutlet UIButton *btnSure;
@property (weak, nonatomic) IBOutlet UILabel *describeLabel;
@property (nonatomic,strong)NSMutableArray *touchArray;
@end

@implementation SuggestViewController
{
    UIActionSheet * _sheet;
    UIViewController * _vc;
    CGFloat _itemWH;
    CGFloat _margin;
    NSArray * _imgsArr;
    NSString *typeStr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _top.constant = IS_IPHONE_X ? 103:80;
    [self creatNav];
    self.tv.delegate = self;
    self.btnSure.userInteractionEnabled = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChange:) name:UITextViewTextDidChangeNotification object:nil];
}
- (void)textFieldChange:(UITextView *)textView
{
    //判断输入(不能输入特殊字符)
    [RestrictionInput restrictionInputTextView:self.tv maxNumber:600 showView:self.view showErrorMessage:@""];
    
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([RestrictionInput isInputRuleAndBlank:text]) {//当输入符合规则和退格键时允许改变输入框
        return YES;
    } else {
        return NO;
    }
}
-(NSMutableArray *)touchArray
{
    if (!_touchArray) {
        _touchArray = [[NSMutableArray alloc]init];
    }
    return _touchArray;
}
- (IBAction)typeButtonAction:(id)sender {
    
    UIButton *btn = (UIButton*)sender;
    [self.touchArray addObject:@(btn.tag)];
    for (id i in self.touchArray) {
        int touchTag = [i intValue];
        UIButton *button = [self.view viewWithTag:touchTag];
        if (touchTag==btn.tag) {
            button.titleLabel.textColor = UIColor.redColor;//kBtn_Commen_Color;
            [button setTitleColor:kBtn_Commen_Color forState:UIControlStateNormal];
            button.layer.borderWidth = kBorderWidth;
            button.layer.borderColor = kBtn_Commen_Color.CGColor;
            button.backgroundColor = [UIColor colorWithRed:254/255.0 green:242/255.0 blue:248/255.0 alpha:1];
            typeStr = button.titleLabel.text;
        }else{
            [button setTitleColor:kLabelText_Commen_Color_3 forState:UIControlStateNormal];
            button.layer.borderWidth = kBorderWidth;
            button.layer.borderColor = kBackgroundColor.CGColor;
            button.backgroundColor = kBackgroundColor;
        }
    }
}

- (void)creatNav
{
    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"意见反馈" withleftImageStr:@"stgkgl_fanhui" withRightStr:nil];
    nav.lineImageView.hidden = YES;
    nav.backgroundColor = kBtn_Commen_Color;
    nav.lbTitle.textColor = [UIColor whiteColor];
    [nav.btnLet addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.tv.textContainerInset = UIEdgeInsetsMake(15, 15, 0, 15);
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length == 0) {
        self.describeLabel.hidden = NO;
        self.btnSure.backgroundColor = kBackgroundColor_CCCCCC;
        self.btnSure.userInteractionEnabled = NO;
    }else{
        self.describeLabel.hidden = YES;
        self.btnSure.backgroundColor = kBtn_Commen_Color;
        self.btnSure.userInteractionEnabled = YES;
    }
}
- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0) {
        self.describeLabel.hidden = NO;
        self.btnSure.backgroundColor = kBackgroundColor_CCCCCC;
        self.btnSure.userInteractionEnabled = NO;
    }else{
        self.describeLabel.hidden = YES;
        self.btnSure.backgroundColor = kBtn_Commen_Color;
        self.btnSure.userInteractionEnabled = YES;
    }
}
- (IBAction)submit:(id)sender {
    
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];

    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * accountId = [NSString stringWithFormat:@"%ld",infomodel.data.ID];
    NSString * phone = [NSString stringWithFormat:@"%@",infomodel.data.phone];
    NSString * oneClick = [NSString stringWithFormat:@"%ld",(long)[ShareWorkInstance shareInstance].share_join_code.fram_id];
    NSString * join_code = [ShareWorkInstance shareInstance].join_code;
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    NSString * frameName = [NSString stringWithFormat:@"%@",[ShareWorkInstance shareInstance].share_join_code.fram_id_name];
    NSString * name = [NSString stringWithFormat:@"%@",infomodel.data.name];
    NSString *backType;
    
    [param setValue:join_code?join_code:@"" forKey:@"join_code"];
    [param setValue:oneClick?oneClick:@"" forKey:@"oneClick"];
    [param setValue:accountId?accountId:@"" forKey:@"id"];
    [param setValue:phone?phone:@"" forKey:@"phone"];
    [param setValue:currentVersion?currentVersion:@"" forKey:@"version_name"];
    [param setValue:frameName?frameName:@"" forKey:@"frame_name"];
    [param setValue:self.tv.text?self.tv.text:@"" forKey:@"content"];
    
    [param setValue:[UIDevice currentDevice].model forKey:@"phone_type"];
    [param setValue:name?name:@"" forKey:@"back_name"];
    if ([typeStr isEqualToString:@"功能出错"]) {
        backType = @"1";
    }else if ([typeStr isEqualToString:@"出现闪退"]){
        backType = @"2";
    }else if ([typeStr isEqualToString:@"信息错误"]){
        backType = @"3";
    }else if ([typeStr isEqualToString:@"页面错乱"]){
        backType = @"4";
    }else if ([typeStr isEqualToString:@"体验问题"]){
        backType = @"5";
    }else if ([typeStr isEqualToString:@"出现乱码"]){
        backType = @"6";
    }else if ([typeStr isEqualToString:@"其他"]){
        backType = @"7";
    }
    [param setValue:backType?backType:@"" forKey:@"back_type"];
    WeakSelf;
    [MineRequest requestFeedbackParams:param resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            [XMHProgressHUD showOnlyText:@"已提交成功"];
            [weakSelf.navigationController popViewControllerAnimated:NO];
        }
    }];
}



@end
#pragma clang diagnostic pop
