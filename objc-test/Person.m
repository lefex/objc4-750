//
//  Person.m
//  objc-test
//
//  Created by Wang,Suyan on 2019/2/26.
//

#import "Person.h"
#import <objc/runtime.h>

static NSString *_name;

@interface NSObject(Sark)
+(void)foo;
@end
@implementation NSObject(Sark)
- (void)foo {
    NSLog(@"runtime - [IMP NSObject foo]");
}
@end


@implementation Person

+ (void)initialize {
    NSLog(@"🐥🐥[Person] initialize");
}

+ (void)load {
    NSLog(@"🐥🐥[Person] load");
    Class cls = objc_getClass("Person");
    Method orgMethod = class_getInstanceMethod(cls, NSSelectorFromString(@"showName"));
    Method hookMethod = class_getInstanceMethod(cls, NSSelectorFromString(@"showName_hook"));
    BOOL isAdded = class_addMethod(cls, NSSelectorFromString(@"showName_hook"), method_getImplementation(hookMethod), method_getTypeEncoding(hookMethod));
    if (!isAdded) {
        method_exchangeImplementations(orgMethod, hookMethod);
    }
}

+ (void)setName:(NSString *)name {
    _name = name;
}

+ (NSString *)name {
    return _name;
}

- (void)showName {
    NSLog(@"Person [-showName orgin] called");
}

- (void)showName_hook {
    NSLog(@"Person [-showName hook] called");
}

+ (void)addName {
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self testRuntime1];
        
        [NSObject foo];
        [[NSObject new] foo];
        
        id cls = [Person class];
        void *obj = &cls;
        [(__bridge id)obj showName];
    }
    return self;
}

- (void)testRuntime1 {
    BOOL res1 = [(id)[NSObject class] isKindOfClass:[NSObject class]];
    BOOL res2 = [(id)[NSObject class] isMemberOfClass:[NSObject class]];
    BOOL res3 = [(id)[Person class] isMemberOfClass:[Person class]];
    BOOL res4 = [(id)[Person class] isMemberOfClass:[Person class]];
    NSLog(@"runtime - %@ - %@ - %@ - %@", @(res1), @(res2), @(res3), @(res4));
}

@end





