//
//  Man.m
//  objc-test
//
//  Created by Wang,Suyan on 2019/2/26.
//

#import "Man.h"

@implementation Man

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"runtime [self class] - %@ - %@", NSStringFromClass([self class]));
        NSLog(@"runtime [super class] - %@", NSStringFromClass([super class]));
        [super showName];
    }
    return self;
}

/*
 static instancetype _I_Man_init(Man * self, SEL _cmd) {
 self = ((Man *(*)(__rw_objc_super *, SEL))(void *)objc_msgSendSuper)((__rw_objc_super){(id)self, (id)class_getSuperclass(objc_getClass("Man"))}, sel_registerName("init"));
 
 
 if (self) {
 NSLog((NSString *)&__NS_9adba5_mi_0, NSStringFromClass(((Class (*)(id, SEL))(void *)objc_msgSend)((id)self, sel_registerName("class"))));
 
 NSLog((NSString *)&__NS_9adba5_mi_1, NSStringFromClass(((Class (*)(__rw_objc_super *, SEL))(void *)objc_msgSendSuper)((__rw_objc_super){(id)self, (id)class_getSuperclass(objc_getClass("Man"))}, sel_registerName("class"))));
 
 ((void (*)(__rw_objc_super *, SEL))(void *)objc_msgSendSuper)((__rw_objc_super){(id)self, (id)class_getSuperclass(objc_getClass("Man"))}, sel_registerName("showName"));
 }
 return self;
 }
 ***/

+ (void)initialize {
    NSLog(@"🐥🐥[Man] initialize");
}

+ (void)load {
    NSLog(@"🐥🐥[Man] load");
}

@end
