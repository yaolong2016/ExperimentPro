//
//  Network.m
//  zxSocket
//
//  Created by yaolong on 16/11/10.
//  Copyright © 2016年 张玺. All rights reserved.
//

#import "Network.h"

///全局网络请求头
static Network* networkRequest_m;

@interface Network()

///用户控制开关，当用户关闭时显示为YES，当用户打开时显示是NO（默认为NO）
@property (nonatomic,assign) BOOL userClick;

- (void)checkNetworkState;

@end

@implementation Network
@synthesize socket;
@synthesize netState;
@synthesize currentNetState;

- (id) initWithNetwork:(dispatch_queue_t)gcdqueue {
    if (self = [super init]) {
        if (self.socket == nil) {
            self.currentNetState = YES;
            self.netState = NO;
            self.userClick = NO;
            self.socket = [[GCDAsyncSocket alloc] initWithDelegate:self
                                                     delegateQueue:gcdqueue];
            
            [self performSelector:@selector(connectSocket)
                       withObject:self
                       afterDelay:0];
            
            [Network RemoveLocalNotification];
            
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(TemDataSend:)
                                                         name:SERVICE_NOTIFICATION_NAME
                                                       object:nil];
            
            
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(reachabilityChanged:)
                                                         name:kReachabilityChangedNotification
                                                       object:nil];
            
            self.internetReachability = [Reachability reachabilityForInternetConnection];
            [self.internetReachability startNotifier];
            
            [self checkNetworkState];
        }
    }
    return self;
}
- (void)checkNetworkState {
     // 检测手机是否能上网络(WIFI\3G\2.5G)
     Reachability *conn = [Reachability reachabilityForInternetConnection];
     if ([conn currentReachabilityStatus] != NotReachable) {
         NSLog(@"有网络");
         self.currentNetState = YES;
         [[NSNotificationCenter defaultCenter] postNotificationName:INTERNET_STATE_LISTEN
                                                             object:@{@"code":[NSString stringWithFormat:@"%d",NETWORK_CONN],@"description":@"连接外网网络"}];
     }else { // 没有网络
         NSLog(@"没网络");
         self.currentNetState = NO;
         [[NSNotificationCenter defaultCenter] postNotificationName:INTERNET_STATE_LISTEN
                                                             object:@{@"code":[NSString stringWithFormat:@"%d",NETWORK_NOT],@"description":@"没有连接外网网络"}];
     }
}

+ (void) RemoveLocalNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:SERVICE_NOTIFICATION_NAME
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kReachabilityChangedNotification
                                                  object:nil];
    [[self class] cancelPreviousPerformRequestsWithTarget:networkRequest_m
                                                 selector:@selector(disconnectReconn)
                                                   object:nil];
}

- (void) reachabilityChanged:(NSNotification *)note
{
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    NetworkStatus netStatus = [curReach currentReachabilityStatus];
    
    switch (netStatus)
    {
        case NotReachable:        {
            NSLog(@"没有网络");
            self.currentNetState = NO;
            [[NSNotificationCenter defaultCenter] postNotificationName:INTERNET_STATE_LISTEN
                                                                object:@{@"code":[NSString stringWithFormat:@"%d",NETWORK_NOT],@"description":@"没有连接网络"}];
            break;
        }
        case ReachableViaWWAN:        {
            NSLog(@"手机自带网络");
            self.currentNetState = YES;
            [self connectSocket];
            [[NSNotificationCenter defaultCenter] postNotificationName:INTERNET_STATE_LISTEN
                                                                object:@{@"code":[NSString stringWithFormat:@"%d",NETWORK_CONN],@"description":@"连接WWAN网络"}];
            break;
        }
        case ReachableViaWiFi:        {
            NSLog(@"连接Wi-Fi");
            self.currentNetState = YES;
            [self connectSocket];
            [[NSNotificationCenter defaultCenter] postNotificationName:INTERNET_STATE_LISTEN
                                                                object:@{@"code":[NSString stringWithFormat:@"%d",NETWORK_NOT],@"description":@"连接Wi-Fi网络"}];

            break;
        }
    }
}

- (void) TemDataSend:(NSNotification*) data {

    NSDictionary* userInfo = [data object];
    if (userInfo) {
        NSString* userData = [userInfo objectForKey:@"data"];
        if (userData) {
            [self.socket writeData:[userData dataUsingEncoding:NSUTF8StringEncoding]
                       withTimeout:-1
                               tag:0];
            [self.socket readDataWithTimeout:-1 tag:0];
        } else {
            [self UserDataForNULL];
        }
    } else {
        [self UserDataForNULL];
    }
    
}

- (void) RemoveNetworkStateListen {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
}

+ (Network*) NetworkRequestObject:(dispatch_queue_t)gcd {
    if (!networkRequest_m) {
        Network* obj = [[Network alloc] initWithNetwork:gcd];
        networkRequest_m = obj;
    }
    return networkRequest_m;
}

+ (void) SendNetworkRequest:(NSString *)sendData queue:(dispatch_queue_t) gcd {
    if (sendData) {
        [[NSNotificationCenter defaultCenter] postNotificationName:SERVICE_NOTIFICATION_NAME
                                                            object:@{@"data":sendData}];
    } else {
        [Network PostMessage:@{@"description":@"数据为空",@"code":[NSString stringWithFormat:@"%d",RESULT_NULL]}];
    }
}


- (void) connectSocket {
    if (!_userClick) {
        if (!self.netState) {
            NSError* error;
            self.netState = NO;
            if (self.currentNetState) {
                if (self.socket) {
                    if ([self.socket connectToHost:SERVICE_IP onPort:SERVICE_PORT error:&error]) {
                        NSLog(@"创建成功");
                    }
                    
                    if (![self.socket isConnected]) {
                        self.netState = NO;
                        [Network PostMessage:@{@"description":@"没有连接网络",@"code":[NSString stringWithFormat:@"%d",NETWORK_NOT]}];
                        NSLog(@"%@", [NSString stringWithFormat:@"链接失败,%d秒后重连\n[错误原因：%@]",SERVICE_RECONNECT_TIME,[error description]]);
                    }
                }
            } else {
                [Network PostMessage:@{@"description":@"没有连接网络",@"code":[NSString stringWithFormat:@"%d",NETWORK_NOT]}];
                NSLog(@"没有连接到外网");
            }
        }
    }
}

-(void) disconnectReconn {
    [self connectSocket];
}

#pragma socketdelegate

-(void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    if ([sock isConnected]) {
        self.netState = YES;
        [Network PostMessage:@{@"description":@"数据格式有问题",@"code":[NSString stringWithFormat:@"%d",NETWORK_CONN],@"data":@{}}];
        NSLog(@"已成功连接服务器");
    }
    [socket readDataWithTimeout:-1 tag:0];
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
    self.netState = NO;
    [self performSelector:@selector(disconnectReconn)
               withObject:self
               afterDelay:SERVICE_RECONNECT_TIME];
    NSLog(@"断开服务器连接");
}

-(void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    if (data) {
        NSString *newMessage = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if (newMessage) {
            NSDictionary* newdata = [newMessage objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode];
            if (newdata) {
                [Network PostMessage:@{@"description":@"数据格式有问题",@"code":[NSString stringWithFormat:@"%d",RESULT_SUCCESS],@"data":newdata}];
            } else {
                [Network PostMessage:@{@"description":@"数据格式有问题",@"code":[NSString stringWithFormat:@"%d",RESULT_DATA_ERROR]}];
            }
        } else {
            [Network PostMessage:@{@"description":@"数据格式有问题",@"code":[NSString stringWithFormat:@"%d",RESULT_DATA_ERROR]}];
        }
    } else {
        [self UserDataForNULL];
    }
//    
    [socket readDataWithTimeout:-1 tag:0];
}


- (void) UserDataForNULL {
    [Network PostMessage:@{@"description":@"数据为空",@"code":[NSString stringWithFormat:@"%d",RESULT_NULL]}];
}

+ (void) RegisterMessagePostNotification:(id)object selector:(SEL)fun{
    [Network UnrigisterMessagePostNotifcation:object];
    [[NSNotificationCenter defaultCenter] addObserver:object
                                             selector:fun
                                                 name:NETWORK_DATA_POST_NOTIFICATION
                                               object:nil];
}


+ (void) UnrigisterMessagePostNotifcation:(id)object {
    [[NSNotificationCenter defaultCenter] removeObserver:object
                                                    name:NETWORK_DATA_POST_NOTIFICATION
                                                  object:nil];
}

+ (void) PostMessage:(NSDictionary*) info {
    [[NSNotificationCenter defaultCenter] postNotificationName:NETWORK_DATA_POST_NOTIFICATION
                                                        object:info];

}

+ (void) CloseNetworkRequest {
    if (networkRequest_m) {
        networkRequest_m.userClick = YES;
        if (networkRequest_m.socket.isConnected) {
            [networkRequest_m.socket disconnect];
        }
    }
}

+ (void) ConnectionNetworkRequest {
    if (networkRequest_m) {
        networkRequest_m.userClick = NO;
        if (networkRequest_m.socket) {
            if (!networkRequest_m.socket.isConnected) {
                [networkRequest_m connectSocket];
            }
        }
    }
}

+ (void) RegisterInternetListener:(id) object selector:(SEL) fun{
    [Network UnrigisterInternetListener:object];
    [[NSNotificationCenter defaultCenter] addObserver:object
                                             selector:fun
                                                 name:INTERNET_STATE_LISTEN
                                               object:nil];
}

+ (void) UnrigisterInternetListener:(id) object {
    [[NSNotificationCenter defaultCenter] removeObserver:object
                                                    name:INTERNET_STATE_LISTEN
                                                  object:nil];
}

+ (BOOL) UserClickGetNetwork {
    if (networkRequest_m) {
        [networkRequest_m checkNetworkState];
        return networkRequest_m.currentNetState;
    }else {
        NSLog(@"请先初始化网络请求对象");
        return NO;
    }
}

@end
