//
//  MzzPortraitView.m
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/11/16.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "MzzPortraitView.h"
#import "UICollectionViewLeftAlignedLayout.h"
#import "MzzPortraitCollectionViewCell.h"
#import "MzzSelectModel.h"
#import "MzzAddButtonCollectionViewCell.h"

@interface MzzPortraitView()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    UIColor *_textColor; // 文字颜色
    UIColor *_cellColor; // cell背景颜色
    UIColor *_cellBorderColor; // cell边框颜色
    NSMutableArray *titlearr;
}
@property(nonatomic,assign)BOOL select;
@property (nonatomic,strong)UICollectionViewLeftAlignedLayout *layout;
@property (nonatomic,strong)NSMutableArray *tagArr;
@property (nonatomic,strong)UILabel *titleOneLable;
@end
@implementation MzzPortraitView

-(UILabel *)titleOneLable
{
    if (!_titleOneLable) {
        _titleOneLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        _titleOneLable.text = @"顾客画像";
        _titleOneLable.textColor = kLabelText_Commen_Color_3;
        _titleOneLable.font = FONT_SIZE(15);
        _titleOneLable.textAlignment = NSTextAlignmentCenter;
        _titleOneLable.backgroundColor = [UIColor whiteColor];
    }
    return _titleOneLable;
}
- (UICollectionView *)myCollectionView
{
    if (!_myCollectionView) {
        _layout = [[UICollectionViewLeftAlignedLayout alloc]init];
        _myCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 44, self.frame.size.width, self.frame.size.height - 40 - 44) collectionViewLayout:_layout];
        _myCollectionView.delegate = self;
        _myCollectionView.dataSource = self;
        _myCollectionView.scrollEnabled = NO;
        // 1.设置列间距
        _layout.minimumInteritemSpacing = self.minitemSpace;
        // 2.设置行间距
        _layout.minimumLineSpacing = self.minlineSpace;
        _myCollectionView.backgroundColor = [UIColor whiteColor];
        [_myCollectionView registerClass:[MzzPortraitCollectionViewCell class] forCellWithReuseIdentifier:@"MzzPortraitCollectionViewCell"];
        
    }
    return _myCollectionView;
}
-(UIView *)botomView
{
    if (!_botomView) {
        _botomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 40, self.frame.size.width, 40)];
        _botomView.backgroundColor = [UIColor whiteColor];
        [_botomView addSubview:self.moreButton];
    }
    return _botomView;
}
-(UIButton *)moreButton
{
    if (!_moreButton) {
        _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _moreButton.frame = CGRectMake(0, 10, self.frame.size.width, 20);
        [_moreButton setImage:[UIImage imageNamed:@"paiming_xiala"] forState:UIControlStateNormal];
        [_moreButton setTitle:@"展开" forState:UIControlStateNormal];
        _moreButton.titleLabel.font = FONT_SIZE(13);
        [_moreButton setTitleColor:kColor9 forState:UIControlStateNormal];
        [_moreButton setTitleEdgeInsets:UIEdgeInsetsMake(0, - _moreButton.imageView.image.size.width-5, 0, _moreButton.imageView.image.size.width)];
        [_moreButton setImageEdgeInsets:UIEdgeInsetsMake(0, _moreButton.titleLabel.bounds.size.width+5, 0, -_moreButton.titleLabel.bounds.size.width)];
        [_moreButton addTarget:self action:@selector(moreButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreButton;
}
- (instancetype)initWithFrame:(CGRect)frame withArray:(NSArray *)dataArray andWithSelect:(BOOL)select
{
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = [UIColor whiteColor];
        [self.tagArr removeAllObjects];
        self.select = select;
        self.collectionViewMaxHeight = MAXFLOAT;
        
        _textColor = [UIColor grayColor];
        _cellColor = [UIColor whiteColor];
        _cellBorderColor = [UIColor grayColor];
        self.cellBorderWidth = 1;
        
        self.tagArr = [NSMutableArray arrayWithArray:dataArray];
        MzzselsectListModel * model = [[MzzselsectListModel alloc]init];
        model.content = @"添加";
        [self.tagArr addObject:model];
        self.edgeInset = UIEdgeInsetsMake(5, 15, 15, 15);
        self.minitemSpace = 10;
        self.minlineSpace = 10;
        self.textInterval = 15;
        self.cellHeight = 35;
        self.textFont = 15;
        [self addSubview:self.titleOneLable];
        [self addSubview:self.myCollectionView];
        [self addSubview:self.botomView];
        [self performSelector:@selector(returnTheContentViewHeight) withObject:nil afterDelay:0.1];
    }
    return self;
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.tagArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    MzzPortraitCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MzzPortraitCollectionViewCell" forIndexPath:indexPath];
        MzzselsectListModel * model =  self.tagArr[indexPath.row];
    cell.backgroundColor = _cellColor;
    NSString *title =[NSString stringWithFormat:@"%@",model.content];
    [cell setTheLabeValueWithFont:_textFont borderWidth:self.cellBorderWidth cornerRadius:self.cellCornerRadius andContent:title];
    cell.addButtonBlock = ^{
        if (_toPushAddPortrait) {
            _toPushAddPortrait();
        }
    };
        
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    MzzselsectListModel * model =  self.tagArr[indexPath.row];
    NSString *title = [NSString stringWithFormat:@"%@",model.content];
    CGSize thesize = [title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:_textFont]}];
    return CGSizeMake(thesize.width + self.textInterval*2, self.cellHeight);
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return self.edgeInset;
}


/**
 点击更多按钮显示全部标签
 */
-(void)moreButtonAction
{
    self.select = !self.select;
    int height;
    CGSize thesize = self.myCollectionView.contentSize;
    if (self.select) {
        height = thesize.height+40+44;
    }else{
        if (thesize.height+40+44<229) {
            height = thesize.height+40+44;
        }else{
            height = 229;
        }
    }
    if (_changeHeight) {
        _changeHeight(height,self.select);
    }
}
#pragma mark - 拿到高度
- (void)returnTheContentViewHeight
{
    CGSize thesize = self.myCollectionView.contentSize;
    int height = thesize.height+40+44;
    if (self.heightBlock) {
        self.heightBlock(height);
    }
}

@end
