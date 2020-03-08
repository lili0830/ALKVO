//
//  NSObject+ALKVO.m
//  ALKVO
//
//  Created by 李丽 on 2020/2/23.
//  Copyright © 2020 李丽. All rights reserved.
//

#import "NSObject+ALKVO.h"
#import <objc/message.h>

static const char *ALKVO_observer = "ALKVO_observer";
static const char *ALKVO_getter = "ALKVO_getter";
static const char *ALKVO_setter = "ALKVO_setter";

@implementation NSObject (ALKVO)

- (void)al_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context {
    
    // 1、创建一个类
    NSString *oldClassName = NSStringFromClass(self.class);
    NSString *newClassName = [@"ALKVONotyfing_" stringByAppendingString:oldClassName];
    // 获取 子类
    Class myClass = objc_getClass(newClassName.UTF8String);
    if (!myClass) {
        // 子类不存在，创建新的字类
        myClass = objc_allocateClassPair(self.class, newClassName.UTF8String, 0);
        // 注册子类
        objc_registerClassPair(myClass);
    }
    // 2、重写 set 方法
    // name => Name
    NSString *newKeyPath = [[[keyPath substringToIndex:1] uppercaseString] stringByAppendingString:[keyPath substringFromIndex:1]];
    NSString *setNameStr = [NSString stringWithFormat:@"set%@:",newKeyPath];
    SEL setSEL = NSSelectorFromString(setNameStr);
    
    Method getMethod = class_getInstanceMethod(self.class, @selector(keyPath));
    const char *type = method_getTypeEncoding(getMethod);
    // type 也可以直接写 @"v@:@"
    /*
     class : 给那个类添加方法
     SEL   : 方法编号
     IMP   : 方法实现
     type  : 返回值类型
     */
    class_addMethod(myClass, setSEL, (IMP)setMethod, type);
    
    // 3、修改isa指针,指向字类
    object_setClass(self, myClass);
    
    // 4、 保存 observer
    objc_setAssociatedObject(self, ALKVO_observer, observer, OBJC_ASSOCIATION_ASSIGN);
    // 保存 set、get 方法
    objc_setAssociatedObject(self, ALKVO_getter, keyPath, OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, ALKVO_setter, setNameStr, OBJC_ASSOCIATION_COPY_NONATOMIC);

}

void setMethod(id self, SEL _cmd, id newValue) {
    // 获取 set 、 get 方法
    NSString *setterStr = objc_getAssociatedObject(self, ALKVO_setter);
    NSString *getterStr = objc_getAssociatedObject(self, ALKVO_getter);
    
    // 保存子类类型
    Class class = [self class];
    
    //isa 指向原有的类 ,即父类
    object_setClass(self, class_getSuperclass(class));
    
    // 调用父类的 get 方法，获取 旧值
    id oldValue = objc_msgSend(self, NSSelectorFromString(getterStr));
    
    // 调用父类 set 方法
    objc_msgSend(self, NSSelectorFromString(setterStr), newValue);
    
    // 获取观察者
    id observer = objc_getAssociatedObject(self, ALKVO_observer);
    
    // 配置返回数据 change
    NSMutableDictionary *change = @{}.mutableCopy;
    if (newValue) {
        change[NSKeyValueChangeNewKey] = newValue;
    }
    if (oldValue) {
        change[NSKeyValueChangeOldKey] = oldValue;
    }
    
    objc_msgSend(observer, @selector(observeValueForKeyPath: ofObject: change: context:),getterStr, observer, change, nil);
    
    // isa 改回字类类型
    object_setClass(self, class);
}

@end
