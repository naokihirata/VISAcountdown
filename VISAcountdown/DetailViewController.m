//
//  DetailViewController.m
//  VISAcountdown
//
//  Created by hiratanaoki on 2014/11/11.
//  Copyright (c) 2014年 hiratanaoki. All rights reserved.
//

#import "DetailViewController.h"
#import "ViewController.h"
@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //0 = 一番左のTabBarを設定

    
    //現在の時刻、日付をとる
    _today = [NSDate date];
    //時刻、日付の書式を決める
    _df = [[NSDateFormatter alloc] init];
    [_df setDateFormat:@"yyyy/MM/dd"];
    //時刻、日付を書式の通りに変換する
    _datestr = [_df stringFromDate:_today];
    //コンソールに出力
    NSLog(@"%@",_datestr);
    
    NSUserDefaults *defaultscount = [NSUserDefaults standardUserDefaults];
    NSInteger memorycount=[defaultscount integerForKey:@"KEY_5"];
    
    if (_daycount3!=0) {
        _daycount3=memorycount;
    }else{
    }
    [self countLabel];
    
    //[self countBudge];
    
    NSLog(@"%@", _df);
    //_countNotification.applicationIconBadgeNumber = self._daycount2;
    [self extendButton];
    
//    ///広告
//    //タブバーの高さと調べる
//    CGFloat tabBarHeight = self.tabBarController.tabBar.bounds.size.height;
//    CGFloat addViewHeight =_adView.frame.size.height;
//    //バナーオブジェクト生成
//    _adView = [[ADBannerView alloc] initWithFrame:CGRectMake(0, 0, _adView.frame.size.width, _adView.frame.size.height)];
//    _adView.delegate = self;
//    [self.view addSubview:_adView];
//    _adView.alpha =1.0;
//    //フラグがNOの時にこの処理をする
//    //_isVisible = NO;

    UIApplication *application = [UIApplication sharedApplication];
    application.applicationIconBadgeNumber = _daycount3;
    
    //初期化
    _adView = [[ADBannerView alloc] init];
    _adView.frame = CGRectMake(0, -_adView.frame.size.height, _adView.frame.size.width, _adView.frame.size.height);
    
    //場所を決定
    _adView.alpha = 0.0;
    _adView.delegate = self;
    
    //画面本体に追加
    [self.view addSubview:_adView];
    
    //バナーは表示されていないのでNOを設定
    _isVisible = NO;

}
//バナーが正常に表示された場合
-(void)bannerViewDidLoadAd:(ADBannerView *)banner{
    
    if (_isVisible == NO) {
        [UIView beginAnimations:@"animateAdBannerOn" context:nil];
        [UIView setAnimationDuration:0.3];
        
        banner.frame = CGRectOffset(banner.frame, 0, CGRectGetHeight(banner.frame));
        banner.alpha = 1.0;
        [UIView commitAnimations];
        
        //バナーを表示しているのでYESを設定
        _isVisible = YES;
        
    }
    
    
}
//バナー表示でエラーが発生した場合
-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error{
    
    if (_isVisible == YES) {
        [UIView beginAnimations:@"animateAdBannerOff" context:nil];
        [UIView setAnimationDuration:0.3];
        
        _adView.frame = CGRectMake(0, -_adView.frame.size.height, _adView.frame.size.width, _adView.frame.size.height);
        
        banner.alpha = 0.0;
        
        [UIView commitAnimations];
        
        //バナーを非表示にしているのでNOを設定
        _isVisible = NO;
        
    }
    
}
//-(void)viewWillAppear:(BOOL)animated{
//    
//    _daycount3 = [self getDaysCountByTwoDateString:_today endDateString:__departdate];
//    NSLog(@"%d",_daycount3);
//
//    
//    if (_daycount3==0) {
//        self.tabBarController.selectedIndex=1;
//    }else{
//    }
//    NSString *daycount = [NSString stringWithFormat:@"残り%d日", _daycount3];
//    
//    _countLabel.text = daycount;
//    
//    }

-(void)viewDidAppear:(BOOL)animated{
    
    NSUserDefaults *defaultsdate = [NSUserDefaults standardUserDefaults];
    NSDate *date1=[_df dateFromString:[defaultsdate objectForKey:@"KEY_4"]];

    __departdate = date1;
    
    _daycount3 = [self getDaysCountByTwoDateString:_today endDateString:__departdate];
    NSLog(@"%d",_daycount3);

    
    if (_daycount3==0) {
        self.tabBarController.selectedIndex=1;
    }else{
            }
    
    //DatePickerのデータを保存
    NSUserDefaults *defaultscount = [NSUserDefaults standardUserDefaults];
    [defaultscount setInteger:_daycount3 forKey:@"KEY_5"];
    [defaultscount synchronize];
    
    
    NSString *daycount = [NSString stringWithFormat:@"残り%d日", _daycount3];
    
    _countLabel.text = daycount;
    
    }
-(int)getDaysCountByTwoDateString:(NSString*)startDateString endDateString:(NSString*)endDateString{
    float tmp= [__departdate timeIntervalSinceDate:_today];
    int day=(int)( tmp / (3600.0*24.0) );
    //    day +=1;
    return day;
}
-(void)countLabel{
    _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(0 ,160 ,self.view.bounds.size.width, 60)];
    
    _countLabel.font = [UIFont systemFontOfSize:36];
    _countLabel.textAlignment = NSTextAlignmentCenter;
    
    NSString *daycount = [NSString stringWithFormat:@"残り%d日", _daycount3];
    
    _countLabel.text = daycount;
    [self.view addSubview:_countLabel];
}
-(void)extendButton{
    _extendButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 300, 130, 20)];
    
    [_extendButton setTitle:@"延長手続き完了" forState:UIControlStateNormal];
    
    [_extendButton setTitleColor:[UIColor colorWithRed:0.192157 green:0.760784 blue:0.952941 alpha:1.0] forState:UIControlStateNormal];
    
    [_extendButton addTarget:self action:@selector(TapextendBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:_extendButton];
}
-(void)TapextendBtn:(UIButton *)extendButton{
    
    NSLog(@"extend");

}

//UILocalNotification *localNotification = [[UILocalNotification alloc] init];
//
//localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:10];
//localNotification.alertBody = @"10秒経過した";
//
//localNotification.applicationIconBadgeNumber = 1;
//
//
//localNotification.timeZone = [NSTimeZone defaultTimeZone];
//[[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
-(void)countBudge{
    _countNotification = [[UILocalNotification alloc] init];
    
    _countNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:1];
    _countNotification.alertBody = @"visa";
    _countNotification.applicationIconBadgeNumber = _daycount3;
    _countNotification.timeZone = [NSTimeZone defaultTimeZone];
    [[UIApplication sharedApplication] scheduleLocalNotification:_countNotification];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
