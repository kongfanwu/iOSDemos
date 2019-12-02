//
//  MzzNewfeatureController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/23.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MzzNewfeatureController.h"
#import "WorkRequest.h"
#import "WorkGreetListModel.h"
#import <YYWebImage/YYWebImage.h>
@interface MzzNewfeatureController ()<UIScrollViewDelegate>
@end

@implementation MzzNewfeatureController
{
    UIScrollView *_scrollView;
    WorkGreetListModel * _greetListModel;
    NSInteger _lastpageindex;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
//    NSUInteger count = 4;
    //新建一个scrollview
    _scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    _scrollView.delegate = self;
    //添加分页
    
    //取消弹簧效果
    _scrollView.bounces = NO;
    //分页效果
    _scrollView.pagingEnabled = YES;
    //取消水平显示条
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [WorkRequest requestWorkGreetParams:param resultBlock:^(WorkGreetListModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _greetListModel = model;
            /** 没有引导页不显示 */
            if (model.list.count > 0) {
               [self show];
            }else{
               [self onclick];
            }
            
        }else{/** 网络请求失败直接不展示引导页 */
            [self onclick];
        }
    }];
    
}

- (void)onclick{
    [[NSNotificationCenter defaultCenter] postNotificationName:AppDelegate_ChooseRoot object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)show
{
    for (int i = 0; i < _greetListModel.list.count ; i++) {
        //建立分页
        UIImageView *newfeature = [[UIImageView alloc] init];
        newfeature.contentMode = UIViewContentModeCenter;
        //设置tag方便确定滚到到了第几页
        newfeature.tag = i;
        CGFloat nfViewW = self.view.frame.size.width;
        CGFloat nfViewH = self.view.frame.size.height;
        CGFloat nfViewY = 0;
        CGFloat nfViewX = i * nfViewW;
        newfeature.frame = CGRectMake(nfViewX, nfViewY, nfViewW, nfViewH);
        WorkGreetModel * model = _greetListModel.list[i];
        if (IS_IPHONE_X) {
            [newfeature yy_setImageWithURL:URLSTR(model.pic) placeholder:nil];
        }else{
            [newfeature yy_setImageWithURL:URLSTR(model.pic) placeholder:nil];
        }
        newfeature.contentMode = UIViewContentModeScaleAspectFit;
        
        [_scrollView addSubview:newfeature];
        
        if (i == _greetListModel.list.count - 1) {
            //创建按钮
            UIButton *click = [UIButton buttonWithType:UIButtonTypeCustom];
            //            click.backgroundColor = [UIColor greenColor];
            if (IS_IPHONE_X) {
                click.frame =  CGRectMake( (i +0.5) * nfViewW - 60, nfViewH - 115, 120, 40);
            }else{
                click.frame =  CGRectMake( (i +0.5) * nfViewW - 60, nfViewH - 90, 120, 40);
            }
            [click addTarget:self action:@selector(onclick) forControlEvents:UIControlEventTouchUpInside];
            [_scrollView addSubview:click];
        }
    }
    //设置contentsize
    _scrollView.contentSize = CGSizeMake((_greetListModel.list.count)  * self.view.frame.size.width + 10, 0);
}
/** 滑到最后一页 继续滑动 消失 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int index = fabs(_scrollView.contentOffset.x)/self.view.frame.size.width;
    if(_lastpageindex == index) {
        _lastpageindex++;
    } else{
        _lastpageindex = index;
    }
    if (_lastpageindex>index){
        [self onclick];
    }
}

@end
