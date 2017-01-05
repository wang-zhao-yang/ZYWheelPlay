# UIScrollView + 多张 ImageView 实现轮播

实现原理：

将所有图片的名字储存在数组 imageAry 中，imageAry 的元素个数为 num，在 scrollView 上添加 num + 1 个 UIImageView，第一个 imageView 上放最后一张图片，第二个 imageView 上放第一张图片，依次类推，最后一个 imageView 上的图片和第一个 imageView 的图片相同，用来过渡。在初始状态将 scrollView 的 contentOffset 的 x 值设为一个屏幕的宽度。 

代码如下：

```
for (NSInteger i = 0; i < count + 1; i++) {
	UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * DEVICE_WIDTH, 0, DEVICE_WIDTH, 500)];
	NSString *imageName = self.imageAry[count-1];
	if (i != 0) {
		imageName = self.imageAry[i-1];
	}
	imageView.image = [UIImage imageNamed:imageName];
	[self.scrollView addSubview:imageView];
}
```

1. 手动轮播

	当手动滚动到倒数第二张图片，继续向右滚动时，设置 scrollView 的 contentOffset 的 x 值为 0，并不做动画，实现自然过渡到第一个 imageView，显示最后一张图片。
	
	当手动滚动到第一个 imageView，继续向左滚动时，设置 scrollView 的 contentOffset 的 x 值为图片的总个数乘以屏幕的宽度，并不做动画，实现自然过渡到最后一个 imageView，显示的也是最后一张图片。
	
	代码如下：
	
	```
	- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
		CGFloat offsetX = scrollView.contentOffset.x;
    	NSInteger count = self.imageAry.count;
    	if (offsetX < 0) {
    		[scrollView setContentOffset:CGPointMake(count * DEVICE_WIDTH, 0) animated:NO];
    	} else if (offsetX > count * DEVICE_WIDTH) {
    		[scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    	}
	}
	```

2. 自动轮播

	当自动滚动到倒数第二张图片，继续向右滚动时，设置 scrollView 的 contentOffset 的 x 值为 0，并不做动画，紧接着设置 scrollView 的 contentOffset 的 x 值为屏幕的宽度，并做动画，实现从最后一个 imageView 到第一个 imageView 的自然过渡。 

	代码如下：
	
	```
	- (void)autoPlay {
		[super autoPlay];
		CGFloat offsetX = self.scrollView.contentOffset.x;
		NSInteger count = self.imageAry.count;
		CGFloat imageViewX = DEVICE_WIDTH;
		if (offsetX > (count - 1) * DEVICE_WIDTH) {
			[self.scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
		} else {
			imageViewX += offsetX;
		}
		[self.scrollView setContentOffset:CGPointMake(imageViewX, 0) animated:YES];
	}
	```
	
# UIScrollView + 3 张 ImageView 实现轮播
	
实现原理：

将所有图片的名字储存在数组 imageAry 中，imageAry 的元素个数为 num，在 scrollView 上添加 3 个 UIImageView，第一个 imageView 上放最后一张图片，第二个 imageView 上放第一张图片，第三个 imageView 上放第二张图片。在初始状态将 scrollView 的 contentOffset 的 x 值设为一个屏幕的宽度，即显示的是中间的 imageView。

代码如下：

```
for (NSInteger i = 0; i < 3; i++) {
	UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * DEVICE_WIDTH, 0, DEVICE_WIDTH, 500)];
	NSString *imageName = self.imageAry[count-1];
	if (i != 0) {
		imageName = self.imageAry[i-1];
	}
	imageView.image = [UIImage imageNamed:imageName];
	[self.scrollView addSubview:imageView];
}
```

1. 手动轮播

	当 scrollView 的 contentOffset 的 x 值为 0 时，减小 pageControl 的 currentPage（如果 currentPage 为 0，则设置 currentPage 为最大）。
	
	当 scrollView 的 contentOffset 的 x 值为 2 倍的屏幕宽度时，变大 pageControl 的 currentPage（如果 currentPage 为最大，则设置 currentPage 为 0）。
	
	然后根据 currentPage 从数组中取出图片给 imageView 赋值。
	
	最后将 scrollView 的 contentOffset 的 x 值恢复到一个屏幕的宽度，且不做动画，即始终显示中间的 imageView。

	代码如下：
	
	```
	- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
		CGFloat offsetX = scrollView.contentOffset.x;
		if (offsetX == 0) {
			[self currentPageDown];
			[self resetImagesAndContentOffset];
		} else if (offsetX == 2 * DEVICE_WIDTH) {
			[self currentPageUp];
			[self resetImagesAndContentOffset];
		}
	}
    	
	- (void)currentPageDown {
		NSInteger count = self.imageAry.count;
		NSInteger currentIndex = (self.pageControl.currentPage - 1 + count) % count;
		self.pageControl.currentPage = currentIndex;
	}

	- (void)currentPageUp {
		NSInteger currentIndex = (self.pageControl.currentPage + 1) % 	self.imageAry.count;
		self.pageControl.currentPage = currentIndex;
	}

	- (void)resetImagesAndContentOffset {
		NSInteger currentPage = self.pageControl.currentPage;
		NSInteger count = self.imageAry.count;
		for (NSInteger i = 0; i < 3; i++) {
			UIImageView *imageView = self.scrollView.subviews[i];
			NSInteger imageIndex = 0;
			switch (i) {
				case 0:
					imageIndex = currentPage - 1;
					if (imageIndex < 0) {
						imageIndex = count - 1;
					}
					break;
				case 1:
					imageIndex = currentPage;
					break;
				case 2:
					imageIndex = currentPage + 1;
					if (imageIndex > count - 1) {
						imageIndex = 0;
					}
					break;
			}
			imageView.image = [UIImage imageNamed:self.imageAry[imageIndex]];
		}
		[self.scrollView setContentOffset:CGPointMake(DEVICE_WIDTH, 0) animated:NO];
	}
	```

2. 自动轮播

	设置 scrollView 的 contentOffset 的 x 值为 2 倍的屏幕宽即可。

	代码如下：
	
	```
	- (void)autoPlay {
		[super autoPlay];
		[self.scrollView setContentOffset:CGPointMake(2 * DEVICE_WIDTH, 0) animated:YES];
	}
	```
	


