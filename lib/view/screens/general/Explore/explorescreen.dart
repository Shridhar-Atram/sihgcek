
import 'package:e_agri_farmers/constants/lmagepaths/logopaths.dart';
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
              alignment: Alignment.centerLeft,
              constraints: const BoxConstraints(maxWidth: 500),
              margin: const EdgeInsets.only(top: 15, left: 20, right: 20),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Image.asset(LogoPaths.imagePath),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Image.asset(LogoPaths.imagePath),
                  ),Container(
                    margin: EdgeInsets.all(10),
                    child: Image.asset(LogoPaths.imagePath),
                  ),
                ],
              )
          )
      ),
    );
  }
}


