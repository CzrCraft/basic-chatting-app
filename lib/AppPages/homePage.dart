import 'package:flutter/material.dart';



class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child:IconButton(
              icon: const Icon(Icons.message),
              iconSize: 43,
              onPressed: (){},
            )
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child:IconButton(
              icon: const Icon(Icons.add_circle_outline_rounded),
              iconSize: 55,
              onPressed: (){},
            )
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child:IconButton(
              icon: const Icon(Icons.account_box_rounded),
              iconSize: 45,
              onPressed: (){},
            )
          ),
        ],
        
      ),
      
    );
  }
}