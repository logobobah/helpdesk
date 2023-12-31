
#Область ПрограммныйИнтерфейс

Процедура ОткрытьДиалогНастройкиРасписания(ОбластьДоступа) Экспорт
	
	РасписаниеРегламентногоЗадания = ОбменСGoogleВызовСервера.РасписаниеРегламентногоЗадания(ОбластьДоступа);
	
	Если РасписаниеРегламентногоЗадания = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ОписаниеОповещения = Новый ОписаниеОповещения("ОбработатьИзменениеРасписания", ЭтотОбъект, ОбластьДоступа);
	Диалог = Новый ДиалогРасписанияРегламентногоЗадания(РасписаниеРегламентногоЗадания);
	Диалог.Показать(ОписаниеОповещения);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовФормыДокумента

// Обработчик события АвтоПодбор в поле Наименование.
//
// Параметры:
//  Форма			 - УправляемаяФорма - форма элемента справочника Контрагенты, Контактные лица, Физические лица
//  ИмяЭлемента		 - Строка - имя элемента формы, для которого обрабатывается событие АвтоПодбор
//  Текст			 - Строка - строка текста, введенная в поле Наименование
//  ДанныеВыбора	 - СписокЗначений - содержит список значений, который будет показан при обработке события АвтоПодбор
//
Процедура НаименованиеАвтоПодбор(Форма, ИмяЭлемента, Текст, ДанныеВыбора, СтандартнаяОбработка) Экспорт
	
	Если ПустаяСтрока(Текст) Тогда
		Возврат;
	КонецЕсли;
	
	Если Не Форма.ПоддержкаGoogle.ЗагружатьКонтактыИзGoogle
		И Не Форма.ПоддержкаGoogle.ЕстьКонтактыСозданныеПоСобытию Тогда
		Возврат;
	КонецЕсли;
	
	Если ЭтоЗаполненныйКонтакт(Форма, ИмяЭлемента) Тогда
		Возврат;
	КонецЕсли;
	
	Если Форма.ПоддержкаGoogle.КлассификаторКонтактовЗаполнен
		Или Форма.ПоддержкаGoogle.ЕстьКонтактыСозданныеПоСобытию Тогда
		ДанныеВыбора = ОбменСGoogleВызовСервера.СписокАвтоПодбораКонтакта(
		Текст,
		Истина,
		ТипЗнч(Форма.Объект.Ссылка));
	КонецЕсли;
	
	Если Не Форма.ПоддержкаGoogle.КлассификаторКонтактовЗаполнен Тогда
		ДобавитьПунктЗагрузитьКонтактыИзGoogle(ДанныеВыбора, Форма, Текст);
	КонецЕсли;
	
	СтандартнаяОбработка = Не ЗначениеЗаполнено(ДанныеВыбора);
	
КонецПроцедуры

// Подключаемый обработчик события АвтоПодбор в поле ввода формы для выбора контрагента
// Добавляет в выпадающий список контакты из классификатора, или предложение загрузить
// их из Google.
//
// Параметры:
//  Форма				 - УправляемаяФорма - форма, содержащая поле ввода, для которого
//                         вызывается обработчик.
//  Элемент				 - ПолеФормы - элемент, для которого вызывается обработчик.
//  Текст				 - Строка - строка текста, введенная в поле ввода.
//  ДанныеВыбора		 - СписокЗначений - содержит список значений, который
//                         будет показан при обработке события АвтоПодбор.
//  Параметры			 - Структура - содержит параметры поиска, подробное описание
//                         см. в синтакс-помощнике, для обработчика расширения поля формы
//                         для поля ввода АвтоПодбор.
//  Ожидание			 - Число - обработчик выполняется только когда Ожидание
//                         не равно 0, то есть только когда был введён текст.
//  СтандартнаяОбработка - Булево - признак выполнения стандартной (системной) обработки.
//
Процедура Подключаемый_АвтоПодбор(Форма, Элемент, Текст, ДанныеВыбора, Параметры, Ожидание, СтандартнаяОбработка) Экспорт
	
	Если ПустаяСтрока(Текст) Тогда
		Возврат;
	КонецЕсли;
	
	Если Параметры.ВыборГруппИЭлементов = ИспользованиеГруппИЭлементов.Группы Тогда
		Возврат;
	КонецЕсли;
	
	Если Не Форма.ПоддержкаGoogle.ЗагружатьКонтактыИзGoogle
		И Не Форма.ПоддержкаGoogle.ЕстьКонтактыСозданныеПоСобытию Тогда
		Возврат;
	КонецЕсли;
	
	СтандартнаяОбработка = Ложь;
	
	ДанныеВыбора = ОбменСGoogleВызовСервера.СписокАвтоПодбораКонтакта(
	Текст,
	Ложь,
	Форма.ПоддержкаGoogle.ОписаниеПолейДляАвтоПодбора[Элемент.Имя].ТипЗначения,
	Параметры.Отбор);
	
	Если Не Форма.ПоддержкаGoogle.КлассификаторКонтактовЗаполнен Тогда
		ДобавитьПунктЗагрузитьКонтактыИзGoogle(ДанныеВыбора, Форма, Текст);
	КонецЕсли;
	
КонецПроцедуры

// Добавляет пункт "Загрузить контакты из Google" в список АвтоПодбор.
//
// Параметры:
//  ДанныеВыбора - СписокЗначений - содержит список значений, который
//                 будет показан при обработке события АвтоПодбор.
//  Форма		 - УправляемаяФорма - форма, содержащая поле ввода, для которого
//                 вызывается обработчик.
//  Текст		 - Строка - строка текста, введенная в поле ввода.
//
Процедура ДобавитьПунктЗагрузитьКонтактыИзGoogle(ДанныеВыбора, Форма, Текст)
	
	Если Форма.ПоддержкаGoogle.КлассификаторКонтактовЗаполнен Тогда
		Возврат;
	КонецЕсли;
	
	Если Форма.ПоддержкаGoogle.ПревышеноЗначениеСчетчикаПодсказок Тогда
		Возврат;
	КонецЕсли;
	
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("Форма", Форма);
	
	ОписаниеОповещения = Новый ОписаниеОповещения(
	"ОткрытьФормуЗагрузкиКонтактовИзGoogle",
	ЭтотОбъект,
	ДополнительныеПараметры);
	
	Если ДанныеВыбора = Неопределено Тогда
		ДанныеВыбора = Новый СписокЗначений;
	КонецЕсли;
	
	Если ЗначениеЗаполнено(Текст)
		И Не ЗначениеЗаполнено(ДанныеВыбора) Тогда
		ДанныеВыбора.Добавить(Текст, СтрШаблон("""%1""", Текст));
	КонецЕсли;
	
	ДанныеВыбора.Добавить(
	ОписаниеОповещения,
	НСтр("ru = 'Загрузить контакты из Google...'"),,
	БиблиотекаКартинок.GoogleДобавить);
	
КонецПроцедуры

// Подключаемый обработчик события ОбработкаВыбора в поле ввода формы
// для выбора контрагента. Обеспечивает обработку выбора из классификатора
//
// Параметры:
//  Форма				 - УправляемаяФорма - форма, содержащая поле ввода, для которого
//                         вызывается обработчик
//  Элемент				 - ПолеФормы - элемент формы, для которого вызывается обработчик
//  ВыбранноеЗначение	 - Произвольный - выбранное значение, которое
//                         будет установлено как значение поля ввода
//  СтандартнаяОбработка - Булево - признак выполнения стандартной (системной) обработки
//
Процедура Подключаемый_ОбработкаВыбора(Форма, Элемент, ВыбранноеЗначение, СтандартнаяОбработка) Экспорт
	
	Если ТипЗнч(ВыбранноеЗначение) = Тип("ОписаниеОповещения") Тогда
		
		СтандартнаяОбработка = Ложь;
		ВыполнитьОбработкуОповещения(ВыбранноеЗначение);
		
	КонецЕсли;
	
	Если ТипЗнч(ВыбранноеЗначение) = Тип("СправочникСсылка.КлассификаторКонтактов") Тогда
		
		СтандартнаяОбработка = Ложь;
		
		ПараметрыФормы = Новый Структура;
		ПараметрыФормы.Вставить("РежимВыбора", Истина);
		ПараметрыФормы.Вставить("КлассификаторДляЗаполненияКИ", ВыбранноеЗначение);
		
		//Если ТипЗнч(Форма.Объект.Ссылка) = Тип("СправочникСсылка.Заказчики") Тогда
		//	ПараметрыФормы.Вставить("ЗначенияЗаполнения", Новый Структура("Владелец", Форма.Объект.Ссылка));
		//КонецЕсли;
		
		Если ТипЗнч(Форма.Объект.Ссылка) = Тип("ДокументСсылка.Задачи") Тогда
			ПараметрыФормы.Вставить("Заказчик",Форма.Объект.Заказчик);
		ИначеЕсли ТипЗнч(Форма.Объект.Ссылка) = Тип("СправочникСсылка.Заказчики") Тогда
			ПараметрыФормы.Вставить("Заказчик",Форма.Объект.Ссылка);
		КонецЕсли;
		
		ДополнитьПараметрыФормыИзПараметровВыбораЭлемента(ПараметрыФормы, Элемент);
		
		ОткрытьФорму(
		Форма.ПоддержкаGoogle.ОписаниеПолейДляАвтоПодбора[Элемент.Имя].ИмяФормыОбъекта,
		ПараметрыФормы,
		Элемент);
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ЭтоЗаполненныйКонтакт(Форма, ИмяЭлемента)
	
	Если ТипЗнч(Форма.Объект.Ссылка) <> Тип("СправочникСсылка.Контрагенты") Тогда
		Возврат ЗначениеЗаполнено(Форма.Объект.Ссылка);
	КонецЕсли;
	
	Если Не СтрНачинаетсяС(ИмяЭлемента, "НаименованиеКонтакт_") Тогда
		Возврат ЗначениеЗаполнено(Форма.Объект.Ссылка);
	КонецЕсли;
	
	ИндексЭлемента = Число(СтрЗаменить(ИмяЭлемента, "НаименованиеКонтакт_", ""));
	
	Возврат ЗначениеЗаполнено(Форма.ДанныеКонтактныхЛиц[ИндексЭлемента].КонтактноеЛицо);
	
КонецФункции

Процедура ОткрытьФормуЗагрузкиКонтактовИзGoogle(Результат, ДополнительныеПараметры) Экспорт
	
	ОписаниеОповещения = Новый ОписаниеОповещения(
	"ОбработатьРезультатЗагрузкиКонтактовИзGoogle",
	ЭтотОбъект,
	ДополнительныеПараметры);
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить(
	"ОбластьДоступа",
	ПредопределенноеЗначение("Перечисление.ОбластиДоступаGoogle.Контакты"));
	
	ОткрытьФорму(
	"Обработка.ОбменСGoogle.Форма.ВыполнитьОбменСGoogle",
	ПараметрыФормы,
	ДополнительныеПараметры.Форма,,,,
	ОписаниеОповещения);
	
КонецПроцедуры

Процедура ОбработатьРезультатЗагрузкиКонтактовИзGoogle(Результат, ДополнительныеПараметры) Экспорт
	
	ДополнительныеПараметры.Форма.ПоддержкаGoogle.КлассификаторКонтактовЗаполнен = ОбменСGoogleВызовСервера.КлассификаторКонтактовЗаполнен();
	Если ДополнительныеПараметры.Форма.ПоддержкаGoogle.КлассификаторКонтактовЗаполнен Тогда
		ПоказатьОповещениеПользователя(НСтр("ru = 'Данные классификатора контактов загружены из Google'"));
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбработатьИзменениеРасписания(Расписание, ОбластьДоступа) Экспорт
	
	Если Расписание <> Неопределено Тогда
		ОбменСGoogleВызовСервера.УстановитьРасписаниеРегламентногоЗадания(Расписание, ОбластьДоступа);
	КонецЕсли;
	
КонецПроцедуры

// Дополняет параметры формы из параметров выбора элемента.
// Используется, например, когда следует заполнить реквизиты "Покупатель", "Поставщик"
// в открывшейся форме создания контрагенента из классификатора контактов.
//
// Параметры:
//  ПараметрыФормы	 - Структура - параметры формы, которые следует дополнить,
//  Элемент			 - ЭлементФормы - элемент формы, для которого вызвается процедура.
//
Процедура ДополнитьПараметрыФормыИзПараметровВыбораЭлемента(ПараметрыФормы, Знач Элемент) Экспорт
	
	Для Каждого ТекПараметрВыбора Из Элемент.ПараметрыВыбора Цикл
		
		КомпонентыИмени = СтрРазделить(ТекПараметрВыбора.Имя, ".", Ложь);
		
		Если КомпонентыИмени.Количество() = 1 Тогда
			ПараметрыФормы.Вставить(КомпонентыИмени[0], ТекПараметрВыбора.Значение);
			Продолжить;
		КонецЕсли;
		
		Если КомпонентыИмени[0] <> "Отбор" Тогда
			Продолжить;
		КонецЕсли;
		
		Если Не ПараметрыФормы.Свойство("ЗначенияЗаполнения") Тогда
			ПараметрыФормы.Вставить("ЗначенияЗаполнения", Новый Структура);
		КонецЕсли;
		
		ПараметрыФормы.ЗначенияЗаполнения.Вставить(КомпонентыИмени[1], ТекПараметрВыбора.Значение);
		
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти
