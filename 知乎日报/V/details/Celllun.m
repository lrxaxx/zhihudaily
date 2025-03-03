//
//  Celllun.m
//  知乎日报
//
//  Created by 李睿鑫 on 2024/10/31.
//

#import "Celllun.h"

@implementation Celllun

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if([self.reuseIdentifier isEqualToString:@"celllun"]) {
        _scroll = [[UIScrollView alloc] init];
        _page = [[UIPageControl alloc] init];
        
        [self.contentView addSubview:_scroll];
//        [self.contentView addSubview:_page];
        _scroll.tag = 101;
        [_scroll mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
        
        _scroll.contentSize = CGSizeMake(393 * 7, 450);
        self.scroll.pagingEnabled = YES;
        self.scroll.scrollEnabled = YES;
        self.scroll.delegate = self;
        [self beginTime];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        [self.scroll setContentOffset:CGPointMake(0, 0) animated:NO];
        // 实现滚动到最后一张视图时，再次滚动能回到第一张视图
        self.page = [[UIPageControl alloc] init];
        self.page.numberOfPages = 5;
        self.page.currentPage = 0;
        self.page.currentPageIndicatorTintColor = [UIColor whiteColor];
        self.page.pageIndicatorTintColor = [UIColor lightGrayColor];
        [self.page addTarget:self action:@selector(pageChange:) forControlEvents:UIControlEventValueChanged];
        self.page.backgroundStyle = UIPageControlBackgroundStyleMinimal;
        self.page.translatesAutoresizingMaskIntoConstraints = NO;
        self.scroll.showsHorizontalScrollIndicator = YES;
        [self.scroll setContentOffset:CGPointMake(([UIScreen mainScreen].bounds.size.width ), 0) animated:NO];
        
    }
    return self;
}

-(void) beginTime
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(press:) userInfo:nil repeats:YES];
}

-(void) stopTime
{
    [self.timer invalidate];
//    self.timer = nil;
}


-(void) pageChange:(UIPageControl*) sender
{
    CGFloat pagewidth = [UIScreen mainScreen].bounds.size.width;
    [self.scroll setContentOffset:CGPointMake(pagewidth * (sender.currentPage + 1), 0) animated:NO];
}

-(void) press: (Celllun*) cell
{
    NSInteger pageX = self.scroll.contentOffset.x / ([UIScreen mainScreen].bounds.size.width);
    self.page.currentPage = pageX - 1;
    if (pageX == 5) {
        [self.scroll setContentOffset:CGPointMake(0, 0) animated:NO];
        [self.scroll setContentOffset:CGPointMake(([UIScreen mainScreen].bounds.size.width ), 0) animated:YES];
        
        pageX = 1;
    } else {
        [self.scroll setContentOffset:CGPointMake(([UIScreen mainScreen].bounds.size.width) * (pageX + 1), 0) animated:YES];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat contentOffsetX = self.scroll.contentOffset.x;
    CGFloat screenWidth = CGRectGetWidth(self.scroll.frame);
    CGFloat contentWidth = self.scroll.contentSize.width;
    NSInteger pageX = self.scroll.contentOffset.x / ([UIScreen mainScreen].bounds.size.width);
    if(pageX == 0)
    {
        self.page.currentPage = 4;
    }else{
        self.page.currentPage = pageX - 1;
    }
    // 滚动到最后一张视图之后，将滚动位置重置到第二张图片
    if (contentOffsetX >= contentWidth - screenWidth) {
        [self.scroll setContentOffset:CGPointMake(screenWidth, 0) animated:NO];
    }
    // 滚动到第一张视图之前，将滚动位置重置到倒数第二张图片
    else if (contentOffsetX < screenWidth - self.scroll.frame.size.width) {
        [self.scroll setContentOffset:CGPointMake(contentWidth - 2 * screenWidth, 0) animated:NO];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTime];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self beginTime];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

@end

