
import 'package:e_agri_farmers/constants/lmagepaths/logopaths.dart';
import 'package:e_agri_farmers/router/route_paths.dart';
import 'package:flutter/cupertino.dart';

class ExploreScreen extends StatefulWidget {
  final BuildContext ctx;

  const ExploreScreen({Key? key, required this.ctx}) : super(key: key);

  @override
  _exploreScreenState createState() => _exploreScreenState();
}

class _exploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Center(
          child: Container(

              alignment: Alignment.center,
              constraints: const BoxConstraints(maxWidth: 500),
              margin: const EdgeInsets.all(10),
              child: Column(
                children: [
                  GestureDetector(
                    child: Container(
                        margin: EdgeInsets.all(10),
                        child: Image.asset("assets/images/kharip.png"),
                        ),
                    onTap: () {Navigator.pushNamed(context, RoutePaths.cropType);}
                  ),
                  GestureDetector(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Image.asset("assets/images/rabbi.png"),
                    ),
                      onTap: () {Navigator.pushNamed(context, RoutePaths.cropType);}
                  ),
                  GestureDetector(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Image.asset("assets/images/zaid.png"),
                    ),
                      onTap: () {Navigator.pushNamed(context, RoutePaths.cropType);}
                  )
                ],
              )
          )
      ),
    );
  }
}


