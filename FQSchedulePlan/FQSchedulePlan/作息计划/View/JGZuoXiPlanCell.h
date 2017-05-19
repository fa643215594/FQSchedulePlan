//
//  JGZuoXiPlanCell.h
//  haha
//
//  Created by faqiang feng on 2017/2/18.
//  Copyright © 2017年 faqiang feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JGZuoXiPlanModel.h"


//#define RGB(a,b,c) [UIColor colorWithRed:a/255.0 green:b/255.0 blue:c/255.0 alpha:1]
#define screenW [UIScreen mainScreen].bounds.size.width
#define screenH [UIScreen mainScreen].bounds.size.height
#define weakH 30
#define leftWidth 35

@interface JGZuoXiPlanCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *leftView;
//上午 下午 晚上
@property (weak, nonatomic) IBOutlet UILabel *leftLab;

@property(nonatomic,strong)JGZuoXiPlanModel *model;

@property(nonatomic,copy)void(^cellBtnClick)(int index);
@end
