//
//  LClearCardCell4.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/6.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"


#import "LClearCardCell4.h"
#import "TZImagePickerController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "TZImageManager.h"
#import "TZLocationManager.h"
#import "CollectionViewCell.h"
@interface LClearCardCell4()<TZImagePickerControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) CLLocation *location;
@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
@property (nonatomic ,strong) NSMutableArray *photosArray;
@property (nonatomic ,strong) NSMutableArray *assestArray;
@property (nonatomic ,strong) UICollectionView *collectionView;
@property BOOL isSelectOriginalPhoto;
@end
@implementation LClearCardCell4
{
    UIActionSheet * _sheet;
    UIViewController * _vc;
    CGFloat _itemWH;
    CGFloat _margin;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (NSMutableArray *)assestArray{
    if (!_assestArray) {
        self.assestArray = [NSMutableArray array];
    }
    return _assestArray;
}
- (NSMutableArray *)photosArray{
    if (!_photosArray) {
        self.photosArray = [NSMutableArray array];
    }
    return _photosArray;
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        _margin = 4;
        _itemWH = (SCREEN_WIDTH - 2 * _margin - 4) / 3 - _margin;
        UICollectionViewFlowLayout *flowLayOut = [[UICollectionViewFlowLayout alloc] init];
        flowLayOut.itemSize = CGSizeMake((SCREEN_WIDTH - 50)/ 4, (SCREEN_WIDTH - 50)/ 4);
        flowLayOut.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 25 + 15, SCREEN_WIDTH,100) collectionViewLayout:flowLayOut];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.scrollEnabled = NO;
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
    }
    return _collectionView;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initSubViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        [self getPresentedViewController];
        [self addSubview:self.collectionView];
    }
    return self;
}
- (void)initSubViews
{
    UILabel * line = [[UILabel alloc] init];
    line.backgroundColor = kBackgroundColor;
    line.frame = CGRectMake(0, 0, SCREEN_WIDTH, 10);
    [self addSubview:line];
    UILabel * lb = [[UILabel alloc] init];
    lb.text = @"上传图片";
    lb.font = FONT_BOLD_SIZE(15);
    lb.textColor = kLabelText_Commen_Color_3;
    [lb sizeToFit];
    lb.frame = CGRectMake(15, line.bottom + 15, lb.width, lb.height);
    [self addSubview:lb];
}
- (UIViewController *)getPresentedViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    if (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    _vc = topVC;
    return topVC;
}

- (void)checkLocalPhoto{
    
    TZImagePickerController *imagePicker = [[TZImagePickerController alloc] initWithMaxImagesCount:3 delegate:self];
    [imagePicker setSortAscendingByModificationDate:NO];
    imagePicker.isSelectOriginalPhoto = _isSelectOriginalPhoto;
    imagePicker.selectedAssets = _assestArray;
    imagePicker.allowPickingVideo = NO;
    [_vc presentViewController:imagePicker animated:YES completion:nil];
    
}
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    self.photosArray = [NSMutableArray arrayWithArray:photos];
    self.assestArray = [NSMutableArray arrayWithArray:assets];
    _isSelectOriginalPhoto = isSelectOriginalPhoto;
    if(_LClearCardCell4Block){
        _LClearCardCell4Block(_photosArray);
    }
    [_collectionView reloadData];
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    WeakSelf
    if (indexPath.row == _photosArray.count) {
        if (_photosArray.count == 3) {
            [MzzHud toastWithTitle:@"注意" message:@"最多选择3张图片"];
        }else{
            [weakSelf checkLocalPhoto];
        }
    }else{
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithSelectedAssets:_assestArray selectedPhotos:_photosArray index:indexPath.row];
        imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            _photosArray = [NSMutableArray arrayWithArray:photos];
            _assestArray = [NSMutableArray arrayWithArray:assets];
            _isSelectOriginalPhoto = isSelectOriginalPhoto;
            [_collectionView reloadData];
            _collectionView.contentSize = CGSizeMake(0, ((_photosArray.count + 2) / 3 ) * (_margin + _itemWH));
        }];
        [_vc presentViewController:imagePickerVc animated:YES completion:nil];
    }
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _photosArray.count+1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    if (indexPath.row == _photosArray.count) {
        cell.imagev.image = [UIImage imageNamed:@"stspyytajiantupian"];
        cell.deleteButton.hidden = YES;
        
    }else{
        cell.imagev.image = _photosArray[indexPath.row];
        cell.deleteButton.hidden = NO;
    }
    cell.deleteButton.tag = 100 + indexPath.row;
    [cell.deleteButton addTarget:self action:@selector(deletePhotos:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
    
}
- (void)deletePhotos:(UIButton *)sender{
    [_photosArray removeObjectAtIndex:sender.tag - 100];
    [_assestArray removeObjectAtIndex:sender.tag - 100];
    [_collectionView performBatchUpdates:^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:sender.tag-100 inSection:0];
        [_collectionView deleteItemsAtIndexPaths:@[indexPath]];
    } completion:^(BOOL finished) {
        [_collectionView reloadData];
        if(_LClearCardCell4Block){
            _LClearCardCell4Block(_photosArray);
        }
    }];
    
}

@end
#pragma clang diagnostic pop
