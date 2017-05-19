//
//  JGZuoXiCellSubModel.h
//  haha
//
//  Created by faqiang feng on 2017/2/18.
//  Copyright © 2017年 faqiang feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JGZuoXiCellSubModel : UIView


//------sdk返回的原始属性----------

//"Daily" : "Wednesday|Saturday",
@property(nonatomic,copy)NSString *Id;
@property(nonatomic,copy)NSString *Daily;
//"Details" : "sfdsf",
@property(nonatomic,copy)NSString *Details;
//"Time" : "09:06:00"
@property(nonatomic,copy)NSString *Time;
//开:1 关:0
@property(nonatomic,copy)NSString *Status;
//-------拓展属性(界面所需要的属性)---------

/**
 这是时间段，一周内有多少天进行了计划,例如：arr[@1,@3,@5,@7]
 */
@property(nonatomic,strong)NSArray *planArr;

/**
 选中作息时间的颜色 (不用赋值)
 */
@property(nonatomic,strong)UIColor *color;


/**
 作息计划名称
 */
@property(nonatomic,copy)NSString *planName;

/**
 作息时间分钟表示
 */
@property(nonatomic,assign)NSInteger minute;
/**
 闹钟是否开启
 */
@property(nonatomic,assign)BOOL isOpen;
@end
