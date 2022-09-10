import 'dart:developer';

import 'package:casino/controller/casion_controller.dart';
import 'package:casino/model/favorite_casions.dart';
import 'package:casino/model/find_casino_by_id.dart';

import 'package:casino/ui/styles/images.dart';
import 'package:casino/ui/widgets/dark_button.dart';
import 'package:casino/utiles/constant.dart';
import 'package:casino/utiles/utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CasionDetailImage extends StatefulWidget {
  const CasionDetailImage({
    Key? key,
    required this.screenSize,
    required this.casinoDetail,
    required this.casionController,
    required this.favouriteLists,
  }) : super(key: key);

  final Size screenSize;
  final CasinoDetails casinoDetail;
  final CasionController casionController;
  final List<FavouriteList> favouriteLists;

  @override
  State<CasionDetailImage> createState() => _CasionDetailImageState();
}

class _CasionDetailImageState extends State<CasionDetailImage> {
  var isCasionFavt = false;
  @override
  void initState() {
    super.initState();
    isCasionFavts();
  }

  _addFavt(CasinoDetails casinoDetail) {
    widget.casionController.addCasionToFav(
        Utility.getUserID(),
        casinoDetail.casinoId,
        casinoDetail.casinoName,
        casinoDetail.casinoDiscription,
        casinoDetail.picVersion,
        casinoDetail.picId,
        casinoDetail.location[0],
        casinoDetail.location[1]);
    setState(() {
      isCasionFavt = true;
    });
  }

  _disFavt(CasinoDetails casinoDetail) {
    widget.casionController.removeCasinoFavourite(
      Utility.getUserID(),
      casinoDetail.casinoId,
    );
    setState(() {
      isCasionFavt = false;
    });
  }

  isCasionFavts() {
    var isCasionFavtLocal = false;
    //widget.casionController.isCasionFavt.value == false;
    log(" CasionDetailImage isCasionFavts()");
    for (var element in widget.favouriteLists) {
      if (element.casinoId == widget.casinoDetail.casinoId) {
        log(" CasionDetailImage Found");
        isCasionFavtLocal = true;
        break;
      }
    }

    setState(() {
      isCasionFavt = isCasionFavtLocal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      fit: StackFit.loose,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          child: FadeInImage.assetNetwork(
            placeholder: Images.community_casion,
            image:
                "${Constant.imageURL}${widget.casinoDetail.picVersion}/${widget.casinoDetail.picId}",
            fit: BoxFit.fill,
            height: widget.screenSize.height * 0.22,
            width: double.infinity,
          ),
        ),
        isCasionFavt == true
            ? InkWell(
                onTap: () => _disFavt(widget.casinoDetail),
                child: Container(
                  //alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  height: widget.screenSize.height * 0.08,
                  // width: screenSize.width * 0.28,
                  child: const Icon(Icons.favorite, color: Colors.redAccent),
                ),
              )
            : InkWell(
                onTap: () => _addFavt(widget.casinoDetail),
                child: Container(
                  //alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  height: widget.screenSize.height * 0.08,
                  // width: screenSize.width * 0.28,
                  child: const Icon(Icons.favorite, color: Colors.white),
                ),
              ),
        // Positioned(
        //   right: 25,
        //   top: 130,
        //   //  alignment: Alignment.bottomRight,
        //   // padding: const EdgeInsets.only(left: 8, right: 8),
        //   height: widget.screenSize.height * 0.04,
        //   width: widget.screenSize.width * 0.28,
        //   child: DarkButton(
        //     buttonText: 'checkIn'.tr,
        //   ),
        // ),
      ],
    );
  }
}
