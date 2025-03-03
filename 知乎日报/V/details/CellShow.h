//
//  CellShow.h
//  知乎日报
//
//  Created by 李睿鑫 on 2024/10/31.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
NS_ASSUME_NONNULL_BEGIN

@interface CellShow : UITableViewCell
@property (nonatomic, strong) UILabel* title;
@property (nonatomic, strong) UILabel* author;
@property (nonatomic, strong) UIImageView* showImage;
@end

NS_ASSUME_NONNULL_END
