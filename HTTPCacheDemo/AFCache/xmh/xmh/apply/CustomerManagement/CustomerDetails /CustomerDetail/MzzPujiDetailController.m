//
//  MzzPujiDetailController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/28.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MzzPujiDetailController.h"
#import "MzzPujiButton.h"
#import "MzzPujiModel.h"
@interface MzzPujiDetailController ()
@property (nonatomic ,strong)UIScrollView *ctView;
@end

@implementation MzzPujiDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)pop{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)setupPujiArr:(NSArray *)pujiArr andTitle:(NSString *)title{
    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:title withleftImageStr:@"back" withRightStr:nil];
    [nav.btnLet addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _ctView = [[UIScrollView alloc] init];
    [_ctView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_ctView];
    
    CGFloat maxH = 0;
    //todo
    CGFloat marginW = 15;
    CGFloat marginH = 12;
    int col = 2;
    CGFloat witch = (SCREEN_WIDTH - (col + 1) * marginW) / col;
    CGFloat heigh = 28;
    NSInteger needDisplay =pujiArr.count;
    for (int i = 0; i <needDisplay; i ++) {
        int currentRow = i / col;
        int currentCol =   i % col;
        MzzPujiButton *btn = [MzzPujiButton buttonWithType:UIButtonTypeCustom];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [btn setTitleColor:kLabelText_Commen_Color_6 forState:UIControlStateNormal];
        [btn setTitleColor:kBtn_Commen_Color forState:UIControlStateSelected];
        btn.tag = i;
        btn.frame = CGRectMake(marginW +(marginW +witch)*currentCol, marginH + (marginH + heigh) * currentRow, witch, heigh);
        maxH =2* marginH + (marginH + heigh) *( currentRow+1);
        btn.selectColor = kBtn_Commen_Color;
        PujiCard *model = [pujiArr objectAtIndex:i];
        [btn setTitle:model.name forState:UIControlStateNormal];
        [btn setTitle:model.name forState:UIControlStateSelected];
        //        [btn addTarget:self action:@selector(btnOnclick:) forControlEvents:UIControlEventTouchUpInside];
        if (model.is_have) {
            [btn setSelected:YES];
        }
        [_ctView addSubview:btn];
    }
    if (maxH >=SCREEN_HEIGHT - Heigh_Nav) {
        _ctView.frame =CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav);
    }else{
        _ctView.frame =CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, maxH);
    }
    _ctView.contentSize = CGSizeMake(SCREEN_WIDTH, maxH);
}
@end
