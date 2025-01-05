import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transsectes_app/app/core/providers/language_provider.dart'; // Import SharedPreferences

/// A widget that allows the user to pick a language from a list of available languages.
///
/// This widget uses a `ListWheelScrollView` to display the language options. It loads the current language
/// preference from `SharedPreferences` and updates it when a new language is selected.
class LanguagePicker extends ConsumerStatefulWidget {
  const LanguagePicker({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LanguagePickerState();
}

class _LanguagePickerState extends ConsumerState<LanguagePicker> {
  /// Controller for the scrollable list of languages.
  late FixedExtentScrollController _controller;

  /// The index of the currently selected language in the list.
  int _currentElement = 0;

  /// Height of each item in the list of languages.
  double height = 56;

  @override
  void initState() {
    super.initState();
    _controller = FixedExtentScrollController();
    _loadLanguagePreference(); // Load the language preference on initialization
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Loads the preferred language from `SharedPreferences` and updates the UI.
  ///
  /// This method retrieves the stored language code from `SharedPreferences`,
  /// and sets the initial value of `_currentElement` based on the stored language.
  Future<void> _loadLanguagePreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? savedLanguage = preferences.getString('language');

    setState(() {
      if (savedLanguage == 'en') {
        _currentElement = 0;
      } else if (savedLanguage == 'es') {
        _currentElement = 1;
      } else if (savedLanguage == 'ca') {
        _currentElement = 2;
      }
    });

    _controller.jumpToItem(_currentElement);
  }

  /// Changes the language and updates the preference in `SharedPreferences`.
  ///
  /// This method updates the language in `SharedPreferences` and calls `changeLanguage`
  /// to apply the new language across the app.
  ///
  /// Parameters:
  /// - [ref]: A reference to the Riverpod `WidgetRef` to update the language state.
  /// - [code]: The language code to set ('en', 'es', or 'ca').
  /// - [index]: The index of the selected language in the list.
  void _changeLanguage(WidgetRef ref, String code, int index) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('language', code);

    if (!mounted) return;

    setState(() {
      _currentElement = index;
    });

    changeLanguage(ref: ref, language: code);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: height - 20,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          ListWheelScrollView.useDelegate(
            itemExtent: height,
            diameterRatio: 1,
            squeeze: 1.75,
            controller: _controller,
            physics: const FixedExtentScrollPhysics(),
            onSelectedItemChanged: (index) {
              if (mounted) {
                setState(() {
                  _currentElement = index;
                });
              }

              String selectedLanguage = index == 0
                  ? 'en'
                  : index == 1
                      ? 'es'
                      : 'ca';

              _changeLanguage(ref, selectedLanguage, index);

              _controller.animateToItem(
                _currentElement,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: 3,
              builder: (ctx, index) {
                return Center(
                  child: Text(
                    index == 0
                        ? 'English'
                        : index == 1
                            ? 'Español'
                            : 'Català',
                    style: TextStyle(
                      fontSize: 32,
                      color:
                          _currentElement == index ? Colors.black : Colors.grey,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Opens a modal bottom sheet that allows the user to pick a language.
///
/// This method shows a `LanguagePicker` widget inside a modal bottom sheet.
/// The user can select a language, which will be saved in `SharedPreferences`
/// and applied globally in the app.
void languagePickerModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    useSafeArea: true,
    builder: (BuildContext context) {
      return Container(
        height: MediaQuery.of(context).size.height / 3.5,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(25),
            topLeft: Radius.circular(25),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width / 6,
              height: 10,
              decoration: const BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Expanded(
              child: LanguagePicker(),
            ),
          ],
        ),
      );
    },
  );
}
