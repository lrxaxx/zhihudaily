//
//  commentView.m
//  知乎日报
//
//  Created by 李睿鑫 on 2024/11/7.
//

#import "commentView.h"

@implementation commentView

-(void) InitTableView {
    _tableview = [[UITableView alloc] init];
    [self addSubview:_tableview];
    [_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.mas_top);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
    }];
//    self.tableview.tag = 100;
//    self.tableview.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
    
}

@end
