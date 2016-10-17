//
//  SpeechRecognitionController.m
//  Demo
//
//  Created by Ari on 16/10/16.
//  Copyright © 2016年 com.Ari. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import "SpeechRecognitionController.h"
#import "VoiceRecordView.h"
#import <AVFoundation/AVFoundation.h>
#import <Speech/Speech.h>
#import "AudioTool.h"
@interface SpeechRecognitionController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *press2RecordBtn;
/**标记按钮是否被按下*/
@property (nonatomic,assign) BOOL isHighlight;
/**语音状态*/
@property (nonatomic,strong) VoiceRecordView *voiceRecordView;
/**展示语音的tableView*/
@property (weak, nonatomic) IBOutlet UITableView *VoiceTableView;
/**录音数据*/
@property (nonatomic,strong) NSMutableArray *voiceData;
/** 录音器*/
@property (nonatomic, strong) AVAudioRecorder *recorder;
/**录音文件放置位置*/
@property (nonatomic, strong) NSURL *url;
/**识别内容*/
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (nonatomic,assign) NSInteger recognizeType;
@end

@implementation SpeechRecognitionController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self settingRecorder];
    _voiceData = [NSMutableArray array];
    //配置录音器
    //初始化_isHighlight 为yes
    _isHighlight = YES;
    /**使用下面的代码监听按钮事件会造成崩溃*/
    /**================================分割线================================*/
//    /**按下松开的事件*/
//    __weak typeof(self) weakSelf = self;
//    [[self.press2RecordBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
//        NSLog(@"UIControlEventTouchUpInside");
//        weakSelf.voiceRecordView.hidden = true;
//        //松开后,记录这次录音 生成字典 存到数组中 刷新tableView的数据
//        [weakSelf.recorder stop];
//        NSDictionary *data = @{@"recordUrl":weakSelf.url.copy,@"name" : [NSString stringWithFormat:@"recorder%zd.wav",weakSelf.voiceData.count]};
//        [weakSelf.voiceData addObject:data];
//        [weakSelf.VoiceTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:weakSelf.voiceData.count - 1 inSection:0]] withRowAnimation:(UITableViewRowAnimationFade)];
//        //清空recorder
//        weakSelf.recorder = nil;
//    }];
//    /**按下的事件*/
//    [[self.press2RecordBtn rac_signalForControlEvents:(UIControlEventTouchDown)] subscribeNext:^(id x) {
//        NSLog(@"UIControlEventTouchDown");
//        __strong typeof(weakSelf) blockStrongSelf = weakSelf;
//        weakSelf.voiceRecordView.hidden = false;
//        //按下 就开始录音
//        [weakSelf createRecoder];
//        
//        [blockStrongSelf.recorder record];
//    }];
//    /**按下移开松开的事件*/
//    [[self.press2RecordBtn rac_signalForControlEvents:(UIControlEventTouchUpOutside)] subscribeNext:^(id x) {
//        NSLog(@"UIControlEventTouchUpOutside");
//        //确保按下后在外面松开   再次点击按钮时_isHighlight属性true
//        _isHighlight = true;
//        self.voiceRecordView.hidden = true;
//        //取消这次的录音
//        [self.recorder stop];
//        if ([self.recorder deleteRecording]) {
//            NSLog(@"取消了这次录音");
//        } else {
//            NSLog(@"取消失败了");
//        }
//    }];
//    /**按下移开事件*/
//    [[self.press2RecordBtn rac_signalForControlEvents:(UIControlEventTouchDragOutside)] subscribeNext:^(UIButton *x) {
//        if (!_isHighlight && x.state == UIControlStateNormal) {
//            return ;
//        }
//        NSLog(@"UIControlEventTouchDragOutside");
//        _isHighlight = false;
//        //更改录音view的状态
//        self.voiceRecordView.isBtnPress = false;
//    }];
//    /**从移开的位置回到btn上*/
//    [[self.press2RecordBtn rac_signalForControlEvents:(UIControlEventTouchDragInside)] subscribeNext:^(UIButton *x) {
//        if (_isHighlight && x.state == UIControlStateHighlighted) {
//            return ;
//        }
//        NSLog(@"UIControlEventTouchDragInside");
//        _isHighlight = true;
//        //更改录音view的状态
//        self.voiceRecordView.isBtnPress = true;
//    }];
//    /**valueChange*/
//    [[self.press2RecordBtn rac_signalForControlEvents:(UIControlEventValueChanged)] subscribeNext:^(id x) {
//        NSLog(@"UIControlEventValueChanged");
//    }];
    /**================================分割线================================*/
    [self.press2RecordBtn addTarget:self action:@selector(press2RecordBtnClickWithTouchUpInside) forControlEvents:(UIControlEventTouchUpInside)];
    [self.press2RecordBtn addTarget:self action:@selector(press2RecordBtnClickWithTouchDown) forControlEvents:(UIControlEventTouchDown)];
    [self.press2RecordBtn addTarget:self action:@selector(press2RecordBtnClickWithTouchUpOutside) forControlEvents:(UIControlEventTouchUpOutside)];
    [self.press2RecordBtn addTarget:self action:@selector(press2RecordBtnClickWithTouchDragInside:) forControlEvents:(UIControlEventTouchDragInside)];
    [self.press2RecordBtn addTarget:self action:@selector(press2RecordBtnClickWithTouchDragOutside:) forControlEvents:(UIControlEventTouchDragOutside)];
     [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryRecord error:nil];
}
#pragma mark - 按钮的各种点击事件
/**按下松开的事件*/
- (void)press2RecordBtnClickWithTouchUpInside{
    NSLog(@"UIControlEventTouchUpInside");
    self.voiceRecordView.hidden = true;
    //松开后,记录这次录音 生成字典 存到数组中 刷新tableView的数据
    [self.recorder stop];
    NSDictionary *data = @{@"recordUrl":self.url.copy,@"name" : [NSString stringWithFormat:@"recorder%zd.wav",self.voiceData.count]};
    [self.voiceData addObject:data];
    [self.VoiceTableView reloadData];
    [self.VoiceTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.voiceData.count - 1 inSection:0]] withRowAnimation:(UITableViewRowAnimationFade)];
    [self.VoiceTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.voiceData.count - 1 inSection:0] atScrollPosition:(UITableViewScrollPositionNone) animated:true];
    //清空recorder
    self.recorder = nil;
}
/**按下的事件*/
- (void)press2RecordBtnClickWithTouchDown {
    NSLog(@"UIControlEventTouchDown");
    self.voiceRecordView.hidden = false;
    //按下 就开始录音
    [self createRecoder];
    
    [self.recorder record];
}
 /**按下移开松开的事件*/
- (void)press2RecordBtnClickWithTouchUpOutside {
    NSLog(@"UIControlEventTouchUpOutside");
    //确保按下后在外面松开   再次点击按钮时_isHighlight属性true
    _isHighlight = true;
    self.voiceRecordView.hidden = true;
    //取消这次的录音
    [self.recorder stop];
    if ([self.recorder deleteRecording]) {
        NSLog(@"取消了这次录音");
    } else {
        NSLog(@"取消失败了");
    }
}
/**按下移开事件*/
- (void)press2RecordBtnClickWithTouchDragOutside:(UIButton *)x {
    if (!_isHighlight && x.state == UIControlStateNormal) {
        return ;
    }
    NSLog(@"UIControlEventTouchDragOutside");
    _isHighlight = false;
    //更改录音view的状态
    self.voiceRecordView.isBtnPress = false;
}
/**从移开的位置回到btn上*/
- (void)press2RecordBtnClickWithTouchDragInside:(UIButton *)x {
    if (_isHighlight && x.state == UIControlStateHighlighted) {
        return ;
    }
    NSLog(@"UIControlEventTouchDragInside");
    _isHighlight = true;
    //更改录音view的状态
    self.voiceRecordView.isBtnPress = true;
}
#pragma mark - 生成录音器
- (void)createRecoder{
    
    //创建录音器
    //URL: 存放录音的地址
    NSString *fileName = [NSString stringWithFormat:@"recorder%zd.wav",self.voiceData.count];
    NSString *urlStr = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:fileName];
    self.url = [NSURL fileURLWithPath:urlStr];
    self.recorder = [[AVAudioRecorder alloc] initWithURL:self.url settings:@{} error:nil];
}
#pragma mark - 配置录音器
- (void)settingRecorder{
    //1. 语音识别授权
    [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
        /**
         SFSpeechRecognizerAuthorizationStatusNotDetermined,  未决定
         SFSpeechRecognizerAuthorizationStatusDenied,         拒绝
         SFSpeechRecognizerAuthorizationStatusRestricted,     阻止了识别
         SFSpeechRecognizerAuthorizationStatusAuthorized,     已授权
         */
        if (status == SFSpeechRecognizerAuthorizationStatusAuthorized) {
            NSLog(@"授权成功");
        }
    }];
    
    
   
    
    //在播放音乐/录音等的时候, 如果在真机运行, 设置一个分类
    //建议写上.  不设置,真机测试会不好用
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryRecord error:nil];
}
#pragma mark - tableView数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.voiceData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellid = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid];
    }
    cell.textLabel.text = self.voiceData[indexPath.row][@"name"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self recognizerRequestWithUrl:self.voiceData[indexPath.row][@"recordUrl"]];
    self.contentLabel.text = @"识别中...";
    [AudioTool playWithName:self.voiceData[indexPath.row][@"name"] alert:NO];
    
}
#pragma mark - 语音识别
- (void)recognizerRequestWithUrl:(NSURL *)url {
    /**
     0. 导入Speech
     1. 实现语音识别授权
     2. 创建语音识别器
     3. 创建语音识别请求
     4. 开始执行识别请求
     */
    
    // 2. 创建语音识别器
    //2.1 设置识别语音为简体中文
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    //2.2 创建识别器
    SFSpeechRecognizer *recognizer = [[SFSpeechRecognizer alloc] initWithLocale:locale];
    
    //3. 创建语音识别请求 --> URL就是指的录音文件
    SFSpeechURLRecognitionRequest *request = [[SFSpeechURLRecognitionRequest alloc] initWithURL:url];
    
    //4. 开始执行识别请求
    [recognizer recognitionTaskWithRequest:request resultHandler:^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error) {
        //看需求. 如果不希望逐字翻译, 那么可能就不需要随时将结果进行界面程序. 需要当所有的翻译完成, 再显示
        //微信的语音识别是逐字翻译的.
        if (error) {
            self.contentLabel.text = error.description;
            return ;
        }
        if (self.recognizeType == 0) {
            self.contentLabel.text = result.bestTranscription.formattedString;
        }else {
            if (result.final) {
                NSLog(@"best: %@", result.bestTranscription.formattedString);
                self.contentLabel.text = result.bestTranscription.formattedString;
            }
        }
    }];
}

#pragma mark - 识别方式
- (IBAction)recognize4Worlds:(id)sender {
    self.recognizeType = 0;
}
- (IBAction)recognize4Sentence:(id)sender {
    self.recognizeType = 1;
}


#pragma mark - 懒加载控件
- (VoiceRecordView *)voiceRecordView {
    if (!_voiceRecordView) {
        _voiceRecordView = [[VoiceRecordView alloc] initWithFrame:CGRectMake(0, 0, 160, 160)];
        _voiceRecordView.center = self.view.center;
        [self.view addSubview:_voiceRecordView];
        _voiceRecordView.hidden = true;
    }
    return _voiceRecordView;
}


@end
