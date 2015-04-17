本项目功能是提供类似于新浪微博配图浏览。
点击打开大图；
下载浏览原图；
拖拉放大缩小图片；
保存到手机相册等。
点击ImageView打开中图，传入一个URL数组可滑动浏览多个图片；
也可只为单个ImageView设置点击打开。
只需要几个语句即可为Imageview设置浏览功能。
为单个ImageView设置浏览功能：
	在使用的位置头文件导入”SingleWebImageView.h”
	NSString *bmiddle = 
	@"http://ww2.sinaimg.cn/bmiddle/9263d293gw1er6npclu06j20c80s2go6.jpg";
	NSString *original = 
	@"http://ww3.sinaimg.cn/original/9263d293gw1er6npg33q2j20c80lbgo6.jpg";
	//新建SingleWebImageView类型的ImageView
	//新建时传入中图与大图的图片Url
	_singleImageView = [[SingleWebImageView alloc]
			initWithStyleAndBmiddlePicUrl:bmiddle 
				    andOriginalPicUrl:original];
	//设置frame并添加到view上
	_singleImageView.frame = CGRectMake(self.view.center.x-80, 420, 160, 160);
	[self.view addSubview:_singleImageView];


为多个ImageView设置浏览功能：
	在使用的位置头文件导入”WebImageView.h”
	//新建WebImageView类型的ImageView。根据ImageView的顺序设置tag值
	_imageView0 = [[WebImageView alloc]initWithStyleAndTag:0];
	//为ImageView设置中图地址数组与原图地址数组
	_imageView0.original_pic_urls = original_pic_urls;
        _imageView0.bmiddle_pic_urls = bmiddle_pic_urls;
	//设置frame并添加到view上
	_imageView0.hidden = NO;
        _imageView0.frame = CGRectMake(0, 40, btnWidth, btnWidth);    	
	[self.view addSubview:_imageView0];