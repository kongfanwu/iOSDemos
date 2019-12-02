//
//  CustomerGradeCell.m
//  xmh
//
//  Created by ald_ios on 2018/12/7.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "CustomerGradeCell.h"
#import "TJGradeCell.h"
#import "CustomerGradeListModel.h"

@interface CustomerGradeCell ()
<
UICollectionViewDelegate,
UICollectionViewDataSource
>
@property (nonatomic, strong)UILabel *lb1;
@property (nonatomic, strong)UILabel *lb2;
@property (nonatomic, strong)UILabel *line;
@end
@implementation CustomerGradeCell
{
    CustomerGradeModel * _gradeModel;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initSubViews];
    }
    return self;
}
- (void)initSubViews
{
    _lb1 = [[UILabel alloc] init];
    _lb1.font = FONT_SIZE(16);
    _lb1.textColor = kColor3;
    _lb1.text = @"门店";
    [self.contentView addSubview:_lb1];
    
    _lb2 = [[UILabel alloc] init];
    _lb2.font = FONT_SIZE(11);
    _lb2.text = @"数量";
    _lb2.textColor = [ColorTools colorWithHexString:@"#FF0000"];
    [self.contentView addSubview:_lb2];
    
    _line = [[UILabel alloc] init];
    _line.backgroundColor = kSeparatorColor;
    [self.contentView addSubview:_line];
    [self.contentView addSubview:self.gradeConllectionView];
}
- (UICollectionView *)gradeConllectionView
{
    if (!_gradeConllectionView) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake((SCREEN_WIDTH)/2, 20);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _gradeConllectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, _lb2.bottom, SCREEN_WIDTH,0) collectionViewLayout:layout];
        _gradeConllectionView.delegate = self;
        _gradeConllectionView.dataSource = self;
        _gradeConllectionView.showsHorizontalScrollIndicator = NO;
        [_gradeConllectionView registerNib:[UINib nibWithNibName:@"TJGradeCell" bundle:nil] forCellWithReuseIdentifier:@"TJGradeCell"];
        _gradeConllectionView.backgroundColor = [UIColor whiteColor];
        _gradeConllectionView.pagingEnabled = NO;
        _gradeConllectionView.userInteractionEnabled = NO;
    }
    return _gradeConllectionView;
}
#pragma mark ------UICollectionViewDelegate------
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TJGradeCell * gradeCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TJGradeCell" forIndexPath:indexPath];
    [gradeCell updateTJGradeCellModel:_gradeModel.list[indexPath.row] type:_gradeModel.type];
    return gradeCell;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _gradeModel.list.count;
}
- (void)updateCustomerGradeCellModel:(CustomerGradeModel *)model
{
    _gradeModel = model;
    _lb1.text = model.name;
    [_lb1 sizeToFit];
    _lb1.frame = CGRectMake(15, 15, _lb1.width, _lb1.height);
    
    _lb2.text = [NSString stringWithFormat:@"总顾客数：%@人",model.total];
    [_lb2 sizeToFit];
    _lb2.frame = CGRectMake(_lb1.left, _lb1.bottom + 5, _lb2.width, _lb2.height);
   _gradeConllectionView.frame = CGRectMake(0, 60, SCREEN_WIDTH, self.height - 60 - 15);
    [_gradeConllectionView reloadData];
    _line.frame = CGRectMake(0, self.height - 1, SCREEN_WIDTH, 1);
    
    if ([model.type isEqualToString:@"all"]) {
        _lb2.textColor = [ColorTools colorWithHexString:@"#FF0000"];
    }else{
        _lb2.textColor = kColor9;
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    _lb1.frame = CGRectMake(15, 15, _lb1.width, _lb1.height);
    _lb2.frame = CGRectMake(_lb1.left, _lb1.bottom + 5, _lb2.width, _lb2.height);
    _gradeConllectionView.frame = CGRectMake(0, _lb2.bottom, SCREEN_WIDTH, self.height - 60 - 15);
    _line.frame = CGRectMake(0, self.height - kSeparatorHeight, SCREEN_WIDTH, kSeparatorHeight);
}
@end
