//
//  JGZuoXiPlanCellSubView.h
//  haha
//
//  Created by faqiang feng on 2017/2/18.
//  Copyright © 2017年 faqiang feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JGZuoXiCellSubModel.h"

#define RGB(r, g, b)    [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0f]

@interface JGZuoXiPlanCellSubView : UIView

@property(nonatomic,copy)JGZuoXiCellSubModel *model;
@property(nonatomic,copy)void(^btnClickBlock)();

@end
