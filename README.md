# local_life_app

Local Message And Service App

## Getting Started
<!-- web打包 -->
flutter build web --web-renderer html 
<!-- 打包apk -->
flutter build apk --no-tree-shake-icons
<!-- 打包不同架构apk -->
flutter build apk --no-tree-shake-icons --target-platform android-arm,android-arm64,android-x64 --split-per-abi

<!-- model生成.g.dart文件 -->
(1)一次性编译： flutter packages pub run build_runner build
(2)后台自动编译： flutter packages pub run build_runner watch
flutter packages pub run build_runner clean
flutter packages pub run build_runner build --delete-conflicting-outputs
<!-- json_serializable 自动生成工具： -->
https://caijinglong.github.io/json2dart/index.html
<!-- 适配 -->
import 'package:flutter_screenutil/flutter_screenutil.dart';
<!-- 运行web -->
flutter run -d chrome --web-port=8080 --web-hostname=127.0.0.1
<!-- 接口地址 -->
https://apidoc-module-zlabs.doc.coding.io/#e5bc551c3336ef8cfcfb576b178994c3
<!--github地址-->
https://github.com/DuFengShuo/PetStoreApp.git
<!-- 蓝狐地址-->
https://lanhuapp.com/web/#/item/project/detailDetach?pid=0e41bcfa-667b-42b1-b6a4-fd58fae601c4&type=share_mark&teamId=d8deaa49-2acd-433b-9fa6-f3463b158481&project_id=0e41bcfa-667b-42b1-b6a4-fd58fae601c4&image_id=b83bf9bc-0fe2-4479-9bfd-a27a563070d7&fromEditor=true