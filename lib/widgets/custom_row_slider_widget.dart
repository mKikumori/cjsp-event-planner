import 'package:event_planner/view/settings/profile_view.dart';
import 'package:event_planner/widgets/row_item_widget.dart';
import 'package:flutter/cupertino.dart';

class CustomRowSliderWidget extends StatelessWidget {
  final String title;
  final int contentTypeToggle;
  final String rowId;
  final List<Map<String, dynamic>> items;
  final bool instruments;
  final void Function(int index, Map<String, dynamic> item) onCardTap;
  final void Function(int contentId) onSeeMoreTap;

  const CustomRowSliderWidget({
    Key? key,
    required this.title,
    required this.contentTypeToggle,
    required this.items,
    required this.onCardTap,
    required this.onSeeMoreTap,
    this.instruments = false,
    required this.rowId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int displayCount = items.length > 5 ? 6 : items.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              color: CupertinoColors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        if (items.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Center(
              child: Text(
                "No content found.",
                style: TextStyle(
                  color: CupertinoColors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
        else
          SizedBox(
            height: 156,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: displayCount,
                itemBuilder: (context, index) {
                  final item = items[index];

                  return Padding(
                    padding:
                        EdgeInsets.only(right: 12, left: index == 0 ? 16 : 0),
                    child: instruments
                        ? RowItemWidget(
                            imagePath: '',
                            itemId: rowId,
                            type: 'instrument',
                            onTap: () {},
                          )
                        : RowItemWidget(
                            itemId: rowId,
                            imagePath: item['photo_url'] as String? ?? '',
                            type: item['role'] as String? ?? '',
                            onTap: () {
                              onCardTap(index, item);
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) =>
                                        ProfileView(userId: item['uid'])),
                              );
                            },
                          ),
                  );
                }),
          ),
      ],
    );
  }
}
