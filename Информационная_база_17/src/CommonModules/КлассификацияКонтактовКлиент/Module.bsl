
#Область ОбработчикиСобытийРеквизитов

// Процедура - обработчик события "ПриИзменении" для поля ввода тега в форме объекта
//
// Параметры:
//  Форма	 - форма объекта
//  Элемент	 - поле ввода тега
Процедура ТегПриИзменении(Форма, Элемент) Экспорт
	
	ПоместитьТегВТабличнуюЧасть(Форма);
	
КонецПроцедуры

// Процедура - обработчик события "ОбработкаНавигационнойСсылки" для поля значения тега в форме объекта
//
// Параметры:
//  Форма				 - форма объекта
//  Элемент				 - элемент формы - значение тега
//  НавигационнаяСсылка	 - строка - навигационная ссылка содержащая ИД тега
//  СтандартнаяОбработка - булево - стандартная обработка навигационной ссылки
Процедура ТегОбработкаНавигационнойСсылки(Форма, Элемент, НавигационнаяСсылка, СтандартнаяОбработка) Экспорт
	
	Если Лев(НавигационнаяСсылка, 6) <> "ТегИД_" Тогда
		Возврат;
	КонецЕсли;
	
	Объект = Форма.Объект;
	
	СтандартнаяОбработка = Ложь;
	Форма.Модифицированность = Истина;
	
	Форма.ЗаблокироватьДанныеФормыДляРедактирования();
	
	ТегИД = Сред(НавигационнаяСсылка, 7);
	ЭлементСписка = Объект.Теги.НайтиПоИдентификатору(ТегИД);
	
	Объект.Теги.Удалить(ЭлементСписка);
	
	Форма.ОбновитьОблакоТегов();
	
КонецПроцедуры

// Функция - обработчик события "Нажатие" для предопределенных вариантов периодов или события "ПриИзменении" для произвольного периода
//
// Параметры:
//  Форма			 - форма списка
//  ИмяСписка		 - строка - имя динамического списка формы для которого устанавливается отбор
//  ВариантПериода	 - строка - принимает значения: "ПроизвольныйПериод", "Сегодня", "3дня", "Неделя", "Месяц"
//  Элемент			 - элемент формы
// Возвращаемое значение:
//  Булево - включен или выключен отбор по данному элементу
Функция СозданыОтборНажатие(Форма, ИмяСписка, ВариантПериода, Элемент) Экспорт
	
	Если ВариантПериода = "ПроизвольныйПериод" Тогда
		НомерПериода = 0;
	ИначеЕсли ВариантПериода = "Сегодня" Тогда
		НомерПериода = 1;
	ИначеЕсли ВариантПериода = "3Дня" Тогда
		НомерПериода = 2;
	ИначеЕсли ВариантПериода = "Неделя" Тогда
		НомерПериода = 3;
	ИначеЕсли ВариантПериода = "Месяц" Тогда
		НомерПериода = 4;
	КонецЕсли;
	
	Период = Форма.ОтборСозданы[НомерПериода];
	Если НомерПериода = 0 Тогда
		Если ЗначениеЗаполнено(Период.Значение.ДатаНачала) Или ЗначениеЗаполнено(Период.Значение.ДатаОкончания) Тогда
			Период.Пометка = Истина;
		Иначе
			Период.Пометка = Ложь;
		КонецЕсли;
	Иначе
		Период.Пометка = Не Период.Пометка;
	КонецЕсли;
	
	// Вариант периода может быть выбран только один
	Для Индекс = 0 По Форма.ОтборСозданы.Количество()-1 Цикл
		
		ЭлементСпискаПериодов = Форма.ОтборСозданы[Индекс];
		Если ЭлементСпискаПериодов <> Период Тогда
			ЭлементСпискаПериодов.Пометка = Ложь;
		КонецЕсли;
		
		Если Индекс = 0 Тогда
			ЭлементОтображенияПериода = Форма.Элементы.ОтборСозданыПроизвольныйПериод;
		ИначеЕсли Индекс = 1 Тогда
			ЭлементОтображенияПериода = Форма.Элементы.ОтборСозданыСегодня;
		ИначеЕсли Индекс = 2 Тогда
			ЭлементОтображенияПериода = Форма.Элементы.ОтборСозданыЗа3Дня;
		ИначеЕсли Индекс = 3 Тогда
			ЭлементОтображенияПериода = Форма.Элементы.ОтборСозданыЗаНеделю;
		ИначеЕсли Индекс = 4 Тогда
			ЭлементОтображенияПериода = Форма.Элементы.ОтборСозданыЗаМесяц;
		Иначе
			Продолжить;
		КонецЕсли;
		
		Если ЭлементСпискаПериодов.Пометка Тогда
			ЭлементОтображенияПериода.ЦветФона = ОбщегоНазначенияКлиентПовтИсп.ЦветСтиля("ФонАктивногоЗначенияОтбора");
		Иначе
			ЭлементОтображенияПериода.ЦветФона = Новый Цвет;
		КонецЕсли;
		
	КонецЦикла;
	
	СформироватьЗаголовокВариантаОтбора(Форма.Элементы.ОтборПериод, ОбщегоНазначенияКлиентСервер.ОтмеченныеЭлементы(Форма.ОтборСозданы).Количество());
	
	ГруппаОтбораПериод = ОбщегоНазначенияКлиентСервер.СоздатьГруппуЭлементовОтбора(Форма[ИмяСписка].Отбор.Элементы, "ОтборПериод", ТипГруппыЭлементовОтбораКомпоновкиДанных.ГруппаИ);
	ГруппаОтбораПериод.Использование = Период.Пометка;
	Если ГруппаОтбораПериод.Элементы.Количество() = 0 Тогда
		
		ЭлементОтбора = ГруппаОтбораПериод.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
		ЭлементОтбора.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ДатаСоздания");
		ЭлементОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.БольшеИлиРавно;
		ЭлементОтбора.ПравоеЗначение = Период.Значение.ДатаНачала;
		ЭлементОтбора.Использование = Истина;
		
		ЭлементОтбора = ГруппаОтбораПериод.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
		ЭлементОтбора.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ДатаСоздания");
		ЭлементОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.МеньшеИлиРавно;
		ЭлементОтбора.ПравоеЗначение = Период.Значение.ДатаОкончания;
		ЭлементОтбора.Использование = Истина;
		
	ИначеЕсли ГруппаОтбораПериод.Элементы.Количество() = 2 Тогда
		
		ГруппаОтбораПериод.Элементы[0].ПравоеЗначение = Период.Значение.ДатаНачала;
		ГруппаОтбораПериод.Элементы[1].ПравоеЗначение = Период.Значение.ДатаОкончания;
		
	КонецЕсли;
	
	Возврат Период.Пометка;
	
КонецФункции

// Функция - обработчик события "Нажатие" для полей-тегов в форме списка
//
// Параметры:
//  Форма				 - форма списка
//  ИмяСписка			 - строка - имя динамического списка формы для которого устанавливается отбор
//  Элемент				 - элемент формы
//  СтандартнаяОбработка - булево - стандартная обработка нажатия
// Возвращаемое значение:
//  булево - включен или выключен отбор по данному элементу
Функция ТегОтборНажатие(Форма, ИмяСписка, Элемент, СтандартнаяОбработка) Экспорт
	
	Если Лев(Элемент.Имя, 4) <> "Тег_" Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	СтандартнаяОбработка = Ложь;
	
	Если Элемент.Имя = "Тег_Пояснение" Тогда
		ПараметрыОткрытия = Новый Структура("Заголовок, КлючПодсказки", 
			"Как работать с тегами",
			"КлассификацияКонтрагентов_КакРаботатьСТегами");
		ОткрытьФорму("Обработка.МенеджерПодсказок.Форма", ПараметрыОткрытия, , Форма.УникальныйИдентификатор);
		Возврат Неопределено;
	КонецЕсли;
	
	ТегИД = Сред(Элемент.Имя, 5);
	ЭлементСписка = Форма.ОтборТеги.НайтиПоИдентификатору(ТегИД);
	ЭлементСписка.Пометка = НЕ ЭлементСписка.Пометка;
	
	Теги = ОбщегоНазначенияКлиентСервер.ОтмеченныеЭлементы(Форма.ОтборТеги);
	Сегменты = ОбщегоНазначенияКлиентСервер.ОтмеченныеЭлементы(Форма.ОтборСегменты);
	СформироватьЗаголовокВариантаОтбора(Форма.Элементы.ОтборТеги, Теги.Количество());
	
	Контрагенты = Новый Массив;
	Если Теги.Количество() > 0 Или Сегменты.Количество() > 0 Тогда
		Контрагенты = КлассификацияКонтактовВызовСервера.КонтрагентыПоТегамИСегментам(Теги, Сегменты);
		ОтборВключен = Истина;
	Иначе
		Контрагенты = Новый Массив;
		ОтборВключен = Ложь;
	КонецЕсли;
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Форма[ИмяСписка], "Ссылка", Контрагенты, ВидСравненияКомпоновкиДанных.ВСписке, , ОтборВключен);
	
	Возврат ЭлементСписка.Пометка;
	
КонецФункции

// Процедура вызывает диалог выбора тега для прикрепления к указанным владельцам
//
// Параметры:
//  ВладельцыТегов							 - массив	 - выбранные владельцы тегов, ссылочный тип
//  ПараметрыПредметаИсчисленияВладельцев	 - строка	 - для оповещения "тег прикреплен к Х объетам", см. СтроковыеФункцииКлиентСервер.ЧислоЦифрамиПредметИсчисленияПрописью()
//
Процедура УстановитьТег(ВладельцыТегов, ПараметрыПредметаИсчисленияВладельцев = Неопределено) Экспорт
	
	Если ВладельцыТегов.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("РежимВыбора", Истина);
	ПараметрыФормы.Вставить("МножественныйВыбор", Ложь);
	
	ПараметрыОповещения = Новый Структура;
	ПараметрыОповещения.Вставить("ВладельцыТегов", ВладельцыТегов);
	ПараметрыОповещения.Вставить("ПараметрыПредметаИсчисленияВладельцев", ПараметрыПредметаИсчисленияВладельцев);
	
	ОписаниеОповещения = Новый ОписаниеОповещения("ТегВыбранДляУстановки", КлассификацияКонтактовКлиент, ПараметрыОповещения);
	
	ОткрытьФорму("Справочник.Теги.ФормаВыбора", ПараметрыФормы,,,,, ОписаниеОповещения, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКоманд

// Процедура - обработчик смены варианта отбора на панели отборов
//
// Параметры:
//  Форма	 - форма списка
//  Команда	 - команда формы
Процедура ВыборВариантаОтбора(Форма, Команда) Экспорт
	
	Элементы = Форма.Элементы;
	
	Если Команда.Имя = "ОтборПериод" Тогда
		ИмяСтраницы = "ЗначенияОтбораПериод";
	ИначеЕсли Команда.Имя = "ОтборТеги" Тогда
		ИмяСтраницы = "ЗначенияОтбораТеги";
	Иначе
		Возврат;
	КонецЕсли;
	
	СтраницаКОтображению = Элементы.Найти(ИмяСтраницы);
	Если СтраницаКОтображению = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если Элементы.ПанельЗначенийОтбора.Видимость И Элементы.ПанельЗначенийОтбора.ТекущаяСтраница = СтраницаКОтображению Тогда
		Элементы.ПанельЗначенийОтбора.Видимость = Ложь;
		Элементы[Команда.Имя].ЦветФона = Новый Цвет;
	Иначе
		Элементы.ПанельЗначенийОтбора.Видимость = Истина;
		Элементы.ПанельЗначенийОтбора.ТекущаяСтраница = СтраницаКОтображению;
		Элементы.ОтборПериод.ЦветФона = Новый Цвет;
		Элементы.ОтборТеги.ЦветФона = Новый Цвет;
		Элементы.ОтборСегменты.ЦветФона = Новый Цвет;
		Элементы[Команда.Имя].ЦветФона = ОбщегоНазначенияКлиентПовтИсп.ЦветСтиля("ФонАктивногоЗначенияОтбора");
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ПоместитьТегВТабличнуюЧасть(Форма)
	
	Если НЕ ЗначениеЗаполнено(Форма.Тег) Тогда
		Возврат;
	КонецЕсли;
	
	Объект = Форма.Объект;
	
	Если Объект.Теги.НайтиСтроки(Новый Структура("Тег", Форма.Тег)).Количество() = 0 Тогда
		
		Форма.ЗаблокироватьДанныеФормыДляРедактирования();
		Форма.Модифицированность = Истина;
		
		НоваяСтрока = Объект.Теги.Добавить();
		НоваяСтрока.Тег = Форма.Тег;
		
		Форма.ОбновитьОблакоТегов();
		
	КонецЕсли;
	
	Форма.Тег = Неопределено;
	
КонецПроцедуры

Процедура СформироватьЗаголовокВариантаОтбора(ЭлементВариантОтбора, УстановленоОтборов)
	
	ПозицияНачало = СтрНайти(ЭлементВариантОтбора.Заголовок, " (");
	Если ПозицияНачало <> 0 Тогда
		ЭлементВариантОтбора.Заголовок = Лев(ЭлементВариантОтбора.Заголовок, ПозицияНачало-1);
	КонецЕсли;
	
	Если УстановленоОтборов <> 0 Тогда
		ЭлементВариантОтбора.Заголовок = ЭлементВариантОтбора.Заголовок + " (" + УстановленоОтборов + ")";
	КонецЕсли;
	
КонецПроцедуры

Процедура ТегВыбранДляУстановки(РезультатЗакрытия, ДополнительныеПараметры) Экспорт
	
	Если Не ЗначениеЗаполнено(РезультатЗакрытия) Тогда
		Возврат;
	КонецЕсли;
	
	Успешно = КлассификацияКонтактовВызовСервера.УстановитьТег(ДополнительныеПараметры.ВладельцыТегов, РезультатЗакрытия);
	
	ПараметрыПредмета = ДополнительныеПараметры.ПараметрыПредметаИсчисленияВладельцев;
	Если ПараметрыПредмета = Неопределено Тогда
		ПараметрыПредмета = НСтр("ru='объекту,объектам,объектам'");
	КонецЕсли;
	
	ПоказатьОповещениеПользователя(
		НСтр("ru='Прикрепление тега'"),
		,
		СтрШаблон(НСтр("ru='Тег ""%1""
			|прикреплен к %2'"), РезультатЗакрытия, СтроковыеФункцииКлиентСервер.ЧислоЦифрамиПредметИсчисленияПрописью(Успешно, ПараметрыПредмета)),
		БиблиотекаКартинок.Информация32
	);
	
КонецПроцедуры

#КонецОбласти
