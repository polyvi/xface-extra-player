
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

//
//  XVersionLabelFactory.m
//
//

#import <xFace/XVersionLabelFactory.h>
#import <xFace/XConstants.h>
#import <xFace/XUtils.h>

#define  VERSION_LABEL_HEIGHT  50

#define  FACTOR_X              0.50
#define  FACTOR_Y              0.50

@implementation XVersionLabelFactory (XPlayer)

+ (id) createWithFrame:(CGRect)frame
{
    //version label 显示在xface logo的正下方
    UILabel *versionLabel = [[UILabel alloc] initWithFrame:CGRectMake(FACTOR_X * frame.size.width - 100, FACTOR_Y * frame.size.height + 25, FACTOR_X * frame.size.width + 100, VERSION_LABEL_HEIGHT)];

    [versionLabel setTextColor:[UIColor whiteColor]];
    [versionLabel setBackgroundColor:[UIColor clearColor]];
    NSString* versionInfo = [NSString stringWithFormat:@"version:%@",
                             [XUtils getPreferenceForKey:ENGINE_VERSION]];

    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString* bundleId = [NSString stringWithFormat:@"bundleId:%@", [bundle bundleIdentifier]];

    versionLabel.text = [NSString stringWithFormat:@"%@\n%@", versionInfo, bundleId];;
    versionLabel.numberOfLines = 0;
    return versionLabel;
}

@end
