import 'package:flutter/material.dart';


class NotPage extends StatelessWidget {
  const NotPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Material(
      color: Colors.white,
      child: Center(
        child: Material(
          child:  Text ("No User Found", style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),),
            
        ),
      )
    );
  }
}