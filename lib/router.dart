import 'package:blog_mag/views/add_post.dart';
import 'package:blog_mag/views/auth_screen.dart';
import 'package:blog_mag/views/chats/chat_screen.dart';
import 'package:blog_mag/views/chats/chats_screen.dart';
import 'package:blog_mag/views/edit_post.dart';
import 'package:blog_mag/views/home_screen.dart';
import 'package:blog_mag/views/auth/login_screen.dart';
import 'package:blog_mag/views/no_connection.dart';
import 'package:blog_mag/views/preofile_screen.dart';
import 'package:blog_mag/views/auth/register_screen.dart';
import 'package:blog_mag/views/requests_screen.dart';
import 'package:blog_mag/views/routing.dart';
import 'package:blog_mag/views/search_screen.dart';
import 'package:blog_mag/views/settings_screen.dart';
import 'package:blog_mag/views/show_img.dart';
import 'package:blog_mag/views/show_screen.dart';
import 'package:blog_mag/views/user_profile_screen.dart';
import 'package:get/get.dart';

List<GetPage<dynamic>> getPages = [
  GetPage(
    name: AuthScreen.routeName,
    page: () => const AuthScreen(),
  ),
  GetPage(
    name: LoginScreen.routeName,
    page: () => LoginScreen(),
  ),
  GetPage(
    name: RegisterScreen.routeName,
    page: () => RegisterScreen(),
  ),
  GetPage(
    name: RoutingLayout.routeName,
    page: () => RoutingLayout(),
  ),
  GetPage(
    name: HomeScreen.routeName,
    page: () => HomeScreen(),
  ),
  GetPage(
    name: ProfileScreen.routeName,
    page: () => const ProfileScreen(),
  ),
  GetPage(
    name: UserProfileScreen.routeName,
    page: () => UserProfileScreen(),
  ),
  GetPage(
    name: SettingsScreen.routeName,
    page: () => SettingsScreen(),
  ),
  GetPage(
    name: ShowScreen.routeName,
    page: () => ShowScreen(),
  ),
  GetPage(
    name: SearchScreen.routeName,
    page: () => const SearchScreen(),
  ),
  GetPage(
    name: ShowImage.routeName,
    page: () => const ShowImage(),
  ),
  GetPage(
    name: AddPostScreen.routeName,
    page: () => AddPostScreen(),
  ),
  GetPage(
    name: EditPostScreen.routeName,
    page: () => EditPostScreen(),
  ),
  GetPage(
    name: RequestsScreen.routeName,
    page: () => RequestsScreen(),
  ),
  GetPage(
    name: NoConnection.routeName,
    page: () => NoConnection(),
  ),
  GetPage(
    name: ChatsScreen.routeName,
    page: () => ChatsScreen(),
  ),
  GetPage(
    name: ChatScreen.routeName,
    page: () => ChatScreen(),
  ),
];
