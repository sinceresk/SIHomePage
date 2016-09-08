//
//  SIStartViewController.m
//  SIHomePage
//
//  Created by sincere on 16/9/8.
//  Copyright © 2016年 cofortune. All rights reserved.
//

#import "SIStartViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

#define SCREEN_WIDTH CGRectGetWidth([UIScreen mainScreen].bounds)
#define SCREEN_HEIGHT CGRectGetHeight([UIScreen mainScreen].bounds)
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
int lastindex = 0;

@interface SIStartViewController ()<UIScrollViewDelegate>{

    AVPlayer        *avPlayer1;
    AVPlayer        *avPlayer2;
    AVPlayer        *avPlayer3;
    AVPlayerLayer   *avlayer1;
    AVPlayerLayer   *avlayer2;
    AVPlayerLayer   *avlayer3;
    UIPageControl   *_pagecontrol;

}
@property (nonatomic,strong) UIScrollView *scroll;

@end

@implementation SIStartViewController
@synthesize scroll = _scroll;

-(void)viewWillAppear:(BOOL)animated{

    self.navigationController.navigationBarHidden = YES;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _scroll = [[UIScrollView alloc]init];
    _scroll.backgroundColor = [UIColor whiteColor];
    _scroll.delegate = self;
    _scroll.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _scroll.backgroundColor = [UIColor clearColor];
    _scroll.showsHorizontalScrollIndicator = NO;
    _scroll.showsVerticalScrollIndicator = NO;
    _scroll.pagingEnabled = YES;
    _scroll.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    _scroll.contentSize = CGSizeMake((self.view.frame.size.width)*3, _scroll.frame.size.height);
    _scroll.bounces = NO;
    [self.view addSubview:_scroll];
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionMixWithOthers error:nil];
    NSURL *urlMovie1 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"1" ofType:@"m4v"]];
    AVURLAsset *asset1 = [AVURLAsset URLAssetWithURL:urlMovie1 options:nil];
    AVPlayerItem *playerItem1 = [AVPlayerItem playerItemWithAsset:asset1];
    avPlayer1 = [AVPlayer playerWithPlayerItem: playerItem1];
    avlayer1 = [AVPlayerLayer playerLayerWithPlayer:avPlayer1];
    avlayer1.frame = (CGRect){0, 0, self.view.frame.size.width, self.view.frame.size.height};
    avlayer1.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [_scroll.layer addSublayer:avlayer1];
    
    NSURL *urlMovie2 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"2" ofType:@"m4v"]];
    AVURLAsset *asset2 = [AVURLAsset URLAssetWithURL:urlMovie2 options:nil];
    AVPlayerItem *playerItem2 = [AVPlayerItem playerItemWithAsset:asset2];
    avPlayer2 = [AVPlayer playerWithPlayerItem: playerItem2];
    avlayer2 = [AVPlayerLayer playerLayerWithPlayer:avPlayer2];
    avlayer2.frame = (CGRect){self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height};
    //视频充满
    avlayer2.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [_scroll.layer addSublayer:avlayer2];
    
    NSURL *urlMovie3 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"3" ofType:@"m4v"]];
    AVURLAsset *asset3 = [AVURLAsset URLAssetWithURL:urlMovie3 options:nil];
    AVPlayerItem *playerItem3 = [AVPlayerItem playerItemWithAsset:asset3];
    avPlayer3  = [AVPlayer playerWithPlayerItem: playerItem3];
    avlayer3 = [AVPlayerLayer playerLayerWithPlayer:avPlayer3];
    avlayer3.frame = (CGRect){self.view.frame.size.width*2, 0, self.view.frame.size.width, self.view.frame.size.height};
    avlayer3.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [_scroll.layer addSublayer:avlayer3];
    
    [avPlayer1 play];
    
    _pagecontrol=[[UIPageControl alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-100, SCREEN_HEIGHT-100, 200, 30)];
    _pagecontrol.numberOfPages=3;
    [self.view addSubview:_pagecontrol];
    
    
    UIImageView * logoIV = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"keep"]];
    logoIV.frame = CGRectMake((SCREEN_WIDTH-180)/2,(SCREEN_HEIGHT-100)/2, 180, 50);
    [self.view addSubview:logoIV];
    
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    int Offset = _scroll.contentOffset.x/_scroll.frame.size.width;
    
    if (Offset == lastindex)
    {
        return;
    }
    if (Offset == 0)
    {
        [avPlayer1 seekToTime:kCMTimeZero];
        [avPlayer1 play];
        [avPlayer2 seekToTime:kCMTimeZero];
        [avPlayer2 pause];
        [avPlayer3 seekToTime:kCMTimeZero];
        [avPlayer3 pause];
        _pagecontrol.currentPage = 0;
    }
    else if (Offset == 1)
    {
        [avPlayer2 seekToTime:kCMTimeZero];
        [avPlayer2 play];
        [avPlayer1 seekToTime:kCMTimeZero];
        [avPlayer1 pause];
        [avPlayer3 seekToTime:kCMTimeZero];
        [avPlayer3 pause];
        _pagecontrol.currentPage = 1;
    }
    else if (Offset == 2)
    {
        [avPlayer3 seekToTime:kCMTimeZero];
        [avPlayer3 play];
        [avPlayer1 seekToTime:kCMTimeZero];
        [avPlayer1 pause];
        [avPlayer2 seekToTime:kCMTimeZero];
        [avPlayer2 pause];
        _pagecontrol.currentPage = 2;
    }
    lastindex = Offset;
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
