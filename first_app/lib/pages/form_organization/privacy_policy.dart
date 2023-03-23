import 'package:first_app/pages/form_organization/connecting_organization.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../form_login_page/login_page.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicy();
}

class _PrivacyPolicy extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                ),
                Center(
                  child: Text(
                    "Политика Конфиденциальности мобильного приложения",
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                ),
                Text(
                    "Политика конфиденциальности для мобильных приложений, разработанных командой гр.ИВТ92(Святовым Иваном, Жалниным Дмитрием,Андреевым Михаилом,Ишмухаметовым Русланом, Елянюшкиным Владиславом, Мельниковым Александром)"),
                Padding(
                  padding: const EdgeInsets.all(10),
                ),
                Text("1. Общая информация"),
                Padding(
                  padding: const EdgeInsets.all(10),
                ),
                Text(
                    "1.0 Документ может быть использован юридическими и/или физическими лицами, которым принадлежат исключительные имущественные права обладания мобильным приложением (далее 'Правообладатель')."),
                Padding(
                  padding: const EdgeInsets.all(10),
                ),
                Text(
                    "1.1 Настоящая Политика конфиденциальности (далее - Политика) разработана для мобильных приложений, разработанных командой гр.ИВТ92(Святовым Иваном, Жалниным Дмитрием,Андреевым Михаилом, Елянюшкиным Владиславом, Мельниковым Александром)  (далее - Приложения). В настоящей Политике описано, какие данные Приложений обрабатываются разработчиком в лице командой гр.ИВТ92(Святовым Иваном, Жалниным Дмитрием,Андреевым Михаилом, Елянюшкиным Владиславом, Мельниковым Александром) "
                    'далее - Компания), и как Компания собирает и обрабатывает данные их пользователей.'),
                Padding(
                  padding: const EdgeInsets.all(10),
                ),
                Text(
                    "1.2 Компания оставляет за собой право вносить изменения в Приложения и, при необходимости, адаптировать настоящую Политику к внесенным изменениям."),
                Padding(
                  padding: const EdgeInsets.all(10),
                ),
                Text("2. Цели обработки данных пользователей компанией"),
                Padding(
                  padding: const EdgeInsets.all(10),
                ),
                Text(
                    "2.1 Компания собирает данные технического характера об использовании Приложений и о возникающих ошибках с целью создания статистики пользования Приложениями для последующего их улучшения и устранения ошибок."),
                Padding(
                  padding: const EdgeInsets.all(10),
                ),
                Text(
                    "3. Данные пользователей, к которым имеет доступ приложение"),
                Text(
                    "3.1. Приложение получает доступ к списку контактов пользователя для выбора номеров телефонов при добавлении устройств (приборов) в приложении."),
                Padding(
                  padding: const EdgeInsets.all(10),
                ),
                Text(
                    "3.2. Приложение получает возможность отправки получения и чтения СМС сообщений, для управления пользовательскими устройствами, добавленными в приложение."),
                Padding(
                  padding: const EdgeInsets.all(10),
                ),
                Text(
                    "3.3. Технические данные, которые собирает Компания: данные о количестве запусков Приложений в целом и их отдельных экранов и функций, числе активных пользователей, стране и регионе использования Приложений."),
                Padding(
                  padding: const EdgeInsets.all(10),
                ),
                Text(
                    "3.4. Данные об ошибках, которые собирает Компания: технические параметры устройства, данные о локализации ошибки, частоте ошибок и сбоев. "),
                Padding(
                  padding: const EdgeInsets.all(10),
                ),
                Text(
                    "4. Передача данных пользователей, которые собирает и обрабатывает компания, третьим лицам"),
                Padding(
                  padding: const EdgeInsets.all(10),
                ),
                Text(
                    "Телефонные номера и СМС сообщения, которые формирует приложение, сохраняются приложением только на устройстве пользователя, не передаются другим лицам, в том числе командой гр.ИВТ92(Святовым Иваном, Жалниным Дмитрием,Андреевым Михаилом, Елянюшкиным Владиславом, Мельниковым Александром)  и не используются никаким другим образом, кроме как для управления устройствами, которые добавлены в приложение на устройстве пользователя. При этом приложение не имеет непосредственного доступа к получаемым СМС или к перечню звонков, а только формирует текст команды в виде СМС и далее передаёт её в стандартное приложение для отправки СМС на смартфоне."),
                Padding(
                  padding: const EdgeInsets.all(10),
                ),
              ],
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //footer widgets,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row transition(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Transform.rotate(
              angle: 180 * math.pi / 180,
              child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ConnectingOrganization()));
                  },
                  icon: Icon(Icons.logout))),
        ]);
  }
}
