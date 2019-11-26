import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SquarePage extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    return SquarePageState();
  }

}

class SquarePageState extends State<SquarePage> with AutomaticKeepAliveClientMixin
{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Text("flutter view"),
          Container(
            width: 100,
            height: 100,
            child:  AndroidView(
              viewType: "mview",
              creationParams: {
                "text":"这是flutter传递过来的参数"
              },
              creationParamsCodec: StandardMessageCodec(),
          ),

          ),

        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

}