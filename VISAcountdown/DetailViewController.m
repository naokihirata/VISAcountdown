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

    _country = @[@"フィリピン",@"オーストラリア",@"シンガポール",@"ニュージーランド"];
    
    //現在の時刻、日付をとる
    _today = [NSDate date];
    //時刻、日付の書式を決める
    _df = [[NSDateFormatter alloc] init];
    [_df setDateFormat:@"yyyy/MM/dd"];
    //時刻、日付を書式の通りに変換する
    NSString *datestr = [_df stringFromDate:_today];
    //コンソールに出力
    NSLog(@"%@",datestr);
    
    NSUserDefaults *defaultscount = [NSUserDefaults standardUserDefaults];
    int memorycount=[[defaultscount objectForKey:@"KEY_5"] intValue];
    
    
    if (!memorycount) {
        _countdownDayNumber=-90;
       
    }else{
        _countdownDayNumber=memorycount;
    }
    //表示のラベル
    [self textLabel];
    [self countryLabel];
    [self countLabel];
    [self finishdateLabel];
    [self countLabel2];
    [self willreturndateLabel];
//    [self countBudge];
    
    
    NSLog(@"%@", _df);
    //_countNotification.applicationIconBadgeNumber = self._daycount2;
    
    
    
    //表示するボタンを設定によって決定する
    NSUserDefaults *defaultscountry = [NSUserDefaults standardUserDefaults];
    int memo1=[[defaultscountry objectForKey:@"KEY_1"] intValue];

    NSUserDefaults *defaultstouchnumber = [NSUserDefaults standardUserDefaults];
    int touchnumber=[[defaultstouchnumber objectForKey:@"KEY_10"] intValue];
    
        switch(memo1){
        case 0: //フィリピン
                [self WebButton];
                [self smallView];
                [self createButton];

            if (touchnumber==0) {
                
                [self extendButton29];
            }else{
                [self extendButton];
                [self extendButton2];
            }
            break;
        case 1://オーストラリア
            [self extendButton];
            [self extendButton2];
            break;
        case 2://シンガポール
            [self extendButton];
            [self extendButton3];
            break;
        case 3://ニュージーランド
            [self extendButton];
            [self extendButton2];
            break;
        default://それ以外
            [self extendButton];
            [self extendButton2];
            break;
    }

    
    
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

//    DetailViewController  *sub = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];

//    UIView *subview=[[UIView alloc] init];
//    subview.backgroundColor=[UIColor yellowColor];
    //背景の色を黄色に変更
    self.view.backgroundColor = [UIColor yellowColor];
    
}

-(void)viewWillAppear:(BOOL)animated{

    //countdownDayNumberの呼び出し
    NSUserDefaults *defaultscount = [NSUserDefaults standardUserDefaults];
    int memorycount=[[defaultscount objectForKey:@"KEY_5"] intValue];
    //finishdateの呼び出し
    NSUserDefaults *defaultsdate = [NSUserDefaults standardUserDefaults];
    NSDate *date=[_df dateFromString:[defaultsdate objectForKey:@"KEY_4"]];
    
    if (!memorycount) {
        _countdownDayNumber=0;
    }else{
        _countdownDayNumber=memorycount;
    }
    
    _countLabel.text= [NSString stringWithFormat:@"残り%d日",_countdownDayNumber];
    
    //_finishdatelabel.text = [_df stringFromDate:date];
    _finishdatelabel.text = [NSString stringWithFormat:@"滞在可能なのは%@までです",[_df stringFromDate:date]];
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
        
        _adView.frame = CGRectMake(0, 16-_adView.frame.size.height, _adView.frame.size.width, _adView.frame.size.height);
        
        banner.alpha = 0.0;
        
        [UIView commitAnimations];
        
        //バナーを非表示にしているのでNOを設定
        _isVisible = NO;
        
    }
}
-(void)viewDidAppear:(BOOL)animated{
    
    //現在の時刻、日付をとる
    _today = [NSDate date];
    //時刻、日付の書式を決める
    _df = [[NSDateFormatter alloc] init];
    [_df setDateFormat:@"yyyy/MM/dd"];
    NSString *datestr=[_df stringFromDate:_today];
    //コンソールに出力
    NSLog(@"%@",datestr);
    
    //UserDefaultsからデータの取り出し(残り日数、最終日、number)
    NSUserDefaults *defaultsdate = [NSUserDefaults standardUserDefaults];
    NSDate *date=[_df dateFromString:[defaultsdate objectForKey:@"KEY_4"]];
    
    NSUserDefaults *defaultsreturndate=[NSUserDefaults standardUserDefaults];
    NSDate *willreturndate=[_df dateFromString:[defaultsreturndate objectForKey:@"KEY_7"]];
    

    NSUserDefaults *defaultscount=[NSUserDefaults standardUserDefaults];
    _countdownDayNumber = (int)[[defaultscount objectForKey:@"KEY_5"] intValue];
    
    for (_uv in [self.view subviews]) {
        [_extendButton removeFromSuperview];
        [_extendButton2 removeFromSuperview];
        [_extendButton3 removeFromSuperview];
        [_extendButton29 removeFromSuperview];
    }
    
    
    NSUserDefaults *defaultscountry = [NSUserDefaults standardUserDefaults];
    int memo1=[[defaultscountry objectForKey:@"KEY_1"] intValue];
    int valcountry=memo1;

    NSUserDefaults *defaultstouchnumber = [NSUserDefaults standardUserDefaults];
    int touchnumber=[[defaultstouchnumber objectForKey:@"KEY_10"] intValue];
    switch(valcountry){
    case 0: //フィリピン
            [self WebButton];
            if (touchnumber==0) {
                [self extendButton29];
            }else{
                [self extendButton];
                [self extendButton2];
            }
            break;
    case 1://オーストラリア
            [self extendButton];
            [self extendButton2];
            break;
    case 2://シンガポール
            [self extendButton];
            [self extendButton3];
            break;
    case 3://ニュージーランド
            [self extendButton];
            [self extendButton2];
            break;
    default://それ以外
            [self extendButton];
            [self extendButton2];
            break;
        }
    
    //finishdateの呼び出し
    _finishdatelabel.text = [NSString stringWithFormat:@"滞在可能なのは%@までです",[_df stringFromDate:date]];

    _willreturndatelabel.text=[NSString stringWithFormat:@"帰国予定日%@",[_df stringFromDate:willreturndate]];
    
    self._daycount2=_countdownDayNumber;
    //if (self._daycount2>=0) {
        __finishdate1 = date;
    //}else{
    //}
    
//    if(_number<1){
//    }else{
    NSDateComponents *comp = [[NSDateComponents alloc] init];
    NSCalendar *cal = [NSCalendar currentCalendar];
    //指定した日付の30日先を設定
    
    NSDateComponents *def2=[cal components:NSDayCalendarUnit fromDate:_today toDate:__finishdate1 options:0];
    
    NSLog(@"days: %ld", (long)[def2 day]);
    
    _countdownDayNumber = [def2 day];
    
    
    //カウント日数の値が0以下であれば設定画面に戻す
    if (self._daycount2<-60) {
        self.tabBarController.selectedIndex=1;
    }else{
            }
    
    [[defaultscount objectForKey:@"KEY_5"] intValue];
    [defaultscount synchronize];
    
    NSString *daycount = [NSString stringWithFormat:@"残り%d日", _countdownDayNumber+1];
    
    _countLabel.text = daycount;
   // }
    NSDateComponents *startNumberdef =[cal components:NSDayCalendarUnit fromDate:_today toDate:willreturndate options:0];
    
    int day_number2 = [startNumberdef day];
    
    NSString *daycount2=[NSString stringWithFormat:@"帰国予定日まで残り%d日",day_number2+1];

    if (!willreturndate) {
        _willreturndatelabel.text=@"";
        _countlabel2.text=@"";
    }else{
        _countlabel2.text=daycount2;
        NSUserDefaults *defaultscount2=[NSUserDefaults standardUserDefaults];
        [[defaultscount2 objectForKey:@"KEY_8"] intValue];
        [defaultscount2 synchronize];
    }
    _countrylabel.text=_country[valcountry];
}
-(void)textLabel{
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0 ,130 ,self.view.bounds.size.width, 30)];
    textLabel.font = [UIFont systemFontOfSize:16];
    textLabel.textAlignment = NSTextAlignmentLeft;
    
    
    textLabel.text = @"VISAの期限まで...";
    [self.view addSubview:textLabel];
}
-(void)countLabel{
    _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(0 ,160 ,self.view.bounds.size.width, 60)];
    _countLabel.font = [UIFont systemFontOfSize:45];
    _countLabel.textAlignment = NSTextAlignmentCenter;
    
    NSString *daycount = [NSString stringWithFormat:@"残り%d日", _countdownDayNumber];
    
    _countLabel.text = daycount;
    [self.view addSubview:_countLabel];
}
-(void)countryLabel{
    NSUserDefaults *defaultscountry = [NSUserDefaults standardUserDefaults];
    int memo1=[[defaultscountry objectForKey:@"KEY_1"] intValue];

    _countrylabel = [[UILabel alloc] initWithFrame:CGRectMake(0 ,80 ,self.view.bounds.size.width, 30)];
    
    _countrylabel.font = [UIFont systemFontOfSize:22];
    _countrylabel.textAlignment = NSTextAlignmentLeft;
    
    //NSString *daycount = [NSString stringWithFormat:@"残り%d日", _countdownDayNumber];
    
    _countrylabel.text = _country[memo1];
    [self.view addSubview:_countrylabel];
}
-(void)finishdateLabel{
    //finishdateの呼び出し
    NSUserDefaults *defaultsdate = [NSUserDefaults standardUserDefaults];
    NSDate *date=[_df dateFromString:[defaultsdate objectForKey:@"KEY_4"]];
    
     _finishdatelabel= [[UILabel alloc] initWithFrame:CGRectMake(0 ,240 ,self.view.bounds.size.width, 60)];
    
    _finishdatelabel.font = [UIFont systemFontOfSize:18];
    _finishdatelabel.textAlignment = NSTextAlignmentRight;
    
//    _finishdatelabel.text = [_df stringFromDate:date];
    _finishdatelabel.text = [NSString stringWithFormat:@"滞在可能なのは%@までです",[_df stringFromDate:date]];
    UIColor *color = [UIColor whiteColor];
    UIColor *acolor = [color colorWithAlphaComponent:0.5]; //透過率50%
    _finishdatelabel.backgroundColor=acolor;
    [self.view addSubview:_finishdatelabel];
}
//帰国予定日の表示
-(void)willreturndateLabel{
    //returndateの呼び出し
    NSUserDefaults *defaultsreturndate = [NSUserDefaults standardUserDefaults];
    NSDate *willreturndate=[_df dateFromString:[defaultsreturndate objectForKey:@"KEY_7"]];

    _willreturndatelabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 360, self.view.bounds.size.width, 30)];
    _willreturndatelabel.font=[UIFont systemFontOfSize:18];
    _willreturndatelabel.textAlignment=NSTextAlignmentRight;
    
    _willreturndatelabel.text=[NSString stringWithFormat:@"帰国予定日%@",[_df stringFromDate:willreturndate]];
//    UIColor *color = [UIColor whiteColor];
//    UIColor *acolor = [color colorWithAlphaComponent:0.5]; //透過率50%
//    _willreturndatelabel.backgroundColor=acolor;
    [self.view addSubview:_willreturndatelabel];
}
-(void)countLabel2{
    NSUserDefaults *defaultscount2=[NSUserDefaults standardUserDefaults];
    int day_number2 = (int)[[defaultscount2 objectForKey:@"KEY_8"] intValue];
    
    _countlabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0 ,400 ,self.view.bounds.size.width, 30)];
    
    _countlabel2.font = [UIFont systemFontOfSize:18];
    _countlabel2.textAlignment = NSTextAlignmentRight;
    
    NSString *daycount2 = [NSString stringWithFormat:@"残り%d日", day_number2+1];
    
    _countlabel2.text = daycount2;
    [self.view addSubview:_countlabel2];
}
//UIWebViewを表示するためのボタン
-(void)WebButton{
    UIButton *webButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 400, 20, 20)];
    
    //[extendButton setTitle:@"一ヶ月延長" forState:UIControlStateNormal];
    
    [webButton setTitleColor:[UIColor colorWithRed:0.192157 green:0.760784 blue:0.952941 alpha:1.0] forState:UIControlStateNormal];
    
    [webButton addTarget:self action:@selector(TapWebBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    //画像を読み込んでボタンに貼る
    UIImage *imgextend1=[UIImage imageNamed:@"Button_011.png"];
    [webButton setBackgroundImage:imgextend1 forState:UIControlStateNormal];
    [self.view addSubview:webButton];
}
-(void)TapWebBtn:(UIButton *)WebButton{
    [self upObject];
    
}
-(void)smallView{
    _backview = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height)];
    
    UIColor *color = [UIColor whiteColor];
    UIColor *acolor = [color colorWithAlphaComponent:0.9]; //透過率50%
    _backview.backgroundColor = acolor;
    
    
    NSURL *myURL = [NSURL URLWithString:@"http://ameblo.jp/golf220usa/entry-11965692081.html"];
    
    NSURLRequest *myURLReq = [NSURLRequest requestWithURL:myURL];
    
    _webview=[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [_webview loadRequest:myURLReq];
    [_backview addSubview:_webview];
    
    [self.view addSubview:_backview];


}
-(void)createButton{
    UIButton *datecreateButton = [[UIButton alloc] initWithFrame:CGRectMake(120, 270, 100, 30)];
    
    [datecreateButton setTitle:@"完了" forState:UIControlStateNormal];
    
    [datecreateButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [datecreateButton addTarget:self action:@selector(TapDateCreateBtn:) forControlEvents:UIControlEventTouchUpInside];
    //画像を読み込んでボタンに貼る
//    UIImage *imgdate=[UIImage imageNamed:@"VISAbutton_03_03.png"];
//    [datecreateButton setBackgroundImage:imgdate forState:UIControlStateNormal];
    [_backview addSubview:datecreateButton];
}
-(void)TapDateCreateBtn:(UIButton *)datecreateButton{
    
    [self downObject];
}
-(void)upObject{
    
    _backview.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
}
-(void)downObject{
    _backview.frame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height);
    
}
-(void)aditionalcalculate{
    // アプリに登録されている全ての通知を削除
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    UILocalNotification *localNotification= [[UILocalNotification alloc] init];
    //UserDefaultから呼び出し
    NSUserDefaults *defaultscountry = [NSUserDefaults standardUserDefaults];
    int memo1=[[defaultscountry objectForKey:@"KEY_1"] intValue];
    int valcountry=memo1;
    NSUserDefaults *defaultsdate = [NSUserDefaults standardUserDefaults];
    NSDate *date=[_df dateFromString:[defaultsdate objectForKey:@"KEY_4"]];
    NSDate *finishdate=date;
//    NSUserDefaults *defautsdate1 = [NSUserDefaults standardUserDefaults];
//    NSDate *date1=[_df dateFromString:[defautsdate1 objectForKey:@"KEY_6"]];
    
//    if (_number=1) {
//        NSDate *departdate=date;
//    }else{
//        departdate=date1;
//
//    }
//    NSDate *departdate=date1;
    
    
    NSDateComponents *comp = [[NSDateComponents alloc] init];
    NSDateComponents *comp2 = [[NSDateComponents alloc] init];
    NSCalendar *cal = [NSCalendar currentCalendar];
    // NSDateFormatter を用意します。
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    
    NSDateComponents *startNumberdef =[cal components:NSDayCalendarUnit fromDate:_today toDate:finishdate options:0];
    
    int day_number = [startNumberdef day];
    // 変換用の書式を設定
    [formatter setDateFormat:@"YYYY/MM/dd HH:mm:ss"];
    switch(valcountry){
        case 0:
            _daycountoffirstadition = 30;
            break;
        case 1:
            _daycountoffirstadition = 30;
            break;
        case 2:
            _daycountoffirstadition=30;
            break;
        case 3:
            _daycountoffirstadition=30;
            break;
        case 4:
            _daycountoffirstadition=30;
            break;
        default:
            _daycountoffirstadition=30;
            break;
    }
    
    
    [comp2 setDay:_daycountoffirstadition];
    
    day_number=day_number+ _daycountoffirstadition;
    
    //finishdate = [cal dateByAddingComponents:comp2 toDate:departdate options:0];
    NSDate *latestfinishdate=[cal dateByAddingComponents:comp2 toDate:finishdate options:0];
    
//    NSUserDefaults *defaultsdate = [NSUserDefaults standardUserDefaults];
    [defaultsdate setObject:[_df stringFromDate:latestfinishdate] forKey:@"KEY_4"];
    [defaultsdate synchronize];

    //コンソールでfinishdateの確認
    NSString *datefinish = [_df stringFromDate:latestfinishdate];
    //コンソールに出力
    NSLog(@"%@",datefinish);
    
    for (int i=0; i<day_number ;i++) {
        //指定した日付の30日先を設定
        [comp setDay:i];
        NSDate* date_converted = [cal dateByAddingComponents:comp toDate:_today options:0];
        
        // 現在から指定した日付との差分を、日を基準にして取得する。
        NSDateComponents *def1 = [cal components:NSDayCalendarUnit fromDate:date_converted toDate:latestfinishdate options:0];
        NSLog(@"days: %ld", (long)[def1 day]);
        
        _countdownDayNumber = [def1 day];
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        
        //日時データを文字列に変換する場合のフォーマットを指定
        df.dateFormat = @"yyyy/MM/dd";
        //時間単位の文字列にセット
        NSString *hourDateString = [NSString stringWithFormat:@"%@ 00:00:00", [df stringFromDate:date_converted]];
        
        date_converted =[formatter dateFromString:hourDateString];
        
        localNotification.fireDate=date_converted;
        
        localNotification.alertBody=[NSString stringWithFormat:@"あと%d日です",_countdownDayNumber+1];
        localNotification.applicationIconBadgeNumber = _countdownDayNumber+1;
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        _countdownDayNumber=day_number;
        NSString *daycount = [NSString stringWithFormat:@"残り%d日", _countdownDayNumber+1];
        _countLabel.text=daycount;

    }
    //TODO:修正箇所？
        //データを保存
//    NSUserDefaults *defaultscount = [NSUserDefaults standardUserDefaults];
//    //[[defaultscount objectForKey:@"KEY_5"] intValue];
//    [defaultscount setObject:[NSString stringWithFormat:@"%d",_countdownDayNumber] forKey:@"KEY_5"];
//    [defaultscount synchronize];

    NSUserDefaults *defaultscount = [NSUserDefaults standardUserDefaults];
    [defaultscount setInteger:_countdownDayNumber+1 forKey:@"KEY_5"];
    [defaultscount synchronize];

}
-(void)aditionalcalculate2{
    // アプリに登録されている全ての通知を削除
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    UILocalNotification *localNotification= [[UILocalNotification alloc] init];
    //UserDefaultから呼び出し
    NSUserDefaults *defaultscountry = [NSUserDefaults standardUserDefaults];
    int memo1=[[defaultscountry objectForKey:@"KEY_1"] intValue];
    int valcountry=memo1;
    NSUserDefaults *defaultsdate = [NSUserDefaults standardUserDefaults];
    NSDate *date=[_df dateFromString:[defaultsdate objectForKey:@"KEY_4"]];
    NSDate *finishdate=date;
    
    NSDateComponents *comp = [[NSDateComponents alloc] init];
    NSDateComponents *comp2 = [[NSDateComponents alloc] init];
    NSCalendar *cal = [NSCalendar currentCalendar];
    // NSDateFormatter を用意します。
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    
    NSDateComponents *startNumberdef =[cal components:NSDayCalendarUnit fromDate:_today toDate:finishdate options:0];
    
    int day_number = [startNumberdef day];
    // 変換用の書式を設定
    [formatter setDateFormat:@"YYYY/MM/dd HH:mm:ss"];
    switch(valcountry){
        case 0:
            _daycountoffirstadition = 60;
            break;
        case 1:
            _daycountoffirstadition = 60;
            break;
        case 2:
            _daycountoffirstadition=60;
            break;
        case 3:
            _daycountoffirstadition=60;
            break;
        case 4:
            _daycountoffirstadition=60;
            break;
        default:
            _daycountoffirstadition=60;
            break;
    }
    
    
    [comp2 setDay:_daycountoffirstadition];
    
    day_number=day_number+ _daycountoffirstadition;
    
    //finishdate = [cal dateByAddingComponents:comp2 toDate:departdate options:0];
    NSDate *latestfinishdate=[cal dateByAddingComponents:comp2 toDate:finishdate options:0];
    
    //    NSUserDefaults *defaultsdate = [NSUserDefaults standardUserDefaults];
    [defaultsdate setObject:[_df stringFromDate:latestfinishdate] forKey:@"KEY_4"];
    [defaultsdate synchronize];
    
    //コンソールでfinishdateの確認
    NSString *datefinish = [_df stringFromDate:latestfinishdate];
    //コンソールに出力
    NSLog(@"%@",datefinish);
    
    for (int i=0; i<day_number ;i++) {
        //指定した日付の30日先を設定
        [comp setDay:i];
        NSDate* date_converted = [cal dateByAddingComponents:comp toDate:_today options:0];
        
        // 現在から指定した日付との差分を、日を基準にして取得する。
        NSDateComponents *def1 = [cal components:NSDayCalendarUnit fromDate:date_converted toDate:latestfinishdate options:0];
        NSLog(@"days: %ld", (long)[def1 day]);
        
        _countdownDayNumber = [def1 day];
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        
        //日時データを文字列に変換する場合のフォーマットを指定
        df.dateFormat = @"yyyy/MM/dd";
        //時間単位の文字列にセット
        NSString *hourDateString = [NSString stringWithFormat:@"%@ 00:00:00", [df stringFromDate:date_converted]];
        
        date_converted =[formatter dateFromString:hourDateString];
        
        localNotification.fireDate=date_converted;
        //_countdownDayNumber+=1;
        localNotification.alertBody=[NSString stringWithFormat:@"あと%d日です",_countdownDayNumber+1];
        localNotification.applicationIconBadgeNumber = _countdownDayNumber+1;
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        //_countdownDayNumber-=1;
    }
    _countdownDayNumber=day_number;
    _countdownDayNumber+=1;
    NSString *daycount = [NSString stringWithFormat:@"残り%d日", _countdownDayNumber];
    
    _countLabel.text=daycount;
    //_countdownDayNumber-=1;
    //データを保存
    //    NSUserDefaults *defaultscount = [NSUserDefaults standardUserDefaults];
    //    //[[defaultscount objectForKey:@"KEY_5"] intValue];
    //    [defaultscount setObject:[NSString stringWithFormat:@"%d",_countdownDayNumber] forKey:@"KEY_5"];
    //    [defaultscount synchronize];
    
    NSUserDefaults *defaultscount = [NSUserDefaults standardUserDefaults];
    [defaultscount setInteger:_countdownDayNumber forKey:@"KEY_5"];
    [defaultscount synchronize];
    
}
-(void)extendButton{
    _extendButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 300, 130, 35)];
    
    //[extendButton setTitle:@"一ヶ月延長" forState:UIControlStateNormal];
    
    [_extendButton setTitleColor:[UIColor colorWithRed:0.192157 green:0.760784 blue:0.952941 alpha:1.0] forState:UIControlStateNormal];
    
    [_extendButton addTarget:self action:@selector(TapextendBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    //画像を読み込んでボタンに貼る
    UIImage *imgextend1=[UIImage imageNamed:@"Button_011.png"];
    [_extendButton setBackgroundImage:imgextend1 forState:UIControlStateNormal];
    [self.view addSubview:_extendButton];
}
-(void)TapextendBtn:(UIButton *)extendButton{
    NSUserDefaults *defaultsnumber=[NSUserDefaults standardUserDefaults];
    _number = (int)[[defaultsnumber objectForKey:@"KEY_9"] intValue];
    
    //期間延長、計算、ラベルの表示
    [self aditionalcalculate];
    NSLog(@"extend");
    
    _number=1;  //延長したときの見分けるよう
    
//    NSUserDefaults *defaultsnumber = [NSUserDefaults standardUserDefaults];
    [defaultsnumber setInteger:_number forKey:@"KEY_9"];
    //[defaultsnumber setObject:[NSString stringWithFormat:@"%d",_number] forKey:@"KEY_9"];
    //[[defaultsnumber objectForKey:@"KEY_9"] intValue];
    [defaultsnumber synchronize];
    
    
    //finishdateの呼び出し
    NSUserDefaults *defaultsdate = [NSUserDefaults standardUserDefaults];
    NSDate *date=[_df dateFromString:[defaultsdate objectForKey:@"KEY_4"]];
    //_finishdatelabel.text = [_df stringFromDate:date];
    _finishdatelabel.text = [NSString stringWithFormat:@"滞在可能なのは%@までです",[_df stringFromDate:date]];
}
-(void)extendButton2{
    _extendButton2 = [[UIButton alloc] initWithFrame:CGRectMake(170, 300, 130, 35)];
    
    //[extendButton2 setTitle:@"二ヶ月延長" forState:UIControlStateNormal];
    
    [_extendButton2 setTitleColor:[UIColor colorWithRed:0.192157 green:0.760784 blue:0.952941 alpha:1.0] forState:UIControlStateNormal];
    
    [_extendButton2 addTarget:self action:@selector(TapextendBtn2:) forControlEvents:UIControlEventTouchUpInside];
    //画像を読み込んでボタンに貼る
    UIImage *imgextend2=[UIImage imageNamed:@"Button_012.png"];
    [_extendButton2 setBackgroundImage:imgextend2 forState:UIControlStateNormal];
    
    [self.view addSubview:_extendButton2];
}
-(void)TapextendBtn2:(UIButton *)extendButton2{
    
    [self aditionalcalculate2];
    NSLog(@"extend2");
    //_number=1;  //延長したときの見分けるよう
}
-(void)extendButton29{
    _extendButton29 = [[UIButton alloc] initWithFrame:CGRectMake(20, 300, 130, 35)];
    
    //[extendButton setTitle:@"一ヶ月延長" forState:UIControlStateNormal];
    
    [_extendButton29 setTitleColor:[UIColor colorWithRed:0.192157 green:0.760784 blue:0.952941 alpha:1.0] forState:UIControlStateNormal];
    
    [_extendButton29 addTarget:self action:@selector(TapextendBtn29:) forControlEvents:UIControlEventTouchUpInside];
    
    //画像を読み込んでボタンに貼る
    UIImage *imgextend1=[UIImage imageNamed:@"VISAbutton_02_11.png"];
    [_extendButton29 setBackgroundImage:imgextend1 forState:UIControlStateNormal];
    [self.view addSubview:_extendButton29];
}
-(void)TapextendBtn29:(UIButton *)extendButton29{
    //期間延長、計算、ラベルの表示
    [self aditionalcalculate29];
    NSLog(@"extend29");
    for (_uv in [self.view subviews]) {
        [_extendButton29 removeFromSuperview];
    }
    [self extendButton];
    [self extendButton2];
    
    //finishdateの呼び出し
    NSUserDefaults *defaultsdate = [NSUserDefaults standardUserDefaults];
    NSDate *date=[_df dateFromString:[defaultsdate objectForKey:@"KEY_4"]];
    
    _finishdatelabel.text = [NSString stringWithFormat:@"滞在可能なのは%@までです",[_df stringFromDate:date]];
    
    int touchnumber=1;
    NSUserDefaults *defaultstouchnumber = [NSUserDefaults standardUserDefaults];
    [defaultstouchnumber setInteger:touchnumber forKey:@"KEY_10"];
    [defaultstouchnumber synchronize];

}
-(void)aditionalcalculate29{
    // アプリに登録されている全ての通知を削除
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    UILocalNotification *localNotification= [[UILocalNotification alloc] init];
    //UserDefaultから呼び出し
    NSUserDefaults *defaultsdate = [NSUserDefaults standardUserDefaults];
    NSDate *date=[_df dateFromString:[defaultsdate objectForKey:@"KEY_4"]];
    NSDate *finishdate=date;
    
    NSDateComponents *comp = [[NSDateComponents alloc] init];
    NSDateComponents *comp2 = [[NSDateComponents alloc] init];
    NSCalendar *cal = [NSCalendar currentCalendar];
    // NSDateFormatter を用意します。
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    
    NSDateComponents *startNumberdef =[cal components:NSDayCalendarUnit fromDate:_today toDate:finishdate options:0];
    
    int day_number = [startNumberdef day];
    // 変換用の書式を設定
    [formatter setDateFormat:@"YYYY/MM/dd HH:mm:ss"];
    
    [comp2 setDay:29];
    
    day_number=day_number+ 29;
    
    NSDate *latestfinishdate=[cal dateByAddingComponents:comp2 toDate:finishdate options:0];
    
    //    NSUserDefaults *defaultsdate = [NSUserDefaults standardUserDefaults];
    [defaultsdate setObject:[_df stringFromDate:latestfinishdate] forKey:@"KEY_4"];
    [defaultsdate synchronize];
    
    //コンソールでfinishdateの確認
    NSString *datefinish = [_df stringFromDate:latestfinishdate];
    //コンソールに出力
    NSLog(@"%@",datefinish);
    
    for (int i=0; i<day_number ;i++) {
        //指定した日付の30日先を設定
        [comp setDay:i];
        NSDate* date_converted = [cal dateByAddingComponents:comp toDate:_today options:0];
        
        // 現在から指定した日付との差分を、日を基準にして取得する。
        NSDateComponents *def1 = [cal components:NSDayCalendarUnit fromDate:date_converted toDate:latestfinishdate options:0];
        NSLog(@"days: %ld", (long)[def1 day]);
        
        _countdownDayNumber = [def1 day];
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        
        //日時データを文字列に変換する場合のフォーマットを指定
        df.dateFormat = @"yyyy/MM/dd";
        //時間単位の文字列にセット
        NSString *hourDateString = [NSString stringWithFormat:@"%@ 00:00:00", [df stringFromDate:date_converted]];
        
        date_converted =[formatter dateFromString:hourDateString];
        
        localNotification.fireDate=date_converted;
        
        localNotification.alertBody=[NSString stringWithFormat:@"あと%d日です",_countdownDayNumber+1];
        localNotification.applicationIconBadgeNumber = _countdownDayNumber+1;
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        
    }
    //TODO:修正箇所？
    _countdownDayNumber=day_number;
    _countdownDayNumber+=1;
    NSString *daycount = [NSString stringWithFormat:@"残り%d日", _countdownDayNumber];
    
    _countLabel.text=daycount;
    //データを保存
    //    NSUserDefaults *defaultscount = [NSUserDefaults standardUserDefaults];
    //    //[[defaultscount objectForKey:@"KEY_5"] intValue];
    //    [defaultscount setObject:[NSString stringWithFormat:@"%d",_countdownDayNumber] forKey:@"KEY_5"];
    //    [defaultscount synchronize];
    
    NSUserDefaults *defaultscount = [NSUserDefaults standardUserDefaults];
    [defaultscount setInteger:_countdownDayNumber forKey:@"KEY_5"];
    [defaultscount synchronize];
    
}
-(void)extendButton3{
    _extendButton3 = [[UIButton alloc] initWithFrame:CGRectMake(20, 350, 130, 35)];
    
    //[extendButton setTitle:@"一ヶ月延長" forState:UIControlStateNormal];
    
    [_extendButton3 setTitleColor:[UIColor colorWithRed:0.192157 green:0.760784 blue:0.952941 alpha:1.0] forState:UIControlStateNormal];
    
    [_extendButton3 addTarget:self action:@selector(TapextendBtn3:) forControlEvents:UIControlEventTouchUpInside];
    
    //画像を読み込んでボタンに貼る
    UIImage *imgextend1=[UIImage imageNamed:@"VISAbutton_02_07.png"];
    [_extendButton3 setBackgroundImage:imgextend1 forState:UIControlStateNormal];
    [self.view addSubview:_extendButton3];
}
-(void)TapextendBtn3:(UIButton *)extendButton3{
    //期間延長、計算、ラベルの表示
    [self aditionalcalculate3];
    NSLog(@"extend3");
    
    //finishdateの呼び出し
    NSUserDefaults *defaultsdate = [NSUserDefaults standardUserDefaults];
    NSDate *date=[_df dateFromString:[defaultsdate objectForKey:@"KEY_4"]];
    
    _finishdatelabel.text = [NSString stringWithFormat:@"滞在可能なのは%@までです",[_df stringFromDate:date]];
}
-(void)aditionalcalculate3{
    // アプリに登録されている全ての通知を削除
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    UILocalNotification *localNotification= [[UILocalNotification alloc] init];
    //UserDefaultから呼び出し
    NSUserDefaults *defaultsdate = [NSUserDefaults standardUserDefaults];
    NSDate *date=[_df dateFromString:[defaultsdate objectForKey:@"KEY_4"]];
    NSDate *finishdate=date;
    
    NSDateComponents *comp = [[NSDateComponents alloc] init];
    NSDateComponents *comp2 = [[NSDateComponents alloc] init];
    NSCalendar *cal = [NSCalendar currentCalendar];
    // NSDateFormatter を用意します。
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    
    NSDateComponents *startNumberdef =[cal components:NSDayCalendarUnit fromDate:_today toDate:finishdate options:0];
    
    int day_number = [startNumberdef day];
    // 変換用の書式を設定
    [formatter setDateFormat:@"YYYY/MM/dd HH:mm:ss"];
    
    [comp2 setDay:90];
    
    day_number=day_number+ 90;
    
    NSDate *latestfinishdate=[cal dateByAddingComponents:comp2 toDate:finishdate options:0];
    
    //    NSUserDefaults *defaultsdate = [NSUserDefaults standardUserDefaults];
    [defaultsdate setObject:[_df stringFromDate:latestfinishdate] forKey:@"KEY_4"];
    [defaultsdate synchronize];
    
    //コンソールでfinishdateの確認
    NSString *datefinish = [_df stringFromDate:latestfinishdate];
    //コンソールに出力
    NSLog(@"%@",datefinish);
    
    for (int i=0; i<day_number ;i++) {
        //指定した日付の30日先を設定
        [comp setDay:i];
        NSDate* date_converted = [cal dateByAddingComponents:comp toDate:_today options:0];
        
        // 現在から指定した日付との差分を、日を基準にして取得する。
        NSDateComponents *def1 = [cal components:NSDayCalendarUnit fromDate:date_converted toDate:latestfinishdate options:0];
        NSLog(@"days: %ld", (long)[def1 day]);
        
        _countdownDayNumber = [def1 day];
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        
        //日時データを文字列に変換する場合のフォーマットを指定
        df.dateFormat = @"yyyy/MM/dd";
        //時間単位の文字列にセット
        NSString *hourDateString = [NSString stringWithFormat:@"%@ 00:00:00", [df stringFromDate:date_converted]];
        
        date_converted =[formatter dateFromString:hourDateString];
        
        localNotification.fireDate=date_converted;
        //_countdownDayNumber+=1;
        localNotification.alertBody=[NSString stringWithFormat:@"あと%d日です",_countdownDayNumber+1];
        localNotification.applicationIconBadgeNumber = _countdownDayNumber+1;
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        //_countdownDayNumber-=1;
    }
    //TODO:修正箇所？
    _countdownDayNumber=day_number;
    _countdownDayNumber+=1;
    NSString *daycount = [NSString stringWithFormat:@"残り%d日", _countdownDayNumber];
    
    _countLabel.text=daycount;
    //データを保存
    NSUserDefaults *defaultscount = [NSUserDefaults standardUserDefaults];
    [defaultscount setInteger:_countdownDayNumber forKey:@"KEY_5"];
    [defaultscount synchronize];
    
}
//六ヶ月延長
-(void)extendButton6{
    _extendButton6 = [[UIButton alloc] initWithFrame:CGRectMake(20, 350, 130, 35)];
    
    //[extendButton setTitle:@"一ヶ月延長" forState:UIControlStateNormal];
    
    [_extendButton6 setTitleColor:[UIColor colorWithRed:0.192157 green:0.760784 blue:0.952941 alpha:1.0] forState:UIControlStateNormal];
    
    [_extendButton6 addTarget:self action:@selector(TapextendBtn6:) forControlEvents:UIControlEventTouchUpInside];
    
    //画像を読み込んでボタンに貼る
    UIImage *imgextend1=[UIImage imageNamed:@"VISAbutton_02_03.png"];
    [_extendButton6 setBackgroundImage:imgextend1 forState:UIControlStateNormal];
    [self.view addSubview:_extendButton6];
}
-(void)TapextendBtn6:(UIButton *)extendButton6{
    //期間延長、計算、ラベルの表示
    [self aditionalcalculate6];
    NSLog(@"extend6");
    
    //finishdateの呼び出し
    NSUserDefaults *defaultsdate = [NSUserDefaults standardUserDefaults];
    NSDate *date=[_df dateFromString:[defaultsdate objectForKey:@"KEY_4"]];
    
    _finishdatelabel.text = [NSString stringWithFormat:@"滞在可能なのは%@までです",[_df stringFromDate:date]];
}
-(void)aditionalcalculate6{
    // アプリに登録されている全ての通知を削除
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    UILocalNotification *localNotification= [[UILocalNotification alloc] init];
    //UserDefaultから呼び出し
    NSUserDefaults *defaultsdate = [NSUserDefaults standardUserDefaults];
    NSDate *date=[_df dateFromString:[defaultsdate objectForKey:@"KEY_4"]];
    NSDate *finishdate=date;
    
    NSDateComponents *comp = [[NSDateComponents alloc] init];
    NSDateComponents *comp2 = [[NSDateComponents alloc] init];
    NSCalendar *cal = [NSCalendar currentCalendar];
    // NSDateFormatter を用意します。
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    
    NSDateComponents *startNumberdef =[cal components:NSDayCalendarUnit fromDate:_today toDate:finishdate options:0];
    
    int day_number = [startNumberdef day];
    // 変換用の書式を設定
    [formatter setDateFormat:@"YYYY/MM/dd HH:mm:ss"];
    
    [comp2 setDay:180];
    
    day_number=day_number+ 180;
    
    NSDate *latestfinishdate=[cal dateByAddingComponents:comp2 toDate:finishdate options:0];
    
    //    NSUserDefaults *defaultsdate = [NSUserDefaults standardUserDefaults];
    [defaultsdate setObject:[_df stringFromDate:latestfinishdate] forKey:@"KEY_4"];
    [defaultsdate synchronize];
    
    //コンソールでfinishdateの確認
    NSString *datefinish = [_df stringFromDate:latestfinishdate];
    //コンソールに出力
    NSLog(@"%@",datefinish);
    
    for (int i=0; i<day_number ;i++) {
        //指定した日付の30日先を設定
        [comp setDay:i];
        NSDate* date_converted = [cal dateByAddingComponents:comp toDate:_today options:0];
        
        // 現在から指定した日付との差分を、日を基準にして取得する。
        NSDateComponents *def1 = [cal components:NSDayCalendarUnit fromDate:date_converted toDate:latestfinishdate options:0];
        NSLog(@"days: %ld", (long)[def1 day]);
        
        _countdownDayNumber = [def1 day];
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        
        //日時データを文字列に変換する場合のフォーマットを指定
        df.dateFormat = @"yyyy/MM/dd";
        //時間単位の文字列にセット
        NSString *hourDateString = [NSString stringWithFormat:@"%@ 00:00:00", [df stringFromDate:date_converted]];
        
        date_converted =[formatter dateFromString:hourDateString];
        
        localNotification.fireDate=date_converted;
        
        localNotification.alertBody=[NSString stringWithFormat:@"あと%d日です",_countdownDayNumber+1];
        localNotification.applicationIconBadgeNumber = _countdownDayNumber+1;
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    }
    //TODO:修正箇所？
    _countdownDayNumber=day_number;
    _countdownDayNumber+=1;
    NSString *daycount = [NSString stringWithFormat:@"残り%d日", _countdownDayNumber];
    
    _countLabel.text=daycount;
    //データを保存
    NSUserDefaults *defaultscount = [NSUserDefaults standardUserDefaults];
    [defaultscount setInteger:_countdownDayNumber forKey:@"KEY_5"];
    [defaultscount synchronize];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
