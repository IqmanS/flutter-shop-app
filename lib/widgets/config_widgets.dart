import 'package:flutter/material.dart';

Widget ConfigElevatedButton(
    IconData icon, String buttonText, Function() onPressed) {
  return ElevatedButton(
    onPressed: onPressed,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 8),
          Text(buttonText),
        ],
      ),
    ),
  );
}

Widget imageUrlEmpty(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
        color: Theme.of(context).primaryColorDark,
        border: Border.all(
          color: Theme.of(context).primaryColorLight,
          width: 1.8,
        ),
        borderRadius: BorderRadius.circular(18)),
    child: Center(
      child: FittedBox(
        child: Text(
          "Enter Url",
          style: TextStyle(
              fontSize: 23, color: Theme.of(context).primaryColorLight),
        ),
      ),
    ),
  );
}

Widget previewImage(Widget Child, BuildContext context,
    TextEditingController _imageUrlController) {
  return GestureDetector(
    onTap: () {
      showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          builder: (context) {
            return Container(
              width: 100,
              height: 300,
              child: Image.network(
                _imageUrlController.text,
                fit: BoxFit.contain,
              ),
            );
          });
    },
    child: ClipRRect(borderRadius: BorderRadius.circular(18), child: Child),
  );
}
