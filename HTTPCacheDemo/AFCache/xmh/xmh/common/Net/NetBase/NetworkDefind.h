//
//  NetworkDefind.h
//  iCard
//
//  Created by weilihua on 14-5-22.
//  Copyright (c    ) 2014年 woaika.com. All rights reserved.
//

#ifndef iCard_NetworkDefind_h
#define iCard_NetworkDefind_h
/** 本地调试 各个php人员的 地址 */
#define SERVE_URL           @"http://192.168.1.200/index.php/"
#define FUQIANG_URL         @"http://192.168.1.197/index.php/"
#define GAODONG_URL         @"http://192.168.1.153/"
#define DAGE_URL            @"http://192.168.1.162/index.php"
#define DONGZI_URL          @"http://192.168.1.107/"
#define MUMU_URL            @"http://192.168.1.184/index.php"

#define h5_URL              @"http://192.168.1.200:8083/"

//主控制器控制
/** 0 表示原Main  1 表示新的集成Main */
#define SERVER_MAIN     1



#define SERVER_APP                  [[NSUserDefaults standardUserDefaults] objectForKey:@"SERVER_APP"]
#define SERVER_H5                   [[NSUserDefaults standardUserDefaults] objectForKey:@"SERVER_H5"]
#define SERVER_COUNT                [[NSUserDefaults standardUserDefaults] objectForKey:@"SERVER_COUNT"]
#define SERVER_REPORT                [[NSUserDefaults standardUserDefaults] objectForKey:@"SERVER_REPORT"]

#ifdef DEBUG
#define SERVER_APP                  [[NSUserDefaults standardUserDefaults] objectForKey:@"SERVER_APP"]
#define SERVER_H5                   [[NSUserDefaults standardUserDefaults] objectForKey:@"SERVER_H5"]
#define SERVER_COUNT                [[NSUserDefaults standardUserDefaults] objectForKey:@"SERVER_COUNT"]
#define SERVER_REPORT                [[NSUserDefaults standardUserDefaults] objectForKey:@"SERVER_REPORT"]
#else
#define SERVER_APP                  @"http://b.api.shendengmeiye.com/"
#define SERVER_H5                   @"http://b.html.shendengmeiye.com/"
#define SERVER_COUNT                @"http://count.shendengmeiye.com/"
#endif


/** 是否是新的统计 */
//#define REPORT  1
//
//#define SERVER_REPORT               @"http://pc.test.api.shendengzhineng.com/statistics.php/"
#endif
