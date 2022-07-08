import 'package:flutter/material.dart';

class botBar extends StatefulWidget {
  const botBar({Key? key}) : super(key: key);

  @override
  _botBarState createState() => _botBarState();
}

class _botBarState extends State<botBar> {

  Color _iconColor = Colors.grey.shade400;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.grey.shade200,
      child: Container(
        height: 60,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(10, 3, 10, 0),
              child: Row(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios_outlined,
                            color: _iconColor,
                          ),
                          onPressed: (){
                            setState(() {
                              _iconColor = Colors.blueAccent;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: _iconColor,
                          ),
                          onPressed: (){
                            setState(() {
                              _iconColor = Colors.blueAccent;
                            });
                          }
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: IconButton(
                          icon: Icon(
                            Icons.ios_share,
                            color: Colors.grey.shade400,
                            size: 27,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: IconButton(
                          icon: Icon(
                            Icons.menu_book_outlined,
                            color: Colors.grey.shade400,
                            size: 27,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.tab_outlined,
                          color: Colors.grey.shade400,
                          size: 27,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

