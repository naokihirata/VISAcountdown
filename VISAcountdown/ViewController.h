//
//  ViewController.h
//  VISAcountdown
//
//  Created by hiratanaoki on 2014/11/10.
//  Copyright (c) 2014年 hiratanaoki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>{
    
    UILabel *_myLabelInput; //入力された文字を表示する
    UILabel *_countryLabel; //選択された国名を表示する
    UILabel *_purposeLabel; //選択された目的を表示する
    UILabel *_periodLabel; //選択された期間を表示する
    int _int;  //データを送る
    UIView *_uv;
    UIView *_backView;  //水色のビュー用メンバ変数
    BOOL _visibleFlag;  //水色のビューが表示されている:YES 非表示:NO
    
    UIButton *_CheckButton;    //金額チェックボタンを作成する
    UIButton *_CancelButton;    //キャンセルボタンを作成する
    UIButton *_dateButton;    //登録完了ボタンを作成する
    UIButton *_countryButton;   //国名を選ぶボタン
    UIButton *_purposeButton;   //目的を選ぶボタン
    UIButton *_periodButton;    //期間を選ぶボタン
    UIButton *_createButton;    //addSubView内の完了ボタン(PickerView)
    UIButton *_datecreateButton;//addSubView内の完了ボタン(DatePicker)
    UIButton *_setButton;       //設定を完了するボタン
    
    
    UIPickerView *_PickerView;  //選択項目を表示
    
    NSArray *_country;  //国名の連想配列
    NSArray *_period;   //期間の連想配列
    NSArray *_purpose;  //目的の連想配列
    
    NSArray *_PListArray;   //取り出したplistを入れた連想配列
    NSBundle *_bundle;  //プロジェクト内のファイルにアクセス出来るオブジェクトを宣言
    NSString *_path;    //読み込むプロパティリストのファイルパス（場所）(名前)を指定
    NSDictionary *_dic; //プロパティリストの中身のデータを取得
    
    UILabel *_checkLabel;   //料金を表示するラベル
    
    int _valcountry;
    int _valpurpose;
    int _valperiod;
    
    UIDatePicker *_datepicker;
    NSDate *_mindate;
    NSDateFormatter *_df;
    NSDate *_today;
    NSString *_datestr;
    int _dayCount;

}



@end

