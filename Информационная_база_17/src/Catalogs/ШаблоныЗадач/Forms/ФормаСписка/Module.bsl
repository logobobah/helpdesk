&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	СистемаУчетаЗадачСервер.ФормаСпискаВыбораПриСозданииНаСервере(Список, Элементы.Список, Параметры);
	
	Элементы.Список.СоздатьЭлементыФормыПользовательскихНастроек(Элементы.СписокКомпоновщикНастроекПользовательскиеНастройки, РежимОтображенияНастроекКомпоновкиДанных.БыстрыйДоступ, 1);
	
	Если Параметры.ФиксированныеНастройки <> Неопределено Тогда
		МассивЭлементовОтбора = ОбщегоНазначенияКлиентСервер.НайтиЭлементыИГруппыОтбора(Параметры.ФиксированныеНастройки.Отбор, "Ссылка");
		Если МассивЭлементовОтбора.Количество() = 1 Тогда
			ИДОтбораПоСсылке = Параметры.ФиксированныеНастройки.Отбор.ПолучитьИдентификаторПоОбъекту(МассивЭлементовОтбора[0]);
		КонецЕсли;
	КонецЕсли;

	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПараметрыРазмещения = ПодключаемыеКоманды.ПараметрыРазмещения();
	ПараметрыРазмещения.КоманднаяПанель = Элементы.КоманднаяПанель;
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект, ПараметрыРазмещения);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
КонецПроцедуры

&НаКлиенте
Процедура СписокВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	Если ИДОтбораПоСсылке <> Неопределено Тогда
		ЭлементОтбора = Список.КомпоновщикНастроек.ФиксированныеНастройки.Отбор.ПолучитьОбъектПоИдентификатору(ИДОтбораПоСсылке);
		ЭлементОтбора.ПравоеЗначение.Добавить(ВыбраннаяСтрока);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Статус = ПредопределенноеЗначение("Перечисление.СтатусыЗадач.Ожидание");
	Если Источник <> ЭтаФорма И ИмяСобытия = "Задачи.ИзменениеСтатуса" И Параметр = Статус Тогда
		Элементы.Список.Обновить();
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура СписокПриЗагрузкеПользовательскихНастроекНаСервере(Элемент, Настройки)
	Элементы.Список.СоздатьЭлементыФормыПользовательскихНастроек(Элементы.СписокКомпоновщикНастроекПользовательскиеНастройки, РежимОтображенияНастроекКомпоновкиДанных.БыстрыйДоступ, 1);
КонецПроцедуры

&НаСервере
Процедура СписокПриОбновленииСоставаПользовательскихНастроекНаСервере(СтандартнаяОбработка)
	Элементы.Список.СоздатьЭлементыФормыПользовательскихНастроек(Элементы.СписокКомпоновщикНастроекПользовательскиеНастройки, РежимОтображенияНастроекКомпоновкиДанных.БыстрыйДоступ, 1);
КонецПроцедуры

#Область ОбработчикиКомандФормы

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
	ПодключаемыеКомандыКлиент.ВыполнитьКоманду(ЭтотОбъект, Команда, Элементы.Список);
КонецПроцедуры

&НаСервере
Процедура Подключаемый_ВыполнитьКомандуНаСервере(Контекст, Результат)
	ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, Контекст, Элементы.Список, Результат);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Элементы.Список);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

#КонецОбласти

