import 'package:flutter/material.dart';
import 'package:flutter_animations/buttons_animations.dart';
import 'package:flutter_animations/dialog_animations.dart';
import 'package:flutter_animations/list_item_animations.dart';
import 'package:flutter_animations/page_transitions.dart';
import 'package:flutter_animations/text_animations.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All-in-One Animation Demo'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const DialogAnimationsPage();
                }));
              },
              child: const Text('Dialog Animations'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const ButtonAnimationsPage();
                }));
              },
              child: const Text('Buttons Animations'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const PageTransitionsDemo();
                }));
              },
              child: const Text('Page Transitions'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const TextAnimationsDemo();
                }));
              },
              child: const Text('Text Animations'),
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const ListItemAnimationsDemo();
                }));
              },
              child: const Text('List Item Animations'),
            ),
            const SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: () {

            //   },
            //   child: const Text('Fade + Scale Dialog'),
            // ),
            // SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: () {

            //   },
            //   child: const Text('Fade + Scale Dialog'),
            // ),
            // SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: () {

            //   },
            //   child: const Text('Fade + Scale Dialog'),
            // ),
          ],
        ),
      ),
    );
  }
}
