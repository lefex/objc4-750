//
//  Person+ViewModel.m
//  objc-test
//
//  Created by Wang,Suyan on 2019/2/26.
//

#import "Person+ViewModel.h"
#import <objc/runtime.h>

void ReportFunction(id self, SEL _cmd)
{
    NSLog(@"This object is %p.", self);
    NSLog(@"Class is %@, and super is %@.", [self class], [self superclass]);
    
    Class currentClass = [self class];
    for (int i = 1; i < 5; i++)
    {
        NSLog(@"Following the isa pointer %d times gives %p", i, currentClass);
        currentClass = object_getClass(currentClass);
    }
    
    NSLog(@"NSObject's class is %p", [NSObject class]);
    NSLog(@"NSObject's meta class is %p", object_getClass([NSObject class]));
}


@implementation Person (ViewModel)

+ (void)initialize {
    NSLog(@"🐥🐥[Person+ViewModel] initialize");
}

+ (void)load {
    NSLog(@"🐥🐥[Person+ViewModel] load");
    
    Class newClass =
    objc_allocateClassPair([NSError class], "RuntimeErrorSubclass", 0);
    class_addMethod(newClass, @selector(report), (IMP)ReportFunction, "v@:");
    objc_registerClassPair(newClass);
}


@end
