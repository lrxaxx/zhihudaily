//
//  DetailsController.m
//  知乎日报
//
//  Created by 李睿鑫 on 2024/11/28.
//

#import "DetailsController.h"

@interface DetailsController ()
@property (nonatomic, strong) UIButton* btnback;
@property (nonatomic, strong) UIBarButtonItem* back;
@property (nonatomic, strong) UIButton* btncomment;
@property (nonatomic, strong) UIBarButtonItem* comment;
@property (nonatomic, strong) UIButton* btngood;
@property (nonatomic, strong) UIBarButtonItem* good;
@property (nonatomic, strong) UIButton* btncollect;
@property (nonatomic, strong) UIBarButtonItem* collect;
@property (nonatomic, strong) UIButton* btnshare;
@property (nonatomic, strong) UIBarButtonItem* share;
@property (nonatomic, strong) UIBarButtonItem* btnF1;
@property (nonatomic, strong) UIBarButtonItem* btnF2;
@property (nonatomic, copy) NSMutableArray* exitURL;
@property int goodcount;
@property int commentCount;
@end

@implementation DetailsController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString* doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSLog(@"doc = %@", doc);
    NSString* fileName = [doc stringByAppendingPathComponent:@"zhihuDaily.sqlite"];
    _dateBase = [FMDatabase databaseWithPath:fileName];
    
    self.arrdate = [NSMutableArray array];
    self.arrStories = [NSMutableArray array];
    _exitURL = [NSMutableArray array];
    self.mainview = [[detailsView alloc] initWithFrame:CGRectMake(0, 50, 393, 719)];
    [self.view addSubview:self.mainview];
    [self.mainview InitScrollView];
    self.mainview.scroll.contentSize = CGSizeMake(393 * (_count + 2), 719);
    [self.mainview.scroll setContentOffset:CGPointMake(393 * _count, 0) animated:NO];
    self.mainview.scroll.delegate = self;
    _numFMDB = _count;
    [self toolBar];
    [self gainextra:_count];
    self.view.backgroundColor = [UIColor whiteColor];
    _webview = [[WKWebView alloc] initWithFrame:CGRectMake(_count * 393, 0, 393, 719)];
    _webview.navigationDelegate = self;
            
    NSString *urlString = _strurl[_count];
            
    NSURL *url = [NSURL URLWithString:urlString];
    if (url) {
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [_webview loadRequest:request];
    } else {
        NSLog(@"Invalid URL");
    }
    [self.mainview.scroll addSubview:_webview];
    [_exitURL addObject:urlString];
    _countright = _count + 1;
    _countleft = _count - 1;
    _Right = NO;
}

-(void) toolBar {
    self.navigationController.toolbarHidden = NO;
    self.navigationController.toolbar.translucent = YES;
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.navigationController.toolbar.backgroundColor = [UIColor whiteColor];
    //退出按钮
    _btnback = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnback setImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    _btnback.frame = CGRectMake(20, 10, 50, 50);
    _btnback.tag = 101;
    [_btnback addTarget:self action:@selector(press:) forControlEvents:UIControlEventTouchUpInside];
    _back = [[UIBarButtonItem alloc] initWithCustomView:_btnback];
    //评论按钮
    _btncomment = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btncomment setImage:[UIImage imageNamed:@"评论1.png"] forState:UIControlStateNormal];
    [_btncomment setFont:[UIFont systemFontOfSize:10]];
    [_btncomment setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _btncomment.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0); // 上、左、下、右
    _btncomment.titleEdgeInsets = UIEdgeInsetsMake(-20, 6, 0, 0);
    _btncomment.tag = 102;
    [_btncomment addTarget:self action:@selector(press:) forControlEvents:UIControlEventTouchUpInside];
    _btncomment.frame = CGRectMake(0, 0, 50, 50);
    _comment = [[UIBarButtonItem alloc] initWithCustomView:_btncomment];
    //点赞按钮
    _btngood = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btngood setImage:[UIImage imageNamed:@"点赞.png"] forState:UIControlStateNormal];
    [_btngood setFont:[UIFont systemFontOfSize:10]];
    [_btngood setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _btngood.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0); // 上、左、下、右
    _btngood.titleEdgeInsets = UIEdgeInsetsMake(-20, 4, 0, 0);
    _btngood.frame = CGRectMake(20, 10, 50, 50);
    _btngood.tag = 103;
    [_btngood addTarget:self action:@selector(press:) forControlEvents:UIControlEventTouchUpInside];
    [_btngood setImage:[UIImage imageNamed:@"点赞 (1).png"] forState:UIControlStateSelected];
    _good = [[UIBarButtonItem alloc] initWithCustomView:_btngood];
    //收藏按钮
    _btncollect = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btncollect setImage:[UIImage imageNamed:@"收藏.png"] forState:UIControlStateNormal];
    _btncollect.frame = CGRectMake(20, 10, 50, 50);
    _btncollect.tag = 104;
    [_btncollect addTarget:self action:@selector(press:) forControlEvents:UIControlEventTouchUpInside];
    [_btncollect setImage:[UIImage imageNamed:@"收藏 (1).png"] forState:UIControlStateSelected];
    _collect = [[UIBarButtonItem alloc] initWithCustomView:_btncollect];
    //分享按钮
    _btnshare = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnshare setImage:[UIImage imageNamed:@"分享.png"] forState:UIControlStateNormal];
    _btnshare.frame = CGRectMake(20, 10, 50, 50);
    _btnshare.tag = 105;
    [_btnshare addTarget:self action:@selector(press:) forControlEvents:UIControlEventTouchUpInside];
    _share = [[UIBarButtonItem alloc] initWithCustomView:_btnshare];
    
    _btnF1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFixedSpace target: nil action: nil];
       _btnF1.width = 110;
           
       //设置自动计算宽度按钮
       _btnF2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace target: nil action: nil];
    
    NSArray* arr = [NSArray arrayWithObjects:_back, _btnF2, _comment, _btnF2, _good, _btnF2, _collect, _btnF2, _share, nil];
    self.toolbarItems = arr;
}

-(void) press:(UIButton*) btn {
    btn.selected = !btn.selected;
    if(btn.tag == 101) {
        self.navigationController.toolbarHidden = YES;
        [self fetchAllData];
        [self.navigationController popViewControllerAnimated:YES];
    } else if(btn.tag == 103) {
        [_btngood setTitle:[NSString stringWithFormat:@"%d", (_goodcount + 1)] forState:UIControlStateSelected];
    } else if(btn.tag == 102) {
        CGFloat width = self.mainview.scroll.contentOffset.x;
        NSInteger count = width / 393;
        commentController* com = [[commentController alloc]init];
        com.sumcomment = _strid[count];
        com.commentcount = _commentCount;
        NSLog(@"%@", _strid);
        [self.navigationController pushViewController:com animated:NO];
    } else if(btn.tag == 104) {
        if(btn.selected) {
            [self insertDate];
        } else {
            [self deleteData];
        }
    } else {
        NSLog(@"111");
    }
}

- (void)fetchAllData {
    // 打开数据库
    if ([_dateBase open]) {
        // 执行查询，获取所有数据
        FMResultSet *resultSet = [_dateBase executeQuery:@"SELECT * FROM collectionData"];
        
        // 遍历查询结果
        while ([resultSet next]) {
            NSString *mainHeading = [resultSet stringForColumn:@"mainHeading"];
            NSString *webAPI = [resultSet stringForColumn:@"webAPI"];
            NSString *imageURL = [resultSet stringForColumn:@"imageURL"];
            NSString *newsID = [resultSet stringForColumn:@"newsID"];
            
            // 打印结果
            NSLog(@"mainHeading: %@, webAPI: %@, imageURL: %@, newsID: %@", mainHeading, webAPI, imageURL, newsID);
        }
        
        // 关闭结果集
        [resultSet close];
        
        // 关闭数据库
        [_dateBase close];
    } else {
        NSLog(@"无法打开数据库");
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _lastContentOffset = scrollView.contentOffset;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat endWidth = self.mainview.scroll.contentOffset.x;
    NSInteger count = endWidth / 393;
    NSLog(@"滚动结束后：%ld", count);
    NSInteger webAPICount = _strurl.count;
    _countright = webAPICount - count;
    if(_countright <= 4 && !_Right) {
        _Right = YES;
        [self gaindate];
    }
    _numFMDB = count;
    if(count < _strurl.count)
        [self gainextra:count];
    NSString *urlString = _strurl[_numFMDB];
    if (![_exitURL containsObject:urlString]) {
        _webview = [[WKWebView alloc] initWithFrame:CGRectMake(endWidth, 0, 393, 719)];
        _webview.navigationDelegate = self;
        NSLog(@"URL String: %@", urlString);
        [self gainWebview:urlString];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (fabs(scrollView.contentOffset.x - self.lastContentOffset.x) > fabs(scrollView.contentOffset.y - self.lastContentOffset.y)) {
            scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, self.lastContentOffset.y);
        } else {
            self.lastContentOffset = scrollView.contentOffset; // 更新位置
        }
    CGFloat widthNow = self.mainview.scroll.contentOffset.x;
    CGFloat width = self.mainview.scroll.contentSize.width;
    NSInteger cha = width - widthNow;
    if(cha == 393) {
        self.mainview.scroll.contentSize = CGSizeMake(width + 393, 719);
    }

}
//刷新页面
-(void) gainWebview:(NSString*) urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    if (url) {
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [_webview loadRequest:request];
    } else {
        NSLog(@"Invalid URL");
    }
//    NSLog(@"111");
    [self.mainview.scroll addSubview:_webview];
    [_exitURL addObject:urlString];
}
//重新刷新出新的日期的新闻
-(void) gaindate {
    NSLog(@"开始申请之前的日期");
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSDate* date = [formatter dateFromString:_lastday];
    NSDateComponents* for1 = [[NSDateComponents alloc] init];
    for1.day = -1;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate* yesterday = [calendar dateByAddingComponents:for1 toDate:date options:0];
    NSString *str = [formatter stringFromDate:yesterday];
//    NSLog(@"str = %@", str);
    NSString *strweb = @"https://news-at.zhihu.com/api/4/news/before/";
    // 使用 stringByAppendingFormat 创建一个新的字符串
    strweb = [strweb stringByAppendingFormat:@"%@", _lastday];
    self->_lastday = str;
    Manager* manager = [Manager shareManager];
    [manager URLString:strweb NetWorkWithData:^(NowadaysModel * _Nonnull mainModel) {
//        NSLog(@"111");
        NSDictionary *dic = [mainModel yy_modelToJSONObject];
//        NSLog(@"%@", dic[@"stories"]);
        NSArray* arr = dic[@"stories"];
//        NSLog(@"%@", arr);
        NSMutableArray* arrdate = [NSMutableArray array];
        arrdate = [self->_arrdate mutableCopy];
        NSMutableArray* arrStories = [NSMutableArray array];
        arrStories = [self->_arrStories mutableCopy];
        NSMutableArray* arrurl = [NSMutableArray array];
        arrurl = [self->_strurl mutableCopy];
        NSMutableArray* arrid = [NSMutableArray array];
        arrid = [self->_strid mutableCopy];
        NSMutableArray* arrTitle = [NSMutableArray array];
        arrTitle = [self->_strTitle mutableCopy];
        [arrdate addObject:str];
//        NSLog(@"arrdate = %@", arrdate);
        [arrStories addObject:arr];
//        NSLog(@"arrStories = %@", arrStories);
        // 在主线程中更新 UI
        dispatch_async(dispatch_get_main_queue(), ^{
            for (id obj in [arrStories lastObject]) {
                if ([obj isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *dic = (NSDictionary *)obj;
                    [arrurl addObject:dic[@"url"]];
                    [arrid addObject:dic[@"id"]];
                    [arrTitle addObject:dic[@"title"]];
                } else {
                    NSLog(@"Element in arrStories is not an NSDictionary: %@", obj);
                }
            }
            self->_strurl = [arrurl mutableCopy];
            self->_strid = [arrid mutableCopy];
            self->_strTitle = [arrTitle mutableCopy];
            self->_arrdate = [arrdate mutableCopy];
            self->_arrStories = [arrStories mutableCopy];
            
//            NSLog(@"%ld %ld", self->_strurl.count, self->_countright);
//            NSString *urlString = self->_strurl[self->_countright];
//            [self gainextra:self->_countright];
//            self->_countright++;
//            [self gainWebview:urlString];
            NSLog(@"申请成功");
            NSDictionary* dictionary = @{@"stories":[self->_arrStories lastObject],@"date":[self->_arrdate lastObject]};
            [[NSNotificationCenter defaultCenter] postNotificationName:@"inform" object:nil userInfo:dictionary];
            self->_Right = NO;
        });
    } error:^(NSError * _Nonnull error) {
        NSLog(@"error:%@", error.localizedDescription);
    }];
}

-(void) gainextra: (NSInteger) count {
    NSString *strweb = @"https://news-at.zhihu.com/api/4/story-extra/";
    // 使用 stringByAppendingFormat 创建一个新的字符串
    strweb = [strweb stringByAppendingFormat:@"%@", self.strid[count]];
    id manager1 = [Manager1 shareManager];
    [manager1 URLString1:strweb NetWorkWithData:^(CommentModel * _Nonnull mainModel) {
        NSDictionary* dic = [mainModel yy_modelToJSONObject];
        
        // 在主线程中更新 UI
        dispatch_async(dispatch_get_main_queue(), ^{
            self->_goodcount = [dic[@"popularity"] intValue];
            self->_commentCount = [dic[@"comments"] intValue];
            [self toolBar1:dic[@"popularity"]and:dic[@"comments"]];
        });
    } error:^(NSError * _Nonnull error) {
        NSLog(@"error:%@", error.localizedDescription);
    }];
}

-(void) toolBar1:(NSString*) str1 and:(NSString*)str2 {
    if([str1 intValue])
        [_btngood setTitle:str1 forState:UIControlStateNormal];
    else
        [_btngood setTitle:@"" forState:UIControlStateNormal];
    if([str2 intValue])
        [_btncomment setTitle:str2 forState:UIControlStateNormal];
    else
        [_btncomment setTitle:@"" forState:UIControlStateNormal];
    _btncollect.selected = [self queryData];
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

-(void) insertDate {
    if([_dateBase open]) {
        BOOL result = [_dateBase executeUpdate:@"INSERT INTO collectionData (mainHeading, webAPI, imageURL, newsID) VALUES(?, ?, ?, ?);", _strTitle[_numFMDB], _strurl[_numFMDB], _strImageURL[_numFMDB], _strid[_numFMDB]];
        if (!result) {
            NSLog(@"增加数据失败");
        }else{
            NSLog(@"增加数据成功");
        }
        [_dateBase close];
    }
}

-(void) deleteData {
    if([_dateBase open]) {
        NSString *sql = @"delete from collectionData WHERE webAPI = ?";
        BOOL result = [_dateBase executeUpdate:sql, _strurl[_numFMDB]];
        if(result) {
            NSLog(@"删除成功");
        } else {
            NSLog(@"删除失败");
        }
        [_dateBase close];
    }
}

-(BOOL) queryData {
    BOOL select = NO;
    if([_dateBase open]) {
        NSString* sql = @"SELECT * FROM collectionData WHERE webAPI = ?";
        FMResultSet *resultSet = [_dateBase executeQuery:sql, _strurl[_numFMDB]];
        if([resultSet next]) {
            select = YES;
        }
        [resultSet close];
        [_dateBase close];
    }
    return select;
}

@end
