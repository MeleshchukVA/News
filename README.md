# News
UIKit app for viewing Russian news.

![Simulator Screen Shot - iPhone 11 - 2022-04-06 at 18 42 21](https://user-images.githubusercontent.com/45876618/162014807-0fbaf1fe-1755-47a2-a344-39cad76ea857.png)
![Simulator Screen Shot - iPhone 11 - 2022-04-06 at 18 43 46](https://user-images.githubusercontent.com/45876618/162014911-6a88c623-ef48-4b9d-b752-43d856d68982.png)
![Simulator Screen Shot - iPhone 11 - 2022-04-06 at 18 44 17](https://user-images.githubusercontent.com/45876618/162014933-4a992853-0232-4488-8c3a-3a10e5a35d49.png)
![Simulator Screen Shot - iPhone 11 - 2022-04-06 at 18 44 30](https://user-images.githubusercontent.com/45876618/162014946-e8a2f4a1-1993-4ac0-8f96-5d9e61dcd8b7.png)
![Simulator Screen Shot - iPhone 11 - 2022-04-06 at 18 44 34](https://user-images.githubusercontent.com/45876618/162014954-a69fba72-9138-4a5f-b038-75e5f4594d1c.png)
![Simulator Screen Shot - iPhone 11 - 2022-04-06 at 18 44 48](https://user-images.githubusercontent.com/45876618/162014961-487cc766-7f92-4f77-878b-a37d9ce742db.png)
![Simulator Screen Shot - iPhone 11 - 2022-04-06 at 18 44 51](https://user-images.githubusercontent.com/45876618/162014964-83ae3afb-7602-4b20-bab3-505e2c804351.png)
![Simulator Screen Shot - iPhone 11 - 2022-04-06 at 18 44 55](https://user-images.githubusercontent.com/45876618/162014966-ab831d42-47b7-484e-9d89-5f087b3eaf7a.png)

Основной использованный стэк: UIKit, TabBarController, NavigationController, TableView, UserDefaults, NSCache, SafariServices, MVC.

Краткое описание: Приложение загружает из интернета и отображает новости России с возможностью добавления их в закладки и обновлением списка новостей.

Подробное описание:
1. Проект полностью написан на UIKit;
2. Использована архитектура MVC;
3. Использованы TabBarController, NavigationController;
4. Использованы TableView с кастомными ячейками;
5. Постраничная загрузка новостей;
6. Реализован жест pull to refresh;
7. Загрузка из интернета по API (newsapi.org) картинки, тайтла, краткого описания, автора, времени публикации и URL источника новости;
8. Сохранение загруженных из сети картинок в кэш;
9. Возможность просмотра оригинального источника новостей через браузер Safari;
10. Реализован ScrollView для айфонов с маленьким экраном при открытии новости;
11. Реализовано сохранение новостей в закладки с помощью UserDafaults;
12. Реализовано удаление новостей из закладок;
13. Кастомный AlertViewController с обработками различных ошибок;
14. Приложение проверено на утечки памяти;
15. Добавлена иконка приложения.

Что еще планируется реализовать:
1. Не всегда корректно обновляются изображения в ячейках TableView. Возможно, подберу сторонний фреймворк для облегчения работы;
2. Избавиться от синглтонов, внедрить DI;
3. Написать Unit/UI-тесты.
