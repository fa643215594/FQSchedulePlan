//
//  myDatePickerView.h
//  KMDatePicker
//
//  Created by 单启志 on 2017/5/17.
//  Copyright © 2017年 Kenmu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myDatePickerView : UIPickerView

@property(nonatomic,copy)NSString *timeStr;

@property(nonatomic,copy) void(^selectBlock)(NSString*str);

@end
