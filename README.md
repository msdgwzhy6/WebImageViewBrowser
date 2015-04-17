# WebImageBrowser
- SingleWebImageBrowser.h
- SingleWebImageBrowser.m
- SingleWebImageView.h
- SingleWebImageView.m
- WebImageBrowser.h
- WebImageBrowser.m
- WebImageView.h
- WebImageView.m

##Using
类似微博配图浏览功能：

1. 点击全屏浏览大图
2. 再次点击缩小回原位置
3. 双指拖拉图片放大缩小
4. 滑动浏览多个配图或上下滑动浏览
5. 下载查看原图
6. 保存到手机相册等



###Using Instruction

	为单个ImageView设置浏览功能：
	在使用的位置头文件导入”SingleWebImageView.h”
		NSString *bmiddle = @"http://u06j20c80s2go6.jpg";"
		NSString *original = @"http://6nj20c80lbgo6.jpg"
	
		//新建SingleWebImageView类型的ImageView
		//新建时传入中图与大图的图片Url
		_singleImageView = [[SingleWebImageView alloc]
					initWithStyleAndBmiddlePicUrl:bmiddle 
				 	  			andOriginalPicUrl:original];
		//设置frame并添加到view上
		_singleImageView.frame = 
			CGRectMake(self.view.center.x-80, 420, 160, 160);
		[self.view addSubview:_singleImageView];"
		
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
######Remind
	UIImageView实现图片下载并缓存到本地是由SDWebImage库实现。请先下载SDWebImage并导入到项目。该库功能强大具体可在github上直接搜索。本Demo也有附带SDWebImage库。