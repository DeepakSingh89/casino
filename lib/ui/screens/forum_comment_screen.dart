import 'package:casino/controller/community_controller.dart';
import 'package:casino/model/casino_forum_response.dart';
import 'package:casino/ui/styles/my_app_theme.dart';
import 'package:casino/ui/widgets/light_text_head.dart';
import 'package:casino/ui/widgets/loading.dart';
import 'package:casino/ui/widgets/profile_head.dart';
import 'package:casino/utiles/constant.dart';
import 'package:casino/utiles/utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForumCommentScreen extends StatefulWidget {
  const ForumCommentScreen({Key? key}) : super(key: key);

  @override
  _ForumCommentScreenState createState() => _ForumCommentScreenState();
}

class _ForumCommentScreenState extends State<ForumCommentScreen> {
  late Forums forums;
  final TextEditingController _controller = TextEditingController();
  final CommunityController _communityController =
      Get.put(CommunityController());
  String forumData = "";
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    forums = Get.arguments;
    _communityController.getCoummunityById(forums.casinoForumId);
  }

  _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    _communityController
        .addComment(forums.casinoForumId, Utility.getUserID(), forumData,
            Utility.getUserProfilePicID(), Utility.getUserProfilePicVersion())
        .then((value) => _controller.clear());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyAppTheme.mapGradientColorLast,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            ProfileHead(
              isBackArrow: true,
            ),
            Obx(
              () => _communityController.isLoadingId.value
                  ? const Loading(
                      loadingMessage: '',
                    )
                  : _communityController.forumsDetails.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: LightTextHead(data: "noComments".tr),
                        )
                      : Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: ListView.builder(
                              itemCount: _communityController
                                  .forumsDetails.first.forumComment.length,
                              reverse: true,
                              itemBuilder: (BuildContext context, int index) =>
                                  Container(
                                  margin: const EdgeInsets.only(top: 5, bottom: 5,left: 10,right: 10),
                                  decoration: BoxDecoration(
                                  color: Colors.white12,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                // color: Colors.white12,
                                   child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListTile(
                                    title: Text(
                                      _communityController.forumsDetails.first
                                          .forumComment[index].comment,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    leading: CircleAvatar(
                                      backgroundColor: MyAppTheme.textWhite,
                                      radius: 20,
                                      child: CircleAvatar(
                                        radius: 19.0,
                                        backgroundImage: Image.network(
                                          "${Constant.imageURL}${_communityController.forumsDetails.first.forumComment[index].userPicVersion}/${_communityController.forumsDetails.first.forumComment[index].userPicId}",
                                          fit: BoxFit.cover,
                                        ).image,
                                      ),
                                    ),

                                    // CircleAvatar(
                                    //   radius: 40.0,
                                    //   backgroundColor: Colors.white10,
                                    // ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
            ),
            Container(
              width: screenSize.width,
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.only(bottom: 10, left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: screenSize.height * 0.15,
                    decoration: BoxDecoration(
                      color: MyAppTheme.mapGradientColorLast,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: screenSize.height * 0.35,
                    child: Form(
                      key: _formKey,
                      child: ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        children: <Widget>[
                          TextFormField(
                            controller: _controller,
                            cursorColor: Colors.white,
                            autofocus: false,
                            keyboardType: TextInputType.multiline,
                            maxLines: 3,
                            decoration: InputDecoration(
                              errorStyle:
                                  const TextStyle(color: MyAppTheme.textWhite),
                              filled: true,
                              contentPadding: const EdgeInsets.fromLTRB(
                                  20.0, 0.0, 10.0, 20.0),
                              fillColor: MyAppTheme.textSecondary,
                              hintText: "addComment".tr,
                              labelStyle: const TextStyle(color: Colors.white),
                              alignLabelWithHint: false,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 0.1),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15.0),
                                ),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'commentIsEmpty'.tr;
                              }
                            },
                            onSaved: (value) {
                              forumData = value!;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _submit(),
                    child: const Padding(
                      padding: EdgeInsets.only(bottom: 25, right: 20),
                      child: Icon(
                        Icons.send_rounded,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
