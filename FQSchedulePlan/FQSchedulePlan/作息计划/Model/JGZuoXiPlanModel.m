//
//  JGZuoXiPlanModel.m
//  haha
//
//  Created by faqiang feng on 2017/2/18.
//  Copyright © 2017年 faqiang feng. All rights reserved.
//

#import "JGZuoXiPlanModel.h"
#import "JGZuoXiCellSubModel.h"

@implementation JGZuoXiPlanModel


-(NSArray*)colorList{
    
    NSArray *arr=@[RGB(26, 193, 193),RGB(242, 90, 90),RGB(237, 193, 38),RGB(219, 69, 225),RGB(80, 134, 232),RGB(219, 69, 225)];
    
    return arr;
}


+(NSArray *)getsubArr{

    JGZuoXiCellSubModel *subModel=[[JGZuoXiCellSubModel alloc]init];
    subModel.planArr=@[@"1",@"4",@"2",@"5",@"6"];
    //subModel.color=RGB(26, 193, 193);
    subModel.minute=400;
    subModel.planName=@"起床";

    JGZuoXiCellSubModel *subModel1=[[JGZuoXiCellSubModel alloc]init];
    subModel1.planArr=@[@"2",@"7",@"4",@"5"];
    //subModel1.color=RGB(242, 90, 90);
    subModel1.minute=600;
    subModel1.planName=@"上班";

    JGZuoXiCellSubModel *subModel2=[[JGZuoXiCellSubModel alloc]init];
    subModel2.planArr=@[@"1",@"2",@"3",@"4",@"6"];
    //subModel2.color=RGB(237, 193, 38);
    subModel2.minute=710;
    subModel2.planName=@"吃饭";

    JGZuoXiCellSubModel *subModel3=[[JGZuoXiCellSubModel alloc]init];
    subModel3.planArr=@[@"1",@"3",@"5",@"7"];
    //subModel3.color=RGB(25, 186, 85);
    subModel3.minute=800;
    subModel3.planName=@"睡觉";

    JGZuoXiCellSubModel *subModel4=[[JGZuoXiCellSubModel alloc]init];
    subModel4.planArr=@[@"3",@"4"];
    //subModel4.color=RGB(80, 134, 232);
    subModel4.minute=1000;
    subModel4.planName=@"打游戏";

    JGZuoXiCellSubModel *subModel5=[[JGZuoXiCellSubModel alloc]init];
    subModel5.planArr=@[@"1",@"2",@"3",@"4",@"5"];
    //subModel5.color=RGB(219, 69, 225);
    subModel5.minute=1220;
    subModel5.planName=@"玩一玩";

    NSArray *subArr=@[subModel,subModel1,subModel2,subModel3,subModel4,subModel5];

    return subArr;
}


+(NSMutableArray *)getLsitArrayWithSuBArray:(NSArray*)subArra{

    NSMutableArray *modelArr=[JGZuoXiCellSubModel mj_objectArrayWithKeyValuesArray:subArra];

   NSArray *orderArr=[modelArr sortedArrayUsingComparator:^NSComparisonResult(JGZuoXiCellSubModel *obj1, JGZuoXiCellSubModel  *obj2) {
        if (obj1.minute>obj2.minute) {
            return NSOrderedDescending;
        }else if (obj1.minute<obj2.minute){
            return NSOrderedAscending;
        }
        return NSOrderedSame;
    }];

    NSArray *colorArr=@[RGB(26, 193, 193),RGB(242, 90, 90),RGB(237, 193, 38),RGB(25, 186, 85),RGB(80, 134, 232),RGB(219, 69, 225)];

    for (int i=0; i<orderArr.count; i++) {
        JGZuoXiCellSubModel *model=(JGZuoXiCellSubModel*)orderArr[i];
        if (i<6) {
            model.color=colorArr[i];
        }
    }

    //上午 model
    JGZuoXiPlanModel *model1=[[JGZuoXiPlanModel alloc]init];
    model1.typeTime=@"上午";
    NSMutableArray *subArr1=[NSMutableArray array];


    //下午model
    JGZuoXiPlanModel *model2=[[JGZuoXiPlanModel alloc]init];
    model2.typeTime=@"下午";
    NSMutableArray *subArr2=[NSMutableArray array];


    //晚上model
    JGZuoXiPlanModel *model3=[[JGZuoXiPlanModel alloc]init];
    model3.typeTime=@"晚上";
    NSMutableArray *subArr3=[NSMutableArray array];
    model3.subArr=subArr3;

    for (int i=0; i<orderArr.count; i++) {

        //根据时间划分上午下午晚上区域
        JGZuoXiCellSubModel *model=(JGZuoXiCellSubModel*)orderArr[i];
        NSInteger time=model.minute;
        if (time>=0&&time<720) {//上午 12
            [subArr1 addObject:model];
        }else if(time>=720&&time<1089){//下午 18
            [subArr2 addObject:model];
        }else if(time>=1089&&time<1440){//晚上 24
            [subArr3 addObject:model];
        }
    }

    model1.subArr=subArr1;
    model2.subArr=subArr2;
    model3.subArr=subArr3;

    NSMutableArray *arr=@[model1,model2,model3].mutableCopy;

    return arr;
}



#pragma -mark private
+(NSInteger)timeWithString:(NSString*)time{

    //time=@"18:00:00";
    NSArray *arr=[time componentsSeparatedByString:@":"];
    NSInteger value=[arr[0]integerValue]*60+[arr[1]integerValue];
    return value;
}

+(NSArray *)weakDaysWithString:(NSString*)daily{
   // daily=@"Monday| Tuesday | Wednesday | Thursday | Friday | Saturday| Sunday";

    daily=[daily stringByReplacingOccurrencesOfString:@"Monday" withString:@"1"];
    daily=[daily stringByReplacingOccurrencesOfString:@"Tuesday" withString:@"2"];
    daily=[daily stringByReplacingOccurrencesOfString:@"Wednesday" withString:@"3"];
    daily=[daily stringByReplacingOccurrencesOfString:@"Thursday" withString:@"4"];
    daily=[daily stringByReplacingOccurrencesOfString:@"Friday" withString:@"5"];
    daily=[daily stringByReplacingOccurrencesOfString:@"Saturday" withString:@"6"];
    daily=[daily stringByReplacingOccurrencesOfString:@"Sunday" withString:@"7"];

    return [daily componentsSeparatedByString:@"|"];;

//    {
//        "results": {
//            "IMEI": "355637052788650",
//            "Category": "Schedule",
//            "Num": "4",
//            "Schedule": [
//                         {
//                             "id": "24567",
//                             "Daily": "Monday| Tuesday | Wednesday | Thursday | Friday | Saturday| Sunday ",
//                             "Time":"18:00:00",
//                             "Details": "吃饭"
//                         },
//                         {
//                             "id": "34567",
//                             "Daily": "Monday| Tuesday | Wednesday | Thursday | Friday | Saturday| Sunday ",
//                             "Time":"18:00:00",
//                             "Details": "吃水果"
//                         },
//                         {
//                             "id": "24567",
//                             "Daily": "Monday| Tuesday | Wednesday | Thursday | Friday | Saturday| Sunday ",
//                             "Time":"18:00:00",
//                             "Details": "吃饭"
//                         },
//                         {
//                             "id": "24567",
//                             "Daily": "Monday| Tuesday | Wednesday | Thursday | Friday | Saturday| Sunday ",
//                             "Time":"18:00:00",
//                             "Details": "吃饭"
//                         },
//                         ]
//        }
//    }
}

@end
