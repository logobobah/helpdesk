
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// СтандартныеПодсистемы.Свойства
	ПараметрыСвойств = Новый Структура("ИмяЭлементаДляРазмещения", "ГруппаДополнительныеРеквизиты");
	УправлениеСвойствами.ПриСозданииНаСервере(ЭтотОбъект, ПараметрыСвойств);
	// Конец СтандартныеПодсистемы.Свойства
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	Если Параметры.Ключ.Пустая() Тогда
		
		ПриСозданииПриЧтенииНаСервере();
		
	КонецЕсли;
	
	ЭтоВнешнийПользователь = (ТипЗнч(ПараметрыСеанса.АвторизованныйПользователь) = Тип("СправочникСсылка.ВнешниеПользователи"));
	
	УправлениеФормой();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствамиКлиент.ПослеЗагрузкиДополнительныхРеквизитов(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	ПриСозданииПриЧтенииНаСервере();
	ПриоритетПриИзмененииНаСервере();
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ПередЗаписьюНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
	ЗаписатьДанныеТегов(ТекущийОбъект);
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	// СтандартныеПодсистемы.Свойства
	Если УправлениеСвойствамиКлиент.ОбрабатыватьОповещения(ЭтотОбъект, ИмяСобытия, Параметр) Тогда
		ОбновитьЭлементыДополнительныхРеквизитов();
		УправлениеСвойствамиКлиент.ПослеЗагрузкиДополнительныхРеквизитов(ЭтотОбъект);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ОбработкаПроверкиЗаполнения(ЭтотОбъект, Отказ, ПроверяемыеРеквизиты);
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

#КонецОбласти

#Область РеквизитыФормы

&НаКлиенте
Процедура ПерейтиКОписанию(Команда)
	ТекущийЭлемент = Элементы.Описание;
КонецПроцедуры

&НаКлиенте
Процедура ПроектПриИзменении(Элемент)
	//Заказчик = ЗадачиВызовСервера.ПолучитьОсновногоЗаказчикаПроекта(Объект.Проект);
	//Если ЗначениеЗаполнено(Заказчик) И Заказчик <> Объект.Заказчик Тогда
	//	Объект.Заказчик = Заказчик;
	//КонецЕсли;
	ПриИзмененииПроектаСервер();
КонецПроцедуры

&НаКлиенте
Процедура КонтактноеЛицоЗаказчикаПриИзменении(Элемент)
	ПриИзмененииКонтактногоЛицаСервер();
КонецПроцедуры

&НаСервере
Процедура ПриИзмененииПроектаСервер()
	Если Объект.КонтактноеЛицоЗаказчика.Пустая() Тогда
		Объект.КонтактноеЛицоЗаказчика = Объект.Проект.ОсновноеКонтактноеЛицо;
		ПриИзмененииКонтактногоЛицаСервер();
	КонецЕсли;
	Документы.Задачи.ЗаполнитьМинимальныйПриоритетЗадачи(Объект);
	ПриоритетПриИзмененииНаСервере();
	Для Каждого СтрокаТег Из Объект.Проект.Теги Цикл
		ПрикрепитьТегНаСервере(СтрокаТег.Тег);
	КонецЦикла;
КонецПроцедуры

&НаСервере
Процедура ПриИзмененииКонтактногоЛицаСервер()
	Контакты = Документы.Задачи.ПолучитьКонтакты(Объект.КонтактноеЛицоЗаказчика);
КонецПроцедуры

&НаСервереБезКонтекста
Функция ПолучитьОсновнойПроектЗаказчика(Заказчик)
	
	Возврат Справочники.Проекты.ПолучитьОсновнойПроектЗаказчика(Заказчик);
	
КонецФункции

&НаКлиенте
Процедура ЗаказчикПриИзменении(Элемент)
	
	ЗаказчикПриИзмененииСервер();
	
КонецПроцедуры

&НаСервере
Процедура ЗаказчикПриИзмененииСервер()
	
	Для Каждого СтрокаТег Из Объект.Заказчик.Теги Цикл
		ПрикрепитьТегНаСервере(СтрокаТег.Тег);
	КонецЦикла;
	Объект.Проект = ПолучитьОсновнойПроектЗаказчика(Объект.Заказчик);
	ПриИзмененииПроектаСервер();
	
КонецПроцедуры

&НаСервере
Процедура ПриоритетПриИзмененииНаСервере()
	ЦветПриоритета = РегистрыСведений.ЦветаПриоритетов.ПолучитьЦветПриоритета(Объект.Приоритет);
КонецПроцедуры

&НаКлиенте
Процедура ПриоритетПриИзменении(Элемент)
	ПриоритетПриИзмененииНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура ОписаниеПриИзменении(Элемент)
	Если ПустаяСтрока(Объект.Наименование) И Не ПустаяСтрока(Объект.Описание) Тогда
		Объект.Наименование = СтрПолучитьСтроку(Объект.Описание,1);
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ИсполнительПриИзмененииНаСервере()
	
	Если Объект.КалендарьСотрудника.Пустая() ИЛИ Объект.КалендарьСотрудника.ВладелецКалендаря <> Объект.Исполнитель Тогда
		Объект.КалендарьСотрудника = Объект.Исполнитель.ОсновнойКалендарь;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ИсполнительПриИзменении(Элемент)
	ИсполнительПриИзмененииНаСервере();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
	ПодключаемыеКомандыКлиент.ВыполнитьКоманду(ЭтотОбъект, Команда, Объект);
КонецПроцедуры

&НаСервере
Процедура Подключаемый_ВыполнитьКомандуНаСервере(Контекст, Результат)
	ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, Контекст, Объект, Результат);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

#КонецОбласти

#Область Теги

&НаСервере
Процедура ПрочитатьДанныеТегов()
	
	ДанныеТегов.Очистить();
	
	//Если Не ЗначениеЗаполнено(Объект.Ссылка) Тогда
	//	Возврат;
	//КонецЕсли;
	
	Для Каждого СтрокаТЧ Из Объект.Теги Цикл
		
		НовыеДанныеТега = ДанныеТегов.Добавить();
		НавигационнаяСсылкаФС = "Тег_" + НовыеДанныеТега.ПолучитьИдентификатор();
		
		НовыеДанныеТега.Тег = СтрокаТЧ.Тег;
		НовыеДанныеТега.ПометкаУдаления = СтрокаТЧ.Тег.ПометкаУдаления;
		НовыеДанныеТега.ПредставлениеТега = ФорматированнаяСтрокаПредставленияТега(СтрокаТЧ.Тег.Наименование, СтрокаТЧ.Тег.ПометкаУдаления, НавигационнаяСсылкаФС);
		НовыеДанныеТега.ДлинаТега = СтрДлина(СтрокаТЧ.Тег.Наименование);
		
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьЭлементыТегов()
	
	ФС = ДанныеТегов.Выгрузить(, "ПредставлениеТега").ВыгрузитьКолонку("ПредставлениеТега");
	
	Индекс = ФС.Количество()-1;
	Пока Индекс > 0 Цикл
		ФС.Вставить(Индекс, "  ");
		Индекс = Индекс - 1;
	КонецЦикла;
	
	Элементы.ОблакоТегов.Заголовок	= Новый ФорматированнаяСтрока(ФС);
	Элементы.ОблакоТегов.Видимость	= ФС.Количество() > 0;
	
	Элементы.ТегиИОтступ.Видимость = (ФС.Количество() > 0);
КонецПроцедуры

&НаСервере
Процедура ЗаписатьДанныеТегов(ТекущийОбъект)
	
	ТекущийОбъект.Теги.Загрузить(ДанныеТегов.Выгрузить(,"Тег"));
	
КонецПроцедуры

&НаСервере
Процедура ПрикрепитьТегНаСервере(Тег)
	
	Если ДанныеТегов.НайтиСтроки(Новый Структура("Тег", Тег)).Количество() > 0 Тогда
		Возврат;
	КонецЕсли;
	
	ДанныеТега = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Тег, "Наименование, ПометкаУдаления");
	
	СтрокаТегов = ДанныеТегов.Добавить();
	НавигационнаяСсылкаФС = "Тег_" + СтрокаТегов.ПолучитьИдентификатор();
	
	СтрокаТегов.Тег = Тег;
	СтрокаТегов.ПометкаУдаления = ДанныеТега.ПометкаУдаления;
	СтрокаТегов.ПредставлениеТега = ФорматированнаяСтрокаПредставленияТега(ДанныеТега.Наименование, ДанныеТега.ПометкаУдаления, НавигационнаяСсылкаФС);
	СтрокаТегов.ДлинаТега = СтрДлина(ДанныеТега.Наименование);
	
	ОбновитьЭлементыТегов();
	
	Модифицированность = Истина;
	
КонецПроцедуры

&НаСервере
Процедура СоздатьИПрикрепитьТегНаСервере(знач ЗаголовокТега)
	
	Тег = НайтиСоздатьТег(ЗаголовокТега);
	ПрикрепитьТегНаСервере(Тег);
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция НайтиСоздатьТег(Знач ЗаголовокТега)
	
	Тег = Справочники.Теги.НайтиПоНаименованию(ЗаголовокТега, Истина);
	
	Если Тег.Пустая() Тогда
		
		ТегОбъект = Справочники.Теги.СоздатьЭлемент();
		ТегОбъект.Наименование = ЗаголовокТега;
		ТегОбъект.Актуален = Истина;
		ТегОбъект.Записать();
		Тег = ТегОбъект.Ссылка;
		
	КонецЕсли;
	
	Возврат Тег;
	
КонецФункции

&НаКлиентеНаСервереБезКонтекста
Функция ФорматированнаяСтрокаПредставленияТега(НаименованиеТега, ПометкаУдаления, НавигационнаяСсылкаФС)
	
	#Если Клиент Тогда
	Цвет = ОбщегоНазначенияКлиентПовтИсп.ЦветСтиля("ТекстВторостепеннойНадписи");
	БазовыйШрифт = ОбщегоНазначенияКлиентПовтИсп.ШрифтСтиля("ОбычныйШрифтТекста");
	#Иначе
	Цвет = ЦветаСтиля.ТекстВторостепеннойНадписи;
	БазовыйШрифт = ШрифтыСтиля.ОбычныйШрифтТекста;
	#КонецЕсли
	
	Шрифт = Новый Шрифт(БазовыйШрифт,,,Истина,,?(ПометкаУдаления, Истина, Неопределено));
	
	КомпонентыФС = Новый Массив;
	КомпонентыФС.Добавить(Новый ФорматированнаяСтрока(НаименованиеТега + Символы.НПП, Шрифт, Цвет));
	КомпонентыФС.Добавить(Новый ФорматированнаяСтрока(БиблиотекаКартинок.Очистить, , , , НавигационнаяСсылкаФС));
	
	Возврат Новый ФорматированнаяСтрока(КомпонентыФС);
	
КонецФункции

&НаКлиенте
Процедура ПолеВводаТегаОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	Если Не ЗначениеЗаполнено(ВыбранноеЗначение) Тогда
		Возврат;
	КонецЕсли;
	
	СтандартнаяОбработка = Ложь;
	
	Если ТипЗнч(ВыбранноеЗначение) = Тип("СправочникСсылка.Теги") Тогда
		ПрикрепитьТегНаСервере(ВыбранноеЗначение);
	КонецЕсли;
	Элемент.ОбновитьТекстРедактирования();
	
КонецПроцедуры

&НаКлиенте
Процедура ПолеВводаТегаОкончаниеВводаТекста(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, СтандартнаяОбработка)
	
	Если Не ПустаяСтрока(Текст) Тогда
		СтандартнаяОбработка = Ложь;
		СоздатьИПрикрепитьТегНаСервере(Текст);
		ТекущийЭлемент = Элементы.ПолеВводаТега;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОблакоТеговОбработкаНавигационнойСсылки(Элемент, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ТегИД = Сред(НавигационнаяСсылкаФорматированнойСтроки, СтрДлина("Тег_")+1);
	СтрокаТегов = ДанныеТегов.НайтиПоИдентификатору(ТегИД);
	ДанныеТегов.Удалить(СтрокаТегов);
	
	ОбновитьЭлементыТегов();
	
	Модифицированность = Истина;
	
КонецПроцедуры

#КонецОбласти

#Область СтандартныеПодсистемыСвойства

&НаКлиенте
Процедура Подключаемый_СвойстваВыполнитьКоманду(ЭлементИлиКоманда, НавигационнаяСсылка = Неопределено, СтандартнаяОбработка = Неопределено)
	
	УправлениеСвойствамиКлиент.ВыполнитьКоманду(ЭтотОбъект, ЭлементИлиКоманда, СтандартнаяОбработка);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьЗависимостиДополнительныхРеквизитов()
	УправлениеСвойствамиКлиент.ОбновитьЗависимостиДополнительныхРеквизитов(ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПриИзмененииДополнительногоРеквизита(Элемент)
	УправлениеСвойствамиКлиент.ОбновитьЗависимостиДополнительныхРеквизитов(ЭтотОбъект);
КонецПроцедуры

&НаСервере
Процедура ОбновитьЭлементыДополнительныхРеквизитов()
	
	УправлениеСвойствами.ОбновитьЭлементыДополнительныхРеквизитов(ЭтотОбъект);
	
КонецПроцедуры

#КонецОбласти

&НаСервере
Процедура ПриСозданииПриЧтенииНаСервере()
	
	ПрочитатьДанныеТегов();
	ОбновитьЭлементыТегов();
	
КонецПроцедуры

&НаСервере
Процедура УправлениеФормой()
	
	Если ЭтоВнешнийПользователь Тогда
		Элементы.Заказчик.ТолькоПросмотр = Истина;
		Элементы.Статус.ТолькоПросмотр = Истина;
		Элементы.Приоритет.ТолькоПросмотр = Истина;
		Элементы.ОценкаТрудозатрат.ТолькоПросмотр = Истина;
	КонецЕсли;

КонецПроцедуры




