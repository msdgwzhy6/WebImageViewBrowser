//
//  ViewController.m
//  WebImageBrowserDemo
//
//  Created by Caesar on 15/4/16.
//  Copyright (c) 2015年 Caesar. All rights reserved.
//

#import "ViewController.h"
#import "WebImageView.h"
#import "SingleWebImageView.h"

@interface ViewController ()
{
    //配图集合
    WebImageView *_imageView0;
    WebImageView *_imageView1;
    WebImageView *_imageView2;
    WebImageView *_imageView3;
    WebImageView *_imageView4;
    WebImageView *_imageView5;
    WebImageView *_imageView6;
    WebImageView *_imageView7;
    WebImageView *_imageView8;
    //
    NSMutableArray *_bmiddle_pic_urls;
    NSMutableArray *_original_pic_urls;
    
    //单个图片
    SingleWebImageView *_singleImageView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor clearColor];
    [self initImageViews];
    NSMutableArray *thumbnail_pic_urls = [NSMutableArray arrayWithObjects:
                                         @"http://ww2.sinaimg.cn/thumbnail/9263d293gw1er6npclu06j20c80s2go6.jpg",
                                         @"http://ww3.sinaimg.cn/thumbnail/9263d293gw1er6npg33q2j20c80lbgo6.jpg",
                                         @"http://ww2.sinaimg.cn/thumbnail/9263d293gw1er6nplgahgj20c80sadix.jpg",
                                         @"http://ww3.sinaimg.cn/thumbnail/9263d293gw1er6npqq0ojj20c80sadix.jpg",
                                         @"http://ww4.sinaimg.cn/thumbnail/9263d293gw1er6npy8nxsj20c80nhdio.jpg",
                                         @"http://ww3.sinaimg.cn/thumbnail/9263d293gw1er6nq402nwj20c80sfju2.jpg",
                                         @"http://ww2.sinaimg.cn/thumbnail/9263d293gw1er6nqcned3j20c80nb0v2.jpg",
                                         @"http://ww2.sinaimg.cn/thumbnail/9263d293gw1er6nqfv9mij20c80sj77x.jpg",
                                         @"http://ww4.sinaimg.cn/thumbnail/9263d293gw1er6nqi8swoj20c80kcac7.jpg", nil];
    _bmiddle_pic_urls = [[NSMutableArray alloc]init];
    _original_pic_urls = [[NSMutableArray alloc]init];
    for (int i = 0; i < thumbnail_pic_urls.count; i++) {
        NSString *url = [thumbnail_pic_urls[i] stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        [_bmiddle_pic_urls addObject:url];
        url = [thumbnail_pic_urls[i] stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"large"];
        [_original_pic_urls addObject:url];
    }
    [self setImageViewsBmiddlePicUrls:_bmiddle_pic_urls andOriginalPicUrls:_original_pic_urls];
    
}

- (void)initImageViews {
    _imageView0 = [[WebImageView alloc]initWithStyleAndTag:0];
    _imageView0.tag = 0;
    [self.view addSubview:_imageView0];
    _imageView1 = [[WebImageView alloc]initWithStyleAndTag:1];
    _imageView1.tag = 1;
    [self.view addSubview:_imageView1];
    _imageView2 = [[WebImageView alloc]initWithStyleAndTag:2];
    _imageView2.tag = 2;
    [self.view addSubview:_imageView2];
    _imageView3 = [[WebImageView alloc]initWithStyleAndTag:3];
    _imageView3.tag = 3;
    [self.view addSubview:_imageView3];
    _imageView4 = [[WebImageView alloc]initWithStyleAndTag:4];
    _imageView4.tag = 4;
    [self.view addSubview:_imageView4];
    _imageView5 = [[WebImageView alloc]initWithStyleAndTag:5];
    _imageView5.tag = 5;
    [self.view addSubview:_imageView5];
    _imageView6 = [[WebImageView alloc]initWithStyleAndTag:6];
    _imageView6.tag = 6;
    [self.view addSubview:_imageView6];
    _imageView7 =[[WebImageView alloc]initWithStyleAndTag:7];
    _imageView7.tag = 7;
    [self.view addSubview:_imageView7];
    _imageView8 = [[WebImageView alloc]initWithStyleAndTag:8];
    _imageView8.tag = 8;
    [self.view addSubview:_imageView8];
    ///
    
    NSString *bmiddle = @"http://ww2.sinaimg.cn/bmiddle/9263d293gw1er6npclu06j20c80s2go6.jpg";

    NSString *original = @"http://ww3.sinaimg.cn/original/9263d293gw1er6npg33q2j20c80lbgo6.jpg";
    _singleImageView = [[SingleWebImageView alloc]initWithStyleAndBmiddlePicUrl:bmiddle andOriginalPicUrl:original];
    _singleImageView.frame = CGRectMake(self.view.center.x-80, 420, 160, 160);
    [self.view addSubview:_singleImageView];
    
}


- (void)setImageViewsBmiddlePicUrls:(NSMutableArray *)bmiddle_pic_urls andOriginalPicUrls: (NSMutableArray *)original_pic_urls{
    CGRect screen = [[UIScreen mainScreen]bounds];
    CGSize screenSize = screen.size;
    CGFloat btnWidth = (screenSize.width-30)/3;
    for (int i = 0; i < bmiddle_pic_urls.count; i++) {
        switch (i) {
            case 0:
                _imageView0.hidden = NO;
                _imageView0.frame = CGRectMake(0, 40, btnWidth, btnWidth);
                _imageView0.original_pic_urls = original_pic_urls;
                _imageView0.bmiddle_pic_urls = bmiddle_pic_urls;
                break;
            case 1:
                _imageView1.hidden = NO;
                _imageView1.frame = CGRectMake(btnWidth+10, 40, btnWidth, btnWidth);
                _imageView1.original_pic_urls = original_pic_urls;
                _imageView1.bmiddle_pic_urls = bmiddle_pic_urls;
                break;
            case 2:
                _imageView2.hidden = NO;
                _imageView2.frame = CGRectMake(btnWidth*2+20, 40, btnWidth, btnWidth);
                _imageView2.original_pic_urls = original_pic_urls;
                _imageView2.bmiddle_pic_urls = bmiddle_pic_urls;
                break;
            case 3:
                _imageView3.hidden = NO;
                _imageView3.frame = CGRectMake(0, 50+btnWidth, btnWidth, btnWidth);
                _imageView3.original_pic_urls = original_pic_urls;
                _imageView3.bmiddle_pic_urls = bmiddle_pic_urls;
                break;
            case 4:
                _imageView4.hidden = NO;
                _imageView4.frame = CGRectMake(btnWidth+10, 50+btnWidth, btnWidth, btnWidth);
                _imageView4.original_pic_urls = original_pic_urls;
                _imageView4.bmiddle_pic_urls = bmiddle_pic_urls;
                break;
            case 5:
                _imageView5.hidden = NO;
                _imageView5.frame = CGRectMake((btnWidth+10)*2, 50+btnWidth, btnWidth, btnWidth);
                _imageView5.original_pic_urls = original_pic_urls;
                _imageView5.bmiddle_pic_urls = bmiddle_pic_urls;
                break;
            case 6:
                _imageView6.hidden = NO;
                _imageView6.frame = CGRectMake(0, 60+btnWidth*2, btnWidth, btnWidth);
                _imageView6.original_pic_urls = original_pic_urls;
                _imageView6.bmiddle_pic_urls = bmiddle_pic_urls;
                break;
            case 7:
                _imageView7.hidden = NO;
                _imageView7.frame = CGRectMake(btnWidth+10, 60+btnWidth*2, btnWidth, btnWidth);
                _imageView7.original_pic_urls = original_pic_urls;
                _imageView7.bmiddle_pic_urls = bmiddle_pic_urls;
                break;
            case 8:
                _imageView8.hidden = NO;
                _imageView8.frame = CGRectMake((btnWidth+10)*2, 60+btnWidth*2, btnWidth, btnWidth);
                _imageView8.original_pic_urls = original_pic_urls;
                _imageView8.bmiddle_pic_urls = bmiddle_pic_urls;
                break;
            default:
                break;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
