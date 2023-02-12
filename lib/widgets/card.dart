import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget content;
  final Function()? onTap;
  const CustomCard({Key? key, required this.content, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
          color: const Color(0xFFD6ABD1),
        )),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 10.0),
            child: content,
          ),
        ),
      ),
    );
  }
}
