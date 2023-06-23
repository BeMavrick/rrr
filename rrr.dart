import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class rrr extends StatefulWidget {
  const rrr({super.key});

  @override
  State<rrr> createState() => _rrrState();
}

class _rrrState extends State<rrr> {
  int selectedIndex = 0;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final List<Widget> pages = [
    homepage(),
    settingpage(),
    searchpage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              validator: (value) {
                if (value == null || value.isEmpty){
                  return 'Invalid Username';
                }
                return null;
              },
            ),
            TextFormField(
              controller: emailController,
              validator: (value) {
                if (value == null || value.isEmpty){
                  return 'Invalid Password';
                }
                return null;
              },
            ),
            ElevatedButton(onPressed: () {
              if (_formKey.currentState!.validate()){

              };
            }, child: Text('Click Me')),
          ],
        ),
      ),
      bottomNavigationBar: GNav(
        tabs: [
          GButton(icon: Icons.settings,
          text: 'setting',),
          GButton(icon: Icons.search,
            text: 'search',),
          GButton(icon: Icons.home,
            text: 'home',),
        ],
        selectedIndex: selectedIndex,
        onTabChange: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}
class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ListTile(tileColor: Colors.yellow,
            title: Text('Nihareeka'),
          ),
          ListTile(tileColor: Colors.green,
            title: Text('Nihareeka'),
          ),
          ListTile(tileColor: Colors.brown,
            title: Text('Nihareeka'),
          ),
          ListTile(tileColor: Colors.red,
            title: Text('Nihareeka'),
          ),
        ],
      ),
    );
  }
}
class settingpage extends StatefulWidget {
  const settingpage({super.key});

  @override
  State<settingpage> createState() => _settingpageState();
}

class _settingpageState extends State<settingpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 5,
          itemBuilder: (context, Index) {
          List<Color> tileColors = [
            Colors.purple,
            Colors.white,
          ];
          Color currentColor = tileColors[Index % tileColors.length];
          }
      ),
    );
  }
}
class searchpage extends StatefulWidget {
  const searchpage({super.key});

  @override
  State<searchpage> createState() => _searchpageState();
}

class _searchpageState extends State<searchpage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

