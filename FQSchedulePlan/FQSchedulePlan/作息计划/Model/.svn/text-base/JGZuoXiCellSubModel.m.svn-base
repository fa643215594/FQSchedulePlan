//
//  JGZuoXiCellSubModel.m
//  haha
//
//  Created by faqiang feng on 2017/2/18.
//  Copyright © 2017年 faqiang feng. All rights reserved.
//

#import "JGZuoXiCellSubModel.h"
#import "MJExtension.h"
@implementation JGZuoXiCellSubModel



-(NSArray *)planArr{

    return [self weakDaysWithString:self.Daily];
}

-(NSString *)planName{

    return self.Details;
}

-(NSInteger)minute{

    return [self timeWithString:self.Time];
}


#pragma mark - private

-(NSInteger)timeWithString:(NSString*)time{

    //time=@"18:00:00";
    NSArray *arr=[time componentsSeparatedByString:@":"];
    NSInteger value=[arr[0]integerValue]*60+[arr[1]integerValue];
    return value;
}

-(NSArray *)weakDaysWithString:(NSString*)daily{
    // daily=@"Monday| Tuesday | Wednesday | Thursday | Friday | Saturday| Sunday";

    daily=[daily stringByReplacingOccurrencesOfString:@"Monday" withString:@"1"];
    daily=[daily stringByReplacingOccurrencesOfString:@"Tuesday" withString:@"2"];
    daily=[daily stringByReplacingOccurrencesOfString:@"Wednesday" withString:@"3"];
    daily=[daily stringByReplacingOccurrencesOfString:@"Thursday" withString:@"4"];
    daily=[daily stringByReplacingOccurrencesOfString:@"Friday" withString:@"5"];
    daily=[daily stringByReplacingOccurrencesOfString:@"Saturday" withString:@"6"];
    daily=[daily stringByReplacingOccurrencesOfString:@"Sunday" withString:@"7"];

    return [daily componentsSeparatedByString:@"|"];
}
@end
