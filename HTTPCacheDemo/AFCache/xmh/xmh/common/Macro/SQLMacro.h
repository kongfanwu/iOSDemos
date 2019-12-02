//
//  SQLMacro.h
//  iCardGod
//
//  Created by weilihua on 14/11/11.
//  Copyright (c) 2014年 51credit.com. All rights reserved.
//

#ifndef iCardGod_SQLMacro_h
#define iCardGod_SQLMacro_h

#pragma mark -
#pragma mark Test Table

//创建数据表SQL语句
static NSString * const CreateTabel        = @"CREATE TABLE IF NOT EXISTS t_userInfo (user_id integer PRIMARY KEY AUTOINCREMENT,user_name text,user_age text)";

//查询SQL语句
static NSString * const SelectTabel        = @"SELECT * FROM t_userInfo";

//插入SQL语句
static NSString * const AddDataToTabel     = @"INSERT INTO t_userInfo(user_name,user_age) VALUES('%@','%@')";

//更新SQL语句
static NSString * const UpdateTable        = @"UPDATE t_userInfo SET user_name = '%@',user_age = '%@' WHERE user_id = '%@'";

//删除SQL语句
static NSString * const DeleteTableData    = @"DELETE FROM t_userInfo WHERE user_id = '%@'";

static NSString * const DeleteTableAllData = @"DELETE FROM t_userInfo";

#endif
