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
    //タイトル文章を入力
    [self textLabel];
    //国名を表示する
    [self countryLabel];
    //期間を表示する
    [self periodLabel];
    //目的を表示する
    [self purposeLabel];
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
    _country = @[@"アメリカ",@"フィリピン",@"オーストラリア",@"カナダ",@"ニュージーランド"];
    _period = @[@"1ヶ月",@"2ヶ月",@"3ヶ月",@"4ヶ月",@"5ヶ月",@"6ヶ月",@"7ヶ月",@"8ヶ月",@"9ヶ月",@"10ヶ月",@"11ヶ月",@"12ヶ月"];
    _purpose = @[@"留学",@"就労",@"観光"];
    
    

}
-(void)textLabel{
    _myLabelInput = [[UILabel alloc] initWithFrame:CGRectMake(20 ,80 ,200, 50)];
    
    _myLabelInput.text = @"情報を入力";
    [self.view addSubview:_myLabelInput];
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
    _countryButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 130, 130, 20)];
    
    [_countryButton setTitle:@"国名を選択" forState:UIControlStateNormal];
    
    [_countryButton setTitleColor:[UIColor colorWithRed:0.192157 green:0.760784 blue:0.952941 alpha:1.0] forState:UIControlStateNormal];
    
    [_countryButton addTarget:self action:@selector(TapCountryBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:_countryButton];
}
-(void)periodButton{
    _periodButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 190, 130, 20)];
    
    [_periodButton setTitle:@"期間を選択" forState:UIControlStateNormal];
    
    [_periodButton setTitleColor:[UIColor colorWithRed:0.192157 green:0.760784 blue:0.952941 alpha:1.0] forState:UIControlStateNormal];
    
    [_periodButton addTarget:self action:@selector(TapPeriodBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_periodButton];
}

-(void)purposeButton{
    _purposeButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 250, 130, 20)];
    
    [_purposeButton setTitle:@"目的を選択" forState:UIControlStateNormal];
    
    [_purposeButton setTitleColor:[UIColor colorWithRed:0.192157 green:0.760784 blue:0.952941 alpha:1.0] forState:UIControlStateNormal];
    
    [_purposeButton addTarget:self action:@selector(TapPurposeBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_purposeButton];
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
    //NSString *_country = [NSString stringWithFormat:@"%d行目",row];
    //return _country[row];
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
    _createButton = [[UIButton alloc] initWithFrame:CGRectMake(200, 300, 130, 20)];
    
    [_createButton setTitle:@"完了" forState:UIControlStateNormal];
    
    [_createButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_createButton addTarget:self action:@selector(TapCreateBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_backView addSubview:_createButton];
}
-(void)TapCreateBtn:(UIButton *)createButton{

    for (_uv in [self.view subviews]) {
        [_PickerView removeFromSuperview];
//        [_createButton removeFromSuperview];
    }
    [self downObject];
    switch(_int){
        case 0:
            [self countryLabel];
            break;
        case 1:
            [self periodLabel];
            break;
        case 2:
            [self purposeLabel];
            break;
        default:
            break;
    }

}
-(void)checkButton{
    _CheckButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 340, 130, 20)];
    
    [_CheckButton setTitle:@"料金チェック" forState:UIControlStateNormal];
    
    [_CheckButton setTitleColor:[UIColor colorWithRed:0.192157 green:0.760784 blue:0.952941 alpha:1.0] forState:UIControlStateNormal];
    
    [_CheckButton addTarget:self action:@selector(TapCheckBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_CheckButton];
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
-(void)dateButton{
    _dateButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 460, 130, 20)];
    
    [_dateButton setTitle:@"出発日を登録" forState:UIControlStateNormal];
    
    [_dateButton setTitleColor:[UIColor colorWithRed:0.192157 green:0.760784 blue:0.952941 alpha:1.0] forState:UIControlStateNormal];
    
    [_dateButton addTarget:self action:@selector(TapFinishBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_dateButton];
}
-(void)TapFinishBtn:(UIButton *)dateButton{
    NSLog(@"date");
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView commitAnimations];
}
-(void)setButton{
    _setButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 500, 130, 20)];
    
    [_setButton setTitle:@"設定完了" forState:UIControlStateNormal];
    
    [_setButton setTitleColor:[UIColor colorWithRed:0.192157 green:0.760784 blue:0.952941 alpha:1.0] forState:UIControlStateNormal];
    
    [_setButton addTarget:self action:@selector(TapSetBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_setButton];
}
-(void)TapSetBtn:(UIButton *)setButton{
    NSLog(@"完了");
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView commitAnimations];
    
    //controller　＠の中はIdentifierで定義した名前
    DetailViewController  *sub = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    
    //NavigationControllerを使って遷移する
    [self.navigationController pushViewController:sub animated:YES];
}
@end
