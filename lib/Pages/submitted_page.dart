import 'package:flutter/material.dart';


class SubmittedPage extends StatelessWidget {
  const SubmittedPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Material(
      color: Colors.white,
      child: Center(
        child: Material(
          child:  Text ("Submission Completed", style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),),
        ),
      )
    );
  }
}