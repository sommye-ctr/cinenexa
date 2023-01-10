import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:cinenexa/resources/strings.dart';
import 'package:cinenexa/resources/style.dart';
import 'package:cinenexa/services/local/database.dart';
import 'package:cinenexa/widgets/rounded_button.dart';

class SettingsGeneral extends StatefulWidget {
  const SettingsGeneral({Key? key}) : super(key: key);

  @override
  State<SettingsGeneral> createState() => _SettingsGeneralState();
}

class _SettingsGeneralState extends State<SettingsGeneral> {
  Country? providerCountry;
  bool? providersEnabled;

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  void _fetch() async {
    providerCountry = await Database().getProviderCountry();
    providersEnabled = await Database().getJustwatchProvidersStatus();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          Strings.general,
          style: Style.headingStyle,
        ),
        Expanded(
          child: ListView(
            children: [
              ValueListenableBuilder<AdaptiveThemeMode>(
                valueListenable: AdaptiveTheme.of(context).modeChangeNotifier,
                builder: (context, value, child) {
                  return Style.getListTile(
                    context: context,
                    title: Strings.darkMode,
                    trailing: CupertinoSwitch(
                      value: value == AdaptiveThemeMode.dark,
                      onChanged: (value) {
                        if (value) {
                          AdaptiveTheme.of(context).setDark();
                          return;
                        }
                        AdaptiveTheme.of(context).setLight();
                      },
                    ),
                  );
                },
              ),
              Style.getListTile(
                context: context,
                title: Strings.justwatchProvidersShow,
                trailing: CupertinoSwitch(
                  value: providersEnabled ?? true,
                  onChanged: (value) {
                    providersEnabled = !providersEnabled!;
                    providerCountry = null;
                    setState(() {});
                    Database().addJustwatchProvidersEnabled(providersEnabled!);
                    Database().removeProviderCountry();
                  },
                ),
              ),
              Style.getListTile(
                context: context,
                title: Strings.countryProviders,
                enabled: providersEnabled != null && providersEnabled!,
                subtitle: Strings.countryProvidersSub,
                trailing: _buildCountryTrailing(),
              )
            ],
          ),
        ),
      ],
    );
  }

  void setCountry(var value) {
    providerCountry = value;
    setState(() {});
    Database().addProviderCountry(value);
  }

  Widget _buildCountryTrailing() {
    if (providerCountry != null) {
      return GestureDetector(
        onTap: () {
          if (providersEnabled != null && providersEnabled!) {
            showCountryPicker(
              context: context,
              onSelect: (value) {
                setCountry(value);
              },
              showSearch: true,
            );
          }
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(providerCountry!.flagEmoji),
            Style.getVerticalHorizontalSpacing(context: context),
            Text(providerCountry!.name),
          ],
        ),
      );
    }
    return RoundedButton(
      child: Text(Strings.chooseCountry),
      onPressed: providersEnabled != null && providersEnabled!
          ? () {
              showCountryPicker(
                context: context,
                onSelect: (value) {
                  setCountry(value);
                },
                showSearch: true,
              );
            }
          : null,
      type: RoundedButtonType.outlined,
    );
  }
}
