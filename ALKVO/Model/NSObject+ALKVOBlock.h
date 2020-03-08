//
//  NSObject+ALKVOBlock.h
//  ALKVO
//
//  Created by 李丽 on 2020/2/23.
//  Copyright © 2020 李丽. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ALKVOBlock)(NSDictionary *change);

@interface NSObject (ALKVOBlock)

- (void)al_observerKeyPath: (NSString *)keyPath options:(NSKeyValueObservingOptions)options block:(ALKVOBlock)block;

@end

NS_ASSUME_NONNULL_END
