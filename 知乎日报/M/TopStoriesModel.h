//
//  TopStoriesModel.h
//  知乎日报
//
//  Created by 李睿鑫 on 2024/11/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TopStoriesModel : NSObject
@property (nonatomic, strong) NSString* image_hue;
@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* url;
@property (nonatomic, strong) NSString* hint;
@property (nonatomic, strong) NSString* ga_prefix;
@property (nonatomic, strong) NSString* image;
@property (nonatomic, strong) NSString* id;
@property (nonatomic, strong) NSString* type;
@end

NS_ASSUME_NONNULL_END
