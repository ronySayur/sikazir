import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sikasir/app/modules/components/dataCard.dart';
import 'package:sikasir/app/modules/components/constants.dart';
import 'package:sikasir/widgets/widgets.dart';

class FileInfoCard extends StatelessWidget {
  const FileInfoCard({
    Key? key,
    required this.info,
  }) : super(key: key);

  final CloudStorageInfo info;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: info.press,
      child: Card(
        elevation: 2,
        child: Container(
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(defaultPadding * 0.75),
                    height: wDimension.height45,
                    width: wDimension.height45,
                    decoration: BoxDecoration(
                      color: info.color!.withOpacity(0.1),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: SvgPicture.asset(
                      info.svgSrc!,
                      color: info.color,
                    ),
                  ),
                  // Icon(Icons.more_vert, color: Colors.white54)
                ],
              ),
              wBigText(
                text: info.title!,
                weight: FontWeight.w500,
                color: primaryColor,
              ),
              // Text(
              //   info.title!,
              //   maxLines: 1,
              //   overflow: TextOverflow.ellipsis,
              // ),
              // ProgressLine(
              //   color: info.color,
              //   percentage: info.percentage,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       "${info.numOfFiles} Files",
              //       style: Theme.of(context)
              //           .textTheme
              //           .caption!
              //           .copyWith(color: Colors.white70),
              //     ),
              //     Text(
              //       info.totalStorage!,
              //       style: Theme.of(context)
              //           .textTheme
              //           .caption!
              //           .copyWith(color: Colors.white),
              //     ),
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}

class ProgressLine extends StatelessWidget {
  const ProgressLine({
    Key? key,
    this.color = primaryColor,
    required this.percentage,
  }) : super(key: key);

  final Color? color;
  final int? percentage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 5,
          decoration: BoxDecoration(
            color: color!.withOpacity(0.1),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) => Container(
            width: constraints.maxWidth * (percentage! / 100),
            height: 5,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}

class FileInfoCardGridView extends StatelessWidget {
  const FileInfoCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: demoMyFiles.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) => FileInfoCard(info: demoMyFiles[index]),
    );
  }
}
