import 'package:flutter/material.dart';
import 'dart:async';

import 'package:software_studio_project/page/page_note.dart';
import 'package:software_studio_project/page/page_home.dart';
import 'package:software_studio_project/page/page_assist.dart';
import 'package:software_studio_project/page/page_add.dart';
import 'package:software_studio_project/page/page_profile.dart';
import 'package:software_studio_project/global.dart';
import 'package:software_studio_project/page/page_login.dart';

class Template extends StatefulWidget {
  const Template({super.key});

  @override
  State<Template> createState() => _TemplateState();
}

class _TemplateState extends State<Template> {
  int _navigationPageIndex = 1;

  final List<Widget> _pages = [
    const PageNote(),
    const PageHome(),
    const PageAssist(),
  ];

  @override
  void initState() {
    super.initState();

    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        today = DateTime.now();
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      appWidth = MediaQuery.of(context).size.width;
      appHeight = MediaQuery.of(context).size.height;
    });
  }

  @override
  Widget build(BuildContext context) {
    return !isLogin.value
        ? const PageLogin()
        : Scaffold(
            appBar: AppBar(
              toolbarHeight: 40.0,
              backgroundColor: Theme.of(context).colorScheme.onPrimary,
              title: Row(
                children: [
                  Icon(Icons.note_alt,
                      color: Theme.of(context).colorScheme.primary),
                  Text(
                    'ClassifyNotesAI',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (ctx) => PageAdd(),
                      );
                    },
                    icon: const Icon(Icons.add),
                  ),
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (ctx) => PageProfile(),
                      );
                    },
                    icon: const Icon(Icons.person),
                  ),
                ],
              ),
            ),
            body: _pages[_navigationPageIndex],
            bottomNavigationBar: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              child: BottomNavigationBar(
                currentIndex: _navigationPageIndex,
                onTap: (int index) {
                  setState(() {
                    _navigationPageIndex = index;
                  });
                },
                selectedItemColor: Theme.of(context).colorScheme.primary,
                backgroundColor: Theme.of(context).colorScheme.onPrimary,
                items: [
                  BottomNavigationBarItem(

                    icon: Icon(Icons.note,
                        color: Theme.of(context).colorScheme.secondary),
                    activeIcon: Icon(Icons.note,
                        color: Theme.of(context).colorScheme.primary),
                    label: 'Note',
                  ),
                  BottomNavigationBarItem(

                    icon: Icon(Icons.home,
                        color: Theme.of(context).colorScheme.secondary),
                    activeIcon: Icon(Icons.home,
                        color: Theme.of(context).colorScheme.primary),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(

                    icon: Icon(Icons.chat,
                        color: Theme.of(context).colorScheme.secondary),
                    activeIcon: Icon(Icons.chat,
                        color: Theme.of(context).colorScheme.primary),
                    label: 'Assist',
                  ),
                ],
              ),
            ),
          );
  }
}
