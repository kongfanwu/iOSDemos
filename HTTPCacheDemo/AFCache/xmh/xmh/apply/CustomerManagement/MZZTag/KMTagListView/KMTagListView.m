//
//  KMTagListView.m
//  KMTag
//
//  Created by chavez on 2017/7/13.
//  Copyright © 2017年 chavez. All rights reserved.
//

#import "KMTagListView.h"
#import "KMTag.h"
#import "MzzHud.h"
#import "MzzTags.h"
//#import "MBProgressHUD+NHAdd.h"
#import "MzzHud.h"
#define angle2Radius(angle) (angle)/180.f * M_PI
@interface KMTagListView ()

@property (nonatomic,strong)NSMutableArray *tags;

@property (nonatomic ,strong)NSMutableArray *datalist;

@property (nonatomic,strong)KMTag *touchTag;
@end

@implementation KMTagListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.bounces = NO;
        self.pagingEnabled = YES;
        self.backgroundColor = [UIColor lightGrayColor];
        self.scrollEnabled = NO;
    }
    return self;
}

- (NSMutableArray *)tags {
    if (_tags == nil) {
        _tags = [NSMutableArray array];
    }
    return _tags;
}


- (void)setupSubViewsWithTitles:(NSArray *)titles {
    _datalist = titles.mutableCopy;
    if (![_datalist.lastObject isKindOfClass:NSString.class]) {
            [_datalist addObject:@"+自定义"];
    }
   
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.tags removeAllObjects];
    
    for (NSInteger i = 0; i < _datalist.count; i++) {
        
        KMTag *tag = [[KMTag alloc] initWithFrame:CGRectZero];
       
        if (i  <_datalist.count -1) {
            MzzTag *tagModel = _datalist[i];
            tag.tagModel = tagModel;
            [tag setRemoveclick:^(KMTag *tag) {
                [_datalist removeObjectAtIndex:tag.tag];
                WeakSelf;
                [weakSelf setupSubViewsWithTitles:_datalist];
                if (_delegate_) {
                    [_delegate_ ptl_TagListView:self heightChange:self.contentSize.height lastList:_datalist currentIndexPath:_currentIndexPath ];
                    [_delegate_ ptl_TagListView:self didRemoveTagView:tag selectContent:tag.lbl.text currentIndexPath:_currentIndexPath];
                }
            }];
        }else{
            [tag setupWithText:@"+自定义"];
            [tag.backImgView setImage:[[UIImage imageNamed:@"stgukeguanlibiaoqian"]resizableImageWithCapInsets:UIEdgeInsetsMake(tag.height/2, tag.width/2, tag.height/2, tag.width/2) resizingMode:UIImageResizingModeStretch]];
            [tag.lbl setTextColor:[ColorTools colorWithHexString:@"f10180"]];
        }
        [self addSubview:tag];
        [self.tags addObject:tag];
        // 添加手势
        tag.tag = i;
        if (i  ==_datalist.count -1) {
            UITapGestureRecognizer *pan = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(zidingyiClick:)];
            [tag addGestureRecognizer:pan];
            tag.userInteractionEnabled = YES;
        }else{
            UITapGestureRecognizer *pan = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectTagClick:)];
            [tag addGestureRecognizer:pan];
            UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressHit:)];
            [tag addGestureRecognizer:longPress];
            tag.userInteractionEnabled = YES;
        }
    }
    
    UITapGestureRecognizer *panSelf = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selfClick:)];
    [self addGestureRecognizer:panSelf];
    [self setupAllSubViews];
}

- (void)zidingyiClick:(KMTag *)tag{
    [[[MzzHud alloc]initWithTextFieldTitle:@"请输入自定义名称" leftButtonTitle:@"取消" rightButtonTitle:@"确定" click:^(NSInteger index, NSString *text) {
        switch (index) {
            case 1:
            {
                if ([self.delegate_ respondsToSelector:@selector(ptl_TagListView:selectContent:currentIndexPath:)]) {
                    [self.delegate_ ptl_TagListView:self selectContent:text currentIndexPath:_currentIndexPath];
                }
            }
                break;
                
            default:
                break;
        }
    }]show];
}

- (void)selfClick:(UITapGestureRecognizer *)gesture{
    //退出编辑模式
    if ([self.delegate_ respondsToSelector:@selector(ptl_TagListView:enterEditStyle:)]) {
        [self.delegate_ ptl_TagListView:self enterEditStyle:NO];
    }
}

- (void)longPressHit:(UILongPressGestureRecognizer *)gesture {
    
    //NSLog(@"%ld",gesture.state);
    /*
     UIGestureRecognizerStatePossible,
     UIGestureRecognizerStateBegan, 触摸开始  1
     UIGestureRecognizerStateChanged, 触摸拖动  2
     UIGestureRecognizerStateEnded, 触摸结束 3
     UIGestureRecognizerStateCancelled,
     UIGestureRecognizerStateFailed,
     UIGestureRecognizerStateRecognized = UIGestureRecognizerStateEnded
     */
    //触摸开始
    //获得触摸的按钮

    if (gesture.state == UIGestureRecognizerStateBegan) {
        //进入编辑模式
        if ([self.delegate_ respondsToSelector:@selector(ptl_TagListView:enterEditStyle:)]) {
            [self.delegate_ ptl_TagListView:self enterEditStyle:YES];
        }
    }
    //触摸拖动 调用多次
    else if (gesture.state == UIGestureRecognizerStateChanged){

//        NSInteger index = [self indexOfPoint:btn.center withButton:btn];
       
    } else if (gesture.state == UIGestureRecognizerStateEnded){
    }
}


//传入point判断在哪个btn上面,返回btn tag
- (NSInteger)indexOfPoint:(CGPoint)point withButton:(KMTag *)btn {
    
    for (KMTag *button in self.tags) {
        //自己不比较
        if (btn != button ) {
            
            if (CGRectContainsPoint(button.frame, point) ) {//在范围内
                //返回tag值
                return button.tag;
            }
        }
    }
    //表示没有找到
    return -1;
}
- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    [self setupAllSubViews];
}


- (void)selectTagClick:(UIPanGestureRecognizer *)pan {
    KMTag *tag = (KMTag *)pan.view;
    tag.is_select = !tag.is_select;
    if ([self.delegate_ respondsToSelector:@selector(ptl_TagListView:didSelectTagView:selectContent:currentIndexPath:)]) {
        [self.delegate_ ptl_TagListView:self didSelectTagView:tag selectContent:tag.lbl.text currentIndexPath:_currentIndexPath];
    }
}



- (void)setupAllSubViews {
    

    CGFloat marginX = 10;
    CGFloat marginY = 10;
    
    __block CGFloat x = 0;
    __block CGFloat y = 10;
    
    [self.tags enumerateObjectsUsingBlock:^(KMTag *obj, NSUInteger idx, BOOL * _Nonnull stop) {
    
//        NSLog(@"%@",NSStringFromCGRect(obj.frame));
        CGFloat height = CGRectGetHeight(obj.frame);

        if (idx == 0) {
            x = marginX;
        }else {
            x = CGRectGetMaxX([self.tags[idx - 1] frame]) + marginX;
            if ( x + CGRectGetWidth(obj.frame) + marginX > CGRectGetWidth(self.frame) ) {
                x = marginX;
                y += height;
                y += marginY;
            }
        }
        CGRect frame = obj.frame;
        frame.origin = CGPointMake(x, y);
        obj.frame = frame;
        
    }];
    
    
    CGFloat contentHeight = CGRectGetMaxY([self.tags.lastObject frame]) + 10;
    if (contentHeight < CGRectGetHeight(self.frame)) {
        contentHeight = 0;
    }
    if (contentHeight < 11) {
        contentHeight = 44;
    }
//    if (contentHeight < 42) {
//        contentHeight = 44;
//    }
    
    self.contentSize = CGSizeMake(0, contentHeight);
    
    CGRect rect = self.frame;
    rect.size.height = self.height;
    self.frame = rect;
    
//    _viewHeight = CGRectGetMaxY([self.tags.lastObject frame]) + 10;
//    if (_viewHeight < 22) {
//        _viewHeight = 44;
//    }
}

-(void)setEditStyle:(BOOL)editStyle{
    CAKeyframeAnimation *animatioin = [CAKeyframeAnimation animation];
    animatioin.keyPath = @"transform.rotation";
    animatioin.values = @[@(angle2Radius(-2)),@(angle2Radius(2)),@(angle2Radius(-2))];
    animatioin.duration = 0.25;
    animatioin.repeatCount = CGFLOAT_MAX;
    //找出所有自定义button
    if (_tags.count == 0) {
        return;
    }
    for (int i = 0; i<_tags.count - 1; i++) {
        KMTag *tag = _tags[i];
        if (!tag.tagModel.content_is_sys) {
            //非系统按钮
            if (editStyle) {
                //增加抖动效果
                [tag setRemoveStyle:YES];
                [tag.layer addAnimation:animatioin forKey:@"wocao"];
            }else{
                 [tag setRemoveStyle:NO];
                  [ tag.layer removeAnimationForKey:@"wocao"];
            }
        }
    }
}

@end
