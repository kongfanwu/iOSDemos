//
//  FWDSelectView.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/12.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLJishiSearchModel.h"
#import "SLSearchManagerModel.h"
#import "MzzStoreModel.h"
#import "JasonSearchView.h"

@interface FWDSelectView : UIView
//@property (nonatomic, strong)MLJishiSearchModel * jisListModel;
//@property (nonatomic, strong)SLSearchManagerModel * managerListModel;
//@property (nonatomic, strong)MzzStoreList * storeListModel;
@property (nonatomic,strong)JasonSearchView * search;

@property (nonatomic, strong) id listModel;
@property (nonatomic, copy)void (^FWDSelectViewBlock)(id model);
@end
