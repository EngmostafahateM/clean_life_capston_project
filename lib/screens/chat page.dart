import 'package:flutter/material.dart';
import 'package:flutter_tawkto/flutter_tawk.dart';

class chatscreen extends StatelessWidget {
  const chatscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Tawk(
        directChatLink: 'https://tawk.to/chat/67b0c306b09408190f0fb233/1ik57jkh4',
        visitor: TawkVisitor(
          name: 'mostafa',
          email: 'mostafa@gmail.com',
        ),
        onLoad: () {
          print('Hello Tawk!');
        },
        onLinkTap: (String url) {
          print(url);
        },
        placeholder: const Center(
          child: Text('Loading...'),
        ),
      ),
    );
  }
}
