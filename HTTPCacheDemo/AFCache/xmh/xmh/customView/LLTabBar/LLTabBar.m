//
//  LLTabBar.m
//  LLRiseTabBarDemo
//
//  Created by Meilbn on 10/18/15.
//  Copyright © 2015 meilbn. All rights reserved.
//

#import "LLTabBar.h"
#import "XMHBadgeLabel.h"
@interface LLTabBar ()

@property (strong, nonatomic) NSMutableArray *tabBarItems;

@end

@implementation LLTabBar{
    XMHBadgeLabel * _lb;          //消息条数
    NSInteger _selectIndex;
}

#pragma mark - Lifecycle

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	
	if (self) {
		[self config];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(messageCount:) name:Nav_MsgCount object:nil];
	}
	
	return self;
}

#pragma mark - Private Method

- (void)config {
	self.backgroundColor = [UIColor whiteColor];
	UIImageView *topLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, -0.5, [[UIScreen mainScreen] bounds].size.height, 0.5)];
    topLine.backgroundColor = [ColorTools colorWithHexString:@"e5e5e5"];
	[self addSubview:topLine];
}

- (void)setSelectedIndex:(NSInteger)index {
	for (LLTabBarItem *item in self.tabBarItems) {
		if (item.tag == index) {
			item.selected = YES;
		} else {
			item.selected = NO;
		}
	}
    if (index == 0) {
        _lb.hidden = YES;
    }
    if (_selectIndex==2 &&index ==2) {
         [[NSNotificationCenter defaultCenter]postNotificationName:@"Work_AddBtnClick" object:[NSString stringWithFormat:@"%ld",index]];
    }
    if (index == 2) {
         [[NSNotificationCenter defaultCenter]postNotificationName:@"TapWork" object:nil];
    }
    _selectIndex = index;
//
//    UIWindow *keyWindow = [[[UIApplication sharedApplication] delegate] window];
//    UINavigationController *rootNav = (UINavigationController *)keyWindow.rootViewController;
//    UITabBarController *tabBarController = (UITabBarController *)rootNav.topViewController;
    if (_tabbarVc) {
        _tabbarVc.selectedIndex = index;
    }
}

#pragma mark - Touch Event

- (void)itemSelected:(LLTabBarItem *)sender {
    [self setSelectedIndex:sender.tag];
}

#pragma mark - Setter

- (void)setTabBarItemAttributes:(NSArray<NSDictionary *> *)tabBarItemAttributes {
    _tabBarItemAttributes = tabBarItemAttributes.copy;
    
    CGFloat itemWidth = [UIScreen mainScreen].bounds.size.width / _tabBarItemAttributes.count;
    CGFloat tabBarHeight = CGRectGetHeight(self.frame);
    NSInteger itemTag = 0;
    BOOL passedRiseItem = NO;
    
    _tabBarItems = [NSMutableArray arrayWithCapacity:_tabBarItemAttributes.count];
    for (id item in _tabBarItemAttributes) {
        if ([item isKindOfClass:[NSDictionary class]]) {
            NSDictionary *itemDict = (NSDictionary *)item;
            
            LLTabBarItemType type = [itemDict[kLLTabBarItemAttributeType] integerValue];
            CGRect frame = CGRectMake(itemTag * itemWidth + (passedRiseItem ? itemWidth : 0), 0, itemWidth, tabBarHeight);
            
            LLTabBarItem *tabBarItem = [self tabBarItemWithFrame:frame
                                                           title:itemDict[kLLTabBarItemAttributeTitle]
                                                 normalImageName:itemDict[kLLTabBarItemAttributeNormalImageName]
                                               selectedImageName:itemDict[kLLTabBarItemAttributeSelectedImageName] tabBarItemType:type];
            if (itemTag == 0) {
                tabBarItem.selected = YES;
            }
            if (itemTag ==0) {
                if (!_lb) {
                    _lb = [XMHBadgeLabel defaultBadgeLabel];
//                    _lb.text = @"999";
                    _lb.backgroundColor = [ColorTools colorWithHexString:@"#f10180"];;
                    _lb.layer.borderColor = [UIColor whiteColor].CGColor;
                    _lb.layer.borderWidth = 2;
                    _lb.left = tabBarItem.centerX + 5;
                    _lb.top = tabBarItem.centerY - 25;
                    _lb.height = 14;
                    _lb.hidden = YES;
                    [tabBarItem addSubview:_lb];
                }
                
            }
            
            [tabBarItem addTarget:self action:@selector(itemSelected:) forControlEvents:UIControlEventTouchUpInside];
            
            tabBarItem.tag = itemTag;
            itemTag++;
            [_tabBarItems addObject:tabBarItem];
            [self addSubview:tabBarItem];
        }
    }
}

- (LLTabBarItem *)tabBarItemWithFrame:(CGRect)frame title:(NSString *)title normalImageName:(NSString *)normalImageName selectedImageName:(NSString *)selectedImageName tabBarItemType:(LLTabBarItemType)tabBarItemType {
    LLTabBarItem *item = [[LLTabBarItem alloc] initWithFrame:frame];
    [item setTitle:title forState:UIControlStateNormal];
    [item setTitle:title forState:UIControlStateSelected];
    item.titleLabel.font = [UIFont systemFontOfSize:12];
    UIImage *normalImage = [UIImage imageNamed:normalImageName];
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    [item setImage:normalImage forState:UIControlStateNormal];
    [item setImage:selectedImage forState:UIControlStateSelected];
    [item setTitleColor:[UIColor colorWithWhite:51 / 255.0 alpha:1] forState:UIControlStateNormal];
    [item setTitleColor:kBtn_Commen_Color forState:UIControlStateSelected];
    item.tabBarItemType = tabBarItemType;
    
    return item;
}

- (void)messageCount:(NSNotification *)not{
    NSString * str = not.object;
    if (str.integerValue == 0) {
        _lb.hidden = YES;
    }else{
        _lb.text = not.object;
        _lb.hidden = NO;
    }
}

@end
