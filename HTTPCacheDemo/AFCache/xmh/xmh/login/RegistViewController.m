//
//  RegistViewController.m
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/9/14.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "RegistViewController.h"
#import "NSString+Check.h"
#import "UserInfoRequest.h"
#import "NSString+DE.h"

@interface RegistViewController ()
@property (weak, nonatomic) IBOutlet UIView *numView;
@property (weak, nonatomic) IBOutlet UIView *codeView;
@property (weak, nonatomic) IBOutlet UITextField *numText;
@property (weak, nonatomic) IBOutlet UITextField *codeText;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnCode;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;

@end

@implementation RegistViewController
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _lbTitle.text = self.title;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.btnCode.tag=101;
    self.btnLogin.tag=102;
    [self.btnCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.btnCode setTitleColor:[ColorTools colorWithHexString:@"E73462"] forState:UIControlStateNormal];
    self.numText.clearButtonMode = UITextFieldViewModeWhileEditing;
    
}
- (IBAction)clickAction:(id)sender {
    UIButton *btn=(UIButton*)sender;
    WeakSelf
    if (btn.tag == 101) {
        if(!(self.numText.text.length>0)){
            [XMHProgressHUD showOnlyText:@"手机号不能为空"];
            return;
        }
        [UserInfoRequest requestSendCodePhone:self.numText.text resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
            if (isSuccess) {
                [XMHProgressHUD showOnlyText:@"验证码发送成功"];
                [weakSelf openCountdown];
            }else{
                [XMHProgressHUD showOnlyText:errorDic[@"error"]];
            }
        }];
    }else if(btn.tag ==102){
        if (self.numText.text.length && self.codeText.text.length) {
            [UserInfoRequest requestCheckPhone:self.numText.text code:self.codeText.text fastLogin:@"1" resultBlock:^(LolUserInfoModel *model, BOOL isSuccess, NSDictionary *errorDic) {
                if (isSuccess) {
                    [XMHProgressHUD showOnlyText:@"登录成功"];
                    [SVProgressHUD dismissWithCompletion:^{
                        [self.codeText resignFirstResponder];
                        [self.numText resignFirstResponder];
                        if (_successBlock) {
                            _successBlock(YES);
                        }
                    }];
                }else{
                    [XMHProgressHUD showOnlyText:errorDic[@"error"]];
                }
            }];
        }
    }else{//返回
        
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}
// 开启倒计时效果
-(void)openCountdown{
    
    __block NSInteger time = 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                [self.btnCode setTitle:@"重新发送" forState:UIControlStateNormal];
                [self.btnCode setTitleColor:kBtn_Commen_Color forState:UIControlStateNormal];
                self.btnCode.userInteractionEnabled = YES;
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [self.btnCode setTitle:[NSString stringWithFormat:@"%.2d%@", seconds,@"秒后重发"] forState:UIControlStateNormal];
                [self.btnCode setTitleColor:kBtn_Commen_Color forState:UIControlStateNormal];
                self.btnCode.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
