
//////////////////////////////////////////////////////////////////////////////// 
// ПРОЦЕДУРЫ И ФУНКЦИИ 
// 

&НаСервере 
Процедура УдалитьЗаписи(ТекущаяСтрока)
	
	МенеджерЗаписи = РегистрыСведений.НастройкаСвязей.СоздатьМенеджерЗаписи();
	МенеджерЗаписи.ТипСвязи = ТекущаяСтрока.ТипСвязи;
	МенеджерЗаписи.СсылкаИз = ТекущаяСтрока.СсылкаИз;
	МенеджерЗаписи.СсылкаНа = ТекущаяСтрока.СсылкаНа;
	МенеджерЗаписи.Прочитать();
	
	Если ЗначениеЗаполнено(МенеджерЗаписи.ТипОбратнойСвязи) Тогда 
		МенеджерОбратнойЗаписи = РегистрыСведений.НастройкаСвязей.СоздатьМенеджерЗаписи();
		МенеджерОбратнойЗаписи.ТипСвязи = МенеджерЗаписи.ТипОбратнойСвязи;
		МенеджерОбратнойЗаписи.СсылкаИз = МенеджерЗаписи.СсылкаНа;
		МенеджерОбратнойЗаписи.СсылкаНа = МенеджерЗаписи.СсылкаИз;
		МенеджерОбратнойЗаписи.Удалить();
	КонецЕсли;	
	МенеджерЗаписи.Удалить();
	
КонецПроцедуры
 
//////////////////////////////////////////////////////////////////////////////// 
// ОБРАБОТЧИКИ СОБЫТИЙ ФОРМЫ
// 

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	СсылкаИз = РеквизитФормыВЗначение("СписокСсылкаИз");
	НоваяСтрока = СсылкаИз.Строки.Добавить();
	НоваяСтрока.Наименование = НСтр("ru = 'Все типы'");
	НоваяСтрока.Ссылка = Неопределено;
	 	
	НоваяСтрока = СсылкаИз.Строки.Добавить();
	НоваяСтрока.Наименование = НСтр("ru = 'Файлы'");
	НоваяСтрока.Ссылка = Справочники.Файлы.ПустаяСсылка();
	//ЗаполнитьДерево(НоваяСтрока, "Файлы");
	
	НоваяСтрока = СсылкаИз.Строки.Добавить();
	НоваяСтрока.Наименование = НСтр("ru = 'Проекты'");
	НоваяСтрока.Ссылка = Справочники.Проекты.ПустаяСсылка();
	
	НоваяСтрока = СсылкаИз.Строки.Добавить();
	НоваяСтрока.Наименование = НСтр("ru = 'Задачи'");
	НоваяСтрока.Ссылка = Документы.Задачи.ПустаяСсылка();

	Если ПолучитьФункциональнуюОпцию("ИспользованиеВстроеннойПочты") Тогда 
		НоваяСтрока = СсылкаИз.Строки.Добавить();
		НоваяСтрока.Наименование = НСтр("ru = 'Входящие письма'");
		НоваяСтрока.Ссылка = Документы.ВходящееПисьмо.ПустаяСсылка();
		
		НоваяСтрока = СсылкаИз.Строки.Добавить();
		НоваяСтрока.Наименование = НСтр("ru = 'Исходящие письма'");
		НоваяСтрока.Ссылка = Документы.ИсходящееПисьмо.ПустаяСсылка();
	КонецЕсли;
	
	ЗначениеВРеквизитФормы(СсылкаИз, "СписокСсылкаИз");
	Элементы.СписокСсылкаИз.ТекущаяСтрока = СписокСсылкаИз.ПолучитьЭлементы().Получить(0).ПолучитьИдентификатор();
	Список.Параметры.УстановитьЗначениеПараметра("СсылкаИз", Неопределено);
	
	
	СсылкаНа = РеквизитФормыВЗначение("СписокСсылкаНа");
	НоваяСтрока = СсылкаНа.Строки.Добавить();
	НоваяСтрока.Наименование = НСтр("ru = 'Все типы'");
	НоваяСтрока.Ссылка = Неопределено;
	  	
	НоваяСтрока = СсылкаНа.Строки.Добавить();
	НоваяСтрока.Наименование = НСтр("ru = 'Файлы'");
	НоваяСтрока.Ссылка = Справочники.Файлы.ПустаяСсылка();
	//ЗаполнитьДерево(НоваяСтрока, "Файлы");
	
	НоваяСтрока = СсылкаНа.Строки.Добавить();
	НоваяСтрока.Наименование = НСтр("ru = 'Проекты'");
	НоваяСтрока.Ссылка = Справочники.Проекты.ПустаяСсылка();
	
	НоваяСтрока = СсылкаНа.Строки.Добавить();
	НоваяСтрока.Наименование = НСтр("ru = 'Задачи'");
	НоваяСтрока.Ссылка = Документы.Задачи.ПустаяСсылка();

	Если ПолучитьФункциональнуюОпцию("ИспользованиеВстроеннойПочты") Тогда 
		НоваяСтрока = СсылкаНа.Строки.Добавить();
		НоваяСтрока.Наименование = НСтр("ru = 'Входящие письма'");
		НоваяСтрока.Ссылка = Документы.ВходящееПисьмо.ПустаяСсылка();
		
		НоваяСтрока = СсылкаНа.Строки.Добавить();
		НоваяСтрока.Наименование = НСтр("ru = 'Исходящие письма'");
		НоваяСтрока.Ссылка = Документы.ИсходящееПисьмо.ПустаяСсылка();
	КонецЕсли;
	
	НоваяСтрока = СсылкаНа.Строки.Добавить();
	НоваяСтрока.Наименование = НСтр("ru = 'Внешние ссылки'");
	НоваяСтрока.Ссылка = "";
	
	ЗначениеВРеквизитФормы(СсылкаНа, "СписокСсылкаНа");
	Элементы.СписокСсылкаНа.ТекущаяСтрока = СписокСсылкаНа.ПолучитьЭлементы().Получить(0).ПолучитьИдентификатор();
	Список.Параметры.УстановитьЗначениеПараметра("СсылкаНа", Неопределено);
	
	ЗаголовокСписка = НСтр("ru = 'Все связи'");
	
	ПоказатьПредопределенныеСвязи = Ложь;
	Список.Параметры.УстановитьЗначениеПараметра("ПоказатьПредопределенные", ПоказатьПредопределенныеСвязи);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОжидания()
	
	СсылкаИз = Элементы.СписокСсылкаИз.ТекущиеДанные.Ссылка;
	СсылкаНа = Элементы.СписокСсылкаНа.ТекущиеДанные.Ссылка;
	
	Если СсылкаИз <> Список.Параметры.Элементы.Найти("СсылкаИз").Значение
	 Или СсылкаНа <> Список.Параметры.Элементы.Найти("СсылкаНа").Значение Тогда 
		НаименованиеСсылкаИз = Элементы.СписокСсылкаИз.ТекущиеДанные.Наименование;
		НаименованиеСсылкаНа = Элементы.СписокСсылкаНа.ТекущиеДанные.Наименование;
		
		Если СсылкаИз = Неопределено И СсылкаНа = Неопределено Тогда 
			ЗаголовокСписка = НСтр("ru = 'Все связи'");
		ИначеЕсли СсылкаНа = Неопределено Тогда 
			ЗаголовокСписка = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru = 'Связи из %1'"), НаименованиеСсылкаИз);
		ИначеЕсли СсылкаИз = Неопределено Тогда 
			ЗаголовокСписка = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru = 'Связи на %1'"), НаименованиеСсылкаНа);
		Иначе
			ЗаголовокСписка = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru = 'Связи из %1 на %2'"), НаименованиеСсылкаИз, НаименованиеСсылкаНа);
		КонецЕсли;	
	КонецЕсли;	
	
	Если СсылкаИз <> Список.Параметры.Элементы.Найти("СсылкаИз").Значение Тогда
		Список.Параметры.УстановитьЗначениеПараметра("СсылкаИз", СсылкаИз);
	КонецЕсли;
	
	Если СсылкаНа <> Список.Параметры.Элементы.Найти("СсылкаНа").Значение Тогда
		Список.Параметры.УстановитьЗначениеПараметра("СсылкаНа", СсылкаНа);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПриЗагрузкеДанныхИзНастроекНаСервере(Настройки)
	
	 Список.Параметры.УстановитьЗначениеПараметра("ПоказатьПредопределенные", Настройки["ПоказатьПредопределенныеСвязи"]);

КонецПроцедуры


//////////////////////////////////////////////////////////////////////////////// 
// ОБРАБОТЧИКИ СОБЫТИЙ ЭЛЕМЕНТОВ ФОРМЫ
// 

&НаКлиенте
Процедура СписокСсылкаНаПриАктивизацииСтроки(Элемент)
	
	Если Элементы.СписокСсылкаНа.ТекущаяСтрока <> Неопределено Тогда
		ПодключитьОбработчикОжидания("ОбработкаОжидания", 0.2, Истина);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СписокСсылкаИзПриАктивизацииСтроки(Элемент)
	
	Если Элементы.СписокСсылкаИз.ТекущаяСтрока <> Неопределено Тогда
		ПодключитьОбработчикОжидания("ОбработкаОжидания", 0.2, Истина);
	КонецЕсли; 
	
КонецПроцедуры

&НаКлиенте
Процедура СписокПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа)
	
	Если Не Копирование Тогда
		Отказ = Истина;
		
		ПараметрыФормы = Новый Структура;
		Если Элементы.СписокСсылкаИз.ТекущаяСтрока <> Неопределено Тогда
			ПараметрыФормы.Вставить("СсылкаИз", Элементы.СписокСсылкаИз.ТекущиеДанные.Ссылка);
		КонецЕсли;
		Если Элементы.СписокСсылкаНа.ТекущаяСтрока <> Неопределено Тогда
			ПараметрыФормы.Вставить("СсылкаНа", Элементы.СписокСсылкаНа.ТекущиеДанные.Ссылка);
		КонецЕсли;
		
		Открытьформу("РегистрСведений.НастройкаСвязей.ФормаЗаписи", ПараметрыФормы, Элементы.Список);
	КонецЕсли;	
	
КонецПроцедуры

&НаКлиенте
Процедура СписокПередУдалением(Элемент, Отказ)
	
	Отказ = Истина;
	
	ТекущаяСтрока = Элементы.Список.ТекущаяСтрока;
	Если ТекущаяСтрока = Неопределено Тогда 
		Возврат;
	КонецЕсли;	
	
	ТекущиеДанные = Элементы.Список.ТекущиеДанные;
	Если ТекущиеДанные.Предопределенная Тогда 
		ПоказатьПредупреждение(, НСтр("ru = 'Нельзя удалить предопределенную настройку связей!'"));
		Возврат;
	КонецЕсли;
	
	ОписаниеОповещения = Новый ОписаниеОповещения(
		"СписокПередУдалениемПродолжение",
		ЭтотОбъект,
		Новый Структура("ТекущаяСтрока", ТекущаяСтрока));
	ПоказатьВопрос(ОписаниеОповещения, НСтр("ru = 'Удалить запись?'"), 
		РежимДиалогаВопрос.ДаНет,,КодВозвратаДиалога.Да);
	
КонецПроцедуры

&НаКлиенте
Процедура СписокПередУдалениемПродолжение(Результат, Параметры)Экспорт 

	Если Результат = КодВозвратаДиалога.Да Тогда 
		УдалитьЗаписи(Параметры.ТекущаяСтрока);
		Элементы.Список.Обновить();
	КонецЕсли;	
	
КонецПроцедуры

&НаКлиенте
Процедура ПоказатьПредопределенныеСвязиПриИзменении(Элемент)
	
	Список.Параметры.УстановитьЗначениеПараметра("ПоказатьПредопределенные", ПоказатьПредопределенныеСвязи);
	
КонецПроцедуры
