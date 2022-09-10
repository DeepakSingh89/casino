import 'package:casino/ui/screens/casion_map_screen.dart';
import 'package:casino/ui/screens/community_screen.dart';
import 'package:casino/ui/styles/my_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'profile_screen.dart';

class MyBottomNavScreen extends StatefulWidget {
  const MyBottomNavScreen({Key? key}) : super(key: key);

  @override
  _MyBottomNavScreenState createState() => _MyBottomNavScreenState();
}

class _MyBottomNavScreenState extends State<MyBottomNavScreen> {
  // //int _page = 0;
  // GlobalKey _bottomNavigationKey = GlobalKey();

  // int _selectedIndex = 0;

  // final List<Map<String, Object>> _page = [
  //   {
  //     'page': ProfileScreen(),
  //     'title': 'Profile',
  //   },
  //   {
  //     'page': ProfileScreen(),
  //     'title': 'MyReports',
  //   },
  //   {
  //     'page': ProfileScreen(),
  //     'title': 'Community',
  //   },
  // ];

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  // }

  // @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();

  //   var selectedIndex = Get.arguments as int;
  //   print('_selectedIndex : ${_selectedIndex} : ');
  //   if (selectedIndex != null) {
  //     _selectedIndex = selectedIndex;
  //   }
  // }

  // void _onItemTapped(int index) {
  //   print('_onItemTapped : ${index}');
  //   setState(() {
  //     _selectedIndex = index;

  //     // Navigator.of(context).pushReplacementNamed(
  //     //     Constant.BOTTOM_NAVIGATION_NAME,
  //     //     arguments: _selectedIndex);
  //   });
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return
  //       // WillPopScope(
  //       //   onWillPop: () {
  //       //     print('WillPopScope');
  //       //     setState(() {
  //       //       if (_selectedIndex != 0) {
  //       //         Get.toNamed(MyRouter.bottomNav, arguments: 0);
  //       //         // Navigator.of(context)
  //       //         //     .pushReplacementNamed(MyRouter.bottomNav, arguments: 0);
  //       //       } else {
  //       //         SystemNavigator.pop();
  //       //       }
  //       //     });
  //       //   },
  //       //   child:

  //       Scaffold(
  //     body: Center(
  //       child: _page.isNotEmpty
  //           ? _page[_selectedIndex]['page']
  //           : const ProfileScreen(),
  //     ),
  //     bottomNavigationBar: BottomNavigationBar(
  //       unselectedItemColor: Color(0xFF6B6B6B),
  //       selectedItemColor: MyAppTheme.secondaryColor,
  //       currentIndex: _selectedIndex,
  //       onTap: _onItemTapped,
  //       type: BottomNavigationBarType.fixed,
  //       items: const <BottomNavigationBarItem>[
  //         BottomNavigationBarItem(
  //           icon: Icon(
  //             Icons.home,
  //           ),
  //           title: Text('Profile'),
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.book),
  //           title: Text('MyReports'),
  //           //label: 'Library',
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.live_tv),
  //           title: Text('Community'),
  //         ),
  //       ],
  //     ),
  //   );
  //   //);
  // }

  int _selectedIndex = 1;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    ProfileScreen(),
    CasionMapScreen(),
    CommunityScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  //Widget dumbbellIcon = Image.asset(name);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        // unselectedItemColor: Color(0xFF6B6B6B),
        selectedItemColor: Colors.white,
        backgroundColor: MyAppTheme.gradientColorTop,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: const Icon(Icons.person_outline_rounded),
            label: 'Profile'.tr,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.document_scanner),
            label: 'MyReports'.tr,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.school),
            label: 'Community'.tr,
          ),
        ],
        currentIndex: _selectedIndex,

        onTap: _onItemTapped,
      ),
    );
  }
}
