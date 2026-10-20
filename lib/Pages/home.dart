import 'package:flutter/material.dart';
import 'package:onlinetranslator/Pages/Firstpage.dart';
import 'package:onlinetranslator/Pages/Secondpage.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

const tab_style = TextStyle(
  fontFamily: "Irs",
  fontSize: 14,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

const title_style = TextStyle(
  fontFamily: "Irs",
  fontSize: 18,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

const menu_style = TextStyle(
  fontFamily: "Irs",
  fontSize: 14,
  fontWeight: FontWeight.normal,
  color: Colors.black,
);

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      home: Directionality(
        textDirection: TextDirection.rtl,
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              title: Padding(
                padding: EdgeInsets.only(top: 4, right: 0),
                child: Text("مترجم آنلاین", style: title_style),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    // code to write
                  },
                  icon: Icon(Icons.more_vert),
                ),
              ],

              leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    onPressed: () {
                      // code to write
                      Scaffold.of(context).openDrawer();
                    },
                    icon: Icon(Icons.menu, size: 28),
                  );
                },
              ),

              bottom: TabBar(
                labelStyle: tab_style,
                unselectedLabelStyle: tab_style,
                //labelColor: Colors.white,
                //unselectedLabelColor: Colors.white,
                tabs: [
                  Tab(text: "مترجم متون آنلاین", icon: Icon(Icons.home)),
                  Tab(text: "تشخیص کلمات", icon: Icon(Icons.visibility)),
                ],
              ),
            ),

            body: TabBarView(
              children: [
                //page1
                First(),

                //page2
                Second(),
              ],
            ),

            drawer: Drawer(
              child: ListView(
                children: [
                  UserAccountsDrawerHeader(
                    accountName: Text(''),
                    accountEmail: Text("مترجم آنلاین", style: tab_style),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: AssetImage("assets/Logo.png"),
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      //code to write
                    },
                    child: ListTile(
                      title: Text("درباره ما", style: menu_style),
                      leading: Icon(Icons.info),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      //code to write
                    },
                    child: ListTile(
                      title: Text("ارتباط با ما", style: menu_style),
                      leading: Icon(Icons.telegram),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      //code to write
                    },
                    child: ListTile(
                      title: Text("ثبت نظر", style: menu_style),
                      leading: Icon(Icons.star_rate),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      //code to write
                    },
                    child: ListTile(
                      title: Text("سایر برنامه ها", style: menu_style),
                      leading: Icon(Icons.app_shortcut),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      //code to write
                    },
                    child: ListTile(
                      title: Text("اشتراک برنامه", style: menu_style),
                      leading: Icon(Icons.share),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      //code to write
                    },
                    child: ListTile(
                      title: Text("خروج از برنامه", style: menu_style),
                      leading: Icon(Icons.exit_to_app),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

