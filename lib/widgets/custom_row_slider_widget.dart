import 'package:flutter/cupertino.dart';

class CustomRowSliderWidget extends StatelessWidget {
  final String title;
  final int memberId;
  final List<Map<String, dynamic>> items;
  final void Function(int index, Map<String, dynamic> item) onCardTap;
  final void Function(int memberId) onSeeMoreTap;

  const CustomRowSliderWidget({
    Key? key,
    required this.title,
    required this.memberId,
    required this.items,
    required this.onCardTap,
    required this.onSeeMoreTap,
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
                if (index < 5) {
                  final item = items[index];

                  /*return Padding(
                    padding:
                        EdgeInsets.only(right: 12, left: index == 0 ? 16 : 0),
                    child: RowItemWidget(
                      imagePath: item['thumbnail'] as String? ?? '',
                      contentId: item['id'] as String? ?? '',
                      type: item['type'] as String? ?? 'unknown',
                      onTap: () {
                        onCardTap(index, item);
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) =>
                                  MemberView(contentId: item['id'])),
                        );
                      },
                    ),
                  );*/
                }

                // See More button
                return Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => onSeeMoreTap(memberId),
                    child: Container(
                      width: 156,
                      height: 156,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: CupertinoColors.systemGrey.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        "Veja Mais",
                        style: TextStyle(
                          color: CupertinoColors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
