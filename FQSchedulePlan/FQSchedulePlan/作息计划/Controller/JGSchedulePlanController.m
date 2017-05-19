//
//  JGSchedulePlanController.m
//  HealthConsultant
//
//  Created by 单启志 on 2017/2/17.
//  Copyright © 2017年 JG. All rights reserved.
//

#import "JGSchedulePlanController.h"

#import "JGAddSchedulePlanVController.h"

#import "JGZuoXiPlanCell.h"

#import "JGZuoXiPlanModel.h"

#import "MBProgressHUD+Add.h"

#import "DBHelper.h"

@interface JGSchedulePlanController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

//封装后的数组
@property(nonatomic,strong)NSMutableArray *dataArr;

//封装前的数组
@property(nonatomic,strong)NSMutableArray *subArr;

//星期几
@property(nonatomic,assign)NSInteger weekDay;

@property(nonatomic,weak)MBProgressHUD *HUD;
@end

@implementation JGSchedulePlanController
static NSString *cellId=@"zuoXiPlanCell";
- (void)viewDidLoad {
    [super viewDidLoad];

    self.weekDay=[self weekdayFromDate:[NSDate date]];
    [self setbgLine];
    [self setNav];
    //_dataArr=[JGZuoXiPlanModel getList];
    _subArr=[NSMutableArray array];
    [self setTableView];

}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];

   // [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshNotification) name:SDKZuoXiPlanNotification object:nil];

    if (_dataArr.count>0) {
        //[_dataArr removeAllObjects];
    }
    //数据库拿数据
    [self getDataForDB];

}

-(void)refreshNotification{

    [self getDataForDB];
}

-(void)viewWillDisappear:(BOOL)animated{

   // [[NSNotificationCenter defaultCenter]removeObserver:self];
}

//数据库拿数据
-(void)getDataForDB{

  //走本地
  NSMutableArray *subArr=[[DBHelper share]getDateWithColumnName:DBZuoXiPlan deviceId:defaultDeviceId];

      _subArr=subArr;
      _dataArr=[JGZuoXiPlanModel getLsitArrayWithSuBArray:subArr];
        [self.tableView reloadData];

}

-(void)getWeekDay{

    NSDate *nowDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSDayCalendarUnit fromDate:nowDate];
    // 获取今天是周几
    NSInteger weekDay = [comp weekday];
    self.weekDay=weekDay-1;
    if (weekDay==1) {
        self.weekDay=7;
    }
}

-(void)setNav{

    self.title=@"作息计划";
   
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"crawl_ico_add_nor"] style:UIBarButtonItemStyleDone target:self action:@selector(addPlan)];
}

//添加作息时间
-(void)addPlan{
    if (self.subArr.count>=6) {
        NSLog(@"最多只能添加6条");
        //[self.HUD hidHUDMsg:@"最多添加6条"];
        [MBProgressHUD showError:@"最多添加6条" toView:self.view];
        return;
    }
    NSLog(@"添加作息时间");
    JGAddSchedulePlanVController *vc=[[JGAddSchedulePlanVController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

//设置背景竖线
-(void)setbgLine{

    self.view.backgroundColor=RGB(238, 243, 246);

    CGFloat margin=(screenW-leftWidth)/7;

    CGFloat w=0.5;
    CGFloat h=screenH;

    UIView *weakSuperView=[[UIView alloc]initWithFrame:CGRectMake(0, 64, screenW, weakH)];
    weakSuperView.backgroundColor=RGB(220, 220, 220);
    [self.view addSubview:weakSuperView];

    NSInteger lineCount=screenW/(margin-0.5);

    NSArray *arr=@[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
    for (int i=0; i<lineCount; i++) {
        //画线
        CGFloat x=leftWidth+i*(margin+w);
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(x, 64, 0.5, h)];
        line.backgroundColor=RGB(204, 204, 204);

        [self.view addSubview:line];

        //画标题
        CGFloat firstX=i==0?0.5:0;
        UIView *weakView=[[UIView alloc]initWithFrame:CGRectMake(x+firstX, 64, margin+0.5, weakH)];
        weakView.backgroundColor=RGB(220, 220, 220);
        iPhone5H(15);
        UILabel *weakLab=[[UILabel alloc]initWithFrame:CGRectMake((margin-iPhone5W(30))/2, (weakH- iPhone5H(15))/2, iPhone5W(30), iPhone5H(15))];
        weakLab.text=arr[i];
        weakLab.textColor=RGB(102, 102, 102);
        weakLab.font=[UIFont systemFontOfSize:12];
        if (i==self.weekDay-1) {
            weakLab.backgroundColor=RGB(244, 64, 40);
            weakLab.textColor=[UIColor whiteColor];
        }
        weakLab.textAlignment=NSTextAlignmentCenter;
        weakLab.layer.cornerRadius=2;
        weakLab.layer.masksToBounds=YES;
        //[weakLab sizeToFit];
        [weakView addSubview:weakLab];

        [self.view addSubview:weakView];
    }

}

-(void)setTableView{

    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64+weakH, screenW, screenH-64-weakH) style:UITableViewStylePlain];
    _tableView.backgroundColor=[UIColor clearColor];
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([JGZuoXiPlanCell class]) bundle:nil] forCellReuseIdentifier:cellId];
    [self.view addSubview:_tableView];
    self.tableView.showsVerticalScrollIndicator=NO;
}

#pragma -mark tableVeiwDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    JGZuoXiPlanModel *model=_dataArr[indexPath.row];
    NSInteger cellRows=model.subArr.count<4?4:model.subArr.count;
    return (screenW-leftWidth)/7*cellRows;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    JGZuoXiPlanCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];

    cell.leftView.backgroundColor=indexPath.row==1?[UIColor whiteColor]:RGB(238, 243, 246);
    cell.model=_dataArr[indexPath.row];
    cell.cellBtnClick=^(int index){

        NSLog(@"你点击了第%ldCell里面的%d行",indexPath.row,index);
        [self pushSettingControllerWithModel:_dataArr[indexPath.row] index:index];
    };
    return cell;
}

-(void)pushSettingControllerWithModel:(JGZuoXiPlanModel*)model index:(NSInteger)index{

    JGAddSchedulePlanVController *vc=[[JGAddSchedulePlanVController alloc]init];
    JGZuoXiCellSubModel *sModel=model.subArr[index];
    vc.model=sModel;
    
    [self.navigationController pushViewController:vc animated:YES];

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


-(NSInteger)weekdayFromDate:(NSDate*)inputDate {

    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];

    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];

    [calendar setTimeZone: timeZone];

    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;

    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    NSInteger weekDay = [theComponents weekday];
    NSInteger day=weekDay-1;
    if (weekDay==1) {
        day=7;
    }
    return day;
}

/*
 #pragma mark - Navigation

 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


@end
