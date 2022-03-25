import 'package:e_agri_farmers/constants/colors/constant_colors.dart';
import 'package:e_agri_farmers/constants/lang/language.dart';
import 'package:e_agri_farmers/helper/chage_lang.dart';
import 'package:e_agri_farmers/helper/text_helper.dart';
import 'package:e_agri_farmers/localization/lang_constants.dart';
import 'package:flutter/material.dart';

class LangDialog {
  static Future<void> showLangDialog(BuildContext context) async {
    Locale curr = await getLocale();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  constraints: const BoxConstraints(maxWidth: 200),
                  child: Wrap(
                    children: [
                      Column(
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(Icons.translate, color: Colors.grey),
                                TextHelper.textWithColorSize(
                                    getTranslated(context, "home_page") ?? "",
                                    18,
                                    Colors.grey,
                                    fontWeight: FontWeight.w600)
                              ],
                            ),
                            padding: const EdgeInsets.all(10),
                          ),
                          ListView.builder(
                            padding: const EdgeInsets.only(top: 10),
                            shrinkWrap: true,
                            itemCount: Language.langs.length,
                            itemBuilder: (context, i) {
                              return GestureDetector(
                                onTap: () async {
                                  await ChangeLang.changeLanguage(
                                      Language.langs[i], context);
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  color: curr.languageCode ==
                                          Language.langs[i].languageCode
                                      ? ConstantColors.mPrimaryColor
                                      : Colors.white,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    child: TextHelper.textWithColorSize(
                                        Language.langs[i].name,
                                        18,
                                        curr.languageCode !=
                                                Language.langs[i].languageCode
                                            ? Colors.black
                                            : Colors.white,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      )
                    ],
                  )
              )
          );
        }
        );
  }
}
