//
//  personalView.m
//  知乎日报
//
//  Created by 李睿鑫 on 2024/11/16.
//

#import "personalView.h"

@implementation personalView

-(void) InitTable {
    _btnSetting = [[UIButton alloc] init];
    _btnType = [[UIButton alloc] init];
    _personalImage = [[UIImageView alloc] init];
    _tableview = [[UITableView alloc] init];
    _myName = [[UILabel alloc] init];
    
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:_btnType];
    [self addSubview:_btnSetting];
    [self addSubview:_personalImage];
    [self addSubview:_tableview];
    [self addSubview:_myName];
    
    [_btnType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(76.5);
        make.top.equalTo(self).offset(650);
        make.width.and.height.mas_offset(80);
    }];
    
    [_btnSetting mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_btnType.mas_right).offset(80);
        make.top.equalTo(_btnType.mas_top);
        make.width.and.height.mas_offset(80);
    }];
    
    [_personalImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(121.5);
        make.top.equalTo(self).offset(100);
        make.width.and.height.mas_offset(150);
    }];
    _personalImage.contentMode = UIViewContentModeScaleAspectFill; // 设置内容模式
    _personalImage.clipsToBounds = YES; // 确保内容不超出边界
    _personalImage.layer.cornerRadius = 75;
    _personalImage.layer.masksToBounds = YES;
    [_personalImage setImage:[UIImage imageNamed:@"Reus.jpg"]];
    
    [_myName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_personalImage.mas_left);
        make.top.equalTo(_personalImage.mas_bottom).offset(10);
        make.width.mas_offset(150);
        make.height.mas_offset(50);
    }];
    _myName.text = @"陌桑";
    _myName.font = [UIFont systemFontOfSize:24];
    _myName.textColor = [UIColor blackColor];
    _myName.textAlignment = NSTextAlignmentCenter;
    
    [_btnType setImage:[UIImage imageNamed:@"月亮.png"] forState:UIControlStateNormal];
    [_btnSetting setImage:[UIImage imageNamed:@"设置.png"] forState:UIControlStateNormal];
    
    _btnType.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 20, 0); // 图像下移
    _btnType.titleEdgeInsets = UIEdgeInsetsMake(0, -_btnType.imageView.frame.size.width, -70, 0); // 标题上移
    _btnType.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    _btnSetting.imageEdgeInsets = UIEdgeInsetsMake(0, 15, 20, 0); // 图像下移
    _btnSetting.titleEdgeInsets = UIEdgeInsetsMake(0, 10 - _btnSetting.imageView.frame.size.width, -70, 0); // 标题上移
    _btnSetting.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    [_btnType setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_btnSetting setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [_btnType setTitle:@"夜间模式" forState:UIControlStateNormal];
    [_btnSetting setTitle:@"设置" forState:UIControlStateNormal];
}

-(void) InitTableView {
    _tableview = [[UITableView alloc] init];
    [self addSubview:_tableview];
    
    [_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.top.equalTo(_myName.mas_bottom).offset(30);
        make.height.mas_offset(100);
        make.width.mas_equalTo(self.mas_width);
    }];
    
    _tableview.scrollEnabled = NO;
}



@end
