//
//  main.m
//  objc-test
//
//  Created by GongCF on 2018/12/16.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>
#import "Person.h"
#import "Man.h"

void TagFunctiion(id self, SEL _cmd) {
    NSLog(@"%@ - %@", self, @"I am women");
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Class newClass = objc_allocateClassPair(objc_getClass("Person"), "newClass", 0);
                objc_registerClassPair(newClass);
        Person *person = [[newClass alloc]init];
        [person showName];
        
        Person.name = @"Lefex class pro";
        [Person addName];
        
        NSLog(@"%@",person);
        NSLog(@"Person.name: %@", Person.name);
        
        // 打印类的继承关系，对象模型
        NSLog(@"========================================");
        Person *lefex = [[Person alloc] init];
        NSLog(@"This object is %p.", lefex);
        NSLog(@"Class is %@, and super is %@.", [lefex class], [lefex superclass]);
        
        Class currentClass = [lefex class];
        for (int i = 1; i < 5; i++)
        {
            NSLog(@"Following the isa pointer %d times gives %@ - %p, super: %@", i, currentClass, currentClass, [currentClass superclass]);
            currentClass = object_getClass(currentClass);
        }
        
        NSLog(@"NSObject's class is %p", [NSObject class]);
        NSLog(@"NSObject's meta class is %p", object_getClass([NSObject class]));
        NSLog(@"========================================");
        
        // 创建一个 Women 类，父类为 Person
        Class women = objc_allocateClassPair(objc_getClass("Person"), "Women", 0);
        // 添加一个方法 tag
        class_addMethod(women, NSSelectorFromString(@"tag"), (IMP)TagFunctiion, "v@:");
        objc_registerClassPair(women);
        
        // 执行刚才添加的方法
        Class aWomenClass = objc_getClass("Women");
        NSObject *womenObj = [[aWomenClass alloc] init];
        [womenObj performSelector:NSSelectorFromString(@"tag")];
        
        
        NSLog(@"============================= Object Model");
        /// 对象模型
        /**
         Man类 -> Person类 -> NSObject 类
         */
        Man *man = [[Man alloc] init];
        Class man_meta = objc_getMetaClass("Man");
        NSLog(@"man: %@(%p), %@", man, man, man_meta);
        // Person
        Class sup1_man = [man superclass];
        NSLog(@"sup1_man: %@(%p)", sup1_man, sup1_man);
        // NSObject
        Class sup2_man = [sup1_man superclass];
        NSLog(@"sup2_man: %@(%p)", sup2_man, sup2_man);
        Class sup3_man = [sup2_man superclass];
        // null
        NSLog(@"sup3_man: %@(%p)", sup3_man, sup3_man);
        
        
        NSLog(@"============================= Object Model");
    }
    return 0;
}
