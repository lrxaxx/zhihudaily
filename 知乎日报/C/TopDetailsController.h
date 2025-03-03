//
//  TopDetailsController.h
//  知乎日报
//
//  Created by 李睿鑫 on 2024/11/28.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import <YYModel/YYModel.h>
#import "detailsView.h"
#import "NowadaysModel.h"
#import "commentController.h"
#import "Manager1.h"
#import "Manager.h"
#import "FMDB.h"

NS_ASSUME_NONNULL_BEGIN

@interface TopDetailsController : UIViewController<WKNavigationDelegate, UIScrollViewDelegate>
@property (nonatomic, copy) NSMutableArray* strurl;
@property (nonatomic, copy) NSMutableArray* strid;
@property (nonatomic, copy) NSMutableArray* strTitle;
@property (nonatomic, copy) NSMutableArray* strImageURL;
@property (nonatomic, copy) NSMutableArray* exitImageURL;
@property  NSInteger count;
@property NSInteger countNow;
@property NSInteger countleft;
@property NSInteger countright;
@property BOOL Right;
@property (nonatomic, strong) WKWebView* webview;
@property (nonatomic, strong) detailsView* mainview;
@property (nonatomic) CGPoint lastContentOffset;
@property (nonatomic, strong) FMDatabase* dateBase;

@end

NS_ASSUME_NONNULL_END

