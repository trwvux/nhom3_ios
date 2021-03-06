/*
 * Copyright 2017 Google
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "FirebaseDatabase/Sources/Core/Operation/FOperationSource.h"
#import "FirebaseDatabase/Sources/Core/FQueryParams.h"
#import "FirebaseDatabase/Sources/Core/Utilities/FPath.h"

@interface FOperationSource ()
@property(nonatomic, readwrite) BOOL fromUser;
@property(nonatomic, readwrite) BOOL fromServer;
@property(nonatomic, readwrite) BOOL isTagged;
@property(nonatomic, strong, readwrite) FQueryParams *queryParams;
@end

@implementation FOperationSource

@synthesize fromUser;
@synthesize fromServer;
@synthesize queryParams;

- (id)initWithFromUser:(BOOL)isFromUser
            fromServer:(BOOL)isFromServer
           queryParams:(FQueryParams *)params
                tagged:(BOOL)tagged {
    self = [super init];
    if (self) {
        self.fromUser = isFromUser;
        self.fromServer = isFromServer;
        self.queryParams = params;
        self.isTagged = tagged;
    }
    return self;
}

+ (FOperationSource *)userInstance {
    static FOperationSource *user = nil;
    static dispatch_once_t userToken;
    dispatch_once(&userToken, ^{
      user = [[FOperationSource alloc] initWithFromUser:YES
                                             fromServer:NO
                                            queryParams:nil
                                                 tagged:NO];
    });
    return user;
}

+ (FOperationSource *)serverInstance {
    static FOperationSource *server = nil;
    static dispatch_once_t serverToken;
    dispatch_once(&serverToken, ^{
      server = [[FOperationSource alloc] initWithFromUser:NO
                                               fromServer:YES
                                              queryParams:nil
                                                   tagged:NO];
    });
    return server;
}

+ (FOperationSource *)forServerTaggedQuery:(FQueryParams *)params {
    return [[FOperationSource alloc] initWithFromUser:NO
                                           fromServer:YES
                                          queryParams:params
                                               tagged:YES];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"FOperationSource { fromUser=%d, "
                                      @"fromServer=%d, queryId=%@, tagged=%d }",
                                      self.fromUser, self.fromServer,
                                      self.queryParams, self.isTagged];
}

@end
