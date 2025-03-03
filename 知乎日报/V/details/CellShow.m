//
//  CellShow.m
//  知乎日报
//
//  Created by 李睿鑫 on 2024/10/31.
//

#import "CellShow.h"

@implementation CellShow

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if([self.reuseIdentifier isEqualToString:@"cellShow"]) {
        _title = [[UILabel alloc] init];
        _author = [[UILabel alloc] init];
        _showImage = [[UIImageView alloc] init];
        
        [self.contentView addSubview:_title];
        [self.contentView addSubview:_author];
        [self.contentView addSubview:_showImage];
        
        _title.numberOfLines = 2;
        _title.font = [UIFont systemFontOfSize:18];
        
        _author.font = [UIFont systemFontOfSize:12];
        _author.textColor = [UIColor grayColor];
        
        [_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(20);
            make.width.mas_equalTo(300);
            make.height.mas_equalTo(50);
        }];
        
        [_author mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(60);
            make.left.mas_equalTo(20);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(20);
        }];
        
        [_showImage  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(320);
            make.width.and.height.mas_equalTo(60);
        }];
    }
    return self;
}

@end

