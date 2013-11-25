
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

#import "XPlayerSystemBootstrap.h"

@protocol XApplication;

@interface XPlayerSystemBootstrap()

/**
    创建默认启动的应用
    先尝试读取 default app根目录的app.xml, 如果有该文件就读取app info, 没有就创建默认的app info
    @returns 默认启动应用的实例
 */
- (id<XApplication>)createDefaultApp;

@end

