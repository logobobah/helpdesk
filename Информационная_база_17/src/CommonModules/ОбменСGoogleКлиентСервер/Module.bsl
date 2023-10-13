////////////////////////////////////////////////////////////////////////////////
//	Общие процедуры для работы со службами Google
//
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Функция возвращает признак заполненности токена доступа
//
// Параметры:
//  Данные 	- Структура - поля соответствуют ресурсам
//  регистра сведений СеансовыеДанныеGoogle
// 
// Возвращаемое значение:
//  Булево 	- Ложь, когда переданный параметр является структурой, содержащей
//  заполненное свойство access_token, в противном случае возвращается Истина
//
Функция НеЗаполненТокенДоступа(Данные) Экспорт
	
	Если ТипЗнч(Данные)<>Тип("Структура") Тогда
		Возврат Истина;
	КонецЕсли;
	
	ТокенДоступа = Неопределено;
	
	Данные.Свойство("access_token", ТокенДоступа);
	
	Возврат Не ЗначениеЗаполнено(ТокенДоступа);
	
КонецФункции

Функция ДанныеПользователяИзПрофиляGoogle(Данные) Экспорт
	
	Результат = Новый Структура;
	
	Если ЗначениеЗаполнено(Данные["name"]) Тогда
		Результат.Вставить("Имя", Данные["name"]["givenName"]);
		Результат.Вставить("Фамилия", Данные["name"]["familyName"]);
	КонецЕсли;
	
	Если ЗначениеЗаполнено(Данные["organizations"]) Тогда
		Для Каждого ТекОрганизация Из Данные["organizations"] Цикл
			Если ТекОрганизация["primary"] Тогда
				Результат.Вставить("Организация", ТекОрганизация["name"]);
				Прервать;
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	
	Если ЗначениеЗаполнено(Данные["emails"]) Тогда
		Результат.Вставить("eMail", Данные["emails"][0]["value"]);
	КонецЕсли;
	
	Если ЗначениеЗаполнено(Данные["urls"]) Тогда
		Для Каждого ТекURL Из Данные["urls"] Цикл
			Если ТекURL["type"]="other" Тогда
				Результат.Вставить("АдресСайта", ТекURL["value"]);
				Прервать;
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

Функция ОписанияОбластейДоступаКалендарь() Экспорт
	
	Результат = Новый Массив;
	
	Календарь = ОбменСGoogleКлиентСервер.НовоеОписаниеОбластиДоступа();
	Календарь.Представление = НСтр("ru = 'Календарь'");
	Календарь.ОбластьДоступа = ОбменСGoogleКлиентСервер.ОбластьДоступа(ПредопределенноеЗначение("Перечисление.ОбластиДоступаGoogle.Календарь"));
	Результат.Добавить(Календарь);
	
	Возврат Результат;
	
КонецФункции

Функция ОписанияОбластейДоступаКонтакты() Экспорт
	
	Результат = Новый Массив;
	
	Контакты = НовоеОписаниеОбластиДоступа();
	Контакты.Представление = НСтр("ru = 'Контакты'");
	Контакты.ОбластьДоступа = ОбластьДоступа(ПредопределенноеЗначение("Перечисление.ОбластиДоступаGoogle.Контакты"));
	Результат.Добавить(Контакты);
	
	Возврат Результат;
	
КонецФункции

Функция ОписанияОбластейДоступаПочта() Экспорт
	
	Результат = Новый Массив;
	
	Почта = НовоеОписаниеОбластиДоступа();
	Почта.Представление = НСтр("ru = 'Почта'");
	Почта.ОбластьДоступа = ОбластьДоступа(ПредопределенноеЗначение("Перечисление.ОбластиДоступаGoogle.Почта"));
	Результат.Добавить(Почта);
	
	Профиль = НовоеОписаниеОбластиДоступа();
	Профиль.Представление = НСтр("ru = 'Профиль'");
	Профиль.ОбластьДоступа = ОбластьДоступа(ПредопределенноеЗначение("Перечисление.ОбластиДоступаGoogle.Профиль"));
	Результат.Добавить(Профиль);
	
	Возврат Результат;
	
КонецФункции

// Возвращает описание областей доступа для определения какие вызовы API можно
// будет выполнять от имени пользователя
// 
// Возвращаемое значение: Структура с ключами
//  * Представление -	Строка - представление области доступа
//  * ОбластьДоступа -	Строка - строка, которая будет передана в качестве
//                    	параметра scope в запросе подтверждения доступа у пользователя
//  * Использование -	Булево - использование области, включено по-умолчанию
//  * Редактирование -	Булево - использование области может переключать пользователь,
//                    	отключено по-умолчанию
//
Функция НовоеОписаниеОбластиДоступа() Экспорт
	
	Результат = Новый Структура;
	Результат.Вставить("Представление", "");
	Результат.Вставить("ОбластьДоступа", "");
	Результат.Вставить("Использование", Истина);
	Результат.Вставить("Редактирование", Ложь);
	Возврат Результат;
	
КонецФункции

Функция ОбластьДоступа(Вид) Экспорт
	
	Если Вид = ПредопределенноеЗначение("Перечисление.ОбластиДоступаGoogle.Календарь") Тогда
		Возврат "https://www.googleapis.com/auth/calendar";
	КонецЕсли;
	
	Если Вид = ПредопределенноеЗначение("Перечисление.ОбластиДоступаGoogle.Контакты") Тогда
		Возврат "https://www.googleapis.com/auth/contacts.readonly";
	КонецЕсли;
	
	Если Вид = ПредопределенноеЗначение("Перечисление.ОбластиДоступаGoogle.Почта") Тогда
		Возврат "https://mail.google.com";
	КонецЕсли;
	
	Если Вид = ПредопределенноеЗначение("Перечисление.ОбластиДоступаGoogle.Профиль") Тогда
		Возврат "https://www.googleapis.com/auth/userinfo.email+profile";
	КонецЕсли;
	
КонецФункции

Функция ЭтоСправочникДляПодключенияКлассификатораКонтактов(ОписаниеТиповРеквизита) Экспорт
	
	Если ОписаниеТиповРеквизита.Типы().Количество() <> 1 Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Если ОписаниеТиповРеквизита.СодержитТип(Тип("СправочникСсылка.Заказчики")) Тогда
		Возврат Истина;
	КонецЕсли;
	
	Если ОписаниеТиповРеквизита.СодержитТип(Тип("СправочникСсылка.КонтактныеЛицаЗаказчиков")) Тогда
		Возврат Истина;
	КонецЕсли;
	
	Если ОписаниеТиповРеквизита.СодержитТип(Тип("СправочникСсылка.Пользователи")) Тогда
		Возврат Истина;
	КонецЕсли;
	
	Возврат Ложь;
	
КонецФункции

// Возвращает адрес перенаправления для подстановки в параметры запроса токена в Google
//
// Параметры:
//  ИдентификацияПриложения	 - Структура  - структура с параметрами из макета client_secret_json
// 
// Возвращаемое значение:
//  Строка - параметр redirect_uri
//
Функция АдресПеренаправления(ИдентификацияПриложения) Экспорт
	
	Если ЗначениеЗаполнено(ИдентификацияПриложения.redirect_uris) Тогда
		Возврат ИдентификацияПриложения.redirect_uris[0];
	КонецЕсли;
	
	Возврат "";
	
КонецФункции

// Возвращает поддерживаемые виды идентификации приложения
// 
// Возвращаемое значение:
//  Массив - массив строк
//
Функция ВидыИдентификацииПриложения() Экспорт
	
	Результат = Новый Массив;
	Результат.Добавить("installed");
	Результат.Добавить("web");
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

Процедура ОбработкаПолученияФормыУчетнойЗаписиЭлектроннойПочты(Источник, ВидФормы, Параметры, ВыбраннаяФорма, ДополнительнаяИнформация, СтандартнаяОбработка) Экспорт
	
	ОбменСGoogleВызовСервера.ОбработкаПолученияФормыУчетнойЗаписиЭлектроннойПочты(
	Источник,
	ВидФормы,
	Параметры,
	ВыбраннаяФорма,
	ДополнительнаяИнформация,
	СтандартнаяОбработка);
	
КонецПроцедуры

#КонецОбласти