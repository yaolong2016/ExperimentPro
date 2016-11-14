/*
 所有网络公共使用部分！
 使用时只需要注册消息监听就可以了，内不会自动完成连接和重连接.
 外网的状态变化也可以通过注册监听消息就可以完成。
 
 */

#import <Foundation/Foundation.h>
#import "GCDAsyncSocket.h"
#import "JSONKit.h"
#import "Reachability.h"

///服务器IP和端口号的设置
#define SERVICE_IP @"192.168.0.108"
#define SERVICE_PORT 54323
#define SERVICE_TIMEOUT 15
///当链接服务器失败后设置重复链接时间1s
#define SERVICE_RECONNECT_TIME 3

///消息处理通知名称
#define SERVICE_NOTIFICATION_NAME @"SERVICE_NOTIFICATION_NAME"
///网络数据传递消息
#define NETWORK_DATA_POST_NOTIFICATION @"NETWORK_DATA_POST_NOTIFICATION"
///外网连接状态监听 (默认情况下是有网络不会发送消息，当网络发生改变时才会发送消息)
#define INTERNET_STATE_LISTEN @"INTERNET_STATE_LISTEN"

typedef enum {
       ///返回网络数据为空
       RESULT_NULL,
       ///数据格式有问题
       RESULT_DATA_ERROR,
       ///数据访问成功
       RESULT_SUCCESS,
       ///没有网络或者连接不成功
       NETWORK_NOT,
       ///网络已连接
       NETWORK_CONN
}
///网络数据返回状态提示
NETWORK_TYPE;

///获取网络请求入口类
@interface Network : NSObject<GCDAsyncSocketDelegate> {

}

@property (nonatomic, strong) GCDAsyncSocket* socket;
///连接服务器状态(YES:连接;NO:断开)
@property (assign, nonatomic) BOOL netState;
@property (nonatomic, strong) Reachability *internetReachability;
///网络情况(默认的时候是连接的YES)
@property (nonatomic, assign) BOOL currentNetState;

///不能在外面直接调用
- (id) initWithNetwork:(dispatch_queue_t) gcdqueue;
///链接服务器 注意：当网络被连接时候，会自动连接服务器
- (void) connectSocket;
///数据为空的情况反馈
- (void) UserDataForNULL;
//--------------------------------------外部使用函数-------------------------------------
///初始化网络请求对象 注意：会自动连接网络，不需要再单独连接
+ (Network*) NetworkRequestObject:(dispatch_queue_t) gcd;
///发送网络请求
+ (void) SendNetworkRequest:(NSString*) sendData queue:(dispatch_queue_t) gcd ;

///注册接受消息通知 注意：在需要接受消息的页面添加一个接受消息通知就可以了，用完之后再移除通知；否者该页面还会继续接受通知
+ (void) RegisterMessagePostNotification:(id) object selector:(SEL) fun;
///移除接受消息通知
+ (void) UnrigisterMessagePostNotifcation:(id) object;

///断开网络请求
+ (void) CloseNetworkRequest;
///连接网络请求 注意：用户重复连接使用
+ (void) ConnectionNetworkRequest;

///注册外网网络状态监听
+ (void) RegisterInternetListener:(id) object selector:(SEL) fun;
///移除外网网络状态监听
+ (void) UnrigisterInternetListener:(id) object;

///移除网络网络对象当中的通知(释放app进程使用)
+ (void) RemoveLocalNotification;

///主动监测网络状态
+ (BOOL) UserClickGetNetwork;


@end
