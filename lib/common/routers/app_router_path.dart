enum AppRouterPath {
  splashPage(path: '/splash_page', description: '闪屏页'),
  example(path: '/example', description: '示例'),
  exampleTickPage(path: '/example_tick_page', description: '示例-滴答'),
  exampleAddData(path: '/example_add_data', description: '示例-添加数据'),
  example6(path: '/example_6', description: '示例-6'),
  setting(path: '/setting', description: '设置'),
  mqttPage(path: '/mqtt_page', description: 'mqtt页面'),
  loginPage(path: '/login_page', description: '登录页面'),
  home(path: '/home', description: '主页'),
  admin(path: '/admin', description: 'Admin页面'),
  listExample1(path: '/list_example_1', description: '测试List');

  const AppRouterPath({
    required this.path,
    required this.description,
  });

  ///路由路径解释
  final String description;

  ///路由路径
  final String path;
}
