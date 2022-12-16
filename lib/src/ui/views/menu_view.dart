import 'package:ConsumerApp/src/core/models/menu.dart';
import 'package:ConsumerApp/src/core/viewmodels/menu_view_model.dart';
import 'package:ConsumerApp/src/ui/views/base_view.dart';
import 'package:flutter/material.dart';

class MenuView extends StatelessWidget {
  final List<Menu> menus;
  final String title;
  const MenuView({Key key, this.menus, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<MenuViewModel>(
      setupViewModel: (viewmodel) async {
        if (menus != null && menus.length > 0) {
          viewmodel.menus = menus;
          return;
        }
        await viewmodel.setMenus();
      },
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            title ?? 'Menu',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            color: Colors.lightGreen,
            child: viewModel.menus != null && viewModel.menus.length > 0
                ? ListView(
                    children: List.generate(
                      viewModel.menus.length,
                      (index) => GestureDetector(
                        onTap: () => viewModel.showMenu(viewModel.menus[index]),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 8, 8, 8),
                            child: Row(
                              children: [
                                Text(
                                  viewModel.menus[index].name,
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                Spacer(),
                                Icon(Icons.arrow_forward_ios)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: SizedBox(
                      height: 2,
                      width: 150,
                      child: LinearProgressIndicator(),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
