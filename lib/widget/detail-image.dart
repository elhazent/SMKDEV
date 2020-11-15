
import 'package:flutter/material.dart';
import 'package:smkdevapp/constants.dart';

class DetailImage extends StatelessWidget {
  final String url;
  DetailImage({Key key, @required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          child: Icon(Icons.arrow_back, color: Colors.white,),
          onTap: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Image.network(url),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
        onDoubleTap: (){
          Navigator.pop(context);
        },
        onPanUpdate: (details){
          if (details.delta.dy > 0) {
            Navigator.pop(context);
          }else if (details.delta.dy < 0) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
