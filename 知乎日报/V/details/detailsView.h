//
//  detailsView.h
//  知乎日报
//
//  Created by 李睿鑫 on 2024/10/31.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
NS_ASSUME_NONNULL_BEGIN

@interface detailsView : UIView
@property (nonatomic, strong) UIScrollView* scroll;
-(void) InitScrollView;
@end

NS_ASSUME_NONNULL_END
