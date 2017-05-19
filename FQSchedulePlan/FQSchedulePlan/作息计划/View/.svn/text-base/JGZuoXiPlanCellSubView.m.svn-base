//
//  JGZuoXiPlanCellSubView.m
//  haha
//
//  Created by faqiang feng on 2017/2/18.
//  Copyright © 2017年 faqiang feng. All rights reserved.
//

#import "JGZuoXiPlanCellSubView.h"


@implementation JGZuoXiPlanCellSubView

-(void)awakeFromNib{
    
    [super awakeFromNib];
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor clearColor];
        [self setLine];
    }
    return self;
}

-(void)setModel:(JGZuoXiCellSubModel *)model{
    
    _model=model;
    if (model.planArr.count>0) {
        [self setSubViewsNew];
    }
}


-(void)setLine{
    
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-0.5, self.frame.size.width, 0.5)];
    line.backgroundColor=RGB(204, 204, 204);
    [self addSubview:line];
    
}

//把一个数组分割成我想要的若干个数组
- (NSArray *)weekdaySortWithDayArray:(NSArray *)array {
    
    //NSArray *titleArr = @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
    
    NSArray *wholeArr = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7"];
    
    NSString *wholeStr = [wholeArr componentsJoinedByString:@""];
    
    NSArray *unSeleccArr = [wholeArr filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"NOT (SELF in %@)", array]];
    
    NSString *unSelectStr = [unSeleccArr componentsJoinedByString:@""];
    
    NSArray *sortArr = [wholeStr componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:unSelectStr]];
    
    NSMutableArray *array1 = [NSMutableArray arrayWithArray:sortArr];
    
    [array1 removeObject:@""];
    
    NSMutableArray *goalArr;
    
    for (NSString *subStr in array1) {
        
        NSMutableArray *subArr=[NSMutableArray array];
        if (subStr.length >= 1) {
            
            for (int i=0; i<subStr.length; i++) {
                NSString *value=[subStr substringWithRange:NSMakeRange(i, 1)];
                [subArr addObject:value];
            }
            
        } 
        if (!goalArr) {
            
            goalArr = [NSMutableArray array];
            
        }
        [goalArr addObject:subArr];
        
    }
    return goalArr;
    
}

-(void)setSubViewsNew{

    //赋值前, 清空之前的button
//    for (int i=0; i<self.subviews.count; i++) {
//
//        if ([self.subviews[i] isKindOfClass:[UIButton class]]) {
//
//            [self.subviews[i] removeFromSuperview];
//        }
//    }

   NSArray *arr1=[self weekdaySortWithDayArray:self.model.planArr];
    //134 //135 //15
    for (int i=0; i<arr1.count; i++) {
        
       NSArray *arrI=arr1[i];
        for (int i=0; i<arrI.count; i++) {
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            
            CGFloat h=self.frame.size.height+0.5;
            CGFloat w=h*arrI.count;
            CGFloat x=([arrI[0]intValue]-1)*h;
            CGFloat y=0;
            btn.frame=CGRectMake(x, y, w, h-1);
            if([self.model.Status isEqualToString:@"0"]){
                btn.backgroundColor=RGB(102, 102, 102);
            }else{
                btn.backgroundColor=_model.color;
            }
            UILabel *planTimeLab=[[UILabel alloc]init];
            //planTimeLab.text=self.model.planTimeStr;
            planTimeLab.text=[self timeStringWithMinute:self.model.minute];
            planTimeLab.textColor=[UIColor whiteColor];
            planTimeLab.font=[UIFont systemFontOfSize:12];
            CGSize timeLabSize=[planTimeLab.text sizeWithFont:[UIFont systemFontOfSize:12]];
            CGFloat timeX=(w-timeLabSize.width)/2;
            CGFloat timeY=8;//(h/2-timeLabSize.height)/2;
            planTimeLab.frame=CGRectMake(timeX, timeY, timeLabSize.width, timeLabSize.height);
            planTimeLab.textAlignment=NSTextAlignmentCenter;
            [planTimeLab sizeToFit];
            [btn addSubview:planTimeLab];
            
            UILabel *planNameLab=[[UILabel alloc]init];
            //planNameLab.text=self.model.planName;

             planNameLab.text=[self.model.planName stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            planNameLab.textColor=[UIColor whiteColor];
            planNameLab.font=[UIFont systemFontOfSize:12];
            CGSize nameLabSize=[planNameLab.text sizeWithFont:[UIFont systemFontOfSize:12]];
            CGFloat nameX=(w-nameLabSize.width)/2;
            CGFloat nameY=22;//h/2+(h/2-timeLabSize.height)/2;
            planNameLab.frame=CGRectMake(nameX , nameY, nameLabSize.width, nameLabSize.height);
            planNameLab.textAlignment=NSTextAlignmentCenter;
            [planNameLab sizeToFit];
            [btn addSubview:planNameLab];
            [self addSubview:btn];
            
            [btn addTarget:self action:@selector(onBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}

-(void)onBtnClick:(UIButton *)btn{
    if (self.btnClickBlock) {
        self.btnClickBlock();
    }
}

-(NSString *)timeStringWithMinute:(NSInteger)minute{

    //self.model.minute;

    NSInteger hour=minute/60;
    NSInteger minut=minute%60;
    NSString *str=[NSString stringWithFormat:@"%02ld:%02ld",hour,minut];
    return str;
}

@end
