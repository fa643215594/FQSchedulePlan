//
//  JGZuoXiPlanModel.h
//  haha
//
//  Created by faqiang feng on 2017/2/18.
//  Copyright © 2017年 faqiang feng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JGZuoXiPlanModel : NSObject

/**
 上午下午晚上
 */
@property(nonatomic,strong)NSString *typeTime;

/**
 上午下午晚上具体的作息计划
 */
@property(nonatomic,strong)NSMutableArray *subArr;


+(NSArray *)getsubArr;

//+(NSMutableArray *)getList;


//把请求过来的数据封装成想要的数据
+(NSMutableArray *)getLsitArrayWithSuBArray:(NSArray*)subArra;
@end
