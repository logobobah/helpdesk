
// Записывает персональную настройку синхронизации с мобильными клиентами
// Параметры:
//	Пользователь - ссылка на пользователя
//	ТипНастройки - ссылка на перечисление ОбменСМобильнымиТипыНастроекПользователей
//	Значение - значение настройки
Процедура ЗаписатьНастройку(Пользователь, ТипНастройки, Значение) Экспорт

	МенеджерЗаписи = РегистрыСведений.ОбменСМобильнымиНастройкиПользователей.СоздатьМенеджерЗаписи();

	МенеджерЗаписи.Пользователь = Пользователь;
	МенеджерЗаписи.Настройка    = ТипНастройки;
	МенеджерЗаписи.Значение     = Значение;

	МенеджерЗаписи.Записать();

КонецПроцедуры

// Возвращает персональную настройку синхронизации с мобильными клиентами.
// Если настройка ранее не выполнялась, то возвращается значение по умолчанию.
// Параметры:
//	Пользователь - ссылка на пользователя
//	ТипНастройки - ссылка на перечисление ОбменСМобильнымиТипыНастроекПользователей
Функция ПолучитьНастройку(Пользователь, ТипНастройки) Экспорт

	МенеджерЗаписи = РегистрыСведений.ОбменСМобильнымиНастройкиПользователей.СоздатьМенеджерЗаписи();

	МенеджерЗаписи.Пользователь = Пользователь;
	МенеджерЗаписи.Настройка    = ТипНастройки;
	МенеджерЗаписи.Прочитать();

	Если МенеджерЗаписи.Значение = Неопределено 
	 Или Не МенеджерЗаписи.Выбран() Тогда

		МенеджерЗаписи.Пользователь = Пользователь;
		МенеджерЗаписи.Настройка    = ТипНастройки;

		Если ТипНастройки = 
			Перечисления.ОбменСМобильнымиТипыНастроекПользователей.МаксимальныйРазмерФайлов Тогда
			МенеджерЗаписи.Значение = 512;

		ИначеЕсли ТипНастройки = 
			Перечисления.ОбменСМобильнымиТипыНастроекПользователей.ПериодПервичнойЗагрузки Тогда
			МенеджерЗаписи.Значение = 7;

		ИначеЕсли ТипНастройки = 
			Перечисления.ОбменСМобильнымиТипыНастроекПользователей.СинхронизацияЗадач Тогда
			МенеджерЗаписи.Значение = Истина;

		ИначеЕсли ТипНастройки = 
			Перечисления.ОбменСМобильнымиТипыНастроекПользователей.СинхронизацияКалендаря Тогда
			МенеджерЗаписи.Значение = Истина;

		ИначеЕсли ТипНастройки = 
			Перечисления.ОбменСМобильнымиТипыНастроекПользователей.СинхронизацияПочты Тогда
			МенеджерЗаписи.Значение = Истина;

		ИначеЕсли ТипНастройки = 
			Перечисления.ОбменСМобильнымиТипыНастроекПользователей.СинхронизацияКонтроля Тогда
			МенеджерЗаписи.Значение = Истина;

		ИначеЕсли ТипНастройки = 
			Перечисления.ОбменСМобильнымиТипыНастроекПользователей.СрокУстареванияДанных Тогда
			МенеджерЗаписи.Значение = 14;

		ИначеЕсли ТипНастройки = 
			Перечисления.ОбменСМобильнымиТипыНастроекПользователей.ОграничениеФорматовПередаваемыхФайлов Тогда
			МенеджерЗаписи.Значение = Ложь;

		ИначеЕсли ТипНастройки = 
			Перечисления.ОбменСМобильнымиТипыНастроекПользователей.ФорматыПередаваемыхФайлов Тогда
			МенеджерЗаписи.Значение = 
				ОбменСМобильнымиСервер.СписокФорматовФайловПередаваемыхНаМобильныйКлиент();

		ИначеЕсли ТипНастройки = 
			Перечисления.ОбменСМобильнымиТипыНастроекПользователей.ПодробныйПротоколОбменаСМобильнымУстройством Тогда
			МенеджерЗаписи.Значение = Ложь;

		КонецЕсли;

		МенеджерЗаписи.Записать();

	КонецЕсли;

	Возврат МенеджерЗаписи.Значение;

КонецФункции