//
//  Person.h
//  ALKVO
//
//  Created by 李丽 on 2020/2/22.
//  Copyright © 2020 李丽. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Dog.h"

NS_ASSUME_NONNULL_BEGIN


@interface Person : NSObject

@property (nonatomic, strong) NSString *name;       // 测试手动触发
@property (nonatomic, strong) NSString *gender;     // 测试自动触发
@property (nonatomic, strong) Dog *petDog;          // 属性依赖
@property (nonatomic, strong) NSMutableArray *array;// 容器类 观察

@end



NS_ASSUME_NONNULL_END
