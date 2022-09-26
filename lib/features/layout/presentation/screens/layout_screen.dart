import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quote/config/locale/app_localizations.dart';
import 'package:quote/core/utils/app_colors.dart';
import 'package:quote/features/layout/presentation/cubit/layout_cubit.dart';
import 'package:quote/features/splash/presentation/cubit/local_cubit.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<LayoutCubit>(context);

    return BlocBuilder<LayoutCubit, LayoutState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.items[cubit.index].title),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                if (AppLocalizations.of(context)?.isEnLocale ?? true) {
                  BlocProvider.of<LocalCubit>(context).toArabic();
                } else {
                  BlocProvider.of<LocalCubit>(context).toEnglish();
                }
              },
              icon: Icon(Icons.translate_outlined),
            ),
          ),
          body: IndexedStack(
            children: cubit.items.map((e) => e.screen).toList(),
            index: cubit.index,
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            elevation: 0.0,
            currentIndex: cubit.index,
            backgroundColor: Colors.white,
            onTap: cubit.onChanges,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: AppColors.hint,
            selectedFontSize: 12,
            items: cubit.items
                .map(
                  (element) => BottomNavigationBarItem(
                    icon: element.icon,
                    label: element.title,
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}
