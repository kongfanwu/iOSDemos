//
//  XMHSmartGuanJiaDetail.m
//  xmh
//
//  Created by ald_ios on 2019/6/5.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHSmartGuanJiaDetail.h"
#import "UILabel+LineSpace.h"
#import "XMHSmartGuanJiaListModel.h"
@interface XMHSmartGuanJiaDetail ()<UITextViewDelegate>
@end

@implementation XMHSmartGuanJiaDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubViews];
}
- (void)initSubViews
{
    [self.navView setNavViewTitle:@"智能管家设置详情" backBtnShow:YES];
    self.navView.backgroundColor = kBtn_Commen_Color;
    
    UIView * container = UIView.new;
    container.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:container];
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navView.mas_bottom);
        make.left.right.mas_equalTo(self.view);
    }];
    
    UILabel * lb1 = UILabel.new;
    [container  addSubview:lb1];
    lb1.text = @"触发条件";
    lb1.font = FONT_MEDIUM_SIZE(16);
    lb1.textColor = kColor3;
    [lb1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(container.left).mas_offset(15);
        make.top.mas_equalTo(container.top).mas_offset(15);
    }];

    UILabel * lb2 = UILabel.new;
    [container addSubview:lb2];
    lb2.numberOfLines = 0;
    lb2.lineBreakMode = NSLineBreakByCharWrapping;
    lb2.lineSpace = 5;
    lb2.text = @"每日针对即将流失的顾客，未消费和消耗N天，中午1点提醒";
    lb2.text = _paramModel.team;
    lb2.font = FONT_SIZE(14);
    lb2.textColor = kColor6;
    [lb2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(container.mas_left).mas_offset(15);
        make.right.mas_equalTo(container.mas_right).mas_offset(-15);
        make.top.mas_equalTo(lb1.mas_bottom).mas_offset(10);
    }];

    UIView * line = UIView.new;
    [container addSubview:line];
    line.backgroundColor = kSeparatorColor;
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(container.mas_left).mas_offset(15);
        make.right.mas_equalTo(container.mas_right).mas_offset(-15);
        make.top.mas_equalTo(lb2.mas_bottom).mas_offset(15);
        make.height.mas_equalTo(0.6);
    }];

    UILabel * lb3 = UILabel.new;
    [container addSubview:lb3];
    lb3.text = @"追踪内容";
    lb3.font = FONT_MEDIUM_SIZE(16);
    lb3.textColor = kColor3;
    [lb3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(container.mas_left).mas_offset(15);
        make.top.mas_equalTo(line.mas_top).mas_offset(15);
    }];

    UIView * bgView = UIView.new;
    [container addSubview:bgView];
    bgView.backgroundColor = kBackgroundColor;
    bgView.layer.cornerRadius = 3;
    bgView.layer.masksToBounds = YES;
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(container.mas_left).mas_offset(15);
        make.right.mas_equalTo(container.mas_right).mas_offset(-15);
        make.top.mas_equalTo(lb3.mas_bottom).mas_offset(15);
        make.height.mas_equalTo(250);
        make.bottom.mas_equalTo(-15);
    }];
    
    UITextView * textView = UITextView.new;
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing = 7;// 字体的行间距
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:15],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    textView.typingAttributes = attributes;
    textView.editable = NO;
    textView.delegate = self;
    textView.backgroundColor= [UIColor clearColor];
    [bgView addSubview:textView];
    textView.font = FONT_SIZE(15);
    textView.textColor = kColor6;
    textView.text = @"主人，您已有很长时间未到店，要知道再好的护理方案也需要您的配合才能达到效果，不断完善自己，您才会随时散发优秀魅力哟！";
    textView.text = _paramModel.content;
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(bgView).mas_offset(10);
        make.right.bottom.mas_equalTo(bgView.right).mas_offset(-10);
    }];
    
    UIView * btnContainer = UIView.new;
    [self.view addSubview:btnContainer];
    btnContainer.backgroundColor = [UIColor whiteColor];
    [btnContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(69 + kSafeAreaBottom);
    }];
    
    UIButton * btn = UIButton.new;
    [btn bk_addEventHandler:^(id sender) {
        UIButton * btn = (UIButton *)sender;
        if ([btn.currentTitle isEqualToString:@"确认"]) {
            [textView resignFirstResponder];
            [self requestCommitData];
            return ;
        }
        [btn setTitle:@"确认" forState:UIControlStateNormal];
        textView.editable = YES;
        
    } forControlEvents:UIControlEventTouchUpInside];
    [btnContainer addSubview:btn];
    btn.backgroundColor = kColorTheme;
    btn.layer.cornerRadius = 3;
    btn.layer.masksToBounds = YES;
    btn.titleLabel.font = FONT_SIZE(17);
    [btn setTitle:@"编辑" forState:UIControlStateNormal];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(btnContainer).mas_offset(15);
        make.top.mas_equalTo(btnContainer).mas_offset(13);
        make.right.mas_equalTo(btnContainer.right).mas_offset(-15);
        make.height.mas_equalTo(44);
    }];
    
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    _paramModel.content = textView.text;
}
#pragma mark------网络请求
/** 提交数据 */
- (void)requestCommitData
{
    [XMHProgressHUD showGifImage];
    
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * account = [NSString stringWithFormat:@"%@",infomodel.data.account];
    
    NSString * setID = _paramModel.setID;
    NSString * content = _paramModel.content;
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    /** 技师账号 */
    [param setValue:account?account:@"" forKey:@"account"];
    /** 编辑id */
    [param setValue:setID?setID:@"" forKey:@"id"];
    /** 编辑内容 */
    [param setValue:content?content:@"" forKey:@"content"];
    
    [YQNetworking postWithUrl:[XMHHostUrlManager url:kSMARTHELPER_GUANJIASETMODIFY_URL] refreshRequest:YES cache:YES params:param progressBlock:nil resultBlock:^(BaseModel * obj, BOOL isSuccess, NSError *error) {
        [XMHProgressHUD dismiss];
        if (isSuccess) {
            
        }else{
            
        }
    }];
    MzzLog(@".....提交数据");
}
@end
