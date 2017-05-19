//
//  myDatePickerView.m
//  KMDatePicker
//
//  Created by 单启志 on 2017/5/17.
//  Copyright © 2017年 Kenmu. All rights reserved.
//

#import "myDatePickerView.h"

@interface myDatePickerView()<UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic,strong)NSArray *proHourList;
@property(nonatomic,strong)NSArray *proMinuteList;

@property(nonatomic,copy)NSString *hourStr;
@property(nonatomic,copy)NSString *minuteStr;

@end

@implementation myDatePickerView

-(void)awakeFromNib{
    [super awakeFromNib];

    [self initSubViews];

}

-(instancetype)initWithFrame:(CGRect)frame{

    if (self=[super initWithFrame:frame]) {

        [self initSubViews];
    }

    return self;
}

-(void)setTimeStr:(NSString *)timeStr{

    _timeStr=timeStr;
    NSArray *arr=[timeStr componentsSeparatedByString:@":"];

    _hourStr=arr[0];
    _minuteStr=arr[1];

    [self selectRow:[_hourStr intValue] inComponent:0 animated:NO];
    [self selectRow:[_minuteStr intValue] inComponent:1 animated:NO];

}

-(void)initSubViews{

    self.delegate=self;
    self.dataSource = self;
    //_proHourList = [[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",nil];

    NSMutableArray *hourList=[NSMutableArray array];
    NSMutableArray *minuteList=[NSMutableArray array];
    for (int i=0; i<60; i++) {
        NSString *str=[NSString stringWithFormat:@"%d",i];
        if (i<10) {
            str=[NSString stringWithFormat:@"0%@",str];
        }
        if (i<24) {
            [hourList addObject:str];
        }
        [minuteList addObject:str];
    }
    _proHourList=hourList;
    _proMinuteList=minuteList;

    //self.backgroundColor=[UIColor lightGrayColor];


    //如果timeStr没有传值过来，就设为当前时间
    if (_timeStr==nil) {
        NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
        formatter.dateFormat=@"HH:mm";
       self.timeStr=[formatter stringFromDate:[NSDate date]];
        [NSDate date];
    }
    
}



#pragma mark - 自定义方法
- (void)addUnitLabel:(NSString *)text withPointX:(CGFloat)pointX {
    CGFloat pointY = self.frame.size.height/2 - 10.0;
    UILabel *lblUnit = [[UILabel alloc] initWithFrame:CGRectMake(pointX, pointY, 20.0, 20.0)];
    lblUnit.text = text;
    lblUnit.textAlignment = NSTextAlignmentCenter;
    lblUnit.textColor = [UIColor blackColor];
    lblUnit.backgroundColor = [UIColor clearColor];
    lblUnit.font = [UIFont systemFontOfSize:18.0];
    //lblUnit.layer.shadowColor = [[UIColor whiteColor] CGColor];
    //lblUnit.layer.shadowOpacity = 0.5;
    //lblUnit.layer.shadowRadius = 5.0;
    [self addSubview:lblUnit];
}

#pragma Mark -- UIPickerViewDelegate 

// 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {

    CGFloat width = 50.0;
    CGFloat widthOfAverage;

     widthOfAverage = (self.frame.size.width - 10.0) / 2;
    if (component==0) {

        width = widthOfAverage;
        [self addUnitLabel:@"时" withPointX:width/2 + 12.0+15];
    }else{
        width = widthOfAverage;
        [self addUnitLabel:@"分" withPointX:widthOfAverage + width/2 + 18.0+12];
    }

    return width;

}

// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        NSString  *_proNameStr = [_proHourList objectAtIndex:row];
        NSLog(@"nameStr=%@",_proNameStr);

        _hourStr=_proNameStr;

    } else {
        NSString  *_proTimeStr = [_proMinuteList objectAtIndex:row];
        NSLog(@"_proTimeStr=%@",_proTimeStr);
       _minuteStr=_proTimeStr;
    }

    NSString *timeStr=[NSString stringWithFormat:@"%@:%@",_hourStr,_minuteStr];

    NSLog(@"----%@----",timeStr);
    if (self.selectBlock) {
         self.selectBlock(timeStr);
    }
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{

    if (component == 0) {
        return [_proHourList objectAtIndex:row];
    } else {
        return [_proMinuteList objectAtIndex:row];

    }
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{

    if (component == 0) {
        return _proHourList.count;
    } else {
        return _proMinuteList.count;

    }

}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{

    return 2;
}

////自定义View的样式
//-(UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
//
//    UILabel* pickerLabel = (UILabel*)view;
//    if (!pickerLabel){
//        pickerLabel = [[UILabel alloc] init];
//        // Setup label properties - frame, font, colors etc
//        //adjustsFontSizeToFitWidth property to YES
//        pickerLabel.minimumFontSize = 8.;
//        pickerLabel.adjustsFontSizeToFitWidth = YES;
//        [pickerLabel setTextAlignment:UITextAlignmentCenter];
//        [pickerLabel setBackgroundColor:[UIColor clearColor]];
//        [pickerLabel setFont:[UIFont boldSystemFontOfSize:15]];
//    }
//    // Fill the label text here
//
//    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
//    return pickerLabel;
//}


@end
