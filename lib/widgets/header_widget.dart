import 'package:event_planner/view/core/home_view.dart';
import 'package:event_planner/view/settings/profile_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class HeaderWidget extends StatefulWidget
    implements ObstructingPreferredSizeWidget {
  const HeaderWidget({super.key});

  @override
  _HeaderWidgetState createState() => _HeaderWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  bool shouldFullyObstruct(BuildContext context) => false;
}

class _HeaderWidgetState extends State<HeaderWidget> {
  User? _user;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;

    // Listen to user updates
    FirebaseAuth.instance.userChanges().listen((user) {
      setState(() {
        _user = user;
      });
    });
  }

  TextStyle _textStyle({
    Color color = const Color.fromRGBO(255, 255, 255, 1),
    double fontSize = 17,
    FontWeight fontWeight = FontWeight.w400,
    double height = 1.2,
    double letterSpacing = -0.43,
  }) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: false,
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context, rootNavigator: true).push(
                      CupertinoPageRoute(
                          builder: (context) => const HomeView()));
                },
                child: Image.asset(
                  'assets/images/clave_de_sol.jpg',
                  width: 40,
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    "CJSP Event Planner",
                    style: _textStyle(
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromRGBO(255, 255, 255, 1),
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: CupertinoColors.white,
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(width: 1, color: CupertinoColors.white),
                ),
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Navigator.of(context).push(
                      CupertinoPageRoute(builder: (_) => ProfileView()),
                    );
                  },
                  child: ClipOval(
                    child: (_user?.photoURL?.isEmpty ?? true)
                        ? Image.asset(
                            'assets/images/profile_pic_placeholder.jpg',
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            _user!.photoURL!,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
