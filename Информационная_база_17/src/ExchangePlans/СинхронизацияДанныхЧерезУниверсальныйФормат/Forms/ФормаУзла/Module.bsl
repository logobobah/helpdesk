
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ОбменДаннымиСервер.ФормаУзлаПриСозданииНаСервере(ЭтотОбъект, Отказ);
	
	ПравилоОтбораСправочников =
		?(Объект.ИспользоватьОтборПоОрганизациям, "СинхронизироватьДанныеТолькоПоВыбраннымОрганизациям", "СинхронизироватьДанныеПоВсемОрганизациям");
	
	Если ОбщегоНазначения.РазделениеВключено()
		И ОбщегоНазначения.ДоступноИспользованиеРазделенныхДанных() Тогда
		
		Элементы.Наименование.Видимость = Ложь;
		Элементы.Служебные.Видимость = Ложь;
		
	КонецЕсли;
	
	ЗаполнитьВерсииФорматаОбмена();
	
	УстановитьВидимостьНаСервере();
	ОбновитьНаименованиеКомандФормы();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии(ЗавершениеРаботы)
	
	Если ЗавершениеРаботы Тогда
		Возврат;
	КонецЕсли;
	Оповестить("Запись_УзелПланаОбмена");
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	
	ОбновитьИнтерфейс();
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаВыбора(ВыбранноеЗначение, ИсточникВыбора)
	
	ОбновитьДанныеОбъекта(ВыбранноеЗначение);
	Модифицированность = Истина;
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	
	ОбменДаннымиКлиент.ФормаНастройкиПередЗакрытием(Отказ, ЭтотОбъект, ЗавершениеРаботы);
	
КонецПроцедуры

&НаСервере
Процедура ПриЗаписиНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	ОбменДаннымиСервер.ФормаУзлаПриЗаписиНаСервере(ТекущийОбъект, Отказ);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ПереключательОтправлятьНСИАвтоматическиПриИзменении(Элемент)
	УстановитьВидимостьНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура ПереключательОтправлятьНСИПоНеобходимостиПриИзменении(Элемент)
	
	Если Объект.ПравилаОтправкиДокументов = "НеСинхронизировать" Тогда
		Объект.ПравилаОтправкиДокументов = "АвтоматическаяСинхронизация";
	КонецЕсли;
	
	УстановитьВидимостьНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура ПереключательОтправлятьНСИНикогдаПриИзменении(Элемент)
	Объект.ПравилаОтправкиДокументов = "НеСинхронизировать";
	УстановитьВидимостьНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура ПереключательОтбораСправочниковСОтборомПриИзменении(Элемент)
	УсловияОграниченияСинхронизации();
	УстановитьВидимостьНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура ПереключательОтбораСправочниковБезОтбораПриИзменении(Элемент)
	УсловияОграниченияСинхронизации();
	УстановитьВидимостьНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура ПереключательДокументыОтправлятьАвтоматическиПриИзменении(Элемент)
	УстановитьВидимостьНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура ПереключательДокументыОтправлятьВручнуюПриИзменении(Элемент)
	УстановитьВидимостьНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура ПереключательДокументыНеОтправлятьПриИзменении(Элемент)
	УстановитьВидимостьНаСервере();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОткрытьСписокВыбранныхОрганизаций(Команда)
	
	КоллекцияФильтров = Неопределено;
	
	ПараметрыФормы = Новый Структура();
	ПараметрыФормы.Вставить("ИмяЭлементаФормыДляЗаполнения",          "Организации");
	ПараметрыФормы.Вставить("ИмяРеквизитаЭлементаФормыДляЗаполнения", "Организация");
	ПараметрыФормы.Вставить("ИмяТаблицыВыбора",                       "Справочник.Организации");
	ПараметрыФормы.Вставить("ЗаголовокФормыВыбора",                   НСтр("ru = 'Выберите организации для отбора:'"));
	ПараметрыФормы.Вставить("МассивВыбранныхЗначений",                СформироватьМассивВыбранныхЗначений(ПараметрыФормы));
	ПараметрыФормы.Вставить("ПараметрыВнешнегоСоединения",            Неопределено);
	ПараметрыФормы.Вставить("КоллекцияФильтров",                      КоллекцияФильтров);
	
	ОткрытьФорму("ОбщаяФорма.ФормаВыбораДополнительныхУсловий",
		ПараметрыФормы,
		ЭтотОбъект);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура УстановитьВидимостьНаСервере()
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Элементы,
		"ДатаНачалаВыгрузкиДокументов",
		"Доступность",
		Объект.ПравилаОтправкиДокументов = "АвтоматическаяСинхронизация");
		
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Элементы,
		"ПереключательДокументыНеОтправлять",
		"Доступность",
		Объект.ПравилаОтправкиСправочников <> "СинхронизироватьПоНеобходимости");
		
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Элементы,
		"ОписаниеДокументыНеОтправлять",
		"Доступность",
		Объект.ПравилаОтправкиСправочников <> "СинхронизироватьПоНеобходимости");
		
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Элементы.ГруппаДокументы.ПодчиненныеЭлементы,
		"ГруппаРежимОтправкиДокументов",
		"Доступность",
		Объект.ПравилаОтправкиСправочников <> "НеСинхронизировать");
		
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Элементы,
		"ГруппаНастройкаДополнительныхОтборов",
		"Видимость",
		(Объект.ПравилаОтправкиСправочников <> "НеСинхронизировать"
			Или Объект.ПравилаОтправкиСправочников <> "НеСинхронизировать"));
			//И ПолучитьФункциональнуюОпцию("ИспользоватьНесколькоОрганизацийКЭДО"));
		
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Элементы,
		"ОткрытьСписокВыбранныхОрганизаций",
		"Доступность",
		Объект.ИспользоватьОтборПоОрганизациям);
		
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьВерсииФорматаОбмена();
	
	ВерсииФормата = Новый Соответствие;
	ОбменДаннымиСУЗ.ПриПолученииДоступныхВерсийФормата(ВерсииФормата);
	
	СписокВерсий = Элементы.ВерсияФорматаОбмена.СписокВыбора;
	Для Каждого ВерсияФормат Из ВерсииФормата Цикл
		СписокВерсий.Добавить(ВерсияФормат.Ключ);
	КонецЦикла;
	
	СписокВерсий.СортироватьПоЗначению();
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьДанныеОбъекта(СтруктураПараметров)
	
	Объект[СтруктураПараметров.ИмяТаблицыДляЗаполнения].Очистить();
	
	СписокВыбранныхЗначений = ПолучитьИзВременногоХранилища(СтруктураПараметров.АдресТаблицыВоВременномХранилище);
	
	Если СписокВыбранныхЗначений.Количество() > 0 Тогда
		СписокВыбранныхЗначений.Колонки.Представление.Имя = СтруктураПараметров.ИмяКолонкиДляЗаполнения;
		Объект[СтруктураПараметров.ИмяТаблицыДляЗаполнения].Загрузить(СписокВыбранныхЗначений);
	КонецЕсли;
	
	ОбновитьНаименованиеКомандФормы();
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьНаименованиеКомандФормы()
	
	// Обновим заголовок выбранных организаций.
	Если Объект.Организации.Количество() > 0 Тогда
		
		ВыбранныеОрганизации = Объект.Организации.Выгрузить().ВыгрузитьКолонку("Организация");
		НовыйЗаголовокОрганизаций = СтрСоединить(ВыбранныеОрганизации, ",");
		
	Иначе
		
		НовыйЗаголовокОрганизаций = НСтр("ru = 'Выбрать организации'");
		
	КонецЕсли;
	
	Элементы.ОткрытьСписокВыбранныхОрганизаций.Заголовок = НовыйЗаголовокОрганизаций;
	
КонецПроцедуры

&НаСервере
Функция СформироватьМассивВыбранныхЗначений(ПараметрыФормы)
	
	ТабличнаяЧасть           = Объект[ПараметрыФормы.ИмяЭлементаФормыДляЗаполнения];
	ТаблицаВыбранныхЗначений = ТабличнаяЧасть.Выгрузить(,ПараметрыФормы.ИмяРеквизитаЭлементаФормыДляЗаполнения);
	МассивВыбранныхЗначений  = ТаблицаВыбранныхЗначений.ВыгрузитьКолонку(ПараметрыФормы.ИмяРеквизитаЭлементаФормыДляЗаполнения);
	
	Возврат МассивВыбранныхЗначений;
	
КонецФункции

&НаКлиенте
Процедура УсловияОграниченияСинхронизации()
	Объект.ИспользоватьОтборПоОрганизациям = ПравилоОтбораСправочников = "СинхронизироватьДанныеТолькоПоВыбраннымОрганизациям";
КонецПроцедуры

#КонецОбласти
