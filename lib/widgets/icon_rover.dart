import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Padding iconRoverShowDialog(nameRover, context) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 5),
    child: Container(
        decoration: BoxDecoration(
          border:
              Border.all(width: 1.0, color: Color.fromARGB(255, 0, 85, 135)),
          gradient: LinearGradient(
            begin: AlignmentDirectional.topCenter,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 0, 0, 0),
              Color.fromARGB(255, 26, 116, 176),
              Color.fromARGB(255, 0, 0, 0),
            ],
          ),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context, nameRover);
            },
            child: SvgPicture.asset(
              placeholderBuilder: (context) => Container(),
              colorFilter: ColorFilter.mode(
                  Color.fromARGB(255, 65, 185, 255), BlendMode.srcIn),
              'assets/svgs/${nameRover}.svg',
              semanticsLabel: 'robot',
              width: 30,
              height: 40,
            ),
          ),
        )),
  );
}

Container iconRoverBody(nameRover) {
  return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: Color.fromARGB(255, 0, 85, 135)),
        gradient: LinearGradient(
          begin: AlignmentDirectional.topCenter,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 0, 0, 0),
            Color.fromARGB(255, 26, 116, 176),
            Color.fromARGB(255, 0, 0, 0),
          ],
        ),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: SvgPicture.asset(
          colorFilter: ColorFilter.mode(
              Color.fromARGB(255, 65, 185, 255), BlendMode.srcIn),
          'assets/svgs/${nameRover}.svg',
          semanticsLabel: 'robot',
          width: 50,
          height: 60,
        ),
      ));
}
