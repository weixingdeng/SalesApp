## 一嗨销售App

### Cocoapods管理库
* pod 'AFNetworking', '~> 3.0'
* pod 'MJExtension'
* pod 'MJRefresh'
* pod 'IQKeyboardManager'
* pod 'Masonry'
* pod 'UMengAnalytics'
* pod 'FMDB'
* pod 'CocoaAsyncSocket'
* pod 'MBProgressHUD', '~> 1.0.0'
* pod 'Bugly'

### 第三方库


### 主要逻辑和埋的`💣`
* 登录 
	第一次进入加载登录视屏 以后进入跳过视屏
* 聊天
	* 本地缓存顶部菜单 以后可能要缓存所有的内容`💣`
	* socket封装成一个单例类 可能会有 `💣`
	
* 个人信息
	* 退出时候 要立即清除本地缓存 
	* 创建数据库使用的是单例,退出需要释放 要不然不会创建新的数据库.此处待以后需求复杂需要更改 `💣`

### 文件目录说明

* MobleSales
	* Apps(主程序)
		* EHIRootViewController 启动逻辑
		* EHIHomeViewController 主页 tabbar
		* Chat
			* EHIChatManager 消息数据库操作(增删改查)
			* EHIMessageStatusManager 消息发送状态管理
			* ChatDetail 聊天界面
			* ChatList 聊天列表界面
			
	* Utils
		* EHIMacros 宏定义
		* EHIEnumerate 全局枚举
		* EHIConstant 全局静态变量
		* SQLUtils 封装的数据库处理
	
	* Common(继承的公用基类或者整个项目用到的组件)
		* AppContext 程序公共参数 环境等
	* Extends(各种扩展 分类)
	
	* Frameworks
	
	* Launcher(启动视频页)
	
	* Resources(资源文件)
	
	* Services(网络请求http,socket)




