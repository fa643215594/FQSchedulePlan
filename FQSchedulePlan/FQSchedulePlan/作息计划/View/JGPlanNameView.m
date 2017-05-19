//
//  JGPlanNameView.m
//  HealthConsultant
//
//  Created by 单启志 on 2017/2/17.
//  Copyright © 2017年 JG. All rights reserved.
//

#import "JGPlanNameView.h"
#define iPhone5W(w) (w*screenW/320)
#define iPhone5H(h) (h*screenH/568)
@interface JGPlanNameView()<UITextFieldDelegate>

//加border
@property (weak, nonatomic) IBOutlet UIView *textFSuperView;

@property (weak, nonatomic) IBOutlet UIButton *okBtn;

@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;


//屏幕适配线
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleTopCons;//20

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tipTopCons;//33

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textFieldTopCons;//15

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *okBtnTopCons;//20

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textFieldSuperViewH;//34

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textFieldSuperViewW; //235 -

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *okBtnConsH; //34


@end

@implementation JGPlanNameView

-(void)awakeFromNib{

    [super awakeFromNib];

    [self configSubViews];

}

-(void)configSubViews{

    //适配
    _titleTopCons.constant=iPhone5H(20);
    _tipTopCons.constant=iPhone5H(33); //33;
    _textFieldTopCons.constant=iPhone5H(15); //15;
    _okBtnTopCons.constant=iPhone5H(20); //20;
    _textFieldSuperViewH.constant=iPhone5H(34); //34;
    _textFieldSuperViewW.constant=iPhone5W(235); //235;
    _okBtnConsH.constant=iPhone5H(34); //34;
    //半角
    self.layer.cornerRadius=5;
    self.layer.masksToBounds=YES;

    self.textFSuperView.layer.borderColor=RGB(204, 204, 204).CGColor;
    self.textFSuperView.layer.borderWidth=0.5;
    self.textFSuperView.layer.cornerRadius=2;
    self.textFSuperView.layer.masksToBounds=YES;

    self.okBtn.layer.borderColor=RGB(204, 204, 204).CGColor;
    self.okBtn.layer.borderWidth=0.5;
    self.okBtn.layer.cornerRadius=2;
    self.okBtn.layer.masksToBounds=YES;

    self.cancelBtn.layer.borderColor=RGB(204, 204, 204).CGColor;
    self.cancelBtn.layer.borderWidth=0.5;
    self.cancelBtn.layer.cornerRadius=2;
    self.cancelBtn.layer.masksToBounds=YES;


    //代理
    _textField.delegate=self;
}

//清空输入框文字btn
- (IBAction)onClearWordBtn:(id)sender {

    self.textField.text=@"";
}

- (IBAction)onOKBtnClick:(id)sender {
    [self.textField resignFirstResponder];
     NSLog(@"---%@",self.textField.text);

    if (self.textField.text.length<=0) {
        [MBProgressHUD showError:@"计划名称不能为空" toView:self];
        return;
    }
    NSInteger count=0;
   NSString *text=self.textField.text;
    for (int i=0; i<text.length; i++) {

      NSString *str=[text substringWithRange:NSMakeRange(i, 1)];
     count+=1;
    }
    if (count>8) {
        [MBProgressHUD showError:@"计划名称过长" toView:self];
        return;
    }


//    NSInteger count=0;
//    for (int i=0; i<self.textField.text.length; i++) {
//
//        NSString *subString=[self.textField.text substringWithRange:NSMakeRange(i, 1)];
//        const char *cString=[subString UTF8String];
//        if (strlen(cString)==3) {
//            NSLog(@"你输入的是汉字");
//            count+=2;
//        }else{
//
//            count+=1;
//        }
//        
//    }
//    if (count>8) {
//        return;
//    }

    if (self.btnBlock) {

        self.btnBlock(self.textField.text);
    }
}

- (IBAction)onCancelBtnClick:(id)sender {

     NSLog(@"---%@",nil);
    [self.textField resignFirstResponder];
    if (self.btnBlock) {
        self.btnBlock(nil);
    }


}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

  NSLog(@"text=%@;location=%ld;length=%ld;string=%@",textField.text,range.location,range.length,string);

    if (range.location+range.length>7&&range.length==0) {
        return NO;
    }
    return YES;
}

-(BOOL)textFieldShouldClear:(UITextField *)textField{

    return YES;
}


@end
