-- -------------------------------------------
SET AUTOCOMMIT=0;
START TRANSACTION;
SET SQL_QUOTE_SHOW_CREATE = 1;
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
-- -------------------------------------------
-- -------------------------------------------
-- START BACKUP
-- -------------------------------------------
-- -------------------------------------------
-- TABLE `article`
-- -------------------------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE IF NOT EXISTS `article` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `slug` varchar(1024) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(512) COLLATE utf8_unicode_ci NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `author_id` int(11) DEFAULT NULL,
  `updater_id` int(11) DEFAULT NULL,
  `status` smallint(6) NOT NULL DEFAULT '0',
  `published_at` int(11) DEFAULT NULL,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_article_author_id` (`author_id`),
  KEY `idx_article_updater_id` (`updater_id`),
  KEY `idx_category_id` (`category_id`),
  CONSTRAINT `fk_article_category` FOREIGN KEY (`category_id`) REFERENCES `article_category` (`id`),
  CONSTRAINT `fk_article_author` FOREIGN KEY (`author_id`) REFERENCES `user` (`id`),
  CONSTRAINT `fk_article_updater` FOREIGN KEY (`updater_id`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- -------------------------------------------
-- TABLE `article_category`
-- -------------------------------------------
DROP TABLE IF EXISTS `article_category`;
CREATE TABLE IF NOT EXISTS `article_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `slug` varchar(1024) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(512) COLLATE utf8_unicode_ci NOT NULL,
  `body` text COLLATE utf8_unicode_ci,
  `parent_id` int(11) DEFAULT NULL,
  `status` smallint(6) NOT NULL DEFAULT '0',
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_parent_id` (`parent_id`),
  CONSTRAINT `fk_article_category_section` FOREIGN KEY (`parent_id`) REFERENCES `article_category` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- -------------------------------------------
-- TABLE `file_storage_item`
-- -------------------------------------------
DROP TABLE IF EXISTS `file_storage_item`;
CREATE TABLE IF NOT EXISTS `file_storage_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `repository` varchar(32) NOT NULL,
  `category` varchar(128) DEFAULT NULL,
  `url` varchar(2048) DEFAULT NULL,
  `path` varchar(2048) NOT NULL,
  `mimeType` varchar(128) NOT NULL,
  `upload_ip` varchar(15) DEFAULT NULL,
  `size` int(11) NOT NULL,
  `status` smallint(6) NOT NULL DEFAULT '10',
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- -------------------------------------------
-- TABLE `i18n_message`
-- -------------------------------------------
DROP TABLE IF EXISTS `i18n_message`;
CREATE TABLE IF NOT EXISTS `i18n_message` (
  `id` int(11) NOT NULL DEFAULT '0',
  `language` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `translation` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`,`language`),
  CONSTRAINT `fk_i18n_message_source_message` FOREIGN KEY (`id`) REFERENCES `i18n_source_message` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- -------------------------------------------
-- TABLE `i18n_source_message`
-- -------------------------------------------
DROP TABLE IF EXISTS `i18n_source_message`;
CREATE TABLE IF NOT EXISTS `i18n_source_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `message` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- -------------------------------------------
-- TABLE `key_storage_item`
-- -------------------------------------------
DROP TABLE IF EXISTS `key_storage_item`;
CREATE TABLE IF NOT EXISTS `key_storage_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `value` text COLLATE utf8_unicode_ci NOT NULL,
  `comment` text COLLATE utf8_unicode_ci,
  `updated_at` int(11) DEFAULT NULL,
  `created_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_key_storage_item_key` (`key`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- -------------------------------------------
-- TABLE `page`
-- -------------------------------------------
DROP TABLE IF EXISTS `page`;
CREATE TABLE IF NOT EXISTS `page` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `alias` varchar(1024) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(512) COLLATE utf8_unicode_ci NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `status` smallint(6) NOT NULL,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- -------------------------------------------
-- TABLE `rbac_auth_assignment`
-- -------------------------------------------
DROP TABLE IF EXISTS `rbac_auth_assignment`;
CREATE TABLE IF NOT EXISTS `rbac_auth_assignment` (
  `item_name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`item_name`,`user_id`),
  CONSTRAINT `rbac_auth_assignment_ibfk_1` FOREIGN KEY (`item_name`) REFERENCES `rbac_auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- -------------------------------------------
-- TABLE `rbac_auth_item`
-- -------------------------------------------
DROP TABLE IF EXISTS `rbac_auth_item`;
CREATE TABLE IF NOT EXISTS `rbac_auth_item` (
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `type` int(11) NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `rule_name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `data` text COLLATE utf8_unicode_ci,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `rule_name` (`rule_name`),
  KEY `idx-auth_item-type` (`type`),
  CONSTRAINT `rbac_auth_item_ibfk_1` FOREIGN KEY (`rule_name`) REFERENCES `rbac_auth_rule` (`name`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- -------------------------------------------
-- TABLE `rbac_auth_item_child`
-- -------------------------------------------
DROP TABLE IF EXISTS `rbac_auth_item_child`;
CREATE TABLE IF NOT EXISTS `rbac_auth_item_child` (
  `parent` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `child` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`parent`,`child`),
  KEY `child` (`child`),
  CONSTRAINT `rbac_auth_item_child_ibfk_1` FOREIGN KEY (`parent`) REFERENCES `rbac_auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rbac_auth_item_child_ibfk_2` FOREIGN KEY (`child`) REFERENCES `rbac_auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- -------------------------------------------
-- TABLE `rbac_auth_rule`
-- -------------------------------------------
DROP TABLE IF EXISTS `rbac_auth_rule`;
CREATE TABLE IF NOT EXISTS `rbac_auth_rule` (
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `data` text COLLATE utf8_unicode_ci,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- -------------------------------------------
-- TABLE `system_event`
-- -------------------------------------------
DROP TABLE IF EXISTS `system_event`;
CREATE TABLE IF NOT EXISTS `system_event` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `application` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `category` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `event` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `data` text COLLATE utf8_unicode_ci,
  `created_at` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- -------------------------------------------
-- TABLE `system_log`
-- -------------------------------------------
DROP TABLE IF EXISTS `system_log`;
CREATE TABLE IF NOT EXISTS `system_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `level` int(11) DEFAULT NULL,
  `category` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `log_time` int(11) NOT NULL,
  `prefix` text COLLATE utf8_unicode_ci,
  `message` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `idx_log_level` (`level`),
  KEY `idx_log_category` (`category`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- -------------------------------------------
-- TABLE `system_migration`
-- -------------------------------------------
DROP TABLE IF EXISTS `system_migration`;
CREATE TABLE IF NOT EXISTS `system_migration` (
  `version` varchar(180) NOT NULL,
  `apply_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- -------------------------------------------
-- TABLE `user`
-- -------------------------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `auth_key` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password_reset_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `oauth_client` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `oauth_client_user_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `role` smallint(6) NOT NULL DEFAULT '1',
  `status` smallint(6) NOT NULL DEFAULT '1',
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- -------------------------------------------
-- TABLE `user_profile`
-- -------------------------------------------
DROP TABLE IF EXISTS `user_profile`;
CREATE TABLE IF NOT EXISTS `user_profile` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `firstname` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `middlename` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lastname` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `picture` varchar(2048) COLLATE utf8_unicode_ci DEFAULT NULL,
  `locale` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `gender` int(1) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `fk_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- -------------------------------------------
-- TABLE `widget_carousel`
-- -------------------------------------------
DROP TABLE IF EXISTS `widget_carousel`;
CREATE TABLE IF NOT EXISTS `widget_carousel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `alias` varchar(1024) COLLATE utf8_unicode_ci NOT NULL,
  `status` smallint(6) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- -------------------------------------------
-- TABLE `widget_carousel_item`
-- -------------------------------------------
DROP TABLE IF EXISTS `widget_carousel_item`;
CREATE TABLE IF NOT EXISTS `widget_carousel_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `carousel_id` int(11) NOT NULL,
  `path` varchar(1024) COLLATE utf8_unicode_ci NOT NULL,
  `url` varchar(1024) COLLATE utf8_unicode_ci DEFAULT NULL,
  `caption` varchar(1024) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` smallint(6) NOT NULL DEFAULT '0',
  `order` int(11) DEFAULT '0',
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_carousel_id` (`carousel_id`),
  CONSTRAINT `fk_item_carousel` FOREIGN KEY (`carousel_id`) REFERENCES `widget_carousel` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- -------------------------------------------
-- TABLE `widget_menu`
-- -------------------------------------------
DROP TABLE IF EXISTS `widget_menu`;
CREATE TABLE IF NOT EXISTS `widget_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `items` text COLLATE utf8_unicode_ci NOT NULL,
  `status` smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- -------------------------------------------
-- TABLE `widget_text`
-- -------------------------------------------
DROP TABLE IF EXISTS `widget_text`;
CREATE TABLE IF NOT EXISTS `widget_text` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `alias` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(512) COLLATE utf8_unicode_ci NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `status` smallint(6) NOT NULL DEFAULT '0',
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_widget_text_alias` (`alias`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- -------------------------------------------
-- TABLE DATA i18n_message
-- -------------------------------------------
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('207','ru','Вы уверены, что хотите сбросить этот кеш?');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('207','uk','Вы впевнені, що бажаете скинути цей кеш?');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('208','ru','Кеш');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('208','uk','Кеш');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('209','ru','Запись была успешно удалена из кеша');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('209','uk','Запис у кеші було успішно видалено');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('210','ru','Кеш был успешно сброшен');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('210','uk','Кеш був успішно скинут');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('211','ru','Удалить значение по ключу из кеша');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('211','uk','Видалити запис за ключом');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('212','ru','Неактивно');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('212','uk','Деактивовано');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('213','ru','Активно');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('213','uk','Активавано');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('214','ru','Сбросить');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('214','uk','Скинути');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('215','ru','Сбросить тег');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('215','uk','Скинути тег');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('216','ru','Ключ');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('216','uk','Ключ');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('217','ru','Выберите кеш');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('217','uk','Оберіть кеш');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('218','ru','Тег');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('218','uk','Тег');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('219','ru','TagDependency был инвалидирован');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('219','uk','TagDependency було інвалідовано');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('220','ru','Аккаунт');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('220','uk','Аккаунт');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('221','ru','Активно');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('221','uk','Активно');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('222','ru','Хроника приложения');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('222','uk','Хроніка');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('223','ru','Вы уверены, что хотите удалить эту запись?');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('223','uk','Ви впевнені, що хочете видалити чей запис?');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('224','ru','Вы уверены, что хотите очистить файловое хранилище?');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('224','uk','Ви впевнені, що хочете очистити Сховище Файлів?');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('225','ru','Категории статей');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('225','uk','Категорії статей');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('226','ru','Статьи');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('226','uk','Статті');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('227','ru','Использование CPU');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('227','uk','Використання CPU');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('228','ru','Виджеты карусели');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('228','uk','Віджети каруселі');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('229','ru','Слайд был успешно сохранен');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('229','uk','Слайд був успішно збережен');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('230','ru','Категория');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('230','uk','Категорія');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('231','ru','Очистить');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('231','uk','Очистити');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('232','ru','Контент');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('232','uk','Контент');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('233','ru','Создать');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('233','uk','Створити');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('234','ru','Создание {modelClass}');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('234','uk','Створити {modelClass}');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('235','ru','Тип БД');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('235','uk','Тип бази даних');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('236','ru','Версия БД');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('236','uk','Версія бази даних');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('237','ru','Удалить');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('237','uk','Видалити');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('238','ru','Редактировать аккаунт');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('238','uk','Редагувати аккаунт');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('239','ru','Редактировать профиль');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('239','uk','Редагувати профіль');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('240','ru','Email');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('240','uk','Email');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('241','ru','Ошибка #{id}');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('241','uk','Помилка #{id}');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('242','ru','Внешний IP');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('242','uk','Зовнішній IP');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('243','ru','Менеджер файлов');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('243','uk','Менеджер файлів');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('244','ru','Записи о файлах');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('244','uk','Записи про файли');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('245','ru','Файлов в хранилище');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('245','uk','Файлів у сховищі');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('246','ru','Свободно Swap');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('246','uk','Вільний Swap');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('247','ru','Свободно памяти');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('247','uk','Вільна пам’ять');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('248','ru','Привет, {username}');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('248','uk','Привіт, {username}');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('249','ru','Имя хоста');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('249','uk','Ім’я хоста');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('250','ru','I18N переводы');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('250','uk','I18N переклади');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('251','ru','Тексты');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('251','uk','Тексти');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('252','ru','ID');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('252','uk','ID');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('253','ru','Неправильный логин или пароль');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('253','uk','Неправильні им’я користувача або пароль');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('254','ru','Внутренний IP');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('254','uk','Внутрішній IP');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('255','ru','Версия ядра');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('255','uk','Версія ядра');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('256','ru','Записи');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('256','uk','Записи');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('257','ru','Ключ-Значение');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('257','uk','Сховище ключ-значення');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('258','ru','Язык');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('258','uk','Мова');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('259','ru','Уровень');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('259','uk','Рівень');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('260','ru','Средняя нагрузка');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('260','uk','Load average');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('261','ru','Время события');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('261','uk','Час');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('262','ru','Выход');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('262','uk','Вихід');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('263','ru','Журнал');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('263','uk','Журнал');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('264','ru','Участник с {0, date, short}');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('264','uk','Учасник з {0, date, short}');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('265','ru','Память');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('265','uk','Пам’ять');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('266','ru','Использование памяти');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('266','uk','Використання пам’яті');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('267','ru','Виджеты меню');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('267','uk','Віджети меню');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('268','ru','Сообщение');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('268','uk','Повідомлення');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('269','ru','Подробнее');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('269','uk','Більше');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('270','ru','Сеть');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('270','uk','Мережа');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('271','ru','Новый пользователь');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('271','uk','Новий користувач');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('272','ru','Новый пользователь {username} ({email}) был зарегистрирован {created_at, date} в {created_at, time}');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('272','uk','Новий користувач {username} ({email}) був зареєстрований {created_at, date} о {created_at, time');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('273','ru','Событий нет');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('273','uk','Подій не знайдено');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('274','ru','Кол-во ядер');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('274','uk','Кількість ядер');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('275','ru','ОС');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('275','uk','ОС');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('276','ru','Версия ОС');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('276','uk','Версія ОС');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('277','ru','Выкл');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('277','uk','Викл');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('278','ru','Вкл');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('278','uk','Вкл');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('279','ru','Операционная система');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('279','uk','Операційна система');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('280','ru','Версия РHP');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('280','uk','Версія PHP');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('281','ru','Страницы');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('281','uk','Сторінки');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('282','ru','Пароль');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('282','uk','Пароль');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('283','ru','Подтверждение пароля');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('283','uk','Підтвердження пароля');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('284','ru','Порт');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('284','uk','Порт');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('285','ru','Префикс');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('285','uk','Префікс');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('286','ru','Процессор');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('286','uk','Процессор');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('287','ru','Архитектура процессора');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('287','uk','Архітектура процессора');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('288','ru','Профиль');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('288','uk','Профіль');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('289','ru','В режиме реального времени');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('289','uk','У реальному часі');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('290','ru','Запомнить меня');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('290','uk','Запам\'ятати мене');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('291','ru','Сбросить');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('291','uk','Очистити');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('292','ru','Сбросить файловое хранилище');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('292','uk','Очистити сховище');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('293','ru','Роль');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('293','uk','Роль');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('294','ru','Сохранить');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('294','uk','Зберегти');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('295','ru','Поиск');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('295','uk','Пошук');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('296','ru','Вход');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('296','uk','Вхід');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('297','ru','Войти');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('297','uk','Увійти');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('298','ru','ПО');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('298','uk','Програмне забезбечення');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('299','ru','Текст');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('299','uk','Текст');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('300','ru','Статические страницы');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('300','uk','Статичні сторінки');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('301','ru','Система');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('301','uk','Система');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('302','ru','Системная дата');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('302','uk','Системна дата');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('303','ru','События системы');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('303','uk','Системні події');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('304','ru','Информация о системе');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('304','uk','Інформація о системі');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('305','ru','Системный журнал');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('305','uk','Системний журнал');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('306','ru','Системное время');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('306','uk','Системний час');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('307','ru','Текстовые блоки');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('307','uk','Текстові блоки');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('308','ru','Текстовые виджеты');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('308','uk','Текстові віджети');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('309','ru','Время');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('309','uk','Час');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('310','ru','Хроника');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('310','uk','Хроніка');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('311','ru','Часовой пояс');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('311','uk','Часовий пояс');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('312','ru','Навигация');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('312','uk','Навігація');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('313','ru','Общий Swap');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('313','uk','Усього Swap');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('314','ru','Общая память');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('314','uk','Усього пам’яті');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('315','ru','Перевод');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('315','uk','Переклад');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('316','ru','Редактировать');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('316','uk','Редагувати');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('317','ru','Редактирование {modelClass}: ');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('317','uk','Редагування {modelClass}:');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('318','ru','Загрузка файла');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('318','uk','Завантажити файл');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('319','ru','Uptime');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('319','uk','Uptime');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('320','ru','Использованный размер');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('320','uk','Використаний простір');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('321','ru','Регистраций');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('321','uk','Зареєстровано користувачів');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('322','ru','Имя пользователя');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('322','uk','Им\'я користувача');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('323','ru','Пользователи');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('323','uk','Користувачі');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('324','ru','Просмотр');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('324','uk','Перегляд');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('325','ru','Смотреть всё');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('325','uk','Дивитися усі');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('326','ru','Web сервер');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('326','uk','Web сервер');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('327','ru','Слайды');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('327','uk','Слайди каруселі');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('328','ru','Виджет карусели');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('328','uk','Віджети каруселі');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('329','ru','Виджеты меню');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('329','uk','Віджети меню');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('330','ru','У вас {num} событий');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('330','uk','Сталося {num} подій');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('331','ru','У вас {num} записей в журнале');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('331','uk','{num} записів у журналі');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('332','ru','I18N');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('332','uk','Інтернаціоналізація');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('333','ru','Перевод');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('333','uk','Переклад');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('334','ru','Текст');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('334','uk','Текст');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('335','ru','Подтвердите пароль');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('335','uk','Підтвердження пароля');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('336','ru','E-mail');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('336','uk','E-mail');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('337','ru','Если вы забыли пароль, вы можете сбросить его <a href=\"{link}\">здесь</a>');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('337','uk','Якщо ви забули свій пароль, ви можете скинуту його <a href=\"{link}\">тут</a>');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('338','ru','Нужен аккаунт? Зарегистрируйтесь');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('338','uk','Потрібен аккаунт? Зареєструйтесь');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('339','ru','Запомнить меня');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('339','uk','Запом’ятати мене');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('340','ru','Запрос сброса пароля');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('340','uk','Запит на скидання пароля');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('341','ru','Сброс пароля');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('341','uk','Скидання пароля');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('342','ru','О нас');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('342','uk','О нас');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('343','ru','Аккаунт');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('343','uk','Аккаунт');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('344','ru','Статьи');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('344','uk','Статті');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('345','ru','Панель управления');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('345','uk','Панель управління');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('346','ru','Проверьте ваш e-mail.');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('346','uk','Перевірте ваш e-mail.');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('347','ru','Контакты');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('347','uk','Контакти');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('348','ru','Создать');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('348','uk','Створити');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('349','ru','Ошибка в процессе OAuth авторизации.');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('349','uk','Помилка під час OAuth авторизації.');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('350','ru','Женский');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('350','uk','Жіноча');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('351','ru','Главная');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('351','uk','Головна');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('352','ru','Неправильный логин или пароль.');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('352','uk','Неправильні им’я користувача або пароль');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('353','ru','Язык');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('353','uk','Мова');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('354','ru','Войти с помощью');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('354','uk','Увійти за допомогою');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('355','ru','Вход');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('355','uk','Вхід');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('356','ru','Выход');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('356','uk','Вихід');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('357','ru','Мужской');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('357','uk','Чоловіча');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('358','ru','Новый пароль был сохранен');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('358','uk','Новий пароль було збережено');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('359','ru','Страница не найдена');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('359','uk','Сторінка не знайдена');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('360','ru','Пароль');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('360','uk','Пароль');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('361','ru','Сброс пароля для {name}');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('361','uk','Скидання пароля для {name}');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('362','ru','Профиль');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('362','uk','Профіль');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('363','ru','Создать аккаунт с помощью');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('363','uk','Створити аккаунт за допомогою');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('364','ru','Регистрация');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('364','uk','Реєстрація');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('365','ru','Извините, мы не можем сбросить пароль для этого e-mail.');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('365','uk','Вибачте, але ми не можемо скинути пароль для цього e-mail.');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('366','ru','Этот e-mail уже занят');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('366','uk','Цей e-mail вже зайнятий');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('367','ru','Это имя пользователя уже занято');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('367','uk','Це им\'я користувача вже використовується');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('368','ru','Редактировать');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('368','uk','Зберегти');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('369','ru','Имя пользователя');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('369','uk','Им\'я користувача');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('370','ru','Имя пользователя или e-mail');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('370','uk','Им’я користувача або e-mail');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('371','ru','Пользователь с email {email} уже зарегистрирован.');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('371','uk','Користувач с e-mail {email} вже зареэстрований');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('372','ru','Добро пожаловать в {app-name}. E-mail с информацией о пользователе был отправлен на вашу почту.');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('372','uk','Вітаємо у {app-name}. Вам був надісланий e-mail с інформациєю щодо користувача');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('373','ru','Ваш профиль бы успешно сохранен');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('373','uk','Ваш профіль було успішно збережено');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('374','ru','{app-name} | Информация о пользователе');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('374','uk','{app-name} | Інформація про користувача');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('375','ru','Автор');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('375','uk','Автор');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('376','ru','Создано');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('376','uk','Створено');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('377','ru','E-mail');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('377','uk','E-mail');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('378','ru','Роль');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('378','uk','Роль');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('379','ru','ЧПУ');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('379','uk','ЧПУ');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('380','ru','Обновивщий');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('380','uk','Оновлено');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('381','ru','Имя пользователя');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('381','uk','Им’я користувача');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('382','ru','Активно');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('382','uk','Активно');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('383','ru','Администратор');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('383','uk','Адміністратор');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('384','ru','Псевдоним');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('384','uk','Псевдонім');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('385','ru','Текст');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('385','uk','Текст');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('386','ru','Текст');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('386','uk','Текст');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('387','ru','ID карусели');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('387','uk','ID каруселі');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('388','ru','Категория');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('388','uk','Категорія');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('389','ru','Комментарий');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('389','uk','Коментар');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('390','ru','Настройки');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('390','uk','Налаштування');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('391','ru','Создано');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('391','uk','Створено');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('392','ru','Удалено');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('392','uk','Видалено');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('393','ru','Имя');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('393','uk','Ім’я');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('394','ru','Пол');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('394','uk','Стать');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('395','ru','ID');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('395','uk','ID');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('396','ru','Ключ');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('396','uk','Ключ');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('397','ru','Фамилия');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('397','uk','Прізвище');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('398','ru','Менеджер');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('398','uk','Менеджер');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('399','ru','Отчество');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('399','uk','По батькові');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('400','ru','Порядок');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('400','uk','Порядок');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('401','ru','Путь');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('401','uk','Шлях');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('402','ru','Аватар');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('402','uk','Аватар');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('403','ru','Опубликовано');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('403','uk','Опубліковано');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('404','ru','Дата публикации');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('404','uk','Опубліковано');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('405','ru','Статус');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('405','uk','Статус');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('406','ru','Название');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('406','uk','Назва');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('407','ru','Обновлено');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('407','uk','Оновлено');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('408','ru','Url');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('408','uk','Url');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('409','ru','Пользователь');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('409','uk','Користувач');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('410','ru','ID пользователя');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('410','uk','ID Користувача');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('411','ru','Значение');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('411','uk','Значення');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('412','ru','{attribute} должен быть валидным JSON');;;
INSERT INTO `i18n_message` (`id`,`language`,`translation`) VALUES
('412','uk','{attribute} повинен бути валідним JSON');;;



-- -------------------------------------------
-- TABLE DATA i18n_source_message
-- -------------------------------------------
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('207','backend','Are you sure you want to flush this cache?');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('208','backend','Cache');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('209','backend','Cache entry has been successfully deleted');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('210','backend','Cache has been successfully flushed');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('211','backend','Delete a value with the specified key from cache');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('212','backend','Disabled');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('213','backend','Enabled');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('214','backend','Flush');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('215','backend','Invalidate tag');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('216','backend','Key');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('217','backend','Select cache');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('218','backend','Tag');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('219','backend','TagDependency was invalidated');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('220','backend','Account');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('221','backend','Active');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('222','backend','Application timeline');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('223','backend','Are you sure you want to delete this item?');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('224','backend','Are you sure ypu want to reset File Storage?');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('225','backend','Article Categories');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('226','backend','Articles');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('227','backend','CPU Usage');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('228','backend','Carousel Widgets');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('229','backend','Carousel slide was successfully saved');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('230','backend','Category');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('231','backend','Clear');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('232','backend','Content');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('233','backend','Create');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('234','backend','Create {modelClass}');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('235','backend','DB Type');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('236','backend','DB Version');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('237','backend','Delete');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('238','backend','Edit account');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('239','backend','Edit profile');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('240','backend','Email');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('241','backend','Error #{id}');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('242','backend','External IP');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('243','backend','File Manager');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('244','backend','File Storage Items');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('245','backend','Files in storage');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('246','backend','Free Swap');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('247','backend','Free memory');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('248','backend','Hello, {username}');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('249','backend','Hostname');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('250','backend','I18n Messages');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('251','backend','I18n Source Messages');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('252','backend','ID');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('253','backend','Incorrect username or password.');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('254','backend','Internal IP');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('255','backend','Kernel version');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('256','backend','Key Storage Items');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('257','backend','Key-Value Storage');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('258','backend','Language');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('259','backend','Level');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('260','backend','Load average');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('261','backend','Log Time');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('262','backend','Logout');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('263','backend','Logs');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('264','backend','Member since {0, date, short}');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('265','backend','Memory');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('266','backend','Memory Usage');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('267','backend','Menu Widgets');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('268','backend','Message');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('269','backend','More info');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('270','backend','Network');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('271','backend','New user');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('272','backend','New user {username} ({email}) was registered at {created_at, date} {created_at, time}');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('273','backend','No events found');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('274','backend','Number of cores');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('275','backend','OS');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('276','backend','OS Release');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('277','backend','Off');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('278','backend','On');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('279','backend','Operating System');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('280','backend','PHP Version');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('281','backend','Pages');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('282','backend','Password');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('283','backend','Password Confirm');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('284','backend','Port');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('285','backend','Prefix');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('286','backend','Processor');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('287','backend','Processor Architecture');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('288','backend','Profile');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('289','backend','Real time');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('290','backend','Remember Me');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('291','backend','Reset');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('292','backend','Reset file storage');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('293','backend','Role');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('294','backend','Save');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('295','backend','Search');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('296','backend','Sign In');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('297','backend','Sign me in');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('298','backend','Software');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('299','backend','Source Message');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('300','backend','Static pages');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('301','backend','System');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('302','backend','System Date');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('303','backend','System Events');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('304','backend','System Information');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('305','backend','System Logs');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('306','backend','System Time');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('307','backend','Text Blocks');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('308','backend','Text Widgets');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('309','backend','Time');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('310','backend','Timeline');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('311','backend','Timezone');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('312','backend','Toggle navigation');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('313','backend','Total Swap');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('314','backend','Total memory');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('315','backend','Translation');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('316','backend','Update');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('317','backend','Update {modelClass}: ');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('318','backend','Upload file');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('319','backend','Uptime');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('320','backend','Used size');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('321','backend','User Registrations');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('322','backend','Username');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('323','backend','Users');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('324','backend','View');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('325','backend','View all');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('326','backend','Web Server');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('327','backend','Widget Carousel Items');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('328','backend','Widget Carousels');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('329','backend','Widget Menus');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('330','backend','You have {num} events');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('331','backend','You have {num} log items');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('332','backend','i18n');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('333','backend','i18n Message');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('334','backend','i18n Source Message');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('335','frontend','Confirm Password');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('336','frontend','E-mail');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('337','frontend','If you forgot your password you can reset it <a href=\"{link}\">here</a>');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('338','frontend','Need an account? Sign up.');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('339','frontend','Remember Me');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('340','frontend','Request password reset');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('341','frontend','Reset password');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('342','frontend','About');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('343','frontend','Account');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('344','frontend','Articles');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('345','frontend','Backend');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('346','frontend','Check your email for further instructions.');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('347','frontend','Contact');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('348','frontend','Create');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('349','frontend','Error while oauth process.');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('350','frontend','Female');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('351','frontend','Home');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('352','frontend','Incorrect username or password.');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('353','frontend','Language');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('354','frontend','Log in with');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('355','frontend','Login');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('356','frontend','Logout');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('357','frontend','Male');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('358','frontend','New password was saved.');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('359','frontend','Page not found');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('360','frontend','Password');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('361','frontend','Password reset for {name}');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('362','frontend','Profile');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('363','frontend','Sign up with');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('364','frontend','Signup');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('365','frontend','Sorry, we are unable to reset password for email provided.');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('366','frontend','This email address has already been taken.');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('367','frontend','This username has already been taken.');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('368','frontend','Update');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('369','frontend','Username');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('370','frontend','Username or email');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('371','frontend','We already have a user with email {email}');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('372','frontend','Welcome to {app-name}. Email with your login information was sent to your email.');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('373','frontend','Your profile has been successfully saved');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('374','frontend','{app-name} | Your login information');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('375','common','Author');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('376','common','Created at');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('377','common','E-mail');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('378','common','Role');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('379','common','Slug');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('380','common','Updater');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('381','common','Username');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('382','common','Active');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('383','common','Administrator');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('384','common','Alias');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('385','common','Body');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('386','common','Caption');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('387','common','Carousel ID');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('388','common','Category');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('389','common','Comment');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('390','common','Config');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('391','common','Created At');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('392','common','Deleted');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('393','common','Firstname');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('394','common','Gender');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('395','common','ID');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('396','common','Key');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('397','common','Lastname');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('398','common','Manager');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('399','common','Middlename');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('400','common','Order');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('401','common','Path');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('402','common','Picture');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('403','common','Published');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('404','common','Published At');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('405','common','Status');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('406','common','Title');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('407','common','Updated At');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('408','common','Url');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('409','common','User');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('410','common','User ID');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('411','common','Value');;;
INSERT INTO `i18n_source_message` (`id`,`category`,`message`) VALUES
('412','common','{attribute} must be a valid JSON');;;



-- -------------------------------------------
-- TABLE DATA key_storage_item
-- -------------------------------------------
INSERT INTO `key_storage_item` (`id`,`key`,`value`,`comment`,`updated_at`,`created_at`) VALUES
('1','backend.theme-skin','skin-blue','','','');;;



-- -------------------------------------------
-- TABLE DATA page
-- -------------------------------------------
INSERT INTO `page` (`id`,`alias`,`title`,`body`,`status`,`created_at`,`updated_at`) VALUES
('1','about','About','Lorem ipsum dolor sit amet, consectetur adipiscing elit.','1','1419428676','1419428676');;;



-- -------------------------------------------
-- TABLE DATA rbac_auth_item
-- -------------------------------------------
INSERT INTO `rbac_auth_item` (`name`,`type`,`description`,`rule_name`,`data`,`created_at`,`updated_at`) VALUES
('administrator','1','','userGroup','','1419428682','1419428682');;;
INSERT INTO `rbac_auth_item` (`name`,`type`,`description`,`rule_name`,`data`,`created_at`,`updated_at`) VALUES
('manager','1','','userGroup','','1419428682','1419428682');;;
INSERT INTO `rbac_auth_item` (`name`,`type`,`description`,`rule_name`,`data`,`created_at`,`updated_at`) VALUES
('user','1','','userGroup','','1419428682','1419428682');;;



-- -------------------------------------------
-- TABLE DATA rbac_auth_item_child
-- -------------------------------------------
INSERT INTO `rbac_auth_item_child` (`parent`,`child`) VALUES
('administrator','manager');;;
INSERT INTO `rbac_auth_item_child` (`parent`,`child`) VALUES
('manager','user');;;



-- -------------------------------------------
-- TABLE DATA rbac_auth_rule
-- -------------------------------------------
INSERT INTO `rbac_auth_rule` (`name`,`data`,`created_at`,`updated_at`) VALUES
('userGroup','O:25:\"common\\rbac\\UserGroupRule\":3:{s:4:\"name\";s:9:\"userGroup\";s:9:\"createdAt\";i:1419428682;s:9:\"updatedAt\";i:1419428682;}','1419428682','1419428682');;;



-- -------------------------------------------
-- TABLE DATA system_log
-- -------------------------------------------
INSERT INTO `system_log` (`id`,`level`,`category`,`log_time`,`prefix`,`message`) VALUES
('1','1','yii\\base\\ErrorException:2','1419429099','[backend][/backup/default/index]','exception \'yii\\base\\ErrorException\' with message \'mkdir(): Permission denied\' in /usr/share/nginx/html/yiidb/vendor/spanjeta/yii2-backup/controllers/DefaultController.php:27
Stack trace:
#0 [internal function]: yii\\base\\ErrorHandler->handleError(2, \'mkdir(): Permis...\', \'/usr/share/ngin...\', 27, Array)
#1 /usr/share/nginx/html/yiidb/vendor/spanjeta/yii2-backup/controllers/DefaultController.php(27): mkdir(\'/usr/share/ngin...\')
#2 /usr/share/nginx/html/yiidb/vendor/yiisoft/yii2/base/Component.php(130): spanjeta\\modules\\backup\\controllers\\DefaultController->getPath()
#3 /usr/share/nginx/html/yiidb/vendor/spanjeta/yii2-backup/controllers/DefaultController.php(254): yii\\base\\Component->__get(\'path\')
#4 [internal function]: spanjeta\\modules\\backup\\controllers\\DefaultController->actionIndex()
#5 /usr/share/nginx/html/yiidb/vendor/yiisoft/yii2/base/InlineAction.php(55): call_user_func_array(Array, Array)
#6 /usr/share/nginx/html/yiidb/vendor/yiisoft/yii2/base/Controller.php(151): yii\\base\\InlineAction->runWithParams(Array)
#7 /usr/share/nginx/html/yiidb/vendor/yiisoft/yii2/base/Module.php(455): yii\\base\\Controller->runAction(\'index\', Array)
#8 /usr/share/nginx/html/yiidb/vendor/yiisoft/yii2/web/Application.php(83): yii\\base\\Module->runAction(\'backup/default/...\', Array)
#9 /usr/share/nginx/html/yiidb/vendor/yiisoft/yii2/base/Application.php(375): yii\\web\\Application->handleRequest(Object(yii\\web\\Request))
#10 /usr/share/nginx/html/yiidb/backend/web/index.php(36): yii\\base\\Application->run()
#11 {main}');;;



-- -------------------------------------------
-- TABLE DATA system_migration
-- -------------------------------------------
INSERT INTO `system_migration` (`version`,`apply_time`) VALUES
('m000000_000000_base','1419428672');;;
INSERT INTO `system_migration` (`version`,`apply_time`) VALUES
('m140703_123000_user','1419428676');;;
INSERT INTO `system_migration` (`version`,`apply_time`) VALUES
('m140703_123055_log','1419428676');;;
INSERT INTO `system_migration` (`version`,`apply_time`) VALUES
('m140703_123104_page','1419428676');;;
INSERT INTO `system_migration` (`version`,`apply_time`) VALUES
('m140703_123803_article','1419428676');;;
INSERT INTO `system_migration` (`version`,`apply_time`) VALUES
('m140703_123813_rbac','1419428676');;;
INSERT INTO `system_migration` (`version`,`apply_time`) VALUES
('m140709_173306_widget_menu','1419428676');;;
INSERT INTO `system_migration` (`version`,`apply_time`) VALUES
('m140709_173333_widget_text','1419428676');;;
INSERT INTO `system_migration` (`version`,`apply_time`) VALUES
('m140712_123329_widget_carousel','1419428676');;;
INSERT INTO `system_migration` (`version`,`apply_time`) VALUES
('m140805_084737_file_storage_item','1419428676');;;
INSERT INTO `system_migration` (`version`,`apply_time`) VALUES
('m140805_084745_key_storage_item','1419428676');;;
INSERT INTO `system_migration` (`version`,`apply_time`) VALUES
('m140805_084812_system_event','1419428676');;;
INSERT INTO `system_migration` (`version`,`apply_time`) VALUES
('m141012_101932_i18n_tables','1419428676');;;



-- -------------------------------------------
-- TABLE DATA user
-- -------------------------------------------
INSERT INTO `user` (`id`,`username`,`auth_key`,`password_hash`,`password_reset_token`,`oauth_client`,`oauth_client_user_id`,`email`,`role`,`status`,`created_at`,`updated_at`) VALUES
('1','webmaster','JmgtfkysHkVJqKgG7jBLsRxDqdLCBpvu','$2y$13$A4n6CjP6G1CYJYrBX62jEuFxIb4No/FaQcYoc0SefZo0AQm0b7MiC','','','','webmaster@example.com','10','1','1419428674','1419428674');;;
INSERT INTO `user` (`id`,`username`,`auth_key`,`password_hash`,`password_reset_token`,`oauth_client`,`oauth_client_user_id`,`email`,`role`,`status`,`created_at`,`updated_at`) VALUES
('2','manager','IcwG0VhhRZMCmEZ6GlyrnOUC7aPUqTQS','$2y$13$1bGhwwoH5/D.jlMTF2jQpeJrPJz0Q50K3qyABcSbK2coGXLECxGI.','','','','manager@example.com','5','1','1419428675','1419428675');;;
INSERT INTO `user` (`id`,`username`,`auth_key`,`password_hash`,`password_reset_token`,`oauth_client`,`oauth_client_user_id`,`email`,`role`,`status`,`created_at`,`updated_at`) VALUES
('3','user','8RGROIDWRnmofEJW0MJjPjSJ0XGWLuXk','$2y$13$aBcqm4Q79S9HhBZgBiKkp.L0jNY5Sw0cWXhLyrH.0N/7agL5BgMTa','','','','user@example.com','1','1','1419428676','1419428676');;;



-- -------------------------------------------
-- TABLE DATA user_profile
-- -------------------------------------------
INSERT INTO `user_profile` (`user_id`,`firstname`,`middlename`,`lastname`,`picture`,`locale`,`gender`) VALUES
('1','','','','','en-US','');;;
INSERT INTO `user_profile` (`user_id`,`firstname`,`middlename`,`lastname`,`picture`,`locale`,`gender`) VALUES
('2','','','','','en-US','');;;
INSERT INTO `user_profile` (`user_id`,`firstname`,`middlename`,`lastname`,`picture`,`locale`,`gender`) VALUES
('3','','','','','en-US','');;;



-- -------------------------------------------
-- TABLE DATA widget_carousel
-- -------------------------------------------
INSERT INTO `widget_carousel` (`id`,`alias`,`status`) VALUES
('1','index','1');;;



-- -------------------------------------------
-- TABLE DATA widget_carousel_item
-- -------------------------------------------
INSERT INTO `widget_carousel_item` (`id`,`carousel_id`,`path`,`url`,`caption`,`status`,`order`,`created_at`,`updated_at`) VALUES
('1','1','/img/yii2-starter-kit.gif','/','','1','0','','');;;



-- -------------------------------------------
-- TABLE DATA widget_menu
-- -------------------------------------------
INSERT INTO `widget_menu` (`id`,`key`,`title`,`items`,`status`) VALUES
('1','frontend-index','Frontend index menu','[
    {
        \"label\": \"Get started with Yii2\",
        \"url\": \"http://www.yiiframework.com\",
        \"options\": {
            \"tag\": \"span\"
        },
        \"template\": \"<a href=\\\"{url}\\\" class=\\\"btn btn-lg btn-success\\\">{label}</a>\"
    },
    {
        \"label\": \"Yii2 Starter Kit on GitHub\",
        \"url\": \"https://github.com/trntv/yii2-starter-kit\",
        \"options\": {
            \"tag\": \"span\"
        },
        \"template\": \"<a href=\\\"{url}\\\" class=\\\"btn btn-lg btn-primary\\\">{label}</a>\"
    },
    {
        \"label\": \"Find a bug?\",
        \"url\": \"https://github.com/trntv/yii2-starter-kit/issues\",
        \"options\": {
            \"tag\": \"span\"
        },
        \"template\": \"<a href=\\\"{url}\\\" class=\\\"btn btn-lg btn-danger\\\">{label}</a>\"
    }
]','1');;;



-- -------------------------------------------
-- TABLE DATA widget_text
-- -------------------------------------------
INSERT INTO `widget_text` (`id`,`alias`,`title`,`body`,`status`,`created_at`,`updated_at`) VALUES
('1','backend_welcome','Welcome to backend','<p>Welcome to Yii2 Starter Kit Dashboard</p>','1','1419428676','1419428676');;;



-- -------------------------------------------
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
COMMIT;
-- -------------------------------------------
-- -------------------------------------------
-- END BACKUP
-- -------------------------------------------
