import 'package:flutter/cupertino.dart';

class RowItemWidget extends StatelessWidget {
  final String imagePath;
  final String type;
  final String itemId;
  final VoidCallback onTap;

  const RowItemWidget({
    Key? key,
    required this.imagePath,
    required this.type,
    required this.onTap,
    required this.itemId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: type != 'instrument'
              ? Image.network(
                  imagePath,
                  width: 100,
                  height: 150,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image(
                      width: 100,
                      height: 150,
                      fit: BoxFit.cover,
                      image: AssetImage(
                          'assets/images/profile_pic_placeholder.jpg'),
                    );
                  },
                )
              : Image(
                  width: 100,
                  height: 150,
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/clave_de_sol.jpg'),
                )),
    );
  }
}
