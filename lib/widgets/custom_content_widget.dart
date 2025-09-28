import 'package:flutter/cupertino.dart';

/// A square button displaying an image, used for content previews.
/// The button has a white background and applies optional padding around the image.
/// Supports locked state with a lock icon overlay.
class CustomContentWidget extends StatelessWidget {
  final String contentId;

  // User input fields
  final String eventName;
  final List currentMembers; // List of the names of the members
  // Marcar "(não do coro)" caso não sejam
  final String
      category; // Rock, pop, jazz, clássico, MPB, samba, funk, gospel, outros
  final String remarks;
  final int totalMembers;
  final List?
      intrumentsListTotal; // List of instruments that will need to be used
  final List?
      intrumentsListPayed; // List of instruments that will need to be used and the User play
  final List?
      intrumentsListOwned; // List of instruments that will need to be used and User own
  final String timeFrame; // at the start, middle or end
  final bool seekingMembers;
  final String status; // Just started, Rehearsing. almost done, ready
  final String type; // Song/Dance/Poem/Other

  final String? imagePath; // default image or Spotify API album image
  final double padding;
  final VoidCallback onTap;

  const CustomContentWidget({
    super.key,
    this.imagePath,
    required this.contentId,
    required this.onTap,
    this.padding = 8.0,
    required this.eventName,
    required this.currentMembers,
    required this.category,
    required this.remarks,
    required this.totalMembers,
    this.intrumentsListTotal,
    this.intrumentsListPayed,
    this.intrumentsListOwned,
    required this.timeFrame,
    required this.seekingMembers,
    required this.status,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    print(
        "Rendering CustomContentWidget with contentId: $contentId, type: $type");

    return SizedBox(
        width: 100,
        height: 150,
        child: CupertinoButton(
            onPressed: onTap,
            padding: EdgeInsets.zero,
            color: CupertinoColors.white,
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(padding),
                  child: Center(
                    child: /*imagePath != null
                        ? Image.network(
                            imagePath!,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          )
                        : */
                        Image.asset(
                      "assets/images/clave_de_sol.jpg",
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          eventName,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              'Tipo: $type',
                              style: const TextStyle(fontSize: 14),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Categoria: $category',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          mappingCurrentMembers(currentMembers, totalMembers),
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Status: $status',
                          style: const TextStyle(fontSize: 14),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Horário de Preferência: $timeFrame',
                          style: const TextStyle(fontSize: 14),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )));
  }

  String mappingCurrentMembers(List currentMembers, int totalMembers) {
    if (currentMembers.isEmpty) {
      return "Sem membros ainda ($totalMembers no total)";
    }

    // Mostra até 3 nomes e depois resume
    String memberPreview;
    if (currentMembers.length > 3) {
      final firstThree = currentMembers.take(3).join(", ");
      final remaining = currentMembers.length - 3;
      memberPreview = "$firstThree +$remaining mais";
    } else {
      memberPreview = currentMembers.join(", ");
    }

    return "Membros: $memberPreview / $totalMembers no total";
  }
}
