//
//  JGAddSchedulePlanVController.m
//  HealthConsultant
//
//  Created by 单启志 on 2017/2/17.
//  Copyright © 2017年 JG. All rights reserved.
//

#import "JGAddSchedulePlanVController.h"

#import "JGPlanNameView.h"

#import "MBProgressHUD.h"
#import "DBHelper.h"

#import "myDatePickerView.h"

@interface JGAddSchedulePlanVController ()
//保存按钮
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

//计划名称
@property (weak, nonatomic) IBOutlet UILabel *planNameLab;

//星期的父view
@property (weak, nonatomic) IBOutlet UIView *weakSuperView;

@property(nonatomic,weak)UIView *bgView;
@property(nonatomic,weak)JGPlanNameView *planNameView;

//日期控件
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

//自定义日期控件
@property (weak, nonatomic) IBOutlet myDatePickerView *myDatePicker;
//接收自定义日期控件返回的数据
@property(nonatomic,copy)NSString *myTimeStr;

@property (weak, nonatomic) IBOutlet UISwitch *ocSwitch;


//选中日期的数组
@property(nonatomic,strong)NSMutableArray *weekDaySelectArr;

@property(nonatomic,assign)updateType updateType;

//操作后的字典
@property(nonatomic,weak)NSMutableDictionary *updateDic;

@property(nonatomic,weak)MBProgressHUD *HUD;

@end

@implementation JGAddSchedulePlanVController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title=@"编辑作息时间";
    [self setNav];

    //配置一下子view
    [self initSubViews];

    //创建输入名字框
    [self initCrateNameViewAddBgView];
}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
}

-(void)initCrateNameViewAddBgView{

    //planNameView
    JGPlanNameView *planNameView=[[[NSBundle mainBundle]loadNibNamed:@"JGPlanNameView" owner:nil options:nil]lastObject];
    CGFloat w=260*screenW/320;
    CGFloat h=206*screenH/568;
    planNameView.frame=CGRectMake((screenW-w)/2, screenH*0.25, w, h);
    planNameView.hidden=YES;
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    planNameView.btnBlock=^(NSString *text){

        if (text==nil) {//取消按钮

        }else{//确定按钮

            self.planNameLab.textColor=RGB(0, 178, 178);
            self.planNameLab.text=text;
        }
        self.bgView.hidden=YES;
        self.planNameView.hidden=YES;
        self.planNameView.textField.text=@"";
    };
    //bg
    UIView *bgView=[[UIView alloc]initWithFrame:window.bounds];
    bgView.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    bgView.hidden=YES;
    [window addSubview:bgView];
    [window addSubview:planNameView];
    self.bgView=bgView;
    self.planNameView=planNameView;
}

//配置一下子view
-(void)initSubViews{

    if (self.model==nil) {
        NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
        formatter.dateFormat=@"HH:mm";
        self.myTimeStr=[formatter stringFromDate:[NSDate date]];
    }else{
    self.myTimeStr=self.model.Time;}

    self.saveBtn.layer.cornerRadius=2;
    self.saveBtn.layer.masksToBounds=YES;
    self.saveBtn.layer.borderWidth=1;
    self.saveBtn.layer.borderColor=RGB(0, 178, 178).CGColor;
    NSArray *arr=@[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
    for (int i=0; i<7; i++) {

        CGFloat w=34*screenW/320;
        CGFloat h=34*screenW/320;
        CGFloat margin=(screenW-15*2-7*w)/6;
        CGFloat x=15+i*(w+margin);
        CGFloat y=(64-w)/2;

        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
        btn.layer.cornerRadius=w/2;
        btn.layer.masksToBounds=YES;
        btn.layer.borderWidth=1;
        btn.layer.borderColor=RGB(204, 204, 204).CGColor;
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        btn.titleLabel.font=[UIFont systemFontOfSize:11];
        [btn addTarget:self action:@selector(selectDayClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag=i+1;
        [self.weakSuperView addSubview:btn];
    }

    self.weekDaySelectArr=[NSMutableArray array];

    //自定义日期控件
    self.myDatePicker.timeStr=self.myTimeStr;
    self.myDatePicker.selectBlock=^(NSString *timeStr){
        self.myTimeStr=timeStr;
    };

    if (self.model) {

        self.title=@"编辑作息计划";
        self.planNameLab.text=[self.model.planName stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        //self.planNameLab.text=self.model.planName;
        self.planNameLab.textColor=RGB(0, 178, 178);

        NSArray *arr=self.model.planArr;

        self.weekDaySelectArr=arr.mutableCopy;
        //NSString *timeStr=self.model.Time;
        //timeStr=[timeStr substringToIndex:5];

        if ([self.model.Status isEqualToString:@"1"]) {
            self.ocSwitch.on=YES;
        }else{
            self.ocSwitch.on=NO;
        }

        NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
        formatter.dateFormat=@"HH:mm";
       // self.datePicker.date=[formatter dateFromString:timeStr];

        //self.datePicker.date=@"";
        for (int i=0; i<arr.count; i++) {
           NSInteger index=[arr[i] intValue];
           UIButton *btn=[self.weakSuperView viewWithTag:index];
            btn.selected=YES;
            btn.layer.borderColor=RGB(244, 64, 40).CGColor;
            btn.backgroundColor=RGB(244, 64, 40);
        }
    }else{
        self.title=@"添加作息计划";
    }
}

-(void)selectDayClick:(UIButton *)btn{

    btn.selected=!btn.selected;
    NSInteger tag=btn.tag;
    NSString *selWeekDay=[NSString stringWithFormat:@"%ld",tag];
    if (btn.selected) {
        [self.weekDaySelectArr addObject:selWeekDay];
        btn.layer.borderColor=RGB(244, 64, 40).CGColor;
        btn.backgroundColor=RGB(244, 64, 40);
    }else{
        [self.weekDaySelectArr removeObject:selWeekDay];
         btn.layer.borderColor=RGB(204, 204, 204).CGColor;
        btn.backgroundColor=[UIColor whiteColor];
    }


}

-(void)setNav{

    if (self.model) {


    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"删除" style:UIBarButtonItemStyleDone target:self action:@selector(deletePlan)];
    }
}

#pragma mark -删除 for sdk
//删除计划
-(void)deletePlan{

    //往数据库删数据
    BOOL success=[[DBHelper share]updateDataWithId:self.model.Id ColumnName:DBZuoXiPlan deviceId:defaultDeviceId updateType:updateTypeDelete data:nil];

    if (success) {
        [MBProgressHUD showSuccess:@"修改成功"];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [MBProgressHUD showError:@"操作失败"];
    }

}

//保存按钮
- (IBAction)onSaveBtnClick:(id)sender {

    NSString *status=self.ocSwitch.on?@"1":@"0";
    NSString *playName=[self.planNameLab.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    

    NSString *Daily=[self weakdayWithArray:self.weekDaySelectArr];
    //NSString *time=[self numerStrWithData:self.datePicker.date];
    NSString *time=self.myTimeStr;

    NSMutableDictionary *subDic=[NSMutableDictionary dictionary];

    [subDic setValue:Daily forKey:@"Daily"];
    [subDic setValue:time forKey:@"Time"];
    [subDic setValue:playName forKey:@"Details"];
    [subDic setValue:status forKey:@"Status"];

    if (_model==nil) {//新增
        self.updateType=updateTypeAdd;

    }else{ //修改
        self.updateType=updateTypeEdit;
    }
    if (self.model&&self.model.Id==nil) {//如果上个页面传过来一条不带Id的数据(即无效数据)，返回操作失败
        [MBProgressHUD showError:@"操作失败" toView:self.view];
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }

    //数据验证
    if ([Daily isEqualToString:@""]) {
        [MBProgressHUD showError:@"您未设置日期" toView:self.view];
        return;
    }else if ([self.planNameLab.text isEqualToString:@"请输入"]){
        [MBProgressHUD showError:@"请设置计划名称" toView:self.view];
        return;
    }
    else{


    }
    //数据库需要的数据

    if (_model) {//修改的时候把Id传给subDic
        [subDic setValue:self.model.Id forKey:@"Id"];
    }else{
        NSString *Id=[[NSUUID UUID]UUIDString];
        [subDic setValue:Id forKey:@"Id"];
    }
    _updateDic=subDic;
//    //往数据库存数据
    [self configDataBaseWithDic:subDic];

}


//数据库增改
-(void)configDataBaseWithDic:(NSMutableDictionary *)dic{

    updateType updateType=-1;
    NSString *Id=[dic objectForKey:@"Id"];
    if (_model) {//修改
        updateType=updateTypeEdit;

    }else{//新增
        updateType=updateTypeAdd;
    }

    NSString *str=[[NSUUID UUID]UUIDString];

    NSString *playName=self.planNameLab.text;
    
    [dic setObject:playName forKey:@"Details"];

    BOOL success=[[DBHelper share]updateDataWithId:Id ColumnName:DBZuoXiPlan deviceId:defaultDeviceId updateType:updateType data:dic];
    if (success) {
        [MBProgressHUD showSuccess:@"修改成功"];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [MBProgressHUD showError:@"操作失败"];
    }
}

//计划名称
- (IBAction)onPlanNameBtnClick:(id)sender {

    self.bgView.hidden=NO;
    self.planNameView.hidden=NO;
    //[self.view addSubview:planNameView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



-(void)dealloc{

    [self.bgView removeFromSuperview];
    [self.planNameView removeFromSuperview];
}



#pragma mark - private

//转换成整数分
-(NSInteger )numerWithData:(NSDate*)date{

    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    formatter.dateFormat=@"HH:mm";

    NSString *dateStr=[formatter stringFromDate:date];
    NSArray *arr=[dateStr componentsSeparatedByString:@":"];
    NSInteger minute=[(NSString*)arr[0] integerValue]*60+[arr[1] integerValue];
    return minute;
}

//转换成 HH:mm:ss
-(NSString* )numerStrWithData:(NSDate*)date{

    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    formatter.dateFormat=@"HH:mm";

    NSString *dateStr=[formatter stringFromDate:date];

    return dateStr;
}


//把数组转换成想要的格式
-(NSString*)weakdayWithArray:(NSArray*)arr{
    if (arr.count<=0) {
        return @"";
    }
    NSString *str=[NSString string];
    
    arr=[arr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        
        if ([obj1 intValue]>[obj2 intValue]) {
            return NSOrderedDescending;
        }else if ([obj1 intValue]<[obj2 intValue]){
            return NSOrderedAscending;
        }
        return NSOrderedSame;
        
    }];
    
    for (int i=0; i<arr.count; i++) {
    
       str=[str stringByAppendingFormat:@"%@|",arr[i]];
    }

    str=[str substringToIndex:str.length-1];

    str=[self replaceWithNumberStr:str];
    return str;
}

-(NSString *)replaceWithNumberStr:(NSString*)str{

    str=[str stringByReplacingOccurrencesOfString:@"1" withString:@"Monday"];
    str=[str stringByReplacingOccurrencesOfString:@"2" withString:@"Tuesday"];
    str=[str stringByReplacingOccurrencesOfString:@"3" withString:@"Wednesday"];
    str=[str stringByReplacingOccurrencesOfString:@"4" withString:@"Thursday"];
    str=[str stringByReplacingOccurrencesOfString:@"5" withString:@"Friday"];
    str=[str stringByReplacingOccurrencesOfString:@"6" withString:@"Saturday"];
    str=[str stringByReplacingOccurrencesOfString:@"7" withString:@"Sunday"];

    return str;
}

@end
