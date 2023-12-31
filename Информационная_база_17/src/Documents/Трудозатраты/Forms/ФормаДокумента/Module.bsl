#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ПриСозданииНаСервере(ЭтотОбъект, Новый Структура("ИмяЭлементаДляРазмещения", "ГруппаДополнительныеРеквизиты"));
	// Конец СтандартныеПодсистемы.Свойства
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	Если Объект.Ссылка.Пустая() Тогда
		Объект.Автор = ПараметрыСеанса.ТекущийПользователь;
		Объект.Состояние = Перечисления.СостоянияТрудозатрат.Новый;
	КонецЕсли;
	
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
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
	// СтандартныеПодсистемы.ДатыЗапретаИзменения
	ДатыЗапретаИзменения.ОбъектПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.ДатыЗапретаИзменения
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ПередЗаписьюНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
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

&НаКлиенте
Процедура Заполнить(Команда)
	
	//Если Объект.Работы.Количество() > 0 Тогда
	//	Ответ = Вопрос("Табличная часть будет перезаполнена. Продолжить?",РежимДиалогаВопрос.ДаНет,,КодВозвратаДиалога.Да);
	//	Если Ответ = КодВозвратаДиалога.Нет Тогда
	//		Возврат;
	//	КонецЕсли;
	//КонецЕсли;
	Если Объект.Заказчик.Пустая() Тогда
		Сообщить("Заказчик не заполнен. Действие отменено.");
		Возврат;
	КонецЕсли;
	//Если Объект.Отдел.Пустая() Тогда
	//	Сообщить("Подразделение не заполнено. Действие отменено.");
	//	Возврат;
	//КонецЕсли;
	
	ЗаполнитьНаСервере();
	Модифицированность = Истина;
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьОплаты(Команда)
	ЗаполнитьНаСервере(Истина);
	Модифицированность = Истина;
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьНаСервере(ТолькоОплаты = Ложь)
	
	Если Не ТолькоОплаты Тогда
		ТЗРаботы = Документы.Трудозатраты.ЗаполнитьТабличнуюЧасть(Объект.Дата, Объект.Отдел, Объект.Заказчик, Объект.Ссылка);
		Объект.Работы.Загрузить(ТЗРаботы);
	КонецЕсли;
	//Заполнение ТЧ Оплаты
	Объект.Оплата.Загрузить(Документы.Трудозатраты.ЗаполнитьОплату(Объект.Работы.Выгрузить(), Объект.Дата, Объект.Организация));
	
КонецПроцедуры	
	
&НаКлиенте
Процедура РаботыКоличествоПриИзменении(Элемент)
	ТЧ = Элементы.Работы.ТекущиеДанные;
	ТЧ.Сумма = ТЧ.Количество * ТЧ.Цена;
КонецПроцедуры

&НаКлиенте
Процедура СостояниеПриИзменении(Элемент)
	
	Если Объект.Состояние = ПредопределенноеЗначение("Перечисление.СостоянияТрудозатрат.Оплачен") Тогда
		ТекДата = ТекущаяДата();
		Для Каждого СтрокаТЧ Из Объект.Оплата Цикл
			Если СтрокаТЧ.Дата = '00010101' Тогда
				СтрокаТЧ.Дата = ТекДата;
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура РаботыЗадачаПриИзмененииНаСервере()
	СтрокаТЧ = Объект.Работы.НайтиПоИдентификатору(Элементы.Работы.ТекущаяСтрока);
	СтрокаТЧ.Проект = СтрокаТЧ.Задача.Проект;
	СтрокаТЧ.Исполнитель = СтрокаТЧ.Задача.Исполнитель;
	СтрокаТЧ.Количество = СтрокаТЧ.Задача.ОценкаТрудозатрат;
	СтрокаТЧ.Цена = РегистрыСведений.ЧасовыеСтавкиЗадач.ПолучитьЦенуЗадачи(СтрокаТЧ.Задача);
	СтрокаТЧ.Сумма = СтрокаТЧ.Количество * СтрокаТЧ.Цена;
КонецПроцедуры

&НаКлиенте
Процедура РаботыЗадачаПриИзменении(Элемент)
	РаботыЗадачаПриИзмененииНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура ОплатаПриИзменении(Элемент)
	Объект.СуммаОплатыЗаказчиком = 0;
	Объект.СуммаОплатыИсполнителям = 0;
	Для Каждого СтрокаТЧ Из Объект.Оплата Цикл
		Если ЗначениеЗаполнено(СтрокаТЧ.Дата) Тогда
			Если СтрокаТЧ.Сумма < 0 Тогда
				Объект.СуммаОплатыЗаказчиком = Объект.СуммаОплатыЗаказчиком - СтрокаТЧ.Сумма;
			ИначеЕсли Не СтрокаТЧ.Исполнитель.Пустая() Тогда
				Объект.СуммаОплатыИсполнителям = Объект.СуммаОплатыИсполнителям + СтрокаТЧ.Сумма;
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
КонецПроцедуры


