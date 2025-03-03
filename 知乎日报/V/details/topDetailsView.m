//
//  topDetailsView.m
//  知乎日报
//
//  Created by 李睿鑫 on 2024/11/5.
//

#import "topDetailsView.h"

@implementation topDetailsView

-(void) InitScrollView {
    _scroll = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self addSubview:_scroll];
    
    _scroll.pagingEnabled = YES;
    _scroll.scrollEnabled = YES;
    _scroll.showsVerticalScrollIndicator = NO;
    _scroll.backgroundColor = [UIColor whiteColor];
}

@end
