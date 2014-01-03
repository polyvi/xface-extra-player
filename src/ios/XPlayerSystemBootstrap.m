
/*
 This file was modified from or inspired by Apache Cordova.

 Licensed to the Apache Software Foundation (ASF) under one
 or more contributor license agreements. See the NOTICE file
 distributed with this work for additional information
 regarding copyright ownership. The ASF licenses this file
 to you under the Apache License, Version 2.0 (the
 "License"); you may not use this file except in compliance
 with the License. You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing,
 software distributed under the License is distributed on an
 "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 KIND, either express or implied. See the License for the
 specific language governing permissions and limitations
 under the License.
*/

#import <xFace/XConfiguration.h>
#import <xFace/XAppManagement.h>
#import <xFace/XAppList.h>
#import <xFace/XApplication.h>
#import <xFace/XAppInfo.h>
#import <xFace/XUtils.h>
#import <xFace/XConstants.h>
#import <xFace/XApplicationFactory.h>
#import "XPlayerSystemBootstrap.h"
#import "XPlayerSystemBootstrap_Privates.h"

@implementation XPlayerSystemBootstrap

@synthesize bootDelegate;

/**
    启动之前的准备工作
 */
-(void) prepareWorkEnvironment
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kAppVersionUUIDKey];
    [[NSUserDefaults standardUserDefaults] synchronize];

    [[XConfiguration getInstance] prepareSystemWorkspace];
    BOOL ret = [XUtils copyJsCore];
    if (ret)
    {
        [[self bootDelegate] didFinishPreparingWorkEnvironment];
    }
    else
    {
        NSDictionary *errorDictionary = @{ NSLocalizedDescriptionKey : @"Failed to prepare work environment!"};
        NSError *anError = [[NSError alloc] initWithDomain:@"xface" code:0 userInfo:errorDictionary];
        [[self bootDelegate] didFailToPrepareEnvironmentWithError:anError];
    }
}

#pragma mark XSyncDelegate

-(void) boot:(XAppManagement*)appManagement
{
    //清空所有缓存的response数据
    [[NSURLCache sharedURLCache] removeAllCachedResponses];

    id<XApplication> app = [self createDefaultApp];

    XAppList *appList = [appManagement appList];
    [appList add:app];
    [appList markAsDefaultApp:[app getAppId]];

    NSString *params = [[self bootDelegate] bootParams];
    [appManagement startDefaultAppWithParams:params];
}

- (id<XApplication>)createDefaultApp
{
    NSString *appRoot = [[[XConfiguration getInstance] appInstallationDir] stringByAppendingPathComponent:DEFAULT_APP_ID_FOR_PLAYER];
    NSString *appConfigFilePath = [appRoot stringByAppendingPathComponent:APPLICATION_CONFIG_FILE_NAME];
    XAppInfo* info = [XUtils getAppInfoFromConfigFileAtPath:appConfigFilePath];

    if (info == nil) {
        info = [[XAppInfo alloc] init];
        info.isEncrypted = NO;
        info.entry = DEFAULT_APP_START_PAGE;
        info.type = APP_TYPE_XAPP;
    }

    info.appId = DEFAULT_APP_ID_FOR_PLAYER;
    return [XApplicationFactory create:info];
}

@end
