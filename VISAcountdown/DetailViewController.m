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
    
    if (memorycount!=nil) {
        _countdownDayNumber=memorycount;
    }else{
    }
    [self countLabel];
    
//    [self countBudge];
    
    NSLog(@"%@", _df);
    //_countNotification.applicationIconBadgeNumber = self._daycount2;
    [self extendButton];
    [self extendButton2];

    UIApplication *application = [UIApplication sharedApplication];
    application.applicationIconBadgeNumber = _countdownDayNumber;
    
    
    //広告関連(iAD)
    //初期化
    _adView = [[ADBannerView alloc] init];
    _adView.frame = CGRectMake(0, 16-_adView.frame.size.height, _adView.frame.size.width, _adView.frame.size.height);
    
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
    
    //現在の時刻、日付をとる
    _today = [NSDate date];
    //時刻、日付の書式を決める
    _df = [[NSDateFormatter alloc] init];
    [_df setDateFormat:@"yyyy/MM/dd"];
    //時刻、日付を書式の通りに変換する
    _datestr = [_df stringFromDate:_today];
    //コンソールに出力
    NSLog(@"%@",_datestr);
    
    
    NSUserDefaults *defaultsdate = [NSUserDefaults standardUserDefaults];
    NSDate *date=[_df dateFromString:[defaultsdate objectForKey:@"KEY_4"]];

    if (self._daycount2>=0) {
        __finishdate1 = date;
    }else{
    }
    
    
    
    NSDateComponents *comp = [[NSDateComponents alloc] init];
    NSCalendar *cal = [NSCalendar currentCalendar];
    //指定した日付の30日先を設定
    
    NSDateComponents *def2=[cal components:NSDayCalendarUnit fromDate:_today toDate:__finishdate1 options:0];
    
    NSLog(@"days: %d", [def2 day]);
    
    _countdownDayNumber = [def2 day];
    _countdownDayNumber+=1;
    
//    _daycount3 = [self getDaysCountByTwoDateString:_today endDateString:__departdate];
 //   NSLog(@"%d",_daycount3);

    
    if (self._daycount2<1) {
        self.tabBarController.selectedIndex=1;
    }else{
            }
    
    //DatePickerのデータを保存
    NSUserDefaults *defaultscount = [NSUserDefaults standardUserDefaults];
    [defaultscount setInteger:_countdownDayNumber forKey:@"KEY_5"];
    [defaultscount synchronize];
    
    //_countdownDayNumber+=1;
    NSString *daycount = [NSString stringWithFormat:@"残り%d日", _countdownDayNumber];
    
    _countLabel.text = daycount;
    
    _countNotification.applicationIconBadgeNumber = _countdownDayNumber;

//    // NSDateFormatter を用意します。
//    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
//    
//    // 変換用の書式を設定
//    [formatter setDateFormat:@"YYYY/MM/dd HH:mm:ss"];
//    
//    [formatter stringFromDate:_today];
//    [formatter stringFromDate:self._departdate];
//    
//    // NSString を NSDate に変換
//    NSDate* date_converted = [cal dateByAddingComponents:__departdate toDate:_today options:0];
//    
//    //時間単位の文字列にセット
//    NSString *hourDateString = [NSString stringWithFormat:@"%@ 00:00:00", [_df stringFromDate:date_converted]];
//    
//    
//    date_converted = [formatter dateFromString:hourDateString];
//    
//    //設定した日数と、カウントダウンする日付をUserDefaultに設定
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    
//    //日数
//    [defaults setObject:[NSString stringWithFormat:@"%d",_countdownDayNumber] forKey:@"countdownDayNumber"];
//    
//    //設定した日付
//    [defaults setObject:[_df stringFromDate:__departdate] forKey:@"settingDate"];
//    
//    [defaults synchronize];
//
//
}
//-(int)getDaysCountByTwoDateString:(NSString*)startDateString endDateString:(NSString*)endDateString{
//    float tmp= [__departdate timeIntervalSinceDate:_today];
//    int day=(int)( tmp / (3600.0*24.0) );
//        day +=1;
//    return day;
//}
-(void)countLabel{
    _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(0 ,160 ,self.view.bounds.size.width, 60)];
    
    _countLabel.font = [UIFont systemFontOfSize:45];
    _countLabel.textAlignment = NSTextAlignmentCenter;
    
    NSString *daycount = [NSString stringWithFormat:@"残り%d日", _countdownDayNumber];
    
    _countLabel.text = daycount;
    [self.view addSubview:_countLabel];
}
-(void)extendButton{
    UIButton *extendButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 300, 130, 20)];
    
    [extendButton setTitle:@"一ヶ月延長" forState:UIControlStateNormal];
    
    [extendButton setTitleColor:[UIColor colorWithRed:0.192157 green:0.760784 blue:0.952941 alpha:1.0] forState:UIControlStateNormal];
    
    [extendButton addTarget:self action:@selector(TapextendBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:extendButton];
}
-(void)TapextendBtn:(UIButton *)extendButton{
    
    NSLog(@"extend");
    
   // [self countBudge];
}
-(void)extendButton2{
    UIButton *extendButton2 = [[UIButton alloc] initWithFrame:CGRectMake(150, 300, 130, 20)];
    
    [extendButton2 setTitle:@"二ヶ月延長" forState:UIControlStateNormal];
    
    [extendButton2 setTitleColor:[UIColor colorWithRed:0.192157 green:0.760784 blue:0.952941 alpha:1.0] forState:UIControlStateNormal];
    
    [extendButton2 addTarget:self action:@selector(TapextendBtn2:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:extendButton2];
}
-(void)TapextendBtn2:(UIButton *)extendButton2{
    
    NSLog(@"extend2");
}
    
//    _countNotification = [[UILocalNotification alloc] init];
//    
//    _countNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:1];
//    _countNotification.alertBody = [NSString stringWithFormat:@"あと%d日です",_countdownDayNumber];
//    //
//    _countNotification.repeatInterval = NSDayCalendarUnit;
//    _countNotification.applicationIconBadgeNumber = _countdownDayNumber;
//    _countNotification.timeZone = [NSTimeZone defaultTimeZone];
//    [[UIApplication sharedApplication] scheduleLocalNotification:_countNotification];
//



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


//
////BadgeとlocalNotificationの表記
//-(void)countBudge{
//    _countNotification = [[UILocalNotification alloc] init];
//    
//    NSDateComponents *comp = [[NSDateComponents alloc] init];
//    NSCalendar *cal = [NSCalendar currentCalendar];
////    int day=5;
//    for (int i=0; i<30 ;i++) {
//        //指定した日付の30日先を設定
//        [comp setDay:i];
//        
//        NSDate* finishdate = [cal dateByAddingComponents:comp toDate:__departdate options:0];
//        
//        // 現在から指定した日付との差分を、日を基準にして取得する。
//        NSDateComponents *def1 = [cal components:NSDayCalendarUnit fromDate:_today toDate:finishdate options:0];
//        NSLog(@"days: %d", [def1 day]);
//        
//        int countdownDayNumber = [def1 day];
//        _countLabel.text = [NSString stringWithFormat:@"あと%d日です",countdownDayNumber];
//
//        _countNotification.applicationIconBadgeNumber = countdownDayNumber;
//        
//        _countNotification.timeZone = [NSTimeZone defaultTimeZone];
//        
//        [[UIApplication sharedApplication] scheduleLocalNotification:_countNotification];
//        
//    }
//}



//_def1 = [cal components:NSDayCalendarUnit fromDate:_today toDate:__departdate options:0];
        
//        // NSDateFormatter を用意します。
//        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
//        
//        // 変換用の書式を設定
//        [formatter setDateFormat:@"YYYY/MM/dd HH:mm:ss"];
//        
//        [formatter stringFromDate:_today];
//        [formatter stringFromDate:self._departdate];
//        
//        
//        NSCalendar *cal = [NSCalendar currentCalendar];
//        // NSString を NSDate に変換
//        NSDate* date_converted = [cal dateByAddingComponents:__departdate toDate:_today options:0];
//        
//        //時間単位の文字列にセット
//        NSString *hourDateString = [NSString stringWithFormat:@"%@ 00:00:00", [_df stringFromDate:date_converted]];
//        
//        
//        date_converted = [formatter dateFromString:hourDateString];
//        
//        //設定した日数と、カウントダウンする日付をUserDefaultに設定
//        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        
//        //日数
//        [defaults setObject:[NSString stringWithFormat:@"%d",_countdownDayNumber] forKey:@"countdownDayNumber"];
//        
//        //設定した日付
//        [defaults setObject:[_df stringFromDate:__departdate] forKey:@"settingDate"];
//        
//        [defaults synchronize];
    
        //_countdownDayNumber = _countdownDayNumber - 1;



    
//    _countNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
//    _countNotification.alertBody = [NSString stringWithFormat:@"あと%d日です",_countdownDayNumber];
//    //
//    _countNotification.repeatInterval = NSDayCalendarUnit;
//    _countNotification.applicationIconBadgeNumber = _countdownDayNumber;
//    _countNotification.timeZone = [NSTimeZone defaultTimeZone];
//    [[UIApplication sharedApplication] scheduleLocalNotification:_countNotification];
//    

    
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
