import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list_clean_architecture/app_const.dart';
import 'package:to_do_list_clean_architecture/features/todo/presentation/pages/home.dart';
import 'features/authentication/presentation/pages/sign_in_page.dart';
import 'features/authentication/presentation/pages/sign_up_page.dart';

class OnGenerateRoute {
  static Route<dynamic> route(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case PageConst.signInPage:
        {
          return materialBuilder(widget: SignInPage());
          break;
        }
      case PageConst.signUpPage:
        {
          return materialBuilder(widget: SignUpPage());
          break;
        }
      case PageConst.addNotePage:
        {
          if (args is String) {
            return materialBuilder(
                widget: HomePage(
              uid: args,
            ));
          } else {
            return materialBuilder(
              widget: ErrorPage(),
            );
          }
          break;
        }
      default:
        return materialBuilder(widget: ErrorPage());
    }
  }
}

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("error"),
      ),
      body: Center(
        child: Text("error"),
      ),
    );
  }
}

MaterialPageRoute materialBuilder({required Widget widget}) {
  return MaterialPageRoute(builder: (_) => widget);
}
