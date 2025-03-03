//
//  collectionView.m
//  知乎日报
//
//  Created by 李睿鑫 on 2024/11/18.
//

#import "collectionView.h"

@implementation collectionView

- (void)InitTableView {
    _tableView = [[UITableView alloc] init];
    [self addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(67);
        make.bottom.equalTo(self.mas_bottom).offset(0);
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
    }];
    
    
}

@end
