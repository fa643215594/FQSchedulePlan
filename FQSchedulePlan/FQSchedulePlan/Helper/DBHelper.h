
//  Created by 单启志 on 2017/3/8.
//  Copyright © 2017年 MRH. All rights reserved.
//

#import <Foundation/Foundation.h>

//数据库 字段
#define DBDeviceId @"deviceId"

#define DBZuoXiPlan @"zuoxiPlan"  //作息计划 schedule
#define DBWatchFee @"watchFee"      //手表话费
#define DBWatchBook @"watchBook"    //手表通讯录
#define DBMessageLog @"messageLog"  //消息记录
#define DBHealthStep @"healthStep"  //健康计步 目标步数
#define DBStepsReport @"StepsReport"//健康计步 实时步数

//修改字段里面的某个值（column相当于一个数组，cloumn里面的值为字典）
typedef enum:NSUInteger{
    updateTypeAdd,    //增加字段里面的某个数据
    updateTypeDelete, //删除字段里的某个数据
    updateTypeEdit,   //修改字段里面指定的某个数据
    updateTypeReplace,//整个字段内容替换

}updateType;

@interface DBHelper : NSObject

//单例
+(instancetype)share;

/**
 往表中中插入一列(可不调，search update内部操作)
 @param columnName 表的字段名
 */
-(void)addColumnToWatchTableWith:(NSString*)columnName;

/**
 插入 只有在新增设备的时候是插入一条数据，其余情况下全是update(可不调，search update内部操作)
 */
-(void)insertDataWithDeviceId:(NSString*)deviceId;


//初始化表(清空表里面的所有数据)
-(void)initTable;

// 删除掉某个设备
-(void)deleteWithDeviceId:(NSString*)deviceId;

/**
 查询表对应的数据

 @param columnName 字段名（对应界面的数据）
 @param deviceId   设备Id

 @return 数组(无值返回空数组)
 */
-(NSMutableArray*)getDateWithColumnName:(NSString*)columnName deviceId:(NSString*)deviceId;


/**
 增删改都调用这个方法

 @param ID          需要修改的Id 新增传nil
 @param columnName  哪个字段
 @param deviceId    设备ID
 @param editType    0 增 1 删 2 改 3数据库只保留一条数据
 @param dic         修改后的数据(字典)，删除传nil

 @return Yes成功 No失败
 */
-(BOOL)updateDataWithId:(NSString*)ID ColumnName:(NSString*)columnName deviceId:(NSString*)deviceId updateType:(updateType)updateType data:(id)dic;

@end
