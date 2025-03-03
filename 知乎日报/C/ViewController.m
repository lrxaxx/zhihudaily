//
//  ViewController.m
//  知乎日报
//
//  Created by 李睿鑫 on 2024/10/31.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UILabel* month;
@property (nonatomic, strong) UILabel* day;
@property (nonatomic, strong) UIImageView* photo;
@property (nonatomic, strong) UILabel* hello;
@property (nonatomic, strong) UIImage* settingPhoto;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
//    dispatch_queue_t serialQueue = dispatch_queue_create("com.example.serialQueue", DISPATCH_QUEUE_SERIAL);
    
    // 初始化数组
    self->_arrStories = [[NSMutableArray alloc] init];
    self->_arrTopStories = [NSMutableArray array];
    self->_arrImage = [NSMutableArray array];
    self->_arrTopImage = [NSMutableArray array];
    self->_arrDate = [NSMutableArray array];
    self->_arrURL = [NSMutableArray array];
    
    id manager = [Manager shareManager];
    NSString* url = @"https://news-at.zhihu.com/api/4/news/latest";
    [manager URLString:url NetWorkWithData:^(NowadaysModel * _Nonnull mainModel) {
        NSDictionary *dic = [mainModel yy_modelToJSONObject];
        NSArray *arr = dic[@"stories"];
        [self.arrDate addObject:dic[@"date"]];
        NSArray *arr_top = dic[@"top_stories"];
        
        // 在主线程中更新 UI
        dispatch_async(dispatch_get_main_queue(), ^{
            [self->_arrStories addObject:arr];
            [self->_arrTopStories addObjectsFromArray:arr_top];
            [self loadImages:(self->_arrStories.count - 1)];// 加载图片
//            NSLog(@"%@", self->_arr_top_stories);
        });
    } error:^(NSError * _Nonnull error) {
        NSLog(@"error:%@", error.localizedDescription);
    }];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveNoticed:) name:@"inform" object:nil];
        
}
- (void)receiveNoticed:(NSNotification*)sender {
    [_arrStories addObject:sender.userInfo[@"stories"]];
    [_arrDate addObject:sender.userInfo[@"date"]];
    [self loadImages111:(_arrStories.count - 1)];
    
}

- (void)loadImages111:(long) a {
    // 使用 dispatch_group 来等待所有图片加载完成
    dispatch_group_t imageLoadGroup = dispatch_group_create();
    NSMutableArray* arrImage = [NSMutableArray array];
    for (NSDictionary *dic in self->_arrStories[a]) {
        NSArray* arr = dic[@"images"];
        NSURL *imageurl = [NSURL URLWithString:arr[0]];
        UIImageView *iview = [[UIImageView alloc] init];
        
        dispatch_group_enter(imageLoadGroup); // 进入组
        
        [iview sd_setImageWithURL:imageurl
                placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                         options:SDWebImageRefreshCached
                       completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if (error) {
                NSLog(@"加载图片失败: %@", error.localizedDescription);
            } else {
                NSLog(@"图片加载成功");
            }
            dispatch_group_leave(imageLoadGroup); // 离开组
        }];
        
        [arrImage addObject:iview];
    }
    [self->_arrImage addObject:arrImage];
    // 在所有图片加载完成后设置主视图
    dispatch_group_notify(imageLoadGroup, dispatch_get_main_queue(), ^{
        [self.mainView.tableview reloadData]; // 设置主视图
    });
}

// 移除通知
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

// 加载图片
- (void)loadImages:(long) a {
    // 使用 dispatch_group 来等待所有图片加载完成
    dispatch_group_t imageLoadGroup = dispatch_group_create();
    NSMutableArray* arrimage = [NSMutableArray array];
    for (NSDictionary *dic in self->_arrStories[a]) {
        NSArray* arr = dic[@"images"];
        NSURL *imageurl = [NSURL URLWithString:arr[0]];
        UIImageView *iview = [[UIImageView alloc] init];
        
        dispatch_group_enter(imageLoadGroup); // 进入组
        
        [iview sd_setImageWithURL:imageurl
                placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                         options:SDWebImageRefreshCached
                       completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if (error) {
                NSLog(@"加载图片失败: %@", error.localizedDescription);
            } else {
                NSLog(@"图片加载成功");
            }
            dispatch_group_leave(imageLoadGroup); // 离开组
        }];
        
        [arrimage addObject:iview];
    }
    [self->_arrImage addObject:arrimage];
    // 在所有图片加载完成后设置主视图
    dispatch_group_notify(imageLoadGroup, dispatch_get_main_queue(), ^{
        [self loadtopImages]; // 设置主视图
    });
}

- (void)loadtopImages {
    // 使用 dispatch_group 来等待所有图片加载完成
    dispatch_group_t imageLoadGroup = dispatch_group_create();
    
    for (NSDictionary *dic in self->_arrTopStories) {
        NSString* arr = dic[@"image"];
        NSLog(@"%@", arr);
        NSURL *imageurl = [NSURL URLWithString:arr];
        UIImageView *iview = [[UIImageView alloc] init];
        
        dispatch_group_enter(imageLoadGroup); // 进入组
        
        [iview sd_setImageWithURL:imageurl
                placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                         options:SDWebImageRefreshCached
                       completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if (error) {
                NSLog(@"加载图片失败: %@", error.localizedDescription);
            } else {
                NSLog(@"图片加载成功");
            }
            dispatch_group_leave(imageLoadGroup); // 离开组
        }];
        [self->_arrTopImage addObject:iview];
    }
    
    // 在所有图片加载完成后设置主视图
    dispatch_group_notify(imageLoadGroup, dispatch_get_main_queue(), ^{
        [self setupMainView]; // 设置主视图
        [self setupFMDB];
    });
}

-(void) setupFMDB {
    //FMDB的创建
    NSString* doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSLog(@"doc = %@", doc);
    NSString* fileName = [doc stringByAppendingPathComponent:@"zhihuDaily.sqlite"];
    
    _dataBase = [FMDatabase databaseWithPath:fileName];
    
    if([self.dataBase open]) {
        BOOL result = [self.dataBase executeUpdate:@"CREATE TABLE IF NOT EXISTS collectionData (mainHeading text NOT NULL, webAPI text NOT NULL, imageURL text NOT NULL,newsID text NOT NULL);"];
        if (result) {
            NSLog(@"创表成功");
        } else {
            NSLog(@"创表失败");
        }
    }
}

// 设置主视图
- (void)setupMainView {
    self->_mainView = [[mainView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self->_mainView];
    [self buildTopView];
    [self getURL:0];
    UINavigationBarAppearance* appearance = [[UINavigationBarAppearance alloc] init];
    appearance.backgroundColor = [UIColor whiteColor];
    appearance.shadowImage = [[UIImage alloc] init];
        //设置该对象的阴影颜色
    appearance.shadowColor = nil;
    self.navigationController.navigationBar.standardAppearance = appearance;
        //设置滚动样式导航栏
    self.navigationController.navigationBar.scrollEdgeAppearance = appearance;
   
    self->_mainView.tableview.delegate = self;
    self->_mainView.tableview.dataSource = self;
    self->_mainView.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self->_mainView.tableview registerClass:[Celllun class] forCellReuseIdentifier:@"celllun"];
    [self->_mainView.tableview registerClass:[CellShow class] forCellReuseIdentifier:@"cellShow"];
    self.action = NO;
}

-(void)getURL:(long) a {
    for (NSDictionary* dic in _arrStories[a]) {
        [_arrURL addObject:dic[@"url"]];
    }
    NSLog(@"_arrurl = %@", _arrURL);
}

- (void)buildTopView {
    _month = [[UILabel alloc] init];
    _day = [[UILabel alloc] init];
    _hello = [[UILabel alloc] init];
    

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 60, 40)];
    
    [view addSubview:_month];
    [view addSubview:_day];

    // 使用 Auto Layout
    _day.frame = CGRectMake(0, 0, 50, 25);
    _month.frame = CGRectMake(0, 25, 50, 15); // 确保 _month 在 _day 下方
    _hello.frame = CGRectMake(20, 0, 100, 40);
    // 设置文本对齐和样式
    _day.textAlignment = NSTextAlignmentCenter;
    _month.textAlignment = NSTextAlignmentCenter;
    _hello.textAlignment = NSTextAlignmentCenter;
    _day.font = [UIFont systemFontOfSize:24];
    _month.font = [UIFont systemFontOfSize:12];
    _hello.font = [UIFont systemFontOfSize:24];
    _day.textColor = [UIColor grayColor];
    _month.textColor = [UIColor darkGrayColor];

    NSDate *date = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitMonth | NSCalendarUnitDay|NSCalendarUnitHour) fromDate:date];
    NSInteger month = components.month;
    NSInteger day = components.day;
    NSInteger hour = components.hour;

    NSDictionary *dic = @{
        @"01": @"一月", @"02": @"二月", @"03": @"三月",
        @"04": @"四月", @"05": @"五月", @"06": @"六月",
        @"07": @"七月", @"08": @"八月", @"09": @"九月",
        @"10": @"十月", @"11": @"十一月", @"12": @"十二月"
    };

    NSString *str = [NSString stringWithFormat:@"%02ld", (long)month];
    _month.text = dic[str]; // 使用 _month
    _day.text = [NSString stringWithFormat:@"%ld", (long)day]; // 使用 _day
     NSString* str1;
     if(hour>=0&&hour<6) {
     str1 = @"早点睡！";
     self.hello.text = str1;
     } else if (hour>=6&&hour<12) {
     str1 = @"早上好!";
     self.hello.text = str1;
     } else if (hour>=12&&hour<18) {
     str1 = @"下午好！";
     self.hello.text = str1;
     } else {
     str1 = @"晚上好！";
     self.hello.text = str1;
     }
    
    UIView* view1 = [[UIView alloc] initWithFrame:CGRectMake(59, 0, 1, 40)];
    view1.backgroundColor = [UIColor grayColor];
    [view addSubview:view1];
    UIBarButtonItem* left1 = [[UIBarButtonItem alloc] initWithCustomView:_hello];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:view];
    NSArray* arr = [NSArray arrayWithObjects:left, left1, nil];
    self.navigationItem.leftBarButtonItems = arr;
    _settingPhoto = [UIImage imageNamed:@"Reus.jpg"];
    UIButton* btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
    btnRight.frame = CGRectMake(0, 0, 40, 40);
    btnRight.contentMode = UIViewContentModeScaleAspectFill; // 设置内容模式
    btnRight.clipsToBounds = YES; // 确保内容不超出边界
    btnRight.layer.cornerRadius = 20;
    btnRight.layer.masksToBounds = YES;
    [btnRight setImage:_settingPhoto forState:UIControlStateNormal];
    [btnRight addTarget:self action:@selector(rightButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:btnRight];
//    rightButton.content
    self.navigationItem.rightBarButtonItem = rightButton;
}

-(void) rightButtonTapped {
    personalController* personal = [[personalController alloc] init];
    [self.navigationController pushViewController:personal animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.arrStories.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0) {
        NSArray* arr = self.arrStories[0];
        return (1 + arr.count);
    } else {
        NSArray* arr = self.arrStories[section];
        return arr.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0 && indexPath.row == 0)
        return 450;
    else
        return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0 && indexPath.row == 0) {
        Celllun* cell = [_mainView.tableview dequeueReusableCellWithIdentifier:@"celllun" forIndexPath:indexPath];
        if(!cell) {
            cell = [[Celllun alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"celllun"];
        }
        [cell.contentView addSubview:cell.page];
        [cell.page mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@240);
                make.bottom.equalTo(cell.contentView).offset(-20);
                make.height.equalTo(@20); // 设置高度
                make.width.equalTo(@(150));
        }];
        for (int i = 0; i < 7; i++) {
            UIImageView *iView = [[UIImageView alloc] init]; // 创建新的 UIImageView 实例
            
            // 根据 i 的值设置 UIImageView 的图像
            if (i == 0) {
                UIImageView* view = self->_arrTopImage[4];
                iView.image = view.image; // 使用数组中的图像
            } else if (i == 6) {
                UIImageView* view = self->_arrTopImage[0];
                iView.image = view.image;// 使用数组中的图像
            } else {
                UIImageView* view = self->_arrTopImage[i - 1];
                iView.image = view.image; // 使用数组中的图像
            }
            
            iView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped:)];
            tapGesture.cancelsTouchesInView = NO; // 允许其他触摸事件
            iView.tag = i; // 使用 tag 保存索引
            [iView addGestureRecognizer:tapGesture];

            // 设置 frame
            iView.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width) * i, 0, [UIScreen mainScreen].bounds.size.width, 450);
            
            // 添加到滚动视图中
            [cell.scroll addSubview:iView];
            UILabel* label1 = [[UILabel alloc] init];
            UILabel* label2 = [[UILabel alloc] init];
            
            [cell.scroll addSubview:label1];
            [cell.scroll addSubview:label2];
            
            label1.textColor = [UIColor whiteColor];
            label2.textColor = [UIColor whiteColor];
            
            label1.numberOfLines = 2;
            label1.font = [UIFont systemFontOfSize:20];
            label2.font = [UIFont systemFontOfSize:12];
            
            [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(330);
                make.left.mas_equalTo(20 + i * 393);
                make.width.mas_equalTo(353);
                make.height.mas_equalTo(80);
            }];
            
            [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(410);
                make.left.mas_equalTo(20 + i * 393);
                make.width.mas_equalTo(343);
                make.height.mas_equalTo(20);
            }];
            if(i == 0) {
                label1.text = self->_arrTopStories[4][@"title"];
                label2.text = self->_arrTopStories[4][@"hint"];
            } else if(i == 6) {
                label1.text = self->_arrTopStories[0][@"title"];
                label2.text = self->_arrTopStories[0][@"hint"];
            } else {
                label1.text = self->_arrTopStories[i-1][@"title"];
                label2.text = self->_arrTopStories[i-1][@"hint"];
            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if(indexPath.section == 0){
        CellShow* cell1 = [_mainView.tableview dequeueReusableCellWithIdentifier:@"cellShow" forIndexPath:indexPath];
        if(!cell1) {
            cell1 = [[CellShow alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellShow"];
        }
        NSDictionary* dic = self.arrStories[indexPath.section][indexPath.row - 1];
        cell1.title.text = dic[@"title"];
        cell1.author.text = dic[@"hint"];
        UIImageView* iview = self->_arrImage[indexPath.section][indexPath.row - 1];
        cell1.showImage.image = iview.image;
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell1;
    } else {
        CellShow* cell1 = [_mainView.tableview dequeueReusableCellWithIdentifier:@"cellShow" forIndexPath:indexPath];
        if(!cell1) {
            cell1 = [[CellShow alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellShow"];
        }
        NSDictionary* dic = self.arrStories[indexPath.section][indexPath.row];
        cell1.title.text = dic[@"title"];
        cell1.author.text = dic[@"hint"];
        UIImageView* iview = self->_arrImage[indexPath.section][indexPath.row];
        cell1.showImage.image = iview.image;
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell1;

    }
}

-(void) imageTapped:(UITapGestureRecognizer*) gesture {
    NSInteger index = gesture.view.tag;
    if(index == 0)
        index = 4;
    else if(index == 6)
        index = 0;
    else
        index--;
    TopDetailsController* topDetails = [[TopDetailsController alloc] init];
    topDetails.count = 5;
    topDetails.countNow = index;
    NSMutableArray* arr = [NSMutableArray array];
    NSMutableArray* arr1 = [NSMutableArray array];
    NSMutableArray* arr2 = [NSMutableArray array];
    NSMutableArray* arr3 = [NSMutableArray array];
    for (NSDictionary* dic in _arrTopStories) {
        [arr addObject:dic[@"url"]];
        [arr1 addObject:dic[@"id"]];
        [arr2 addObject:dic[@"title"]];
        [arr3 addObject:dic[@"image"]];
    }
    topDetails.strid = [arr1 mutableCopy];
    topDetails.strurl = [arr mutableCopy];
    topDetails.strTitle = [arr2 mutableCopy];
    topDetails.strImageURL = [arr3 mutableCopy];
    NSLog(@"%ld", index);
    [self.navigationController pushViewController:topDetails animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView* ivew = [[UIView alloc] init];
    ivew.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 1);
    return ivew;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == 0)
        return nil;
    else {
        UIView* view = [[UIView alloc] init];
        view.frame = CGRectMake(0, 0, 393, 30);
        
        UILabel* label = [[UILabel alloc] init];
        NSString* dateString = self->_arrDate[section];
        NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
        [inputFormatter setDateFormat:@"yyyyMMdd"]; // 输入格式
        NSDate *date = [inputFormatter dateFromString:dateString]; // 转换为 NSDate
        
        // 创建另一个 NSDateFormatter 进行日期到字符串的转换
        NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
        [outputFormatter setDateFormat:@"MM月dd日"]; // 输出格式
        NSString *formattedString = [outputFormatter stringFromDate:date]; // 转换为目标格式
        NSLog(@"%@", formattedString);
        label.text = formattedString;
        label.textColor = [UIColor grayColor];
        label.font = [UIFont systemFontOfSize:18];
        label.frame = CGRectMake(20, 0, 100, 30);
        UIView* iview = [[UIImageView alloc] init];
        iview.frame = CGRectMake(120, 14, 260, 1);
        iview.backgroundColor = [UIColor grayColor];
        [view addSubview:iview];
        [view addSubview:label];
        return view;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.section == 0 &&  indexPath.row != 0) {
        NSLog(@"进入头");
        DetailsController* details = [[DetailsController alloc] init];
        NSMutableArray* arr = [NSMutableArray array];
        NSMutableArray* arr1 = [NSMutableArray array];
        NSMutableArray* arr2 = [NSMutableArray array];
        NSMutableArray* arr3 = [NSMutableArray array];
        for (NSArray* arrStories in _arrStories) {
            for (NSDictionary* dic in arrStories) {
                [arr addObject:dic[@"url"]];
                [arr1 addObject:dic[@"id"]];
                [arr2 addObject:dic[@"title"]];
                if(dic[@"images"])
                    [arr3 addObject:dic[@"images"][0]];
                else
                    [arr3 addObject:[NSNull null]];
            }
        }
        NSInteger count = 0;
        if(indexPath.section == 0) {
            count = indexPath.row - 1;
        }
        details.count = count;
        details.lastday = [_arrDate lastObject];
        NSLog(@"%@", [_arrDate lastObject]);
        NSLog(@"最后:%@", [_arrDate lastObject]);
        details.strurl = [arr mutableCopy];
        details.strid = [arr1 mutableCopy];
        details.strTitle = [arr2 mutableCopy];
        details.strImageURL = [arr3 mutableCopy];
        [self.navigationController pushViewController:details animated:YES];
    } else if(!(indexPath.section == 0 && indexPath.row == 0)) {
        NSLog(@"开始进入");
        DetailsController* details = [[DetailsController alloc] init];
        NSMutableArray* arr1 = [NSMutableArray array];
        NSMutableArray* arr2 = [NSMutableArray array];
        NSMutableArray* arr3 = [NSMutableArray array];
        NSMutableArray* arr4 = [NSMutableArray array];
        NSLog(@"%@", _arrStories);
        for(NSMutableArray* arr in _arrStories) {
            for (NSDictionary* dic in arr) {
                NSLog(@"dic = %@", dic);
                [arr1 addObject:dic[@"url"]];
                [arr2 addObject:dic[@"id"]];
                [arr3 addObject:dic[@"title"]];
                if(dic[@"images"])
                    [arr4 addObject:dic[@"images"][0]];
                else
                    [arr4 addObject:[NSNull null]];
            }
        }
        NSInteger count = 0;
        for(int i = 0; i < indexPath.section; i++) {
            NSArray* arr = _arrStories[i];
            count += arr.count;
        }
        count += indexPath.row;
        details.count = count;
        details.lastday = [_arrDate lastObject];
        NSLog(@"%@", [_arrDate lastObject]);
        details.strid = [arr2 mutableCopy];
        details.strurl = arr1;
        details.strTitle = arr3;
        details.strImageURL = arr4;
        NSLog(@"gogogo");
        [self.navigationController pushViewController:details animated:YES];
    } 
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView.tag == 100) {
        CGFloat y = scrollView.contentOffset.y;
        CGFloat contentHeight = scrollView.contentSize.height;
        CGFloat height = scrollView.bounds.size.height;
        if (y + height >= contentHeight + 10) {
            [self Gaindate];
        }
    }
}

-(void) Gaindate {
    if(self.action)
        return;
    self.action = YES;
//    NSString* date1 = [self->_date lastObject];
    [self.mainView.active startAnimating];

    NSString *strweb = @"https://news-at.zhihu.com/api/4/news/before/";
    // 使用 stringByAppendingFormat 创建一个新的字符串
    strweb = [strweb stringByAppendingFormat:@"%@", [self->_arrDate lastObject]];
    NSLog(@"%@", strweb);
//    dispatch_queue_t serialQueue = dispatch_queue_create("com.example.serialQueue", DISPATCH_QUEUE_SERIAL);
    id manager = [Manager shareManager];
    [manager URLString:strweb NetWorkWithData:^(NowadaysModel * _Nonnull mainModel) {
        NSDictionary *dic = [mainModel yy_modelToJSONObject];
        NSArray *arr = dic[@"stories"];
        [self.arrDate addObject:dic[@"date"]];
        
        // 在主线程中更新 UI
        dispatch_async(dispatch_get_main_queue(), ^{
            [self->_arrStories addObject:arr];
            [self getURL:(self->_arrStories.count - 1)];
            [self loadImages1];// 加载图片
//            NSLog(@"%@", self->_arr_top_stories);
        });
    } error:^(NSError * _Nonnull error) {
        NSLog(@"error:%@", error.localizedDescription);
    }];
}

- (void)loadImages1 {
    // 使用 dispatch_group 来等待所有图片加载完成
    dispatch_group_t imageLoadGroup = dispatch_group_create();
    NSMutableArray* arrimage = [NSMutableArray array];
    for (NSDictionary *dic in [self->_arrStories lastObject]) {
        dispatch_group_enter(imageLoadGroup); // 进入组
        NSLog(@"最后一个数据 = %@", dic);
        NSArray* arr = dic[@"images"];
        NSURL *imageurl = [NSURL URLWithString:arr[0]];
        UIImageView *iview = [[UIImageView alloc] init];
        [iview sd_setImageWithURL:imageurl
                placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                         options:SDWebImageRefreshCached
                       completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if (error) {
                NSLog(@"加载图片失败: %@", error.localizedDescription);
            } else {
                NSLog(@"图片加载成功");
            }
            NSLog(@"正在离开组，图片URL: %@", imageurl.absoluteString);
            dispatch_group_leave(imageLoadGroup); // 离开组
        }];
        [arrimage addObject:iview];
    }
    [self->_arrImage addObject:arrimage];
    // 在所有图片加载完成后设置主视图
    dispatch_group_notify(imageLoadGroup, dispatch_get_main_queue(), ^{
        [self.mainView.active stopAnimating];
        [self.mainView.tableview reloadData];
        self.action = NO;
    });
}
@end
