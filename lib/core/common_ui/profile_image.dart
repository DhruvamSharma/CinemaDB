import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema_db/core/auth_utils.dart';
import 'package:cinema_db/injection_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileImage extends StatefulWidget {
  const ProfileImage({Key? key}) : super(key: key);

  @override
  _ProfileImageState createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  late AuthUtils authUtils;
  @override
  void initState() {
    authUtils = sl<AuthUtils>();

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user == null) {
        // do nothing
      } else {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await authUtils.signIn();
        setState(() {});
      },
      child: ClipOval(
        child: CircleAvatar(
          child: CachedNetworkImage(
            imageUrl: authUtils.getProfilePicture(),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
