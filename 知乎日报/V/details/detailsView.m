//
//  detailsView.m
//  知乎日报
//
//  Created by 李睿鑫 on 2024/10/31.
//

#import "detailsView.h"

@implementation detailsView

-(void) InitScrollView {
    _scroll = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:_scroll];
    
//    [_scroll mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(0);// 左侧与父视图左边缘相等
//        make.right.mas_equalTo(0);  // 右侧与父视图右边缘相等
//        make.top.mas_equalTo(0);// 顶部距离父视图顶部50点
//        make.bottom.mas_equalTo(0);
//    }];
    
    _scroll.pagingEnabled = YES;
    _scroll.scrollEnabled = YES;
    _scroll.showsVerticalScrollIndicator = NO;
    _scroll.backgroundColor = [UIColor whiteColor];
}

@end
