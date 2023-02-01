import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sikasir/app/modules/home/components/dataCard.dart';
import 'package:sikasir/widgets/widgets.dart';

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
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) => Container(
            width: constraints.maxWidth * (percentage! / 100),
            height: 5,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}

class gridCard extends StatelessWidget {
  const gridCard({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    GetStorage box = GetStorage();
    final jabatan = box.read("jabatan");

    List<dynamic> menu = [];

    if (jabatan == "Admin") {
      menu = menuAdmin;
    } else if (jabatan == "Kasir") {
      menu = menuKasir;
    } else if (jabatan == "Gudang") {
      menu = menuGudang;
    } else if (jabatan == "Supervisor") {
      menu = menuSPV;
    }

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: menu.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: menu[index].press,
          child: Card(
            elevation: 2,
            child: Container(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(defaultPadding * 0.75),
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          color: menu[index].color!.withOpacity(0.1),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: SvgPicture.asset(
                          menu[index].svgSrc!,
                          color: menu[index].color,
                        ),
                      ),
                    ],
                  ),
                  wBigText(
                    text: menu[index].title!,
                    weight: FontWeight.w500,
                    color: primaryColor,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
