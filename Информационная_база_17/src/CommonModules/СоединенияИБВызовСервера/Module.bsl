#Область СлужебныйПрограммныйИнтерфейс

// См. СоединенияИБ.ИнформацияОСоединениях.
Функция ИнформацияОСоединениях(ПолучатьСтрокуСоединения = Ложь, СообщенияДляЖурналаРегистрации = Неопределено, ПортКластера = 0) Экспорт
	
	Возврат СоединенияИБ.ИнформацияОСоединениях(ПолучатьСтрокуСоединения, СообщенияДляЖурналаРегистрации, ПортКластера);
	
КонецФункции

// Устанавливает блокировку соединений ИБ.
// Если вызывается из сеанса с установленными значениями разделителей,
// то устанавливает блокировку сеансов области данных.
//
// Параметры:
//  ТекстСообщения  - Строка - текст, который будет частью сообщения об ошибке
//                             при попытке установки соединения с заблокированной
//                             информационной базой.
// 
//  КодРазрешения - Строка -   строка, которая должна быть добавлена к параметру
//                             командной строки "/uc" или к параметру строки
//                             соединения "uc", чтобы установить соединение с
//                             информационной базой несмотря на блокировку.
//                             Не применимо для блокировки сеансов области данных.
//
// Возвращаемое значение:
//   Булево   - Истина, если блокировка установлена успешно.
//              Ложь, если для выполнения блокировки недостаточно прав.
//
Функция УстановитьБлокировкуСоединений(ТекстСообщения = "",
	КодРазрешения = "КодРазрешения") Экспорт
	
	Возврат СоединенияИБ.УстановитьБлокировкуСоединений(ТекстСообщения, КодРазрешения);
	
КонецФункции

// Снять блокировку информационной базы.
//
// Возвращаемое значение:
//   Булево   - Истина, если операция выполнена успешно.
//              Ложь, если для выполнения операции недостаточно прав.
//
Функция РазрешитьРаботуПользователей() Экспорт
	
	Возврат СоединенияИБ.РазрешитьРаботуПользователей();
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Получить параметры блокировки соединений ИБ для использования на стороне клиента.
//
// Параметры:
//  ПолучитьКоличествоСеансов - Булево - если Истина, то в возвращаемой структуре
//                                       заполняется поле КоличествоСеансов.
//
// Возвращаемое значение:
//   Структура - с полями:
//     Установлена - Булево - Истина, если установлена блокировка, Ложь - Иначе. 
//     Начало - Дата - дата начала блокировки. 
//     Конец - Дата - дата окончания блокировки. 
//     Сообщение - Строка - сообщение пользователю. 
//     ИнтервалОжиданияЗавершенияРаботыПользователей - Число - интервал в секундах.
//     КоличествоСеансов  - 0, если параметр ПолучитьКоличествоСеансов = Ложь.
//     ТекущаяДатаСеанса - Дата - текущая дата сеанса.
//
Функция ПараметрыБлокировкиСеансов(ПолучитьКоличествоСеансов = Ложь) Экспорт
	
	Возврат СоединенияИБ.ПараметрыБлокировкиСеансов(ПолучитьКоличествоСеансов);
	
КонецФункции

// Установить блокировку сеансов области данных.
// 
// Параметры:
//   Параметры         - Структура - см. НовыеПараметрыБлокировкиСоединений.
//   ПоМестномуВремени - Булево - время начала и окончания блокировки указаны в местном времени сеанса.
//                                Если Ложь, то в универсальном времени.
//
Процедура УстановитьБлокировкуСеансовОбластиДанных(Параметры, ПоМестномуВремени = Истина) Экспорт
	
	СоединенияИБ.УстановитьБлокировкуСеансовОбластиДанных(Параметры, ПоМестномуВремени);
	
КонецПроцедуры

// Возвращает номер текущего сеанса информационной базы.
//
Функция НомерТекущегоСеанса() Экспорт
	
	Возврат НомерСеансаИнформационнойБазы();
	
КонецФункции

// Получает сохраненные параметры администрирования.
//
Функция ПараметрыАдминистрирования() Экспорт
	Возврат СтандартныеПодсистемыСервер.ПараметрыАдминистрирования();
КонецФункции

#КонецОбласти