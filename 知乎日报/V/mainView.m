//
//  mainView.m
//  知乎日报
//
//  Created by 李睿鑫 on 2024/10/31.
//

#import "mainView.h"

@implementation mainView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.tableview = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStyleGrouped];
    [self addSubview:self.tableview];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);    // 左侧与父视图左边缘相等
        make.right.equalTo(self.mas_right);  // 右侧与父视图右边缘相等
        make.top.equalTo(self.mas_top).offset(97); // 顶部距离父视图顶部50点
        make.bottom.equalTo(self.mas_bottom);
    }];
    self.tableview.backgroundColor = [UIColor whiteColor];
    self.tableview.tag = 100;
    self.tableview.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
    
    self.active = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
    [self addSubview:self.active];
    [self.active mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(785);
        make.left.mas_equalTo(161);
        make.height.and.width.mas_equalTo(70);
    }];
    
    
    return self;
}

@end

