#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Возвращает вид события по настройке уведомления.
//
// Параметры:
//  Настройка - ПеречислениеСсылка.НастройкиУведомлений - Настройка.
//
// Возвращаемое значение:
//  СправочникСсылка.ВидыБизнесСобытий, ПеречислениеСсылка.СобытияУведомлений - Вид события.
//
Функция ВидСобытия(Настройка) Экспорт
	
	ВидСобытия = Неопределено;
	Если Настройка = ВыполнениеЗадачПоПочте Тогда
		ВидСобытия = Справочники.ВидыБизнесСобытий.СозданиеЗадачи;
	ИначеЕсли Настройка = ПроцентноеИзменение Тогда
		ВидСобытия = Справочники.ВидыБизнесСобытий.ИзменениеЗначенияПоказателяПроцесса;
	КонецЕсли;
	
	Возврат ВидСобытия;
	
КонецФункции

// Формирует массив связанных подписок.
//
// Параметры:
//  ВидСобытия - СправочникСсылка.ВидыБизнесСобытий, ПеречислениеСсылка.СобытияУведомлений - Вид события.
//
// Возвращаемое значение:
//  Массив - Связанные подписки.
//
Функция СвязанныеПодписки(ВидСобытия) Экспорт
	
	СвязанныеПодписки = Новый Массив;
	Если ВидСобытия = Справочники.ВидыБизнесСобытий.СозданиеЗадачи Тогда
		СвязанныеПодписки.Добавить(Справочники.ВидыБизнесСобытий.ПеренаправлениеЗадачи);
	КонецЕсли;
	
	Возврат СвязанныеПодписки;
	
КонецФункции

// Формирует стандартное значение настройки.
//
// Параметры:
//  Настройка - ПеречислениеСсылка.НастройкиУведомлений - Настройка.
//  ВидСобытия - СправочникСсылка.ВидыБизнесСобытий, ПеречислениеСсылка.СобытияУведомлений - Вид события.
//  СпособУведомления - ПеречислениеСсылка.СпособыУведомления - Способ уведомления.
//
// Возвращаемое значение:
//  Булево, Строка, Число - Значение настройки.
//
Функция СтандартноеЗначениеНастройки(Настройка, ВидСобытия, СпособУведомления) Экспорт
	
	Значение = Неопределено;
	
	Если Настройка = Подписка Тогда
		
		Если СпособУведомления = Перечисления.СпособыУведомления.ПоПочте Тогда
			
			Если ВидСобытия = Справочники.ВидыБизнесСобытий.СозданиеЗадачи
				Или ВидСобытия = Справочники.ВидыБизнесСобытий.ПеренаправлениеЗадачи
				Или ВидСобытия = Справочники.ВидыБизнесСобытий.ОтменаВыполненияЗадачи
				Или ВидСобытия = Справочники.ВидыБизнесСобытий.НазначениеОтветственного
				Или ВидСобытия = Перечисления.СобытияУведомлений.ПодошелСрокЗадачи
				Или ВидСобытия = Перечисления.СобытияУведомлений.ПросроченаЗадача
				Или ВидСобытия = Перечисления.СобытияУведомлений.ПросроченаЗадачаАвтора
				Или ВидСобытия = Справочники.ВидыБизнесСобытий.СозданиеСообщения
				Или ВидСобытия = Перечисления.СобытияУведомлений.УведомлениеПрограммы
				Или ВидСобытия = Перечисления.СобытияУведомлений.ВыполнениеМоейЗадачи
				Или ВидСобытия = Перечисления.СобытияУведомлений.ПеренаправлениеМоейЗадачи Тогда
				Значение = Истина;
			Иначе
				Значение = Ложь;
			КонецЕсли;
			
		ИначеЕсли СпособУведомления = Перечисления.СпособыУведомления.Окном Тогда
			
			Если ВидСобытия = Справочники.ВидыБизнесСобытий.СозданиеЗадачи
				Или ВидСобытия = Справочники.ВидыБизнесСобытий.ПеренаправлениеЗадачи
				Или ВидСобытия = Справочники.ВидыБизнесСобытий.ОтменаВыполненияЗадачи
				Или ВидСобытия = Справочники.ВидыБизнесСобытий.НазначениеОтветственного
				Или ВидСобытия = Перечисления.СобытияУведомлений.УведомлениеПрограммы Тогда
				Значение = Истина;
			Иначе
				Значение = Ложь;
			КонецЕсли;
			
		Иначе
			
			Значение = Ложь;
			
		КонецЕсли;
		
	ИначеЕсли Настройка = СрокУведомления Тогда
		
		Если ВидСобытия = Перечисления.СобытияУведомлений.ПодошелСрокЗадачи Тогда
			Значение = 3;
		Иначе
			Значение = 3;
		КонецЕсли;
		
	ИначеЕсли Настройка = ЧастотаУведомления Тогда
		
		Если ВидСобытия = Перечисления.СобытияУведомлений.ПодошелСрокЗадачи Тогда
			Значение = 0;
		ИначеЕсли ВидСобытия = Перечисления.СобытияУведомлений.ПросроченаЗадача Тогда
			Значение = 1;
		Иначе
			Значение = 0;
		КонецЕсли;
		
	ИначеЕсли Настройка = ВыполнениеЗадачПоПочте Тогда
		
		Значение = Ложь;
		
	ИначеЕсли Настройка = ПроцентноеИзменение Тогда
		
		Значение = 5;
		
	КонецЕсли;
	
	Возврат Значение;
	
КонецФункции

#КонецОбласти

#КонецЕсли