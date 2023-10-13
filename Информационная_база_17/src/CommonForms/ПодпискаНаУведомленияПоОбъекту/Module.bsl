#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// Пропускаем инициализацию, чтобы гарантировать получение формы при передаче параметра "АвтоТест".
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	//ДоступнаОтправкаSMS = ОтправкаSMS.ДоступнаОтправкаSMS();
	ОбъектПодписки = Параметры.ОбъектПодписки;
	Пользователь = Пользователи.ТекущийПользователь();
	
	ПолучитьПодписки();
	УстановитьВидимостьЭлементов();
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	
	Если ОбщегоНазначенияСУЗКлиент.ПередЗакрытием(
		Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка, Модифицированность) Тогда
		Возврат;
	КонецЕсли;
	
	Если Модифицированность Тогда
		
		Отказ = Истина;
		ОписаниеОповещения = Новый ОписаниеОповещения("ПередЗакрытиемЗавершение", ЭтотОбъект);
		ТекстВопроса = НСтр("ru = 'Подписки были изменены. Сохранить изменения?'");
		
		ПоказатьВопрос(ОписаниеОповещения, ТекстВопроса, РежимДиалогаВопрос.ДаНетОтмена);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытиемЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат = КодВозвратаДиалога.Да Тогда
		СохранитьПодписки();
		Закрыть();
	ИначеЕсли Результат = КодВозвратаДиалога.Нет Тогда
		Модифицированность = Ложь;
		Закрыть();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ПодпискиНаБизнесСобытияВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	ТекущиеДанные = Элемент.ТекущиеДанные;
	Если Поле = Элементы.ПодпискиУведомленийПоПочтеСтрокой Тогда
		ИзменитьПодписку(
			ТекущиеДанные.ПоПочте,
			ТекущиеДанные.ПоПочтеСтрокой,
			ТекущиеДанные.ВозможнаПодпискаНаСобытие);
	ИначеЕсли Поле = Элементы.ПодпискиУведомленийОкномСтрокой Тогда
		ИзменитьПодписку(
			ТекущиеДанные.Окном,
			ТекущиеДанные.ОкномСтрокой,
			ТекущиеДанные.ВозможнаПодпискаНаСобытие);
	ИначеЕсли Поле = Элементы.ПодпискиУведомленийПоSMSСтрокой Тогда
		ИзменитьПодписку(
			ТекущиеДанные.ПоSMS,
			ТекущиеДанные.ПоSMSСтрокой,
			ТекущиеДанные.ВозможнаПодпискаНаСобытие);
	ИначеЕсли Поле = Элементы.ПодпискиУведомленийПоPushСтрокой Тогда
		ИзменитьПодписку(
			ТекущиеДанные.ПоPush,
			ТекущиеДанные.ПоPushСтрокой,
			ТекущиеДанные.ВозможнаПодпискаНаСобытие);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПользовательПриИзменении(Элемент)
	
	ПолучитьПодписки();
	
КонецПроцедуры

&НаКлиенте
Процедура ПользовательНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("РежимРаботыФормы", 1);
	ПараметрыФормы.Вставить("РежимВыбора", Истина);
	ПараметрыФормы.Вставить("УпрощенныйИнтерфейс", Истина);
	ПараметрыФормы.Вставить("ОтображатьСотрудников", Истина);
	
	Если ЗначениеЗаполнено(Пользователь) Тогда
		ПараметрыФормы.Вставить("ВыбранныеАдресаты", Пользователь);
	КонецЕсли;
	ПараметрыФормы.Вставить("ЗаголовокФормы", НСтр("ru = 'Выбор пользователя'"));
	
	РаботаСАдреснойКнигойКлиент.ВыбратьАдресатов(ПараметрыФормы, Элемент, Неопределено);
	
КонецПроцедуры

&НаКлиенте
Процедура ПользовательОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	Если Модифицированность Тогда
		
		СтандартнаяОбработка = Ложь;
		ПараметрыОбработчикаОповещения = Новый Структура;
		ПараметрыОбработчикаОповещения.Вставить("ВыбранноеЗначение", ВыбранноеЗначение);
		ОписаниеОповещения = Новый ОписаниеОповещения(
			"ПользовательОбработкаВыбораЗавершение", ЭтотОбъект, ПараметрыОбработчикаОповещения);
		ТекстВопроса = НСтр("ru = 'Подписки были изменены. Сохранить изменения?'");
		
		ПоказатьВопрос(ОписаниеОповещения, ТекстВопроса, РежимДиалогаВопрос.ДаНетОтмена);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПользовательОбработкаВыбораЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат = КодВозвратаДиалога.Да Тогда
		СохранитьПодписки();
		Пользователь = ДополнительныеПараметры.ВыбранноеЗначение;
		ПолучитьПодписки();
	ИначеЕсли Результат = КодВозвратаДиалога.Нет Тогда
		Модифицированность = Ложь;
		Пользователь = ДополнительныеПараметры.ВыбранноеЗначение;
		ПолучитьПодписки();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Готово(Команда)
	
	СохранитьПодписки();
	Закрыть();
	
КонецПроцедуры

&НаКлиенте
Процедура Записать(Команда)
	
	СохранитьПодписки();
	
КонецПроцедуры

&НаКлиенте
Процедура Отмена(Команда)
	
	Модифицированность = Ложь;
	Закрыть();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура СохранитьПодписки()
	
	НачатьТранзакцию();
	Попытка
		
		Для Каждого Подписка Из ПодпискиУведомлений Цикл
			Если Подписка.ПоПочте = 2 Тогда
				РегистрыСведений.НастройкиУведомлений.УдалитьПодпискуПоОбъекту(
					Пользователь,
					Подписка.ВидСобытия,
					Перечисления.СпособыУведомления.ПоПочте,
					ОбъектПодписки);
			Иначе
				РегистрыСведений.НастройкиУведомлений.УстановитьПодпискуПоОбъекту(
					Пользователь,
					Подписка.ВидСобытия,
					Перечисления.СпособыУведомления.ПоПочте,
					ОбъектПодписки,
					Булево(Подписка.ПоПочте));
			КонецЕсли;
			Если Подписка.Окном = 2 Тогда
				РегистрыСведений.НастройкиУведомлений.УдалитьПодпискуПоОбъекту(
					Пользователь,
					Подписка.ВидСобытия,
					Перечисления.СпособыУведомления.Окном,
					ОбъектПодписки);
			Иначе
				РегистрыСведений.НастройкиУведомлений.УстановитьПодпискуПоОбъекту(
					Пользователь,
					Подписка.ВидСобытия,
					Перечисления.СпособыУведомления.Окном,
					ОбъектПодписки,
					Булево(Подписка.Окном));
			КонецЕсли;
			Если ДоступнаОтправкаSMS Тогда
				Если Подписка.ПоSMS = 2 Тогда
					РегистрыСведений.НастройкиУведомлений.УдалитьПодпискуПоОбъекту(
						Пользователь,
						Подписка.ВидСобытия,
						Перечисления.СпособыУведомления.ПоSMS,
						ОбъектПодписки);
				Иначе
					РегистрыСведений.НастройкиУведомлений.УстановитьПодпискуПоОбъекту(
						Пользователь,
						Подписка.ВидСобытия,
						Перечисления.СпособыУведомления.ПоSMS,
						ОбъектПодписки,
						Булево(Подписка.ПоSMS));
				КонецЕсли;
			КонецЕсли;
			Если ПолучитьФункциональнуюОпцию("ИспользоватьPushУведомления") Тогда
				Если Подписка.ПоPush = 2 Тогда
					РегистрыСведений.НастройкиУведомлений.УдалитьПодпискуПоОбъекту(
						Пользователь,
						Подписка.ВидСобытия,
						Перечисления.СпособыУведомления.ПоPush,
						ОбъектПодписки);
				Иначе
					РегистрыСведений.НастройкиУведомлений.УстановитьПодпискуПоОбъекту(
						Пользователь,
						Подписка.ВидСобытия,
						Перечисления.СпособыУведомления.ПоPush,
						ОбъектПодписки,
						Булево(Подписка.ПоPush));
				КонецЕсли;
			КонецЕсли;
		КонецЦикла;
		
		ЗафиксироватьТранзакцию();
		
	Исключение
		ОтменитьТранзакцию();
		ВызватьИсключение;
	КонецПопытки;
	
	Модифицированность = Ложь;
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Функция СтрокаПодписка(Подписка, ВозможнаПодпискаНаСобытие)
	
	Если ВозможнаПодпискаНаСобытие Тогда
		
		Если Подписка = 0 Тогда
			Возврат НСтр("ru = 'Нет'");
		ИначеЕсли Подписка = 1 Тогда
			Возврат НСтр("ru = 'Да'");
		ИначеЕсли Подписка = 2 Тогда
			Возврат НСтр("ru = 'Авто'");
		КонецЕсли;
		
	Иначе
		
		Если Подписка = 0 Или Подписка = 2 Тогда
			Возврат НСтр("ru = 'Нет'");
		ИначеЕсли Подписка = 1 Тогда
			Возврат НСтр("ru = 'Да'");
		КонецЕсли;
		
	КонецЕсли;
	
КонецФункции

&НаКлиенте
Процедура ИзменитьПодписку(Подписка, ПодпискаСтрокой, ВозможнаПодпискаНаСобытие)
	
	Модифицированность = Истина;
	
	Подписка = Подписка - 1;
	Если Подписка < 0 Тогда
		Если ВозможнаПодпискаНаСобытие Тогда
			Подписка = 2;
		Иначе
			Подписка = 1;
		КонецЕсли;
	ИначеЕсли Подписка = 0 И Не ВозможнаПодпискаНаСобытие Тогда
		Подписка = 2;
	КонецЕсли;
	ПодпискаСтрокой = СтрокаПодписка(Подписка, ВозможнаПодпискаНаСобытие);
	
КонецПроцедуры

&НаСервере
Процедура ПолучитьПодписки()
	
	ПодпискиУведомлений.Очистить();
	Для Каждого ЭлементСписка Из Перечисления.СобытияУведомлений.ВидыСобытийПоОбъекту(ОбъектПодписки) Цикл
		
		// Строка подписки
		СтрокаПодписки = ПодпискиУведомлений.Добавить();
		СтрокаПодписки.ВидСобытия = ЭлементСписка.Значение;
		СтрокаПодписки.Представление = ЭлементСписка.Представление;
		СтрокаПодписки.ВозможнаПодпискаНаСобытие = Перечисления.СобытияУведомлений.ДоступнаПодпискаНаСобытие(
			ЭлементСписка.Значение,
			ОбъектПодписки);
		
		// По почте
		ЗначениеПодписки = РегистрыСведений.НастройкиУведомлений.ПолучитьПодпискуПоОбъекту(
			Пользователь,
			ЭлементСписка.Значение,
			Перечисления.СпособыУведомления.ПоПочте,
			ОбъектПодписки);
		Если ЗначениеПодписки <> Неопределено Тогда
			СтрокаПодписки.ПоПочте = ЗначениеПодписки;
		Иначе
			СтрокаПодписки.ПоПочте = 2;
		КонецЕсли;
		СтрокаПодписки.ПоПочтеСтрокой = СтрокаПодписка(
			СтрокаПодписки.ПоПочте,
			СтрокаПодписки.ВозможнаПодпискаНаСобытие);
		
		// Окном
		ЗначениеПодписки = РегистрыСведений.НастройкиУведомлений.ПолучитьПодпискуПоОбъекту(
			Пользователь,
			ЭлементСписка.Значение,
			Перечисления.СпособыУведомления.Окном,
			ОбъектПодписки);
		Если ЗначениеПодписки <> Неопределено Тогда
			СтрокаПодписки.Окном = ЗначениеПодписки;
		Иначе
			СтрокаПодписки.Окном = 2;
		КонецЕсли;
		СтрокаПодписки.ОкномСтрокой = СтрокаПодписка(
			СтрокаПодписки.Окном,
			СтрокаПодписки.ВозможнаПодпискаНаСобытие);
		
		// По SMS
		Если ДоступнаОтправкаSMS Тогда
			ЗначениеПодписки = РегистрыСведений.НастройкиУведомлений.ПолучитьПодпискуПоОбъекту(
				Пользователь,
				ЭлементСписка.Значение,
				Перечисления.СпособыУведомления.ПоSMS,
				ОбъектПодписки);
			Если ЗначениеПодписки <> Неопределено Тогда
				СтрокаПодписки.ПоSMS = ЗначениеПодписки;
			Иначе
				СтрокаПодписки.ПоSMS = 2;
			КонецЕсли;
			СтрокаПодписки.ПоSMSСтрокой = СтрокаПодписка(
				СтрокаПодписки.ПоSMS,
				СтрокаПодписки.ВозможнаПодпискаНаСобытие);
		КонецЕсли;
		
		// По push
		Если ПолучитьФункциональнуюОпцию("ИспользоватьPushУведомления") Тогда
			ЗначениеПодписки = РегистрыСведений.НастройкиУведомлений.ПолучитьПодпискуПоОбъекту(
				Пользователь,
				ЭлементСписка.Значение,
				Перечисления.СпособыУведомления.ПоPush,
				ОбъектПодписки);
			Если ЗначениеПодписки <> Неопределено Тогда
				СтрокаПодписки.ПоPush = ЗначениеПодписки;
			Иначе
				СтрокаПодписки.ПоPush = 2;
			КонецЕсли;
			СтрокаПодписки.ПоPushСтрокой = СтрокаПодписка(
				СтрокаПодписки.ПоPush,
				СтрокаПодписки.ВозможнаПодпискаНаСобытие);
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьВидимостьЭлементов()
	
	Если РольДоступна("ПолныеПрава") Тогда
		Элементы.ГруппаПользователь.Видимость = Истина;
		Элементы.Пользователь.Видимость = Истина;
		Элементы.Записать.Видимость = Истина;
		Элементы.ПодпискиУведомленийПоPushСтрокой.Видимость = Истина;
	Иначе
		Элементы.ГруппаПользователь.Видимость = Ложь;
		Элементы.Пользователь.Видимость = Ложь;
		Элементы.Записать.Видимость = Ложь;
		Элементы.ПодпискиУведомленийПоPushСтрокой.Видимость =
			ПланыОбмена.Мобильный.ЕстьУзлыПользователя(Пользователь);
	КонецЕсли;
	Элементы.ПодпискиУведомленийПоSMSСтрокой.Видимость = ДоступнаОтправкаSMS;
	
КонецПроцедуры

#КонецОбласти