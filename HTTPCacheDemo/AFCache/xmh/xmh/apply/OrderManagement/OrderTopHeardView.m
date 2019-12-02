//
//  OrderTopHeardView.m
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/10/15.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "OrderTopHeardView.h"
@interface OrderTopHeardView()
@property (weak, nonatomic) IBOutlet UIView *redLine;
@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (weak, nonatomic) IBOutlet UIButton *fristJobBtn;
@property (weak, nonatomic) IBOutlet UIButton *secondJobBtn;
@property (weak, nonatomic) IBOutlet UILabel *lbOneTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbOne;
@property (weak, nonatomic) IBOutlet UILabel *lbTwoTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbTwo;
@property (weak, nonatomic) IBOutlet UILabel *lbThreeTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbThree;
@property (weak, nonatomic) IBOutlet UILabel *lbFoureTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbFoure;
@property (weak, nonatomic) IBOutlet UILabel *lbFiveTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbFive;
@property (weak, nonatomic) IBOutlet UILabel *lbSixTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbSix;
@property (weak, nonatomic) IBOutlet UILabel *lbSevenTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbSeven;
@property (weak, nonatomic) IBOutlet UILabel *lbLastTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbLast;
@property (weak, nonatomic) IBOutlet UIView *threeBackGroundView;
@property (weak, nonatomic) IBOutlet UIView *foureBackGroundView;
@property (weak, nonatomic) IBOutlet UIImageView *touchOneImage;
@property (weak, nonatomic) IBOutlet UIImageView *touchTwoImage;
@property (weak, nonatomic) IBOutlet UIImageView *touchThreeImage;
@property (weak, nonatomic) IBOutlet UIView *oneView;
@property (weak, nonatomic) IBOutlet UIView *fiveView;
@property (weak, nonatomic) IBOutlet UIView *sevenView;
@property (weak, nonatomic) IBOutlet UIView *lastView;
@property (weak, nonatomic) IBOutlet UIButton *imageVeiw;
@property (weak, nonatomic) IBOutlet UIImageView *oneImageView;
@property (weak, nonatomic) IBOutlet UIImageView *twoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *threeImageView;
@property (weak, nonatomic) IBOutlet UIImageView *foureImageView;
@property (weak, nonatomic) IBOutlet UIImageView *fiveImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sixImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sevenImageView;
@property (weak, nonatomic) IBOutlet UIImageView *lastImageView;


@property (assign,nonatomic)BOOL notOnClick;
@property (nonatomic ,strong)NSArray <NSString *>*firstDetails;
@property (nonatomic ,strong)NSArray <NSString *>*secondDetails;

@property (nonatomic ,strong)NSArray <NSString *>*firstTitles;
@property (nonatomic ,strong)NSArray <NSString *>*secondTitles;

@end

@implementation OrderTopHeardView
{
    BOOL _selectMore;
    NSUInteger _indext;
    NSUInteger _click;
}

-(void)awakeFromNib {
    [super awakeFromNib];
    _notOnClick = YES;
    self.threeBackGroundView.hidden = YES;
    self.foureBackGroundView.hidden = YES;
    
    //创建手势oneview
    UITapGestureRecognizer *tap0 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(oneView:)];
    //设置手指字数
    tap0.numberOfTouchesRequired = 1;
    [self.oneView addGestureRecognizer:tap0];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(fiveView:)];
    //设置手指字数
    tap1.numberOfTouchesRequired = 1;
    [self.fiveView addGestureRecognizer:tap1];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sevenView:)];
    //设置手指字数
    tap2.numberOfTouchesRequired = 1;
    [self.sevenView addGestureRecognizer:tap2];
    
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lastView:)];
    //设置手指字数
    tap3.numberOfTouchesRequired = 1;
    [self.lastView addGestureRecognizer:tap3];
}

- (IBAction)firstBtn:(id)sender {
    [_fristJobBtn setTitleColor:kBtn_Commen_Color forState:UIControlStateNormal];
    [_secondJobBtn setTitleColor:kLabelText_Commen_Color_6 forState:UIControlStateNormal];
    self.redLine.center = CGPointMake(_fristJobBtn.center.x, _redLine.center.y);
    if (_notOnClick == NO) {
        if (_firstJobOnClick) {
            self.firstJobOnClick();
        }
    }
    _notOnClick = NO;
    _touchOneImage.hidden = NO;
    _touchTwoImage.hidden = NO;
    _touchThreeImage.hidden = NO;
    
    self.lbOneTitle.text = [NSString stringWithFormat:@"%@",_firstTitles[0]];
    self.lbTwoTitle.text = [NSString stringWithFormat:@"%@",_firstTitles[1]];
    self.lbThreeTitle.text = [NSString stringWithFormat:@"%@",_firstTitles[2]];
    self.lbFoureTitle.text = [NSString stringWithFormat:@"%@",_firstTitles[3]];
    self.lbFiveTitle.text = [NSString stringWithFormat:@"%@",_firstTitles[4]];
    self.lbSixTitle.text = [NSString stringWithFormat:@"%@",_firstTitles[5]];
    self.lbSevenTitle.text = [NSString stringWithFormat:@"%@",_firstTitles[6]];
    self.lbLastTitle.text = [NSString stringWithFormat:@"%@",_firstTitles[7]];
    
    self.lbOne.text = [NSString stringWithFormat:@"%@",_firstDetails[0]];
    self.lbTwo.text = [NSString stringWithFormat:@"%@",_firstDetails[1]];
    self.lbThree.text = [NSString stringWithFormat:@"%@",_firstDetails[2]];
    self.lbFoure.text = [NSString stringWithFormat:@"%@",_firstDetails[3]];
    self.lbFive.text = [NSString stringWithFormat:@"%@",_firstDetails[4]];
    self.lbSix.text = [NSString stringWithFormat:@"%@",_firstDetails[5]];
    self.lbSeven.text = [NSString stringWithFormat:@"%@",_firstDetails[6]];
    self.lbLast.text = [NSString stringWithFormat:@"%@",_firstDetails[7]];
    _indext = 0;
    
    self.oneImageView.image = [UIImage imageNamed:@"shouye_xiaoshouyeji"];
    self.twoImageView.image = [UIImage imageNamed:@"shouye_xiaoshoudanshu"];
    self.threeImageView.image = [UIImage imageNamed:@"shouye_xiaoshouxiangmushu"];
    self.foureImageView.image = [UIImage imageNamed:@"shouye_xiaoshourenshu"];
    self.fiveImageView.image = [UIImage imageNamed:@"shouye_huikuandanshu"];
    self.sixImageView.image = [UIImage imageNamed:@"shouye_weihuanqingjinge"];
    self.sevenImageView.image = [UIImage imageNamed:@"shouye_tuikuanjine"];
    self.lastImageView.image = [UIImage imageNamed:@"shouye_peihexiaofei"];

}
-(void)oneView:(UITapGestureRecognizer *)sender{
    //销售业绩
    if (_touchClick) {
        _touchClick(_indext,0);
    }
}
-(void)fiveView:(UITapGestureRecognizer *)sender{
    //回款单数
    if (_touchClick) {
        _touchClick(_indext,5);
    }
}
-(void)sevenView:(UITapGestureRecognizer *)sender{
    //退款金额
    if (_touchClick) {
        _touchClick(_indext,6);
    }
}
-(void)lastView:(UITapGestureRecognizer *)sender{
    //配合消费
    if (_touchClick) {
        if (_indext == 0) {
            _touchClick(0,7);
        }else{
            _touchClick(1,7);
        }
    }
}

- (IBAction)secondBtn:(id)sender {
    [_secondJobBtn setTitleColor:kBtn_Commen_Color forState:UIControlStateNormal];
    [_fristJobBtn setTitleColor:kLabelText_Commen_Color_6 forState:UIControlStateNormal];
    self.redLine.center = CGPointMake(_secondJobBtn.center.x, _redLine.center.y);
    if (_notOnClick == NO) {
        if (_secondJobOnClick) {
            self.secondJobOnClick();
        }
    }
    _notOnClick = NO;
    _touchOneImage.hidden = YES;
    _touchTwoImage.hidden = YES;
    _touchThreeImage.hidden = YES;
    self.lbOneTitle.text = [NSString stringWithFormat:@"%@",_secondTitles[0]];
    self.lbTwoTitle.text = [NSString stringWithFormat:@"%@",_secondTitles[1]];
    self.lbThreeTitle.text = [NSString stringWithFormat:@"%@",_secondTitles[2]];
    self.lbFoureTitle.text = [NSString stringWithFormat:@"%@",_secondTitles[3]];
    self.lbFiveTitle.text = [NSString stringWithFormat:@"%@",_secondTitles[4]];
    self.lbSixTitle.text = [NSString stringWithFormat:@"%@",_secondTitles[5]];
    self.lbSevenTitle.text = [NSString stringWithFormat:@"%@",_secondTitles[6]];
    self.lbLastTitle.text = [NSString stringWithFormat:@"%@",_secondTitles[7]];
    
    self.lbOne.text = [NSString stringWithFormat:@"%@",_secondDetails[0]];
    self.lbTwo.text = [NSString stringWithFormat:@"%@",_secondDetails[1]];
    self.lbThree.text = [NSString stringWithFormat:@"%@",_secondDetails[2]];
    self.lbFoure.text = [NSString stringWithFormat:@"%@",_secondDetails[3]];
    self.lbFive.text = [NSString stringWithFormat:@"%@",_secondDetails[4]];
    self.lbSix.text = [NSString stringWithFormat:@"%@",_secondDetails[5]];
    self.lbSeven.text = [NSString stringWithFormat:@"%@",_secondDetails[6]];
    self.lbLast.text = [NSString stringWithFormat:@"%@",_secondDetails[7]];
    _indext = 1;
    
    self.oneImageView.image = [UIImage imageNamed:@"shouye_fuwuyeji"];
    self.twoImageView.image = [UIImage imageNamed:@"shouye_fuwudanshu"];
    self.threeImageView.image = [UIImage imageNamed:@"shouye_fuwuxiangmushu"];
    self.foureImageView.image = [UIImage imageNamed:@"shouye_fuwurenshu"];
    self.fiveImageView.image = [UIImage imageNamed:@"shouye_xiaoshoufuwudanshu"];
    self.sixImageView.image = [UIImage imageNamed:@"shoye_xioashoufuwujine"];
    self.sevenImageView.image = [UIImage imageNamed:@"shouye_fuwuxiangmucishu"];
    self.lastImageView.image = [UIImage imageNamed:@"shouye_peihehaoka"];

}


-(void)setupWithFirstName:(NSString *)firstName andFirstTitles:(NSArray *)firstTitles andFirstDetails:(NSArray *)firstDetails andSecondName:(NSString *)secondName andSecondTitles:(NSArray *)secondTitles andSectondDetails:(NSArray *)secondDetails{
    [_fristJobBtn setTitle:firstName forState:UIControlStateNormal];
    _firstTitles = firstTitles;
    _firstDetails = firstDetails;
    _notOnClick = YES;
    _fristJobBtn.hidden = NO;
    _secondJobBtn.hidden = NO;
    [self firstBtn:_fristJobBtn];
    
}
-(void)setupWithFirstName:(NSString *)firstName andFirstTitles:(NSArray *)firstTitles andFirstDetails:(NSArray *)firstDetails{
    [_fristJobBtn setTitle:firstName forState:UIControlStateNormal];
    _firstTitles = firstTitles;
    _firstDetails = firstDetails;
    _notOnClick = YES;
    _fristJobBtn.hidden = NO;
    _secondJobBtn.hidden = NO;
    [self firstBtn:_fristJobBtn];

}
-(void)setupWithSecondName:(NSString *)secondName andSecondTitles:(NSArray *)secondTitles andSectondDetails:(NSArray *)secondDetails{
    [_secondJobBtn setTitle:secondName forState:UIControlStateNormal];
    _secondTitles = secondTitles;
    _secondDetails = secondDetails;
    _notOnClick = YES;
    _fristJobBtn.hidden = NO;
    _secondJobBtn.hidden = NO;
    [self secondBtn:_secondJobBtn];

    
}
- (IBAction)moreButtonAction:(id)sender {

    if (_selectMore == YES) {
        _selectMore = NO;
    }else{
        _selectMore = YES;
    }
    if (_selectMore == YES) {
        _imageVeiw.imageView.image =[UIImage imageNamed:@"shousuo"];
        self.threeBackGroundView.hidden = NO;
        self.foureBackGroundView.hidden = NO;
        
    }else{
        _imageVeiw.imageView.image =[UIImage imageNamed:@"xiala"];
        self.threeBackGroundView.hidden = YES;
        self.foureBackGroundView.hidden = YES;
    }
    if (_moreJobOnClick) {
        _moreJobOnClick(_selectMore);
    }
}

@end
