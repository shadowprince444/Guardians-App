import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_adoption_app/utils/screen_utils/size_config.dart';
import 'package:pet_adoption_app/utils/screen_utils/widgets/spacing_widgets.dart';

import '../../../../bloc/get_paginated_pets/get_paginated_pets_bloc.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final TextEditingController searchTextController;
  const CustomAppBar({super.key, required this.searchTextController});
  @override
  Size get preferredSize => Size.fromHeight(70.vdp());

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool isSearchEnabled = false;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return SafeArea(
      child: Container(
        color: theme.colorScheme.background,
        padding: EdgeInsets.symmetric(horizontal: 16.hdp(), vertical: 8.vdp()),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: const Icon(Icons.menu),
            ),
            Expanded(
              child: isSearchEnabled
                  ? Card(
                      child: TextField(
                        controller: widget.searchTextController,
                        onChanged: (text) {
                          BlocProvider.of<GetPaginatedPetListBloc>(context)
                              .add(GetPaginatedPetListSearchEvent(text));
                        },
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 8.hdp(),
                            ),
                            border: InputBorder.none,
                            hintText: "Search pets by Name..."),
                      ),
                    )
                  : Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.pets,
                          ),
                          const HSpace(4),
                          Text(
                            "Guardians",
                            style: theme.textTheme.headlineLarge!
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
            ),
            IconButton(
              onPressed: () => setState(() {
                SystemChannels.textInput.invokeMethod('TextInput.hide');
                widget.searchTextController.clear();
                isSearchEnabled = !isSearchEnabled;
              }),
              icon: Icon(isSearchEnabled ? Icons.close : Icons.search),
            ),
          ],
        ),
      ),
    );
  }
}
