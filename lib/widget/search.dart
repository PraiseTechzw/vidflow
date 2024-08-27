import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:vidflow/constants/colors.dart';
import 'package:vidflow/widget/drawer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

void Function()? onTap;

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "/searchscreen");
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: white, borderRadius: BorderRadius.circular(30)),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: black,
                        size: 20,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Search or Enter URL ...",
                        style: TextStyle(
                            fontSize: 14,
                            color: grey1,
                            fontWeight: FontWeight.w300),
                      )
                    ],
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "/Downloads");
              },
              icon: const Icon(
                CupertinoIcons.arrow_down_to_line,
                size: 30,
                color: black,
              ),
            )
          ],
        ),
      ),
      drawer: const MyDrawer(),
    );
  }
}
