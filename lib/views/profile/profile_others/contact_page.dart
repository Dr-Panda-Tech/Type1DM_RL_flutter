import 'package:flutter/material.dart';
import 'package:type1dm_rl_flutter/constants.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<StatefulWidget> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return Form(
        child: Scaffold(
          appBar: CustomAppBar(titleText: 'お問い合わせ'),
      backgroundColor: ColorConstants.backgroundColor,
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 32.0),
            Container(
              margin: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 5,
                bottom: 5,
              ),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'お名前',
                  textAlign: TextAlign.left,
                  style: TextStyle(),
                ),
              ),
            ),
            Container(
                margin: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: "お名前",
                    filled: true,
                    border: InputBorder.none,
                    fillColor: Color.fromARGB(255, 240, 240, 240),
                  ),
                )),
            Container(
              margin: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 5,
                bottom: 5,
              ),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Email',
                  textAlign: TextAlign.left,
                  style: TextStyle(),
                ),
              ),
            ),
            Container(
                margin: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Email",
                    filled: true,
                    border: InputBorder.none,
                    fillColor: Color.fromARGB(255, 240, 240, 240),
                  ),
                )),
            Container(
              margin: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 5,
                bottom: 5,
              ),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'お問合せ内容',
                  textAlign: TextAlign.left,
                  style: TextStyle(),
                ),
              ),
            ),
            Container(
                margin: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 20,
                ),
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    hintText: "お問い合わせ内容",
                    filled: true,
                    border: InputBorder.none,
                    fillColor: Color.fromARGB(255, 240, 240, 240),
                  ),
                )),
            ColoredBox(
              color: const Color.fromARGB(255, 204, 204, 204),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    "送信",
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
