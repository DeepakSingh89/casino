import 'package:casino/ui/styles/images.dart';
import 'package:flutter/material.dart';

class ProfileAdds extends StatelessWidget {
  const ProfileAdds({
    Key? key,
    required this.screenSize,
  }) : super(key: key);

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenSize.width,
      child: Image.asset(
        Images.profile_adds,
        width: screenSize.width,
      ),
    );
  }
}
