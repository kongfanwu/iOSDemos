//
//  DataView.m
//  xmh
//
//  Created by ald_ios on 2018/10/10.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "DataView.h"
#import "DataSubView.h"
#import "DateSubViewModel.h"
@implementation DataView
{
    NSObject * _dataModel; //数据模型
    NSArray * _titles;  //标题
    UIButton * _selectBtn;
    UIView * _indicator;
    UIView * _titleTabContainer;
    CGFloat _titleMargin;
    CGFloat  _dataViewH;
    CGFloat _lastCountBottom;
    NSArray * _dataSource;
    NSDictionary * _modelDict;
    UIButton * _more;
}
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles modelDict:(NSDictionary *)modelDict
{
    if (self = [super initWithFrame:frame]){
        self.backgroundColor = RGBColorWithAlpha(255, 255, 255, 0.96);
        self.layer.shadowColor= RGBColorWithAlpha(51, 51, 51, 0.14).CGColor;
        self.layer.shadowOpacity = 1;
        self.layer.shadowRadius = 30;
        self.layer.cornerRadius = 5;
        self.backgroundColor = [UIColor cyanColor];
//        self.layer.shadowOffset = CGSizeMake(30, 30);
        self.layer.masksToBounds = YES;
        _titles =  titles;
        _modelDict = modelDict;
        if (titles) {//有标题
            [self initHaveTitleUI];
        }else{//无标题
            [self initNOTitleUI];
        }
    }
    return self;
}
- (void)initNOTitleUI
{
    _titleMargin = 15;
    UIButton * more = [UIButton buttonWithType:UIButtonTypeCustom];
    more.frame = CGRectMake(0, self.height - 8 - 4,self.width, 4);
    [more setImage:UIImageName(@"xiala") forState:UIControlStateNormal];
    [more setImage:UIImageName(@"shousuo") forState:UIControlStateSelected];
    [more addTarget:self action:@selector(moreClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:more];
    [self moreClick:nil];
}
- (void)initHaveTitleUI
{
    
    UIView * titleTabContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    _titleTabContainer = titleTabContainer;
    [self addSubview:titleTabContainer];
    //左tap
    UIButton * leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftbtn.frame = CGRectMake(0, 0, SCREEN_WIDTH/2, titleTabContainer.height -2);
    [leftbtn setTitleColor:kLabelText_Commen_Color_6 forState:UIControlStateNormal];
    leftbtn.titleLabel.font = FONT_BOLD_SIZE(14);
    [leftbtn setTitleColor:kBtn_Commen_Color forState:UIControlStateSelected];
    leftbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    leftbtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    [leftbtn addTarget:self action:@selector(titleTapClick:) forControlEvents:UIControlEventTouchUpInside];
    [leftbtn setTitle:_titles[0] forState:UIControlStateNormal];
    leftbtn.tag = 100;
    [titleTabContainer addSubview:leftbtn];
    //右tap
    UIButton * rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightbtn.frame = CGRectMake(leftbtn.right, 0, SCREEN_WIDTH/2, titleTabContainer.height -2);
    [rightbtn setTitleColor:kLabelText_Commen_Color_6 forState:UIControlStateNormal];
    rightbtn.titleLabel.font = FONT_BOLD_SIZE(14);
    [rightbtn setTitleColor:kBtn_Commen_Color forState:UIControlStateSelected];
    rightbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    rightbtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [rightbtn addTarget:self action:@selector(titleTapClick:) forControlEvents:UIControlEventTouchUpInside];
    [rightbtn setTitle:_titles[1] forState:UIControlStateNormal];
    rightbtn.tag = 101;
    [titleTabContainer addSubview:rightbtn];
    //分割线
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, titleTabContainer.bottom-1, SCREEN_WIDTH, 1)];
    line.backgroundColor = kSeparatorLineColor;
    [titleTabContainer addSubview:line];
    //指示器
    UIView * indicator = [[UIView alloc] init];
    indicator.backgroundColor = kBtn_Commen_Color;
    _indicator = indicator;
    [titleTabContainer addSubview:indicator];
    
    [self titleTapClick:leftbtn];
    
    _titleMargin = 40;
    
    UIButton * more = [UIButton buttonWithType:UIButtonTypeCustom];
    more.frame = CGRectMake(0, self.height - 8 - 4,self.width, 4);
    [more setImage:UIImageName(@"xiala") forState:UIControlStateNormal];
    [more setImage:UIImageName(@"shousuo") forState:UIControlStateSelected];    
    [more addTarget:self action:@selector(moreClick:) forControlEvents:UIControlEventTouchUpInside];
    _more = more;
    [self addSubview:more];
    [self moreClick:nil];
}
- (void)titleTapClick:(UIButton *)titlebtn
{
    CGFloat margin = 10; // 指示器短于标题的长度
    CGFloat titleW =  [titlebtn.currentTitle stringWidthWithFont:FONT_BOLD_SIZE(14)];
    if (titlebtn.tag == 100) {
       _indicator.frame = CGRectMake(titlebtn.width - titleW - 10 + margin/2, _titleTabContainer.height - 2, titleW -margin, 2);
    }else if (titlebtn.tag == 101){
       _indicator.frame = CGRectMake(titlebtn.left + 10 + margin/2 , _titleTabContainer.height - 2, titleW - margin, 2);
    }else{}
    titlebtn.selected = YES;
    _selectBtn.selected = NO;
    _selectBtn = titlebtn;
}
- (void)moreClick:(UIButton *)more
{
    more.selected = !more.selected;
    if (_btnMoreButton) {
        _btnMoreButton(more.selected);
    }
    NSArray * arr = nil;
    if (_titles) {
        arr = _modelDict[_selectBtn.currentTitle];
    }else{
        arr = _modelDict[@"无"];
    }
    if (more.selected) {
        _dataSource = arr;
    }else{
        _dataSource = [arr subarrayWithRange:NSMakeRange(0, 4)];
    }
    more.frame = CGRectMake(0, self.height - 8 ,self.width, 4);
    [self createSubCountViews];
}
- (void)createSubCountViews
{
    for (UIView * view in self.subviews) {
        if ([view isKindOfClass:[DataSubView class]]) {
            [view removeFromSuperview];
        }
    }
//    NSMutableArray * arr = [[NSMutableArray alloc] init];
//    for (int i = 0; i < _dataSource.count; i++) {
//        DateSubViewModel * model = [DateSubViewModel createModelIconName:[NSString stringWithFormat:@"我的%d",i] textName:[NSString stringWithFormat:@"我的%d",i] textValue:[NSString stringWithFormat:@"%d",i + 100] isShow:YES];
//        [arr addObject:model];
//    }
    CGFloat subViewH = 53;
    CGFloat subViewW = self.width/2;
    for (int i = 0; i < _dataSource.count; i++) {
        DataSubView * subView = loadNibName(@"DataSubView");
        subView.backgroundColor = [UIColor redColor];
        [subView updateDataSubViewModel:_dataSource[i]];
        subView.frame = CGRectMake((i%2) * subViewW, _titleMargin + (i/2) * subViewH, subViewW, subViewH);
        if (i == _dataSource.count - 1) {
            _lastCountBottom = subView.bottom;
        }
        [self addSubview:subView];
    }
    _more.frame = CGRectMake(0, self.height - 8 ,self.width, 4);
}
- (void)updateDataViewModelDict:(NSDictionary *)modelDict withTitle:(NSArray *)titles
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _titles =  titles;
    _modelDict = modelDict;
    if (titles) {//有标题
        [self initHaveTitleUI];
    }else{//无标题
        [self initNOTitleUI];
    }
}
@end
