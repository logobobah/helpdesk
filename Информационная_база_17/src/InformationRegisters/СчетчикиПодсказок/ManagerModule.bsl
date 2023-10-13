#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Возвращает признак того, что значение счетчика для отображения подсказок
// пользователю превысило граничное значение. В случае если значение 
// не превышено, значение счетчика в ИБ увеличивается.
//
// Параметры:
//  ВидПодсказки 		- ПеречислениеСсылка.ВидыПодсказок - вид подсказки
//               		для получения значения счетчика.
//  ГраничноеЗначение 	- Число - граничное значение счетчика, по достижению
//                    	которого подсказка не должна отображаться пользователю.
//  Пользователь 		- СправочникСсылка.Пользователи - пользователь.
//               		Если не указан, то используется текущий пользователь.
//  Организация 		- СправочникСсылка.Организации - организация.
//               		Если не указана, то используется пустая ссылка.
//  АвтоИнкремент 		- Булево - значение счетчика будет увеличено после
//                      обращения к функции.
// 
// Возвращаемое значение:
//  Булево - признак того, что значение выбранного счетчика превышено
//
Функция ПревышеноЗначение(Знач ВидПодсказки, Знач ГраничноеЗначение, Знач Пользователь = Неопределено, Знач Организация = Неопределено, Знач АвтоИнкремент = Истина) Экспорт
	
	Если Пользователь = Неопределено Тогда
		Пользователь = ПользователиКлиентСервер.АвторизованныйПользователь();
	КонецЕсли;
	
	Если Организация = Неопределено Тогда
		Организация = Справочники.Организации.ПустаяСсылка();
	КонецЕсли;
	
	Отбор = Новый Структура;
	Отбор.Вставить("ВидПодсказки", ВидПодсказки);
	Отбор.Вставить("Пользователь", Пользователь);
	Отбор.Вставить("Организация", Организация);
	
	ЗначениеСчетчика = Получить(Отбор).Счетчик + 1;
	
	Если ЗначениеСчетчика > ГраничноеЗначение Тогда
		Возврат Истина;
	КонецЕсли;
	
	Если АвтоИнкремент Тогда
		МенеджерЗаписи = СоздатьМенеджерЗаписи();
		МенеджерЗаписи.ВидПодсказки = ВидПодсказки;
		МенеджерЗаписи.Пользователь = Пользователь;
		МенеджерЗаписи.Организация = Организация;
		МенеджерЗаписи.Счетчик = ЗначениеСчетчика;
		МенеджерЗаписи.Записать();
	КонецЕсли;
	
	Возврат Ложь;
	
КонецФункции

// Увеличивает значение счетчика для указанного вида подсказки.
//
// Параметры:
//  ВидПодсказки 		- ПеречислениеСсылка.ВидыПодсказок - вид подсказки
//               		для увеличения значения счетчика.
//  Пользователь 		- СправочникСсылка.Пользователи - пользователь.
//               		Если не указан, то используется текущий пользователь.
//  Организация 		- СправочникСсылка.Организации - организация.
//               		Если не указана, то используется пустая ссылка.
//
Процедура УвеличитьЗначениеСчетчика(Знач ВидПодсказки, Знач Пользователь = Неопределено, Знач Организация = Неопределено) Экспорт
	
	Если Пользователь = Неопределено Тогда
		Пользователь = Пользователи.ТекущийПользователь();
	КонецЕсли;
	
	Если Организация = Неопределено Тогда
		Организация = Справочники.Организации.ПустаяСсылка();
	КонецЕсли;
	
	МенеджерЗаписи = СоздатьМенеджерЗаписи();
	МенеджерЗаписи.ВидПодсказки = ВидПодсказки;
	МенеджерЗаписи.Пользователь = Пользователь;
	МенеджерЗаписи.Организация = Организация;
	МенеджерЗаписи.Прочитать();
	
	МенеджерЗаписи.ВидПодсказки = ВидПодсказки;
	МенеджерЗаписи.Пользователь = Пользователь;
	МенеджерЗаписи.Организация = Организация;
	МенеджерЗаписи.Счетчик = МенеджерЗаписи.Счетчик + 1;
	МенеджерЗаписи.Записать();
	
КонецПроцедуры

// Записывает в счетчик граничное значение, таким образом, отображение
// подсказки для указанного вида в дальнейшем отключается
//
// Параметры:
//  ВидПодсказки		 - ПеречислениеСсылка.ВидПодсказки - вид подсказки, для которого
//              		следует отключить счетчик.
//  ГраничноеЗначение	 - Число - граничное значение, которое будет записано в регистр,
//                   	таким образом подсказки данного вида будут отключены.
//  Пользователь		 - СправочникСсылка.Пользователи - пользователь. Если не указан,
//              		то используется текущий пользователь.
//  Организация			 - СправочникСсылка.Организация - организация. Если не указана,
//              		то используется пустая ссылка.
//
Процедура ОтключитьСчетчик(Знач ВидПодсказки, Знач ГраничноеЗначение, Знач Пользователь = Неопределено, Знач Организация = Неопределено) Экспорт
	
	Если Пользователь = Неопределено Тогда
		Пользователь = Пользователи.ТекущийПользователь();
	КонецЕсли;
	
	Если Организация = Неопределено Тогда
		Организация = Справочники.Организации.ПустаяСсылка();
	КонецЕсли;
	
	МенеджерЗаписи = СоздатьМенеджерЗаписи();
	МенеджерЗаписи.ВидПодсказки = ВидПодсказки;
	МенеджерЗаписи.Пользователь = Пользователь;
	МенеджерЗаписи.Организация = Организация;
	МенеджерЗаписи.Счетчик = ГраничноеЗначение;
	МенеджерЗаписи.Записать();
	
КонецПроцедуры

// Сбрасывает значение указанного вида счетчика.
//
// Параметры:
//  ВидПодсказки - ПеречислениеСсылка.ВидыПодсказок - вид подсказски для
//                 сброса значения счетчика.
//  Пользователь - СправочникСсылка.Пользователи - пользователь.
//                 Если не указан, то используется текущий пользователь.
//  Организация - СправочникСсылка.Организации - организация.
//                 Если не указана, то используется пустая ссылка.
//
Процедура Сбросить(Знач ВидПодсказки, Знач Пользователь = Неопределено, Знач Организация = Неопределено) Экспорт
	
	Если Пользователь = Неопределено Тогда
		Пользователь = Пользователи.ТекущийПользователь();
	КонецЕсли;
	
	Если Организация = Неопределено Тогда
		Организация = Справочники.Организации.ПустаяСсылка();
	КонецЕсли;
	
	МенеджерЗаписи = СоздатьМенеджерЗаписи();
	МенеджерЗаписи.ВидПодсказки = ВидПодсказки;
	МенеджерЗаписи.Пользователь = Пользователь;
	МенеджерЗаписи.Организация = Организация;
	МенеджерЗаписи.Удалить();
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли