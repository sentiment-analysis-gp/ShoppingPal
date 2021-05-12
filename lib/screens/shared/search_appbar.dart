import 'package:flutter/material.dart';
import 'package:shopping_pal/constants.dart';
import 'package:shopping_pal/models/product.dart';
import 'package:shopping_pal/services/networking.dart';
import 'package:shopping_pal/services/databaseService.dart';

class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  _SearchAppBarState createState() => _SearchAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SearchAppBarState extends State<SearchAppBar> {
  DatabaseService _dbService = DatabaseService();
  bool isSearch = false; // boolean to determine if user clicked the search icon
  String searchURL = '';
  RichText appBarTitle = RichText(
    text: TextSpan(
      text: 'Shopping',
      style: kMainTextStyle.copyWith(
        color: Colors.white,
      ),
      children: <TextSpan>[
        TextSpan(
          text: ' Pal',
          style: kMainTextStyle.copyWith(
            color: kPrimaryColor,
          ),
        ),
      ],
    ),
  );

  @override
  PreferredSizeWidget build(BuildContext context) {
    TextField searchField = TextField(
      style: kSecondaryTextStyle.copyWith(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        hintText: 'Enter a search term',
      ),
      autofocus: true,
      onChanged: (enteredURL) {
        searchURL = enteredURL;
        print(searchURL);
      },
    );
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
        onPressed: () async {
          if (!isSearch) {
            //check if the user has clicked the search icon before if false set state of isSearch to true to view the search bar
            setState(() {
              isSearch = true;
            });
          } else {
            //if the user has already clicked the item before begin search process
            //ToDo: Search process

            Product p = await Networking().fetchProductData(searchURL);
            p.productURL = searchURL;
            _dbService.addProductToSearchHistory(p);
            print(p);
          }
        });

    Widget isSearchSelected = isSearch ? searchField : appBarTitle;
    return AppBar(
      title: isSearchSelected,
      backgroundColor: Colors.transparent,
      toolbarOpacity: 0.5,
      actions: (isSearch) ? [cancelBtn, searchBtn] : [searchBtn],
    );
  }
}
