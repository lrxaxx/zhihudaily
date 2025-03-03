//
//  collectionCell.m
//  知乎日报
//
//  Created by 李睿鑫 on 2024/11/18.
//

#import "collectionCell.h"

@implementation collectionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if([self.reuseIdentifier isEqualToString:@"collectionCell"]) {
        _image = [[UIImageView alloc] init];
        _mainTitle = [[UILabel alloc] init];
        _mainTitle.numberOfLines = 0;
        
        [self.contentView addSubview:_image];
        [self.contentView addSubview:_mainTitle];
        
        [_mainTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(10);
            make.left.mas_offset(20);
            make.width.mas_offset(270);
            make.height.mas_offset(60);
        }];
        
        [_image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_mainTitle.mas_top);
            make.left.equalTo(_mainTitle.mas_right).offset(40);
            make.height.and.width.mas_offset(60);
        }];
    }
    return self;
}


@end
