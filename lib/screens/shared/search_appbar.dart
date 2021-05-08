import 'package:flutter/material.dart';
import 'package:shopping_pal/constants.dart';

class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  _SearchAppBarState createState() => _SearchAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SearchAppBarState extends State<SearchAppBar> {
  bool isSearch = false; // boolean to determine if user clicked the search icon
  TextField searchField = TextField(
      decoration: InputDecoration(
          border: UnderlineInputBorder(), hintText: 'Enter a search term'),
      autofocus: true,
    );
  Text appBarTitle = Text(
    "ShoppingPal",
    style: kSecondaryTextStyle.copyWith(color: Colors.white, fontSize: 23.0),
  );

  @override
  PreferredSizeWidget build(BuildContext context) {

    IconButton cancelBtn = IconButton(
        icon: Icon(Icons.cancel_outlined),
        onPressed: () {
          if (isSearch) {
            //check if the user has clicked the search icon before if false set state of isSearch to true to view the search bar
            setState(() {
              isSearch = false;
            });
          }
        });

    IconButton searchBtn = IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            if (!isSearch) {
              //check if the user has clicked the search icon before if false set state of isSearch to true to view the search bar
              setState(() {
                isSearch = true;
              });
            } else {
              //if the user has already clicked the item before begin search process
              //ToDo: Search process
            }
          });

    Widget isSearchSelected = isSearch ? searchField : appBarTitle;
    return AppBar(
      title: isSearchSelected,
      backgroundColor: kPrimaryColor,
      actions: (isSearch)? [cancelBtn, searchBtn] : [searchBtn],
    );
  }
}
