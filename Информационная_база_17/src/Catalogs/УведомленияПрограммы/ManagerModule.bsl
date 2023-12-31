#Область ОбработчикиСобытий

Процедура ОбработкаПолученияПолейПредставления(Поля, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	Поля.Добавить("ВидУведомления");
	Поля.Добавить("Дата");
	
КонецПроцедуры

Процедура ОбработкаПолученияПредставления(Данные, Представление, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	СтрокаПредставления = НСтр("ru = '%1 от %2'");
	
	СтрокаПредставления = СтрЗаменить(СтрокаПредставления, "%1", Данные.ВидУведомления);
	
	Представление = СтрЗаменить(СтрокаПредставления, "%2", Данные.Дата);
	
КонецПроцедуры

#КонецОбласти

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Добавляет уведомление.
//
// Параметры:
//  Описание - Строка - Описание уведомления.
//  ВидУведомления - ПеречислениеСсылка.ВидыУведомленийПрограммы - Вид уведомления.
//  Пользователь - СправочникСсылка.Пользователи - Получатель уведомления.
//  Объект - ЛюбаяСсылка - Объект уведомления.
//
Процедура Добавить(КраткоеОписание, Описание, ВидУведомления, Пользователь, Объект = Неопределено) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	НовоеУведомление = Справочники.УведомленияПрограммы.СоздатьЭлемент();
	НовоеУведомление.Дата = ТекущаяДатаСеанса();
	НовоеУведомление.КраткоеОписание = КраткоеОписание;
	НовоеУведомление.Описание = Описание;
	НовоеУведомление.ВидУведомления = ВидУведомления;
	НовоеУведомление.Пользователь = Пользователь;
	НовоеУведомление.Объект = Объект;
	НовоеУведомление.Записать();
	
КонецПроцедуры

// Получает количество уведомлений для текущего пользователя
//
// Возвращаемое значение:
//  Число - Количество уведомлений для текущего пользователя.
//
Функция ПолучитьУведомления() Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	УведомленияПрограммы.Ссылка КАК Ссылка
		|ИЗ
		|	Справочник.УведомленияПрограммы КАК УведомленияПрограммы
		|ГДЕ
		|	УведомленияПрограммы.Пользователь = &Пользователь
		|	И УведомленияПрограммы.Просмотрено = ЛОЖЬ
		|	И УведомленияПрограммы.ПометкаУдаления = ЛОЖЬ";
	Запрос.УстановитьПараметр("Пользователь", Пользователи.ТекущийПользователь());
	
	Возврат Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Ссылка");
	
КонецФункции

// Отмечает просмотр уведомления.
//
// Параметры:
//  УведомлениеПрограммы - СправочникСсылка.УведомленияПрограммы - Уведомление программы.
//
Процедура ОтметитьПросмотр(УведомлениеПрограммы) Экспорт
	
	УведомлениеПрограммыОбъект = УведомлениеПрограммы.ПолучитьОбъект();
	УведомлениеПрограммыОбъект.Просмотрено = Истина;
	УведомлениеПрограммыОбъект.Записать();
	
КонецПроцедуры

// Отмечает просмотр всех уведомлений.
//
Процедура ОтметитьПросмотрВсех() Экспорт
	
	Запрос = Новый Запрос(
		"ВЫБРАТЬ
		|	УведомленияПрограммы.Ссылка КАК Ссылка
		|ИЗ
		|	Справочник.УведомленияПрограммы КАК УведомленияПрограммы
		|ГДЕ
		|	УведомленияПрограммы.Пользователь = &Пользователь
		|	И УведомленияПрограммы.Просмотрено = ЛОЖЬ");
	
	Запрос.УстановитьПараметр("Пользователь", ПользователиКлиентСервер.ТекущийПользователь());
	
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл
		ОтметитьПросмотр(Выборка.Ссылка);
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли