//
//  NSObject+ALKVOBlock.m
//  ALKVO
//
//  Created by 李丽 on 2020/2/23.
//  Copyright © 2020 李丽. All rights reserved.
//

#import "NSObject+ALKVOBlock.h"
#import <objc/message.h>

static const char *ALKVOBlock_getter = "ALKVOBlock_getter";
static const char *ALKVOBlock_setter = "ALKVOBlock_setter";
static const char *ALKVOBlock_block = "ALKVOBlock_block";


@implementation NSObject (ALKVOBlock)

- (void)al_observerKeyPath: (NSString *)keyPath options:(NSKeyValueObservingOptions)options block:(ALKVOBlock)block{
    // 1、创建一个字类
    NSString *oldName = NSStringFromClass(self.class);
    NSString *newName = [@"NSKVOBlockNotyfing_" stringByAppendingString:oldName];
    
    Class myClass = objc_getClass(newName.UTF8String);
    if (myClass == nil) {
        /* 创建子类
         superclass : 父类
         name       : 新类的名字
        */
        myClass = objc_allocateClassPair(self.class, newName.UTF8String, 0);
        objc_registerClassPair(myClass);
    }
    
    

    /* 重写Set方法
     class cls  : 新建的子类
     SEL name   : 重写的方法的名字 ，此处是 set 方法
     IMP imp    : 添加的方法
     type       :
     */
    NSString *newKeyPath = [[[keyPath substringToIndex:1] uppercaseString] stringByAppendingString:[keyPath substringFromIndex:1]];
    NSString *setterStr = [NSString stringWithFormat:@"set%@:", newKeyPath];
    SEL sel = NSSelectorFromString(setterStr);
    
    Method getMethod = class_getInstanceMethod([self class], @selector(keyPath));
    const char * types = method_getTypeEncoding(getMethod);
    class_addMethod(myClass, sel, (IMP)setterMethod, types);
   
    // 改变 isa 指针， 指向子类
    object_setClass(self, myClass);
    
    // 保存 set 、 get、 block
    objc_setAssociatedObject(self, ALKVOBlock_getter, keyPath, OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, ALKVOBlock_setter, setterStr, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    objc_setAssociatedObject(self, ALKVOBlock_block, block, OBJC_ASSOCIATION_COPY);
}

void setterMethod(id self, SEL _cmd, id newValue) {
    // 获取 set、get 方法名
    NSString *setterStr = objc_getAssociatedObject(self, ALKVOBlock_setter);
    NSString *getterStr = objc_getAssociatedObject(self, ALKVOBlock_getter);
    
    // 保存子类class
    Class class = [self class];
    
    // isa指针指向父类
    object_setClass(self, class_getSuperclass(class));
    
    // 执行父类 get 方法，获取 旧值
    id oldValue = objc_msgSend(self, NSSelectorFromString(getterStr));
    
    // 执行父类 set 方法
    objc_msgSend(self, NSSelectorFromString(setterStr), newValue);
    
    // 配置返回 数据 - change
    NSMutableDictionary *change = @{}.mutableCopy;
    if (newValue) {
        change[NSKeyValueChangeNewKey] = newValue;
    }
    if (oldValue) {
        change[NSKeyValueChangeOldKey] = oldValue;
    }
    
    ALKVOBlock block = objc_getAssociatedObject(self, ALKVOBlock_block);
    if (block) {
        block(change);
    }

    // isa 指针 指向字类类型
    object_setClass(self, class);
}


@end
