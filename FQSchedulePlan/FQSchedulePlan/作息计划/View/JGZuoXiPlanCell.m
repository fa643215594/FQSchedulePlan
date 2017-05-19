//
//  JGZuoXiPlanCell.m
//  haha
//
//  Created by faqiang feng on 2017/2/18.
//  Copyright © 2017年 faqiang feng. All rights reserved.
//

#import "JGZuoXiPlanCell.h"
#import "JGZuoXiPlanCellSubView.h"
@interface JGZuoXiPlanCell()

@property (weak, nonatomic) IBOutlet UIView *rightView;

@property(nonatomic,strong)JGZuoXiPlanCellSubView *cellSubView;

@end

@implementation JGZuoXiPlanCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
}

-(void)setModel:(JGZuoXiPlanModel *)model{
    _model=model;
    //先把之前的清除掉
    NSArray *arr=self.rightView.subviews;
    for (int i=0; i<arr.count; i++) {
        id subView=arr[i];
        if ([subView isKindOfClass:[JGZuoXiPlanCellSubView class]]) {
            [subView removeFromSuperview];
        }
    }
    
    self.leftLab.text=model.typeTime;
    NSInteger cellCount=model.subArr.count<=4?4:model.subArr.count;
    for (int i=0; i<=cellCount; i++) {
        CGFloat h=(screenW-leftWidth)/7;
        CGFloat y=i*h;
       JGZuoXiPlanCellSubView *cellSubView=[[JGZuoXiPlanCellSubView alloc]initWithFrame:CGRectMake(0, y, screenW-leftWidth, h)];
        cellSubView.frame=CGRectMake(0, y, screenW-leftWidth, h);
        cellSubView.btnClickBlock=^(){
            NSLog(@"%d",i);
            if (self.cellBtnClick) {
                self.cellBtnClick(i);
            }
        };
        if (i<model.subArr.count) {

            cellSubView.model=(JGZuoXiCellSubModel*)model.subArr[i];
        }
//        else{
//            cellSubView.model=nil;
//        }
        [self.rightView addSubview:cellSubView];
    }
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
