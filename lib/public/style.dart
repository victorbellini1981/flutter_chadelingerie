library my_prj.style;

import 'package:flutter/rendering.dart';


var corLetra = Color(0xFF1CC3EE);
var boxFundo = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.1,0.9],
      colors: [Color(0xFFFFFFFF), Color(0xFF1CC3EE)]
      )
);