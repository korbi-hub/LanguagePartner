import 'package:auto_route/auto_route.dart';
import 'package:hackaburg_project/chat/view/chat.dart';
import 'package:hackaburg_project/chat_list/view/chat_list.dart';
import 'package:hackaburg_project/vocabulary/view/vocabulary.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Page,Route,Screen',
  routes: <AutoRoute>[
    //user routes with a nested router
    AutoRoute(
      path: '/chats',
      page: ChatList,
      children: [
        AutoRoute(path: '', page: ChatList),
        AutoRoute(path: 'chat', page: Chat),
        AutoRoute(path: 'vocabulary', page: Vocabulary),
        // redirect all other paths
        RedirectRoute(path: '*', redirectTo: 'profile'),
      ],
    ),
    // redirect all other paths
    RedirectRoute(path: '*', redirectTo: '/chats'),
    //Home
  ],
)

class $AppRouter {}
