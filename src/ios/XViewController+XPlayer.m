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
//  XViewController+XPlayer.m
//
//

#import <xFace/XViewController.h>
#import <xFace/XConstants.h>
#import <xFace/XApplication.h>
#import <xFace/XAppInfo.h>

@implementation XViewController (XPlayer)

#pragma mark UIWebViewDelegate

- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [super webView:webView didFailLoadWithError:error];

    NSString *urlStr = [[NSURL URLWithString:[error.userInfo objectForKey:@"NSErrorFailingURLStringKey"]] absoluteString];
    if (![urlStr rangeOfString:[NSString stringWithFormat:@"%@%@%@", DEFAULT_APP_ID_FOR_PLAYER, FILE_SEPARATOR, [[[self ownerApp] appInfo] entry]]].length) {
        return;
    }

    self.loadFromString = YES;

    NSString *loadErr = [NSString stringWithFormat:@"%@:<br/>%@<br/>%@:<br/>%@<br/><br/>%@", NSLocalizedString(@"Failed to load webpage", nil), urlStr, NSLocalizedString(@"with error", nil), [error localizedDescription], NSLocalizedString(@"Please copy your app source code to 'Documents/xface_player/apps/helloxface/'!", nil)];
    if(IsAtLeastiOSVersion(@"7.0")){
        loadErr = [NSString stringWithFormat:@"<br/>%@", loadErr];
    }

    NSString *html = [NSString stringWithFormat:@"<html><head><meta name='viewport' content='width=device-width, user-scalable=no' /></head><body> %@ </body></html>", loadErr];
    [self.webView loadHTMLString:html baseURL:nil];
}

@end