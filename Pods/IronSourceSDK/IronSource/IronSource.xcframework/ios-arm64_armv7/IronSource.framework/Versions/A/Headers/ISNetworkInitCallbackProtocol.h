//
//  ISNetworkInitCallbackDelegate.h
//  IronSource
//
//  Created by Yonti Makmel on 17/05/2020.
//  Copyright © 2020 ironSource. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ISNetworkInitCallbackProtocol <NSObject>

- (void)onNetworkInitCallbackSuccess;
- (void)onNetworkInitCallbackFailed:(NSString*)errorMessage;
@optional
- (void)onNetworkInitCallbackLoadSuccess:(NSString*)placement;

@end

NS_ASSUME_NONNULL_END
