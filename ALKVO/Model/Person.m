//
//  Person.m
//  ALKVO
//
//  Created by 李丽 on 2020/2/22.
//  Copyright © 2020 李丽. All rights reserved.
//

#import "Person.h"


/*
 KVO 底层实现
 1、创建一个字类
 2、重写 set 方法
 3、外界改变 isa 指针
 */


@implementation Person

- (instancetype) init {
    self = [super init];
    if (self) {
        _petDog = [[Dog alloc] init];
    }
    return self;
}

- (NSMutableArray *)array {
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
}



// 模式调整 - 手动模式和自动模式
/*
 自动模式： 函数返回 YES 自动模式，只要观察到数据发生变化，自动调用 监听方法
 手动模式： 函数返回 NO ，仅修改观察的数据不会触发监听方法；
          此时 如过想实现监听 需要调用 willChangeValueForKey: 和 didChangeValueForKey： 才会触发监听方法
           eg：  [person willChangeValueForKey: @"name"];
                 person.name = @"newName";
                 [person didChangeValueForKey:@"name"];
 */

+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key {
    if ([key isEqualToString:@"name"]) {
        return false; // 调整 name 为手动触发监听
    }
    return true;
}


// 依赖属性 设置
+(NSSet<NSString *> *)keyPathsForValuesAffectingValueForKey:(NSString *)key{
    NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
    if ([key isEqualToString: @"petDog"]) {
        keyPaths = [[NSSet alloc] initWithObjects:@"_petDog.age", @"_petDog.name", nil];
    }
    return keyPaths;
}
@end
