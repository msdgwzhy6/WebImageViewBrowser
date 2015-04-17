//
//  SingleWebImageBrowser.m
//  WebImageBrowserDemo
//
//  Created by Caesar on 15/4/16.
//  Copyright (c) 2015年 Caesar. All rights reserved.
//

#import "SingleWebImageBrowser.h"
#import "UIImageView+WebCache.h"

#define IPHONE_SCREEN_WIDTH [[UIScreen mainScreen]bounds].size.width
#define IPHONE_SCREEN_HEIGHT [[UIScreen mainScreen]bounds].size.height
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

@interface SingleWebImageBrowser()<UIScrollViewDelegate>
{
    UIWindow *window;
    UIImageView *imageView;
    UIScrollView *scrollView;
    NSString *_bmiddle_pic_url;
    NSString *_original_pic_url;
    //
    UIButton *downloadBtn;
    UIButton *saveBtn;
    //
    UIActivityIndicatorView *waiting;
}
@end

@implementation SingleWebImageBrowser:NSObject
static CGRect oldImageViewFrame;
+(SingleWebImageBrowser *)sharedSingleWebImageBrowser{
    static SingleWebImageBrowser *webImageBrowser;
    @synchronized(self){
        if (!webImageBrowser) {
            webImageBrowser = [[self alloc]init];
        }
    }
    return webImageBrowser;
}

-(void)showBmiddlePic:(SingleWebImageView *)webImageView{
    _bmiddle_pic_url = webImageView.bmiddle_pic_url;
    _original_pic_url = webImageView.original_pic_url;
    //初始化控件
    [self initComponent:webImageView];
    
    
    [imageView addSubview:waiting];
    [waiting startAnimating];
    
    //使用SDWebImage异步下载并缓存图片
    [imageView sd_setImageWithURL:[NSURL URLWithString:_bmiddle_pic_url]
                 placeholderImage:nil
                          options:SDWebImageProgressiveDownload
                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
                            //图片下载成功
                            if (image) {
                                [waiting stopAnimating];
                                imageView.image = image;
                                CGSize imageSize = image.size;
                                float b = imageSize.width/(IPHONE_SCREEN_WIDTH);
                                
                                //依据下载图片尺寸调整显示
                                //如果按比例缩小图片后图片长仍然比屏幕长，则按照长度设置scrollview的垂直方向上的可拖动范围
                                if (imageSize.height/b >= IPHONE_SCREEN_HEIGHT) {
                                    imageView.frame = CGRectMake(0, 20, IPHONE_SCREEN_WIDTH, imageSize.height/b);
                                    scrollView.contentSize = CGSizeMake(imageView.frame.size.width, imageView.frame.size.height + 40);
                                }
                                else{
                                    imageView.frame = CGRectMake(0, (IPHONE_SCREEN_HEIGHT - imageSize.height/b)/2, IPHONE_SCREEN_WIDTH, imageSize.height/b);
                                }
                            }
                            else{
                                [waiting stopAnimating];
                            }
                            
                        }];
    
    
    
    UITapGestureRecognizer *tap_closeScrollView = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeBmiddlePic:)];
    [scrollView addGestureRecognizer:tap_closeScrollView];
    //放大图片浏览器
    [UIScrollView animateWithDuration:0.3 animations:^{
        scrollView.alpha = 1;
    }completion:^(BOOL finished){
        
    }];
}

- (void)initComponent:(UIImageView *)webImageView{
    window = [UIApplication sharedApplication].keyWindow;
    
    downloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    downloadBtn.frame = CGRectMake(10, IPHONE_SCREEN_HEIGHT-40, 50, 25);
    [downloadBtn setTitle:@"Original" forState:UIControlStateNormal];
    [downloadBtn setFont:[UIFont systemFontOfSize:12]];
    downloadBtn.layer.cornerRadius = 5.0;
    downloadBtn.layer.masksToBounds = YES;
    downloadBtn.backgroundColor = RGBACOLOR(20, 200, 40, 0.5);
    [downloadBtn addTarget:self action:@selector(downloadOriginalPic) forControlEvents:UIControlEventTouchUpInside];
    
    saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.frame = CGRectMake(70, IPHONE_SCREEN_HEIGHT-40, 50, 25);
    [saveBtn setTitle:@"Save" forState:UIControlStateNormal];
    [saveBtn setFont:[UIFont systemFontOfSize:12]];
    saveBtn.layer.cornerRadius = 5.0;
    saveBtn.layer.masksToBounds = YES;
    saveBtn.backgroundColor = RGBACOLOR(20, 200, 40, 0.5);
    [saveBtn addTarget:self action:@selector(saveImage) forControlEvents:UIControlEventTouchUpInside];
    
    
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_SCREEN_WIDTH, IPHONE_SCREEN_HEIGHT)];
    
    oldImageViewFrame = [webImageView convertRect:webImageView.bounds toView:window];
    scrollView.backgroundColor = RGBACOLOR(150, 150, 150, 0.6);
    scrollView.scrollEnabled = YES;
    scrollView.showsVerticalScrollIndicator = YES;
    scrollView.delegate = self;
    scrollView.maximumZoomScale = 3.0;
    scrollView.minimumZoomScale = 0.5;
    
    imageView = [[UIImageView alloc]init];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.layer.cornerRadius = 5.0;
    imageView.layer.masksToBounds = YES;
    
    //设置tag值因为点击时需要按照tag获取点击的控件
    imageView.tag = 901;
    [scrollView addSubview:imageView];
    
    [window addSubview:scrollView];
    [window addSubview:downloadBtn];
    [window addSubview:saveBtn];
    
    waiting = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    waiting.center = CGPointMake(window.center.x, window.center.y);
    [window addSubview:waiting];
}

//下载大图
- (void)downloadOriginalPic{
    [waiting startAnimating];
    [imageView sd_setImageWithURL:[NSURL URLWithString:_original_pic_url] placeholderImage:nil options:SDWebImageProgressiveDownload completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
        if (image) {
            [waiting stopAnimating];
            imageView.image = image;
            CGSize imageSize = image.size;
            float b = imageSize.width/(IPHONE_SCREEN_WIDTH);
            if (imageSize.height/b >= IPHONE_SCREEN_HEIGHT) {
                imageView.frame = CGRectMake(0, 20, IPHONE_SCREEN_WIDTH, imageSize.height/b);
                scrollView.contentSize = CGSizeMake(imageView.frame.size.width, imageView.frame.size.height + 40);
            }
            else{
                imageView.frame = CGRectMake(0, (IPHONE_SCREEN_HEIGHT - imageSize.height/b)/2, IPHONE_SCREEN_WIDTH, imageSize.height/b);
            }
        }
    }];
    
}

//保存图片到相册
- (void)saveImage{
    UIImageWriteToSavedPhotosAlbum([imageView image], nil, nil, nil);
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Reminder" message:@"图片已保存" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

-(void)closeBmiddlePic:(UITapGestureRecognizer *)tap{
    UIScrollView *backgroundView = tap.view;
    UIImageView *aimageView = (UIImageView *)[tap.view viewWithTag:901];
    [UIScrollView animateWithDuration:0.3 animations:^{
        aimageView.frame = oldImageViewFrame;
        backgroundView.alpha = 0;
        downloadBtn.alpha = 0;
        saveBtn.alpha = 0;
    }completion:^(BOOL finished){
        [backgroundView removeFromSuperview];
        [downloadBtn removeFromSuperview];
        [saveBtn removeFromSuperview];
    }];
}
//双指扩张放大图片
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)aScrollView{
    if (aScrollView == scrollView) {
        return imageView;
    }
    return nil;
}
//放大缩小调整图片位置使其不发生偏移
- (void)scrollViewDidZoom:(UIScrollView *)ascrollView{
    if (ascrollView == scrollView) {
        CGFloat offsetX = (ascrollView.bounds.size.width > ascrollView.contentSize.width)?
        (ascrollView.bounds.size.width - ascrollView.contentSize.width) * 0.5 : 0.0;
        CGFloat offsetY = (ascrollView.bounds.size.height > ascrollView.contentSize.height)?
        (ascrollView.bounds.size.height - ascrollView.contentSize.height) * 0.5 : 0.0;
        imageView.center = CGPointMake(ascrollView.contentSize.width * 0.5 + offsetX,
                                       ascrollView.contentSize.height * 0.5 + offsetY);
    }
    
}
@end
