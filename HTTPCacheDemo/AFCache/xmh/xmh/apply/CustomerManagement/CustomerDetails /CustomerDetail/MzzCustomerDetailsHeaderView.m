//
//  MzzCustomerDetailsHeaderView.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/7.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MzzCustomerDetailsHeaderView.h"
#import "MzzTitleAndDetailView.h"
#import "MzzSelectorCell.h"
#import <YYWebImage/YYWebImage.h>
@interface MzzCustomerDetailsHeaderView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic ,strong)UICollectionViewFlowLayout *scrollLayout;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toTopConstraint;
@property (nonatomic ,strong)UICollectionViewFlowLayout *scroll2Layout;
@property (weak, nonatomic) IBOutlet UIView *statisticsView;
@property (nonatomic ,strong)NSMutableArray *cardsList;
////记录index
@property (assign , nonatomic)NSInteger index1;
@property (assign , nonatomic)NSInteger index2;

//头部数据
@property (weak, nonatomic) IBOutlet UIImageView *icon;//头像
@property (weak, nonatomic) IBOutlet UILabel *lbName;//顾客姓名
@property (weak, nonatomic) IBOutlet UILabel *lbTotalTime;//累计消费时间
@property (weak, nonatomic) IBOutlet UILabel *lbOld;//年龄
@property (weak, nonatomic) IBOutlet UIButton *btnHD;//顾客类型
@property (weak, nonatomic) IBOutlet UIButton *btnDJ;//顾客等级
@property (weak, nonatomic) IBOutlet UILabel *leftValue;//总余额
@property (weak, nonatomic) IBOutlet UILabel *rightValue;//总欠款

//数据统计 数据
@property (weak, nonatomic) IBOutlet UILabel *lbGMJE;//购买金额
@property (weak, nonatomic) IBOutlet UILabel *lbXGXMS;//消费项目数
@property (weak, nonatomic) IBOutlet UILabel *lbXMYC;//项目余次
@property (weak, nonatomic) IBOutlet UILabel *lbXFCS;//消费次数
@property (weak, nonatomic) IBOutlet UILabel *lbDDCS;//到店次数
@property (weak, nonatomic) IBOutlet UILabel *lbDXKX;//待续卡项
@property (weak, nonatomic) IBOutlet UILabel *lbXFJE;//累计消耗金额
@property (weak, nonatomic) IBOutlet UILabel *lbYJDDCS;//月均到店次数
@property (weak, nonatomic) IBOutlet UILabel *lbHKDJ;//均次耗卡单价
@property (weak, nonatomic) IBOutlet UIView *equityView;//会员权益View
@property (weak, nonatomic) IBOutlet UIImageView *equityImageView;//会员权益图片
@property (weak, nonatomic) IBOutlet UILabel *equityLabel;//会员权益label
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnDjToTopConstraint;



@end
@implementation MzzCustomerDetailsHeaderView
static NSString *reuseIdentifier = @"reuseIdentifier";
static NSString *sReuseIdentifier = @"sReuseIdentifier";
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupScrollCollectionView];
        [self setupScroll2CollectionView];
        _cardsList = [NSMutableArray arrayWithObjects:@"储值卡",@"任选卡",@"时间卡",@"项目",@"产品",@"票券", @"账户",@"优惠券",nil];
    }
    return self;
}
-(void)setDataList:(NSArray *)dataList
{
    _dataList = dataList;
    [_scrollview reloadData];
}
-(void)awakeFromNib
{
    [super awakeFromNib];
    [self setupScrollCollectionView];
    [self setupScroll2CollectionView];
    _cardsList = [NSMutableArray arrayWithObjects:@"储值卡",@"任选卡",@"时间卡",@"项目",@"产品",@"票券", @"账户",@"优惠券",nil];
    [_btnHD.layer setBorderColor:[ColorTools colorWithHexString:@"#FFAF19"].CGColor];
    [_btnHD.layer setCornerRadius:8];
    [_btnHD.layer setBorderWidth:1];
    [_btnHD.layer setMasksToBounds:YES];
    [_btnHD setTitleColor:[ColorTools colorWithHexString:@"#FFAF19"] forState:UIControlStateNormal];
    
    [_btnDJ.layer setBorderColor:[ColorTools colorWithHexString:@"#FFAF19"].CGColor];
    [_btnDJ.layer setCornerRadius:8];
    [_btnDJ.layer setBorderWidth:1];
    [_btnDJ.layer setMasksToBounds:YES];
    [_btnDJ setTitleColor:[ColorTools colorWithHexString:@"#FFAF19"] forState:UIControlStateNormal];
}
- (void)setupScrollCollectionView {
    _scrollLayout = [[UICollectionViewFlowLayout alloc] init];
    _scrollLayout.itemSize = CGSizeMake(SCREEN_WIDTH / 5, 44);
    _scrollLayout.minimumLineSpacing = 0;
    _scrollLayout.minimumInteritemSpacing = 0;
    _scrollLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _scrollview = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44) collectionViewLayout:_scrollLayout];
    _scrollview.backgroundColor = [UIColor whiteColor];
    _scrollview.bounces = NO;
    _scrollview.tag = 0;
    _scrollview.pagingEnabled = NO;
    _scrollview.showsHorizontalScrollIndicator = NO;
    _scrollview.delegate = self;
    _scrollview.dataSource = self;
    [_scrollview registerClass:MzzSelectorCell.class forCellWithReuseIdentifier:sReuseIdentifier];
    [self addSubview:_scrollview];
}
- (void)setupScroll2CollectionView {
    _scroll2Layout = [[UICollectionViewFlowLayout alloc] init];
    _scroll2Layout.itemSize = CGSizeMake(80, 44);
    _scroll2Layout.minimumLineSpacing = 0;
    _scroll2Layout.minimumInteritemSpacing = 0;
    _scroll2Layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _scroll2view = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_scrollview.frame), SCREEN_WIDTH, 44) collectionViewLayout:_scroll2Layout];
    _scroll2view.backgroundColor = [UIColor whiteColor];
    _scroll2view.bounces = NO;
    _scroll2view.tag =1;
    _scroll2view.pagingEnabled = NO;
    _scroll2view.showsHorizontalScrollIndicator = NO;
    _scroll2view.delegate = self;
    _scroll2view.dataSource = self;
    [_scroll2view registerClass:MzzSelectorCell.class forCellWithReuseIdentifier:sReuseIdentifier];
    [self addSubview:_scroll2view];
}
- (void)setindex1:(NSInteger)index1 andIndex2:(NSInteger)index2
{
    _index1 = index1;
    _index2 = index2;
    if (_index1 == 1) {
        self.toTopConstraint.constant = 98;
    }else{
        self.toTopConstraint.constant = 54;
    }
    [_scrollview reloadData];
    [_scroll2view reloadData];
    [_scroll2view scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_index2 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}
-(void)setOneCollection:(BOOL)OneCollection
{
    [_scroll2view setHidden:YES];
}
#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView.tag == 0) {
        return 6;
    }else{
        return _cardsList.count;
    }
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    if (collectionView.tag ==0) {
        MzzSelectorCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:sReuseIdentifier forIndexPath:indexPath];
        if (_index1 == indexPath.item) {
            [cell selfOnclick:YES];
        }else{
            [cell selfOnclick:NO];
        }
        switch (indexPath.item) {
            case 0:
            {
                [cell setTitleText:@"顾客信息"];
            }
                break;
            case 1:
            {
                [cell setTitleText:@"顾客账单"];
            }
                break;
            case 2:
            {
                [cell setTitleText:@"顾客处方"];
            }
                break;
            case 3:
            {
                [cell setTitleText:@"消费记录"];
            }
                break;
            case 4:
            {
                [cell setTitleText:@"消耗记录"];
            }
                break;
            case 5:
            {
                [cell setTitleText:@"卡项普及"];
            }
                break;
                
            default:
                break;
        }
        return cell;
    }else{
        MzzSelectorCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:sReuseIdentifier forIndexPath:indexPath];
        if (_index2 == indexPath.item) {
            [cell selfOnclick:YES];
        }else{
            [cell selfOnclick:NO];
        }
        for (int i = 0 ; i <_cardsList.count; i++) {
            if (i ==indexPath.row) {
                [cell setTitleText:_cardsList[i]];
            }
        }
        
        return cell;
    }
}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.tag ==0) {
        _index1 = indexPath.item;
    }else{
        _index2 = indexPath.item;
    }
    if ([_delegate respondsToSelector:@selector(customerdetailsHeaderView:andIndex1:andIndex2:)]) {
        [_delegate customerdetailsHeaderView:self andIndex1:_index1 andIndex2:_index2];
    }
    if ([_delegate respondsToSelector:@selector(customerdetailsHeaderView:atCollectionView:onlickAtIndexPath:)]) {
        [_delegate customerdetailsHeaderView:self atCollectionView:collectionView.tag onlickAtIndexPath:indexPath];
    }
}
- (void)setUserInfoModel:(MzzUserInfoModel *)userInfoModel
{
    _userInfoModel = userInfoModel;
    //头部数据赋值
    [_icon yy_setImageWithURL:[NSURL URLWithString:userInfoModel.headimgurl] placeholder:kDefaultCustomerImage]; ;
    _lbName.text = userInfoModel.name;
    _lbTotalTime.text = [NSString stringWithFormat:@"累计消费时间：%ld个月",userInfoModel.sales_month];
    _lbOld.text = [NSString stringWithFormat:@"年龄：%ld个月",userInfoModel.sales_month];
    if (userInfoModel.grade_name.length >0) {
        [_btnDJ setTitle:userInfoModel.grade_name forState:UIControlStateNormal];
    }else{
        [_btnDJ setHidden:YES];
    }
    [_btnHD setTitle:userInfoModel.zt_name forState:UIControlStateNormal];
    _leftValue.text = [NSString stringWithFormat:@"%ld",userInfoModel.z_price];
    _rightValue.text = userInfoModel.qiankuan;
    
    //统计数据赋值
    
    
    //购买金额
    _lbGMJE.text = [NSString stringWithFormat:@"%ld",_userInfoModel.sales_prcie];
    //消费项目数
    _lbXGXMS.text = [NSString stringWithFormat:@"%ld",_userInfoModel.serv_num];
    //项目余次
    _lbXMYC.text = [NSString stringWithFormat:@"%ld",_userInfoModel.pro_num];
    //消费次数
    _lbXFCS.text = [NSString stringWithFormat:@"%ld",_userInfoModel.sales_num];
    //到店次数
    _lbDDCS.text = [NSString stringWithFormat:@"%ld",_userInfoModel.day_num];
    //待续卡项
    _lbDXKX.text = [NSString stringWithFormat:@"%ld",_userInfoModel.xuka];
    //累计消耗金额
    _lbXFJE.text = [NSString stringWithFormat:@"%ld",_userInfoModel.serv_price];
    //月均到店次数
    _lbYJDDCS.text = [NSString stringWithFormat:@"%ld",_userInfoModel.avg_daodian];
    //均次耗卡单价
    _lbHKDJ.text = [NSString stringWithFormat:@"%ld",_userInfoModel.avg_haoka];
    
    //会员权益
    if ([userInfoModel.equity isEqualToString:@"NULL"]||[userInfoModel.equity isEqualToString:@""]) {
        self.equityView.hidden = YES;
        self.btnDjToTopConstraint.constant = 21;
    }else{
        self.equityView.hidden = NO;
        self.btnDjToTopConstraint.constant = 65;
        if ([userInfoModel.equity isEqualToString:@"至尊权益"]) {
            self.equityImageView.image = [UIImage imageNamed:@"gkgl_zhizun"];
        }else if ([userInfoModel.equity isEqualToString:@"普卡权益"]){
            self.equityImageView.image = [UIImage imageNamed:@"gkgl_puka"];
        }else if ([userInfoModel.equity isEqualToString:@"金卡权益"]){
            self.equityImageView.image = [UIImage imageNamed:@"gkgl_jinka"];
        }else{
            self.equityImageView.image = [UIImage imageNamed:@"gkgl_zuanshi"];
        }
        self.equityLabel.text = userInfoModel.equity;
    }
}
@end


