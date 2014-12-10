//
//  ViewController.m
//  VISAcountdown
//
//  Created by hiratanaoki on 2014/11/10.
//  Copyright (c) 2014年 hiratanaoki. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
 
    //controller　＠の中はIdentifierで定義した名前
    DetailViewController  *sub = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    _country = @[@"アメリカ",@"フィリピン",@"オーストラリア",@"カナダ",@"ニュージーランド"];
    _period = @[@"1ヶ月",@"2ヶ月",@"3ヶ月",@"4ヶ月",@"5ヶ月",@"6ヶ月",@"7ヶ月",@"8ヶ月",@"9ヶ月",@"10ヶ月",@"11ヶ月",@"12ヶ月"];
    _purpose = @[@"留学",@"就労",@"観光"];
    
    //現在の時刻、日付をとる
    _today = [NSDate date];
    //時刻、日付の書式を決める
    _df = [[NSDateFormatter alloc] init];
    [_df setDateFormat:@"yyyy/MM/dd"];
    //時刻、日付を書式の通りに変換する
    NSString *datestr = [_df stringFromDate:_today];
    //_lastdatestr = [_df stringFromDate:sub._departdate];

    //コンソールに出力
    NSLog(@"%@",datestr);

    //タイトル文章を入力
    NSUserDefaults *defaultscountry = [NSUserDefaults standardUserDefaults];
    NSUserDefaults *defaultsperiod = [NSUserDefaults standardUserDefaults];
    NSUserDefaults *defaultspurpose = [NSUserDefaults standardUserDefaults];
    NSInteger memo1=[defaultscountry integerForKey:@"KEY_1"];
    
    NSInteger memo2=[defaultsperiod integerForKey:@"KEY_2"];
    
    NSInteger memo3=[defaultspurpose integerForKey:@"KEY_3"];
    
    NSUserDefaults *defaultsdate = [NSUserDefaults standardUserDefaults];
    NSDate *date=[_df dateFromString:[defaultsdate objectForKey:@"KEY_4"]];
    NSUserDefaults *defautsdate1 = [NSUserDefaults standardUserDefaults];
    NSDate *date1=[_df dateFromString:[defautsdate1 objectForKey:@"KEY_6"]];
    //NSDate *date2=[_df dateFromString:de]
    
    if(memo1 !=NULL){
        _valcountry=memo1;
        _countryLabel.text = _country[_valcountry];
    }
    if(memo2 !=NULL){
        _valperiod=memo2;
        _periodLabel.text = _period[_valperiod];
    }
    if(memo3 !=NULL){
        _valpurpose=memo3;
        _purposeLabel.text = _purpose[_valpurpose];
    }
    if(date1 !=NULL){
        //DatePickerで得た日付を転送
        _datepicker = [[UIDatePicker alloc] init];
        _datepicker.date=date1;
        _departdate1=_datepicker.date;
    }
    if (date !=NULL) {
        
        _finishdate = date;
        //sub._departdate = _departdate1;
        sub._finishdate1= _finishdate;
        
        //TODO:_todayを修正
        //_dayCount = [self getDaysCountByTwoDateString:_today endDateString:_finishdate];
        
    }
    [self textLabel];
    //国名を表示する
    [self countryLabel];
    //期間を表示する
    [self periodLabel];
    //目的を表示する
    [self purposeLabel];
    //出発日を表示する
    [self dateLabel];
    //国名を選ぶボタン
    [self countryButton];
    //期間を選ぶボタン
    [self periodButton];
    //目的を選ぶボタン
    [self purposeButton];
    //料金チェックボタン
    [self checkButton];
    //日付設定ボタン作成
    [self dateButton];
    //登録完了ボタン
    [self setButton];
    //バックビュー作成
    [self smallView];
    //バックビュー（datepicker）作成
    [self smalldateView];
    
    _datepicker = [[UIDatePicker alloc] init];
    
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
        
        _adView.frame = CGRectMake(0, 16-_adView.frame.size.height, _adView.frame.size.width, _adView.frame.size.height);
        
        banner.alpha = 0.0;
        
        [UIView commitAnimations];
        
        //バナーを非表示にしているのでNOを設定
        _isVisible = NO;
    }
}
-(void)viewWillAppear:(BOOL)animated{

}
-(void)textLabel{
    UILabel *myLabelInput = [[UILabel alloc] initWithFrame:CGRectMake(20 ,80 ,200, 50)];
    
    myLabelInput.text = @"情報を入力";
    [self.view addSubview:myLabelInput];
}
-(void)countryLabel{
    _countryLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 ,160 ,140, 20)];
    
    _countryLabel.text = _country[_valcountry];
    [self.view addSubview:_countryLabel];
}
-(void)periodLabel{
    _periodLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 ,220 ,140, 20)];
    
    _periodLabel.text = _period[_valperiod];
    [self.view addSubview:_periodLabel];
}
-(void)purposeLabel{
    _purposeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 ,280 ,140, 20)];
    
    _purposeLabel.text = _purpose[_valpurpose];
    [self.view addSubview:_purposeLabel];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)countryButton{
    UIButton *countryButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 130, 130, 20)];
    
    [countryButton setTitle:@"国名を選択" forState:UIControlStateNormal];
    
    [countryButton setTitleColor:[UIColor colorWithRed:0.192157 green:0.760784 blue:0.952941 alpha:1.0] forState:UIControlStateNormal];
    
    [countryButton addTarget:self action:@selector(TapCountryBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:countryButton];
}
-(void)periodButton{
    UIButton *periodButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 190, 130, 20)];
    
    [periodButton setTitle:@"期間を選択" forState:UIControlStateNormal];
    
    [periodButton setTitleColor:[UIColor colorWithRed:0.192157 green:0.760784 blue:0.952941 alpha:1.0] forState:UIControlStateNormal];
    
    [periodButton addTarget:self action:@selector(TapPeriodBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:periodButton];
}

-(void)purposeButton{
    UIButton *purposeButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 250, 130, 20)];
    
    [purposeButton setTitle:@"目的を選択" forState:UIControlStateNormal];
    
    [purposeButton setTitleColor:[UIColor colorWithRed:0.192157 green:0.760784 blue:0.952941 alpha:1.0] forState:UIControlStateNormal];
    
    [purposeButton addTarget:self action:@selector(TapPurposeBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:purposeButton];
}
-(void)TapCountryBtn:(UIButton *)countryButton{
    
    _int = 0;
    NSLog(@"country");
    _valcountry = 0;
    [self upObject];
    [self pickerView];
    [self createButton];
    for (_uv in [self.view subviews]) {
        [_countryLabel removeFromSuperview];
    }
}
-(void)TapPeriodBtn:(UIButton *)periodButton{
    
    _int = 1;
    NSLog(@"period");
    _valperiod = 0;
    [self upObject];
    [self pickerView];
    [self createButton];
    for (_uv in [self.view subviews]) {
        [_periodLabel removeFromSuperview];
    }
}
-(void)TapPurposeBtn:(UIButton *)puposeButton{
    _int = 2;
    NSLog(@"purpose");
    _valpurpose = 0;
    [self upObject];
    [self pickerView];
    [self createButton];
    for (_uv in [self.view subviews]) {
        [_purposeLabel removeFromSuperview];
    }
}

-(void)pickerView{
    _PickerView = [[UIPickerView alloc] init];
    
    _PickerView.delegate = self;
    _PickerView.dataSource = self;
    _PickerView.showsSelectionIndicator = YES;
    
    [_backView addSubview:_PickerView];
}
//国名選ぶ、列数を返す
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
//行数を返す
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    switch(_int){
    case 0:
            return _country.count;
            break;
    case 1:
            return _period.count;
            break;
    case 2:
            return _purpose.count;
            break;
    default:
            return 0;
            break;
    }
}
//文字列を返す
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    switch(_int){
        case 0:
            return _country[row];
            break;
        case 1:
            return _period[row];
            break;
        case 2:
            return _purpose[row];
            break;
        default:
            return 0;
            break;
    }

}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    //NSLog(@"選択=%@",_country[row]);
    switch(_int){
        case 0:
            NSLog(@"選択=%@",_country[row]);
            _valcountry = [pickerView selectedRowInComponent:0];
            break;
        case 1:
            NSLog(@"選択=%@",_period[row]);
            _valperiod = [pickerView selectedRowInComponent:0];
            break;
        case 2:
            NSLog(@"選択=%@",_purpose[row]);
            _valpurpose = [pickerView selectedRowInComponent:0];
            break;
        default:
            NSLog(@"選択=%@",_country[row]);
            break;
    }

    // 1列目の選択された行数を取得
//    _val = [pickerView selectedRowInComponent:0];
}
-(void)smallView{
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height)];
    
    _backView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_backView];
}
-(void)upObject{
    switch(_int){
        case 0:
            _valcountry = 0;
            break;
        case 1:
            _valperiod = 0;
            break;
        case 2:
            _valpurpose = 0;
            break;
        default:
            break;
    }   //_val = 0;
_backView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
}
-(void)downObject{
_backView.frame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height);

}
-(void)createButton{
    UIButton *createButton = [[UIButton alloc] initWithFrame:CGRectMake(200, 300, 130, 20)];
    
    [createButton setTitle:@"完了" forState:UIControlStateNormal];
    
    [createButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [createButton addTarget:self action:@selector(TapCreateBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_backView addSubview:createButton];
}
-(void)TapCreateBtn:(UIButton *)createButton{

    NSUserDefaults *defaultscountry = [NSUserDefaults standardUserDefaults];
    NSUserDefaults *defaultsperiod = [NSUserDefaults standardUserDefaults];
    NSUserDefaults *defaultspurpose = [NSUserDefaults standardUserDefaults];
    for (_uv in [self.view subviews]) {
        [_PickerView removeFromSuperview];

    }
    [self downObject];
    switch(_int){
        case 0:
            [self countryLabel];
            [defaultscountry setInteger:_valcountry forKey:@"KEY_1"];
            [defaultscountry synchronize];
            break;
        case 1:
            [self periodLabel];
            [defaultsperiod setInteger:_valperiod forKey:@"KEY_2"];
            [defaultsperiod synchronize];

            break;
        case 2:
            [self purposeLabel];
            [defaultspurpose setInteger:_valpurpose forKey:@"KEY_3"];
            [defaultspurpose synchronize];

            break;
        default:
            break;
    }

}
-(void)checkButton{
    UIButton *CheckButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 340, 130, 20)];
    
    [CheckButton setTitle:@"料金チェック" forState:UIControlStateNormal];
    
    [CheckButton setTitleColor:[UIColor colorWithRed:0.192157 green:0.760784 blue:0.952941 alpha:1.0] forState:UIControlStateNormal];
    
    [CheckButton addTarget:self action:@selector(TapCheckBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:CheckButton];
}
-(void)TapCheckBtn:(UIButton *)checkButton{
    NSLog(@"check");
    
    
    //プロジェクト内のファイルにアクセス出来るオブジェクトを宣言
    _bundle = [NSBundle mainBundle];
    
    //読み込むプロパティリストのファイルパス（場所）を指定
    _path = [_bundle pathForResource:@"costArea" ofType:@"plist"];
    
    //プロパティリストの中身のデータを取得
    _dic = [NSDictionary dictionaryWithContentsOfFile:_path];
    
    //取得出来た配列のデータをメンバ変数に代入
    _PListArray = [_dic objectForKey:@"VISAfee"];
    //TODO:プロパティリストから値を読み込む
    
    //TODO:取得した配列から国期間目的が一致したデータを取り出す
    
    //TODO:取り出したデータから料金を抜き出し表示する
    for(NSDictionary *VISAcondition in _PListArray) {
        // NSLog(@"%@",VISAcondition[@"country"]);
        
        if(([VISAcondition[@"country"] isEqualToString:_country[_valcountry]])&&([VISAcondition[@"purpose"] isEqualToString:_purpose[_valpurpose]])&&([VISAcondition[@"period"] isEqualToString:_period[_valperiod]])){
            NSLog(@"%@",VISAcondition[@"fee"]);
            
            _checkLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 400, 140, 20)];
            _checkLabel.text = VISAcondition[@"fee"];
            [self.view addSubview:_checkLabel];
            break;
        }else{NSLog(@"%@",VISAcondition[@"country"]);}
        
    }
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView commitAnimations];
}
-(void)smalldateView{
    _backdateView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height)];
    
    _backdateView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_backdateView];
}
-(void)updateObject{
    
    _backdateView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
}
-(void)downdateObject{
    _backdateView.frame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height);
    
}
-(void)dateButton{
    UIButton *dateButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 430, 130, 20)];
    
    [dateButton setTitle:@"出発日を登録" forState:UIControlStateNormal];
    
    [dateButton setTitleColor:[UIColor colorWithRed:0.192157 green:0.760784 blue:0.952941 alpha:1.0] forState:UIControlStateNormal];
    
    [dateButton addTarget:self action:@selector(TapFinishBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:dateButton];
}
-(void)TapFinishBtn:(UIButton *)dateButton{
    NSLog(@"date");
    
    [self datepicker];
    [self updateObject];
    [self datecreateButton];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView commitAnimations];
}
-(void)dateLabel{
    _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 ,460 ,140, 20)];
    
    _dateLabel.text = [_df stringFromDate:_departdate1];
    [self.view addSubview:_dateLabel];
}
-(void)datePicker:(UIDatePicker *)datePicker didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
}
-(void)datepicker{
    
    [_datepicker setDatePickerMode:UIDatePickerModeDate];
    
    _mindate = [_df dateFromString:@"2014/01/01 01:01:00"];
    [_datepicker setMinimumDate:_mindate];
    
    [_datepicker addTarget:self
                    action:@selector(changeDatePicker:)
          forControlEvents:UIControlEventValueChanged];
    
    
    [_backdateView addSubview:_datepicker];
}
-(void)changeDatePicker:(UIDatePicker *)datepicker{
    
    
    _departdate1=_datepicker.date;
    // ログに出発の日付を表示
    NSLog(@"%@", [_df stringFromDate:_departdate1]);
    NSDateComponents *comp = [[NSDateComponents alloc] init];
    NSDateComponents *comp2 = [[NSDateComponents alloc] init];
    NSCalendar *cal = [NSCalendar currentCalendar];
    
    [comp2 setDay:30];
    NSDate* date_converted = [cal dateByAddingComponents:comp toDate:_today options:0];
    _finishdate = [cal dateByAddingComponents:comp2 toDate:_departdate1 options:0];
    // 現在から指定した日付との差分を、日を基準にして取得する。
    NSDateComponents *def1 = [cal components:NSDayCalendarUnit fromDate:date_converted toDate:_finishdate options:0];
//    _dayCount = [self getDaysCountByTwoDateString:_today endDateString:_departdate1];
//    NSLog(@"%d",_dayCount);
}
//-(int)getDaysCountByTwoDateString:(NSString*)startDateString endDateString:(NSString*)endDateString{
//    float tmp= [_departdate1 timeIntervalSinceDate:_today];
//    int day=(int)( tmp / (3600.0*24.0) );
//    day +=1;
//    return day;
//}
-(void)datecreateButton{
    UIButton *datecreateButton = [[UIButton alloc] initWithFrame:CGRectMake(200, 300, 130, 20)];
    
    [datecreateButton setTitle:@"完了" forState:UIControlStateNormal];
    
    [datecreateButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [datecreateButton addTarget:self action:@selector(TapDateCreateBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_backdateView addSubview:datecreateButton];
    
    
}
-(void)TapDateCreateBtn:(UIButton *)datecreateButton{
    
    for (_uv in [self.view subviews]) {
        [_datepicker removeFromSuperview];
            }
    [self downdateObject];
    
    
    //NSdate型にDatePickerの値を代入
    _departdate1=_datepicker.date;
    //finishdateを保存
    NSUserDefaults *defaultsdate = [NSUserDefaults standardUserDefaults];
    [defaultsdate setObject:[_df stringFromDate:_finishdate] forKey:@"KEY_4"];
    [defaultsdate synchronize];
    //DatePickerのデータを保存
    NSUserDefaults *defaultsdate1 = [NSUserDefaults standardUserDefaults];
    [defaultsdate1 setObject:[_df stringFromDate:_datepicker.date] forKey:@"KEY_6"];
    [defaultsdate1 synchronize];
    
    _dateLabel.text = [_df stringFromDate:_departdate1];
}
-(void)setButton{
    UIButton *setButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 490, 130, 20)];
    
    [setButton setTitle:@"設定を登録する" forState:UIControlStateNormal];
    
    [setButton setTitleColor:[UIColor colorWithRed:0.192157 green:0.760784 blue:0.952941 alpha:1.0] forState:UIControlStateNormal];
    
    [setButton addTarget:self action:@selector(TapSetBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:setButton];
}
-(void)TapSetBtn:(UIButton *)setButton{
    NSLog(@"完了");
    
//        NSDateComponents *comp = [[NSDateComponents alloc] init];
//    NSDateComponents *comp2 = [[NSDateComponents alloc] init];
//    NSCalendar *cal = [NSCalendar currentCalendar];
//
//    [comp2 setDay:30];
//    NSDate* date_converted = [cal dateByAddingComponents:comp toDate:_today options:0];
//    _finishdate = [cal dateByAddingComponents:comp2 toDate:_departdate1 options:0];
//    // 現在から指定した日付との差分を、日を基準にして取得する。
//    NSDateComponents *def1 = [cal components:NSDayCalendarUnit fromDate:date_converted toDate:_finishdate options:0];
//    NSLog(@"days: %d", [def1 day]);
//    
//    _countdownDayNumber = [def1 day];
//
    
    if(_valcountry==nil){
        [self WarningAlertView];
    }else if(_valperiod==nil){
        [self WarningAlertView];
    }else if(_valpurpose==nil){
        [self WarningAlertView];
    }else{
        [self ConfirmAlertView];
    }
    
}
-(void)WarningAlertView{
    _alertview = [[UIAlertView alloc] initWithTitle:@"未入力箇所があります" message:nil delegate:self cancelButtonTitle:@"入力を続ける" otherButtonTitles:nil];
    [_alertview show];
    _alertview.tag =1;
}
-(void)ConfirmAlertView{

    _alertview2 = [[UIAlertView alloc] initWithTitle:@"設定完了しますか？" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    [_alertview2 show];
    _alertview2.tag=2;
}
-(void)DepartAlertView{
    _alertview3 = [[UIAlertView alloc] initWithTitle:@"日程に誤りがあります" message:nil delegate:self cancelButtonTitle:@"入力を続ける" otherButtonTitles:nil];
    [_alertview3 show];
    _alertview3.tag =3;
}
-(void)countBudge1{
    // アプリに登録されている全ての通知を削除
    [[UIApplication sharedApplication] cancelAllLocalNotifications];

    UILocalNotification *localNotification= [[UILocalNotification alloc] init];
    
    NSDateComponents *comp = [[NSDateComponents alloc] init];
    NSDateComponents *comp2 = [[NSDateComponents alloc] init];
    NSCalendar *cal = [NSCalendar currentCalendar];
    // NSDateFormatter を用意します。
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    
    NSDateComponents *startNumberdef =[cal components:NSDayCalendarUnit fromDate:_today toDate:_departdate1 options:0];
    
    int day_number = [startNumberdef day];
    // 変換用の書式を設定
    [formatter setDateFormat:@"YYYY/MM/dd HH:mm:ss"];
    switch(_valcountry){
        case 0:
            daycountoffirstadition = 30;
            break;
        case 1:
            daycountoffirstadition = 30;
            break;
        case 2:
            daycountoffirstadition=30;
            break;
        case 3:
            daycountoffirstadition=30;
            break;
        case 4:
            daycountoffirstadition=30;
            break;
        default:
            daycountoffirstadition=30;
            break;
    }

    
    [comp2 setDay:daycountoffirstadition];
    
    day_number=day_number+ daycountoffirstadition;
    
    _finishdate = [cal dateByAddingComponents:comp2 toDate:_departdate1 options:0];
    for (int i=0; i<day_number ;i++) {
        //指定した日付の30日先を設定
        [comp setDay:i];
        NSDate* date_converted = [cal dateByAddingComponents:comp toDate:_today options:0];
        
        // 現在から指定した日付との差分を、日を基準にして取得する。
        NSDateComponents *def1 = [cal components:NSDayCalendarUnit fromDate:date_converted toDate:_finishdate options:0];
        NSLog(@"days: %d", [def1 day]);
        
        _countdownDayNumber = [def1 day];
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        
        //日時データを文字列に変換する場合のフォーマットを指定
        df.dateFormat = @"yyyy/MM/dd";
        //時間単位の文字列にセット
        NSString *hourDateString = [NSString stringWithFormat:@"%@ 00:00:00", [df stringFromDate:date_converted]];


        
        date_converted =[formatter dateFromString:hourDateString];
        //        _countLabel.text = [NSString stringWithFormat:@"あと%d日です",countdownDayNumber];
        localNotification.fireDate=date_converted;
        
        localNotification.alertBody=[NSString stringWithFormat:@"あと%d日です",_countdownDayNumber];
        
        localNotification.applicationIconBadgeNumber = _countdownDayNumber;
        
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        
    }
    _countdownDayNumber=day_number+1;

}
//    __countNotification = [[UILocalNotification alloc] init];
//    
//    __countNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:1];
//    //    __countNotification.alertBody = [NSString stringWithFormat:@"あと%d日です",__countdownDayNumber];
//    //一日ごとに計算
//    //__countNotification.repeatInterval = NSDayCalendarUnit;
//    __countNotification.applicationIconBadgeNumber = _dayCount;
//    __countNotification.timeZone = [NSTimeZone defaultTimeZone];
//   // [[UIApplication sharedApplication] scheduleLocalNotification:__countNotification];
//}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    //controller　＠の中はIdentifierで定義した名前
    DetailViewController  *sub = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    
    if(alertView.tag==2){
        
        switch(buttonIndex){
            case 0:
                //Cancelボタン
                NSLog(@"bbbb");
                break;
            case 1:
                
                //OKボタン
                NSLog(@"aaaa");
                
                //計算、Notificationのセット
                [self countBudge1];

                
                if (_countdownDayNumber<1) {
                    [self DepartAlertView];
                    
                }else{
                

                    
                    NSUserDefaults *defaultscount = [NSUserDefaults standardUserDefaults];
                    [defaultscount setInteger:_countdownDayNumber forKey:@"KEY_5"];
                    [defaultscount synchronize];
                    
                    
                //画面遷移
                    //データを転送（integer型）
                    self.tabBarController.selectedIndex=0;
                    
                    sub=(DetailViewController *)self.tabBarController.selectedViewController;
                    sub._finishdate1 = _finishdate;
                    NSLog(@"%@",sub._finishdate1);
                    
                    sub._daycount2=_countdownDayNumber;
                }
        }
        }else{
        
            NSLog(@"ccc");
        
            switch(buttonIndex){
                case 0:
                    break;
                    
            }
        }   //if文のかっこ
    }
@end
