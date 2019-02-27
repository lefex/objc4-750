//
//  Person.h
//  objc-test
//
//  Created by Wang,Suyan on 2019/2/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

@property (nonatomic, strong, class) NSString *name;

+ (void)addName;
- (void)showName;

@end

NS_ASSUME_NONNULL_END
