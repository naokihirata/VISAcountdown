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
 
    //画像を読み込んでボタンに貼る
    UIImage *backimg=[UIImage imageNamed:@"backimage_02new.png"];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:backimg];
    //[backimg release];
    
    //controller　＠の中はIdentifierで定義した名前
    DetailViewController  *sub = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    _country = @[@"フィリピン",@"オーストラリア",@"シンガポール",@"ニュージーランド",@"カナダ",@"アメリカ",@"フィジー",@"イギリス"];
    _period = @[@"1ヶ月",@"2ヶ月",@"3ヶ月",@"4ヶ月",@"5ヶ月",@"6ヶ月",@"7ヶ月",@"8ヶ月",@"9ヶ月",@"10ヶ月",@"11ヶ月",@"12ヶ月"];
    _period_for_compare = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"];
    
    _purpose = @[@"留学",@"観光"];
    
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
    int memo1=[[defaultscountry objectForKey:@"KEY_1"] intValue];
    
    int memo2=[[defaultsperiod objectForKey:@"KEY_2"] intValue];
    
    int memo3=[[defaultspurpose objectForKey:@"KEY_3"] intValue];
    
    NSUserDefaults *defaultsdate = [NSUserDefaults standardUserDefaults];
    NSDate *date=[_df dateFromString:[defaultsdate objectForKey:@"KEY_4"]];
    NSUserDefaults *defautsdate1 = [NSUserDefaults standardUserDefaults];
    NSDate *date1=[_df dateFromString:[defautsdate1 objectForKey:@"KEY_6"]];
    NSUserDefaults *defaultsreturndate=[NSUserDefaults standardUserDefaults];
    NSDate *date2=[_df dateFromString:[defaultsreturndate objectForKey:@"KEY_7"]];
    //NSDate *date2=[_df dateFromString:de]
    
    if(!memo1){
        _valcountry=memo1;
        _countryLabel.text = _country[_valcountry];
    }
    if(!memo2){
        _valperiod=memo2;
        _periodLabel.text = _period[_valperiod];
    }
    if(!memo3){
        _valpurpose=memo3;
        _purposeLabel.text = _purpose[_valpurpose];
    }
    if(date1 !=NULL){
        //DatePickerで得た日付を転送
        _datepicker = [[UIDatePicker alloc] init];
        _datepicker.date=date1;
        _departdate1=_datepicker.date;
    }
    if(date2 !=NULL){
        _datepicker2=[[UIDatePicker alloc] init];
        _datepicker2.date=date2;
        _willreturndate=_datepicker2.date;
    }
    if (date !=NULL) {
        
        _finishdate = date;
        
        sub._finishdate1= _finishdate;
    }
    //タイトルを表示
    [self textLabel];
    //注意書きを表示
    [self alertlabel];
    //国名を表示する
    [self countryLabel];
    //期間を表示する
    [self periodLabel];
    //目的を表示する
    [self purposeLabel];
    //料金を表示する
    [self checkLabel];
    
    //国名を選ぶボタン
    [self countryButton];
    //期間を選ぶボタン
    [self periodButton];
    //目的を選ぶボタン
    [self purposeButton];
    //料金チェックボタン
    [self checkButton];
    
    
    
    //登録完了ボタン
    [self setButton];
    //バックビュー作成
    [self smallView];
    //バックビュー（datepicker）作成
    [self smalldateView];
    //帰国予定日用のViewを作成
    [self smalldateView2];
    //スイッチを表示
    [self swich];
    //スイッチのラベル
    [self switchlabel];
    
    if(!_switch.on){
        //帰国予定日ボタン作成
        [self returndateButton];
        //帰国予定日を表示する
        [self returnlabel];
    }else{
        //日付設定ボタン作成
        [self dateButton];
        //出発日を表示する
        [self dateLabel];
    }
    _datepicker = [[UIDatePicker alloc] init];
    _datepicker2=[[UIDatePicker alloc] init];
    
    //[self.view bringSubviewToFront:_switch];

//    //初期化
//    _adView = [[ADBannerView alloc] init];
//    _adView.frame = CGRectMake(0, 16-_adView.frame.size.height, _adView.frame.size.width, _adView.frame.size.height);
//    //場所を決定
//    _adView.alpha = 0.0;
//    _adView.delegate = self;
//    
//    //画面本体に追加
//    [self.view addSubview:_adView];
//    
//    //バナーは表示されていないのでNOを設定
//    _isVisible = NO;

}
//バナーが正常に表示された場合
//-(void)bannerViewDidLoadAd:(ADBannerView *)banner{
//    if (_isVisible == NO) {
//        [UIView beginAnimations:@"animateAdBannerOn" context:nil];
//        [UIView setAnimationDuration:0.3];
//        
//        banner.frame = CGRectOffset(banner.frame, 0, CGRectGetHeight(banner.frame));
//        banner.alpha = 1.0;
//        [UIView commitAnimations];
//        
//        //バナーを表示しているのでYESを設定
//        _isVisible = YES;
//    }
//}
//バナー表示でエラーが発生した場合
//-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error{
//    
//    if (_isVisible == YES) {
//        [UIView beginAnimations:@"animateAdBannerOff" context:nil];
//        [UIView setAnimationDuration:0.3];
//        
//        _adView.frame = CGRectMake(0, 16-_adView.frame.size.height, _adView.frame.size.width, _adView.frame.size.height);
//        
//        banner.alpha = 0.0;
//        
//        [UIView commitAnimations];
//        
//        //バナーを非表示にしているのでNOを設定
//        _isVisible = NO;
//    }
//}
-(void)viewDidAppear:(BOOL)animated{
    //全てのbackviewを最前面へ
    [self.view bringSubviewToFront:_backView];
    [self.view bringSubviewToFront:_backdateView];
    [self.view bringSubviewToFront:_backdateView2];
}
-(void)viewWillAppear:(BOOL)animated{
}
-(void)textLabel{
    UILabel *myLabelInput = [[UILabel alloc] initWithFrame:CGRectMake(20 ,16 ,130, 35)];
    //myLabelInput.font=[UIFont systemFontOfSize:22];
    [myLabelInput setFont:[UIFont fontWithName:@"Marker Felt" size:22]];
    myLabelInput.textColor=[UIColor blueColor];
    UIColor *color = [UIColor whiteColor];
    UIColor *acolor = [color colorWithAlphaComponent:0.02]; //透過率50%
    myLabelInput.backgroundColor=acolor;
    myLabelInput.textAlignment = NSTextAlignmentLeft;
    myLabelInput.text = @"情報を入力";
    //画像を読み込んでボタンに貼る
//    UIImage *imgtextlabel=[UIImage imageNamed:@"Button_01.png"];
//    [myLabelInput setBackgroundImage:imgtextlabel forState:UIControlStateNormal];

    [self.view addSubview:myLabelInput];
}
-(void)alertlabel{
    _alertlabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, self.view.bounds.size.width, 20)];
    [_alertlabel setFont:[UIFont fontWithName:@"Marker Felt" size:12]];
    _alertlabel.textColor=[UIColor redColor];
    UIColor *color = [UIColor yellowColor];
    UIColor *acolor = [color colorWithAlphaComponent:0.5]; //透過率50%
    _alertlabel.backgroundColor=acolor;
    _alertlabel.textAlignment=NSTextAlignmentNatural;
    _alertlabel.text=@"国名、期間、目的、出発日は入力必須項目です！";
    
    [self.view addSubview:_alertlabel];
}
-(void)countryLabel{
    _countryLabel = [[UILabel alloc] initWithFrame:CGRectMake(165 ,90 ,140, 27)];
    UIColor *color = [UIColor whiteColor];
    UIColor *acolor = [color colorWithAlphaComponent:0.5]; //透過率50%
    _countryLabel.backgroundColor=acolor;
    _countryLabel.font=[UIFont systemFontOfSize:16];
    _countryLabel.textAlignment = NSTextAlignmentCenter;
    _countryLabel.text = _country[_valcountry];
    [self.view addSubview:_countryLabel];
}
-(void)periodLabel{
    _periodLabel = [[UILabel alloc] initWithFrame:CGRectMake(165 ,145 ,140, 27)];
    UIColor *color = [UIColor whiteColor];
    UIColor *acolor = [color colorWithAlphaComponent:0.5]; //透過率50%
    _periodLabel.backgroundColor=acolor;
    _periodLabel.font=[UIFont systemFontOfSize:22];
    _periodLabel.textAlignment = NSTextAlignmentCenter;
    _periodLabel.text = _period[_valperiod];
    [self.view addSubview:_periodLabel];
}
-(void)purposeLabel{
    _purposeLabel = [[UILabel alloc] initWithFrame:CGRectMake(165 ,207 ,140, 27)];
    UIColor *color = [UIColor whiteColor];
    UIColor *acolor = [color colorWithAlphaComponent:0.5]; //透過率50%
    _purposeLabel.backgroundColor=acolor;
    _purposeLabel.font=[UIFont systemFontOfSize:22];
    _purposeLabel.textAlignment = NSTextAlignmentCenter;
    _purposeLabel.text = _purpose[_valpurpose];
    [self.view addSubview:_purposeLabel];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)countryButton{
    UIButton *countryButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 85, 140, 37)];
    //セットタイトルを消す
    //[countryButton setTitle:@"国名を選択" forState:UIControlStateNormal];
    
    [countryButton setTitleColor:[UIColor colorWithRed:0.192157 green:0.760784 blue:0.952941 alpha:1.0] forState:UIControlStateNormal];
    
    [countryButton addTarget:self action:@selector(TapCountryBtn:) forControlEvents:UIControlEventTouchUpInside];
    //画像を読み込んでボタンに貼る
    UIImage *imgcountry=[UIImage imageNamed:@"Button_01.png"];
    [countryButton setBackgroundImage:imgcountry forState:UIControlStateNormal];
    
    [self.view addSubview:countryButton];
}
-(void)periodButton{
    UIButton *periodButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 141, 140, 37)];
    
    //[periodButton setTitle:@"期間を選択" forState:UIControlStateNormal];
    
    [periodButton setTitleColor:[UIColor colorWithRed:0.192157 green:0.760784 blue:0.952941 alpha:1.0] forState:UIControlStateNormal];
    
    [periodButton addTarget:self action:@selector(TapPeriodBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    //画像を読み込んでボタンに貼る
    UIImage *imgperiod=[UIImage imageNamed:@"Button_03period.png"];
    [periodButton setBackgroundImage:imgperiod forState:UIControlStateNormal];
    [self.view addSubview:periodButton];
}

-(void)purposeButton{
    UIButton *purposeButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 200, 140, 37)];
    
    //[purposeButton setTitle:@"目的を選択" forState:UIControlStateNormal];
    
    [purposeButton setTitleColor:[UIColor colorWithRed:0.192157 green:0.760784 blue:0.952941 alpha:1.0] forState:UIControlStateNormal];
    
    [purposeButton addTarget:self action:@selector(TapPurposeBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    //画像を読み込んでボタンに貼る
    UIImage *imgpurpose=[UIImage imageNamed:@"Button_02purpose.png"];
    [purposeButton setBackgroundImage:imgpurpose forState:UIControlStateNormal];
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
    [self.view bringSubviewToFront:_backView];
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
    [self.view bringSubviewToFront:_backView];
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
    [self.view bringSubviewToFront:_backView];
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
    
    // 生成済みのUIColorに透過率のみ指定する場合
    UIColor *color = [UIColor whiteColor];
    UIColor *acolor = [color colorWithAlphaComponent:0.9]; //透過率50%
    _backView.backgroundColor = acolor;
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
_backView.frame = CGRectMake(0, (self.view.bounds.size.height)/3, self.view.bounds.size.width, self.view.bounds.size.height);
}
-(void)downObject{
_backView.frame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height);

}
-(void)createButton{
    UIButton *createButton = [[UIButton alloc] initWithFrame:CGRectMake(180, 268, 100, 30)];
    
    //[createButton setTitle:@"完了" forState:UIControlStateNormal];
    
    [createButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [createButton addTarget:self action:@selector(TapCreateBtn:) forControlEvents:UIControlEventTouchUpInside];
    //画像を読み込んでボタンに貼る
    UIImage *imgdate=[UIImage imageNamed:@"VISAbutton_03_03.png"];
    [createButton setBackgroundImage:imgdate forState:UIControlStateNormal];
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
    UIButton *CheckButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 250, 140, 34)];
    
    //[CheckButton setTitle:@"料金チェック" forState:UIControlStateNormal];
    
    [CheckButton setTitleColor:[UIColor colorWithRed:0.192157 green:0.760784 blue:0.952941 alpha:1.0] forState:UIControlStateNormal];
    
    [CheckButton addTarget:self action:@selector(TapCheckBtn:) forControlEvents:UIControlEventTouchUpInside];
    //画像を読み込んでボタンに貼る
    UIImage *imgcheck=[UIImage imageNamed:@"Button_04costcheck.png"];
    [CheckButton setBackgroundImage:imgcheck forState:UIControlStateNormal];
    [self.view addSubview:CheckButton];
}
-(void)TapCheckBtn:(UIButton *)checkButton{
    NSLog(@"check");
    
    
    //プロジェクト内のファイルにアクセス出来るオブジェクトを宣言
    _bundle = [NSBundle mainBundle];
    
    //TODO:プロパティリストから値を読み込む
    
    //読み込むプロパティリストのファイルパス（場所）を指定
    _path = [_bundle pathForResource:@"created" ofType:@"plist"];
    
    //プロパティリストの中身のデータを取得
    _dic = [NSDictionary dictionaryWithContentsOfFile:_path];
    
    //取得出来た配列のデータをメンバ変数に代入
    _PListArray = [_dic objectForKey:_country[_valcountry]];
    
    
    //TODO:取得した配列から国期間目的が一致したデータを取り出す
    for(NSDictionary *VISAcondition in _PListArray) {
        // NSLog(@"%@",VISAcondition[@"country"]);
        
        if(([VISAcondition[@"country"] isEqualToString:_country[_valcountry]])&&([VISAcondition[@"purpose"] isEqualToString:_purpose[_valpurpose]])&&([VISAcondition[@"period"] isEqualToString:_period_for_compare[_valperiod]])){
            NSLog(@"%@",VISAcondition[@"cost"]);
            
    //TODO:取り出したデータから料金を抜き出し表示する
            _checkLabel.text = VISAcondition[@"cost"];
            break;
        }else{NSLog(@"%@",VISAcondition[@"country"]);}
        
    }
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView commitAnimations];
}
-(void)checkLabel{

    _checkLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 288, 280, 27)];
    UIColor *color = [UIColor whiteColor];
    UIColor *acolor = [color colorWithAlphaComponent:0.5]; //透過率50%
    _checkLabel.backgroundColor=acolor;
    _checkLabel.font=[UIFont systemFontOfSize:18];
    _checkLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:_checkLabel];
}


-(void)smalldateView{
    _backdateView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height)];
    
    UIColor *color = [UIColor whiteColor];
    UIColor *acolor = [color colorWithAlphaComponent:0.9]; //透過率50%
    _backdateView.backgroundColor = acolor;
    
    [self.view addSubview:_backdateView];
}
-(void)updateObject{
    
    _backdateView.frame = CGRectMake(0, (self.view.bounds.size.height)/3, self.view.bounds.size.width, self.view.bounds.size.height);
}
-(void)downdateObject{
    _backdateView.frame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height);
    
}
-(void)dateButton{
    _dateButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 360, 130, 30)];
    
    //[dateButton setTitle:@"出発日を登録" forState:UIControlStateNormal];
    
    [_dateButton setTitleColor:[UIColor colorWithRed:0.192157 green:0.760784 blue:0.952941 alpha:1.0] forState:UIControlStateNormal];
    
    [_dateButton addTarget:self action:@selector(TapFinishBtn:) forControlEvents:UIControlEventTouchUpInside];
    //画像を読み込んでボタンに貼る
    UIImage *imgdate=[UIImage imageNamed:@"Button_010.png"];
    [_dateButton setBackgroundImage:imgdate forState:UIControlStateNormal];
    [self.view addSubview:_dateButton];
}
-(void)TapFinishBtn:(UIButton *)dateButton{
    NSLog(@"date");
    
    [self datepicker];
    [self updateObject];
    [self datecreateButton];
    [self.view bringSubviewToFront:_backdateView];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView commitAnimations];
}
-(void)dateLabel{
    _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(165 ,363 ,130, 27)];
    UIColor *color = [UIColor whiteColor];
    UIColor *acolor = [color colorWithAlphaComponent:0.5]; //透過率50%
    _dateLabel.backgroundColor=acolor;
    _dateLabel.font=[UIFont systemFontOfSize:22];
    _dateLabel.textAlignment = NSTextAlignmentCenter;

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
}
-(void)datecreateButton{
    UIButton *datecreateButton = [[UIButton alloc] initWithFrame:CGRectMake(180, 270, 100, 30)];
    
    //[datecreateButton setTitle:@"完了" forState:UIControlStateNormal];
    
    [datecreateButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [datecreateButton addTarget:self action:@selector(TapDateCreateBtn:) forControlEvents:UIControlEventTouchUpInside];
    //画像を読み込んでボタンに貼る
    UIImage *imgdate=[UIImage imageNamed:@"VISAbutton_03_03.png"];
    [datecreateButton setBackgroundImage:imgdate forState:UIControlStateNormal];
    [_backdateView addSubview:datecreateButton];
    
}
-(void)TapDateCreateBtn:(UIButton *)datecreateButton{
    
    //_justday=1;
    for (_uv in [self.view subviews]) {
        [_datepicker removeFromSuperview];
            }
    [self downdateObject];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY/MM/dd HH:mm:ss"];
    NSString *hourDateString = [NSString stringWithFormat:@"%@ 00:00:00", [_df stringFromDate:_datepicker.date]];
    
    //NSdate型にDatePickerの値を代入
    _departdate1=[formatter dateFromString:hourDateString];
    
    //finishdateを保存
    NSUserDefaults *defaultsdate = [NSUserDefaults standardUserDefaults];
    [defaultsdate setObject:[_df stringFromDate:_finishdate] forKey:@"KEY_4"];
    [defaultsdate synchronize];
    //DatePickerのデータを保存
    NSUserDefaults *defaultsdate1 = [NSUserDefaults standardUserDefaults];
    [defaultsdate1 setObject:[_df stringFromDate:_departdate1] forKey:@"KEY_6"];
    [defaultsdate1 synchronize];
    
    _dateLabel.text = [_df stringFromDate:_departdate1];
    
}
//Switchの作成
-(void)switchlabel{
    _switchlabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 430, 80, 27)];
    [_switchlabel setFont:[UIFont fontWithName:@"Marker Felt" size:20]];
    //switchlabel.textColor=[UIColor redColor];
    UIColor *color = [UIColor whiteColor];
    UIColor *acolor = [color colorWithAlphaComponent:0.2]; //透過率50%
    _switchlabel.backgroundColor=acolor;
    _switchlabel.textAlignment=NSTextAlignmentCenter;
    _switchlabel.text=@"自動";
    
    [self.view addSubview:_switchlabel];
}
-(void)swich{
    //スイッチの設置
    _switch=[[UISwitch alloc] init];
    _switch.center=CGPointMake(140, 445);
    
    //スイッチをonにする
    _switch.on=YES;
    [_switch addTarget:self action:@selector(swich_ValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:_switch];
}
-(void)swich_ValueChanged:(id)sender{
    
    _switch=sender;
    if (_switch.on) {
        _switchlabel.text=@"自動";
        for (_uv in [self.view subviews]) {
            [_returndateButton removeFromSuperview];
            [_returnlabel removeFromSuperview];
        }
        [self dateButton];
        [self dateLabel];
        _alertlabel.text=@"国名、期間、目的、出発日は入力必須項目です！";

        
    }else{
        _switchlabel.text=@"手入力";
        for (_uv in [self.view subviews]) {
            [_dateButton removeFromSuperview];
            [_dateLabel removeFromSuperview];
        }
        [self returndateButton];
        [self returnlabel];
        _alertlabel.text=@"国名、期間、目的、帰国予定日は入力必須項目です！";

    }
}
//帰国日予定ボタン,メソッド
-(void)returndateButton{
    _returndateButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 360, 130, 30)];
    
    //[dateButton setTitle:@"帰国予定日を登録" forState:UIControlStateNormal];
    
    [_returndateButton setTitleColor:[UIColor colorWithRed:0.192157 green:0.760784 blue:0.952941 alpha:1.0] forState:UIControlStateNormal];
    
    [_returndateButton addTarget:self action:@selector(TapreturnFinishBtn:) forControlEvents:UIControlEventTouchUpInside];
    //画像を読み込んでボタンに貼る
    UIImage *imgdate=[UIImage imageNamed:@"VISAbutton_03_07.png"];
    [_returndateButton setBackgroundImage:imgdate forState:UIControlStateNormal];
    [self.view addSubview:_returndateButton];
}
-(void)TapreturnFinishBtn:(UIButton *)returndateButton{
    NSLog(@"date");
    
    [self datepicker2];
    [self updateObject2];
    [self datecreateButton2];
    [self.view bringSubviewToFront:_backdateView2];
}
-(void)returnlabel{
    _returnlabel = [[UILabel alloc] initWithFrame:CGRectMake(165 ,363 ,130, 27)];
    UIColor *color = [UIColor whiteColor];
    UIColor *acolor = [color colorWithAlphaComponent:0.5]; //透過率50%
    _returnlabel.backgroundColor=acolor;
    _returnlabel.font=[UIFont systemFontOfSize:22];
    _returnlabel.textAlignment = NSTextAlignmentCenter;
    
    _returnlabel.text = [_df stringFromDate:_willreturndate];
    [self.view addSubview:_returnlabel];
}
-(void)smalldateView2{
    _backdateView2 = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height)];
    
    UIColor *color = [UIColor whiteColor];
    UIColor *acolor = [color colorWithAlphaComponent:0.9]; //透過率50%
    _backdateView2.backgroundColor = acolor;
    
    [self.view addSubview:_backdateView2];
}
-(void)updateObject2{
    
    _backdateView2.frame = CGRectMake(0, (self.view.bounds.size.height)/3, self.view.bounds.size.width, self.view.bounds.size.height);
}
-(void)downdateObject2{
    _backdateView2.frame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height);
    
}
//-(void)datePicker:(UIDatePicker *)datePicker didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
//}
-(void)datepicker2{
    
    [_datepicker2 setDatePickerMode:UIDatePickerModeDate];
    
    _mindate = [_df dateFromString:@"2014/01/01 00:00:00"];
    [_datepicker2 setMinimumDate:_mindate];
    
    [_datepicker2 addTarget:self
                    action:@selector(changeDatePicker2:)
          forControlEvents:UIControlEventValueChanged];
    
    [_backdateView2 addSubview:_datepicker2];
}
-(void)changeDatePicker2:(UIDatePicker *)datepicker{
    
    _willreturndate=_datepicker2.date;
    // ログに出発の日付を表示
    NSLog(@"%@", [_df stringFromDate:_willreturndate]);

}
-(void)datecreateButton2{
    UIButton *datecreateButton = [[UIButton alloc] initWithFrame:CGRectMake(180, 270, 100, 30)];
    
    //[datecreateButton setTitle:@"完了" forState:UIControlStateNormal];
    
    [datecreateButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [datecreateButton addTarget:self action:@selector(TapDateCreateBtn2:) forControlEvents:UIControlEventTouchUpInside];
    //画像を読み込んでボタンに貼る
    UIImage *imgdate=[UIImage imageNamed:@"VISAbutton_03_03.png"];
    [datecreateButton setBackgroundImage:imgdate forState:UIControlStateNormal];
    [_backdateView2 addSubview:datecreateButton];
    
}
-(void)TapDateCreateBtn2:(UIButton *)datecreateButton2{
    
    for (_uv in [self.view subviews]) {
        [_datepicker2 removeFromSuperview];
    }
    [self downdateObject2];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY/MM/dd HH:mm:ss"];
    NSString *hourDateString = [NSString stringWithFormat:@"%@ 00:00:00", [_df stringFromDate:_datepicker2.date]];
    
    //NSdate型にDatePickerの値を代入
    _willreturndate=[formatter dateFromString:hourDateString];
    
    //willreturndateを保存(KEY_7)
    NSUserDefaults *defaultsreturndate = [NSUserDefaults standardUserDefaults];
    [defaultsreturndate setObject:[_df stringFromDate:_willreturndate] forKey:@"KEY_7"];
    [defaultsreturndate synchronize];
    
    _returnlabel.text = [_df stringFromDate:_willreturndate];
}
//設定を登録
-(void)setButton{
    UIButton *setButton = [[UIButton alloc] initWithFrame:CGRectMake(190, 475, 130, 35)];
    
    //[setButton setTitle:@"設定を登録する" forState:UIControlStateNormal];
    
    [setButton setTitleColor:[UIColor colorWithRed:0.192157 green:0.760784 blue:0.952941 alpha:1.0] forState:UIControlStateNormal];
    
    [setButton addTarget:self action:@selector(TapSetBtn:) forControlEvents:UIControlEventTouchUpInside];
    //画像を読み込んでボタンに貼る
    UIImage *imgset=[UIImage imageNamed:@"Button_08.png"];
    [setButton setBackgroundImage:imgset forState:UIControlStateNormal];
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
    
    if(_valcountry<0){
        [self WarningAlertView];
    }else if(_valperiod<0){
        [self WarningAlertView];
    }else if(_valpurpose<0){
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
        case 0://フィリピン
            _daycountoffirstadition = 30;
            break;
        case 1://オーストラリア
            _daycountoffirstadition = 30;
            break;
        case 2://シンガポール
            _daycountoffirstadition=30;
            break;
        case 3://ニュージーランド
            _daycountoffirstadition=90;
            break;
        case 4://カナダ
            _daycountoffirstadition = 180;
            break;
        case 5://アメリカ
            _daycountoffirstadition=30;
            break;
        case 6://フィジー
            if (_valpurpose==1) {
                _daycountoffirstadition=120;
            }else{
            _daycountoffirstadition=30;
            }
            break;
        case 7://イギリス
            _daycountoffirstadition=180;
            break;
        default:
            _daycountoffirstadition=30;
            break;
    }

    
    [comp2 setDay:_daycountoffirstadition];
    
    day_number=day_number+ _daycountoffirstadition;
    
    _finishdate = [cal dateByAddingComponents:comp2 toDate:_departdate1 options:0];
    for (int i=0; i<day_number ;i++) {
        //指定した日付の30日先を設定
        [comp setDay:i];
        NSDate* date_converted = [cal dateByAddingComponents:comp toDate:_today options:0];
        
        // 現在から指定した日付との差分を、日を基準にして取得する。
        NSDateComponents *def1 = [cal components:NSDayCalendarUnit fromDate:date_converted toDate:_finishdate options:0];
        NSLog(@"days: %ld", (long)[def1 day]);
        
        _countdownDayNumber = [def1 day];
        
        //_countdownDayNumber-=2;
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        
        //日時データを文字列に変換する場合のフォーマットを指定
        df.dateFormat = @"yyyy/MM/dd";
        //時間単位の文字列にセット
        NSString *hourDateString = [NSString stringWithFormat:@"%@ 00:00:00", [df stringFromDate:date_converted]];


        
        date_converted =[formatter dateFromString:hourDateString];
        localNotification.fireDate=date_converted;
        if (_countdownDayNumber+1<=14) {
            localNotification.alertBody=[NSString stringWithFormat:@"あと%d日です",_countdownDayNumber+1];
        }else{
        }
        localNotification.applicationIconBadgeNumber = _countdownDayNumber + 1;
                localNotification.timeZone = [NSTimeZone defaultTimeZone];
        
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        
    }
    _countdownDayNumber=day_number+1;
    

}
-(void)countBudge2{
    
    // アプリに登録されている全ての通知を削除
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    UILocalNotification *localNotification= [[UILocalNotification alloc] init];
    
    NSDateComponents *comp = [[NSDateComponents alloc] init];
    NSDateComponents *comp2 = [[NSDateComponents alloc] init];
    NSCalendar *cal = [NSCalendar currentCalendar];
    // NSDateFormatter を用意します。
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    
    NSDateComponents *startNumberdef =[cal components:NSDayCalendarUnit fromDate:_today toDate:_willreturndate options:0];
    
    int day_number = [startNumberdef day];
    // 変換用の書式を設定
    [formatter setDateFormat:@"YYYY/MM/dd HH:mm:ss"];
    
    [comp2 setDay:0];
    
    _finishdate = [cal dateByAddingComponents:comp2 toDate:_willreturndate options:0];
    for (int i=0; i<day_number ;i++) {
        //指定した日付の30日先を設定
        [comp setDay:i];
        NSDate* date_converted = [cal dateByAddingComponents:comp toDate:_today options:0];
        
        // 現在から指定した日付との差分を、日を基準にして取得する。
        NSDateComponents *def1 = [cal components:NSDayCalendarUnit fromDate:date_converted toDate:_willreturndate options:0];
        NSLog(@"days: %ld", (long)[def1 day]);
        
        _countdownDayNumber = [def1 day];
        
        //_countdownDayNumber-=2;
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        
        //日時データを文字列に変換する場合のフォーマットを指定
        df.dateFormat = @"yyyy/MM/dd";
        //時間単位の文字列にセット
        NSString *hourDateString = [NSString stringWithFormat:@"%@ 00:00:00", [df stringFromDate:date_converted]];
        
        
        
        date_converted =[formatter dateFromString:hourDateString];
        //        _countLabel.text = [NSString stringWithFormat:@"あと%d日です",countdownDayNumber];
        localNotification.fireDate=date_converted;
        
        localNotification.alertBody=[NSString stringWithFormat:@"あと%d日です",_countdownDayNumber+1];
        
        
        localNotification.applicationIconBadgeNumber = _countdownDayNumber + 1;
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    }
    _countdownDayNumber=day_number+1;
}
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
                if (_switch.on) {
                    [self countBudge1];
                }else{
                    [self countBudge2];
                }
                
                if (_countdownDayNumber<-60) {
                    [self DepartAlertView];
                    
                }else{

                    _countdownDayNumber-=1;
                    NSUserDefaults *defaultscount = [NSUserDefaults standardUserDefaults];

                    [defaultscount setObject:[NSString stringWithFormat:@"%d",_countdownDayNumber] forKey:@"KEY_5"];
                    [defaultscount synchronize];
                    
                    
                //画面遷移
                    //データを転送（integer型）
                    self.tabBarController.selectedIndex=0;
                    
                    sub=(DetailViewController *)self.tabBarController.selectedViewController;
                    sub._finishdate1 = _finishdate;
                    NSLog(@"%@",sub._finishdate1);
                    
                    sub._daycount2=_countdownDayNumber;
                    sub._switch2=_switch;
                    
                    NSUserDefaults *defaultsdate = [NSUserDefaults standardUserDefaults];
                    [defaultsdate setObject:[_df stringFromDate:_finishdate] forKey:@"KEY_4"];
                    
//                    NSUserDefaults *defaultsnumber=[NSUserDefaults standardUserDefaults];
//                    int number = (int)[[defaultsnumber objectForKey:@"KEY_9"] intValue];
                    
                    int number=0;
                    NSUserDefaults *defaultsnumber = [NSUserDefaults standardUserDefaults];
                    [defaultsnumber setInteger:number forKey:@"KEY_9"];
                    [defaultsnumber synchronize];

                    _touchnumber=0;
                    NSUserDefaults *defaultstouchnumber = [NSUserDefaults standardUserDefaults];
                    [defaultstouchnumber setInteger:_touchnumber forKey:@"KEY_10"];
                    [defaultstouchnumber synchronize];
                    
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
