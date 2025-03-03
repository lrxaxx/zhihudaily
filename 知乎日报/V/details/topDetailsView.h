//
//  topDetailsView.h
//  知乎日报
//
//  Created by 李睿鑫 on 2024/11/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface topDetailsView : UIView
@property (nonatomic, strong) UIScrollView* scroll;
-(void) InitScrollView;
@end

NS_ASSUME_NONNULL_END
