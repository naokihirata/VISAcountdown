//
//  ViewController.m
//  VISAcountdown
//
//  Created by hiratanaoki on 2014/11/10.
//  Copyright (c) 2014年 hiratanaoki. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)textLabel{
    _myLabelInput = [[UILabel alloc] initWithFrame:CGRectMake(20 ,80 ,200, 50)];
    
    _myLabelInput.text = @"情報を入力";
    [self.view addSubview:_myLabelInput];
}
-(void)countryLabel{
    _countryLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 ,160 ,200, 50)];
    
    _countryLabel.text = @"";
    [self.view addSubview:_countryLabel];
}
-(void)periodLabel{
    _periodLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 ,220 ,200, 50)];
    
    _periodLabel.text = @"";
    [self.view addSubview:_periodLabel];
}
-(void)purposeLabel{
    _purposeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 ,280 ,200, 50)];
    
    _purposeLabel.text = @"";
    [self.view addSubview:_purposeLabel];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
