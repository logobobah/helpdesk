#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
	
// Возвращает строку, содержащую перечисление полей доступа через запятую
// Это перечисление используется в дальнейшем для передачи в метод 
// ОбщегоНазначения.ЗначенияРеквизитовОбъекта()
Функция ПолучитьПоляДоступа() Экспорт
	
	Возврат "Ссылка";
	
КонецФункции

// Заполняет переданный дескриптор доступа
//
Процедура ЗаполнитьОсновнойДескриптор(ОбъектДоступа, ДескрипторДоступа) Экспорт
	
	//ДокументооборотПраваДоступа.ЗаполнитьНастройкиДескриптора(ДескрипторДоступа, ОбъектДоступа);
	
КонецПроцедуры

// Возвращает признак того, что менеджер содержит метод ЗапросДляРасчетаПрав()
// 
Функция ЕстьМетодЗапросДляРасчетаПрав() Экспорт
	
	Возврат Истина;
	
КонецФункции

// Возвращает запрос для расчета прав доступа по дескрипторам объекта
// 
// Параметры:
//  
//  Дескрипторы - Массив - массив дескрипторов, чьи права нужно рассчитать
//  ИдОбъекта - Ссылка - идентификатор объекта метаданных, назначенный переданным дескрипторам
//  МенеджерОбъектаДоступа - СправочникМенеджер, ДокументМенеджер - менеджер объекта доступа
// 
// Возвращаемое значение - Запрос - запрос, который выберет права доступа для переданного массива дескрипторов
// 
Функция ЗапросДляРасчетаПрав(Дескрипторы, ИдОбъекта, МенеджерОбъектаДоступа) Экспорт
	
	//Запрос = Справочники.ДескрипторыДоступаОбъектов.ЗапросДляСтандартногоРасчетаПрав(
	//	Дескрипторы, ИдОбъекта, МенеджерОбъектаДоступа, Истина, Ложь);
	//Запрос.Текст = ДокументооборотПраваДоступаПовтИсп.ТекстЗапросаДляРасчетаПравПапок();
	Запрос = Новый Запрос;
	Возврат Запрос;
	
КонецФункции

// Заполняет протокол расчета прав дескрипторов
// 
// Параметры:
//  
//  ПротоколРасчетаПрав - Массив - протокол для заполнения
//  ЗапросПоПравам - Запрос - запрос, который использовался для расчета прав дескрипторов
//  Дескрипторы - Массив - массив дескрипторов, чьи права были рассчитаны
//  
Процедура ЗаполнитьПротоколРасчетаПрав(ПротоколРасчетаПрав, ЗапросПоПравам) Экспорт
	
	Справочники.ДескрипторыДоступаОбъектов.ЗаполнитьПротоколРасчетаПравСтандартно(
		ПротоколРасчетаПрав, ЗапросПоПравам);
	
КонецПроцедуры

// Проверяет наличие метода.
// 
Функция ЕстьМетодПолучитьПравилаОбработкиНастроекПравПапки() Экспорт
	
	Возврат Истина;
	
КонецФункции

// Возвращает таблицу значений с правилами обработки настроек прав папки,
// которые следует применять для расчета прав объекта
// 
Функция ПолучитьПравилаОбработкиНастроекПравПапки() Экспорт
	
	//ТаблицаПравил = ДокументооборотПраваДоступа.ТаблицаПравилОбработкиНастроекПапки();
	//
	//Стр = ТаблицаПравил.Добавить();
	//Стр.Настройка = "ЧтениеПапокИПисем";
	//Стр.Чтение = Истина;
	//
	//Стр = ТаблицаПравил.Добавить();
	//Стр.Настройка = "ИзменениеПапок";
	//Стр.Добавление = Истина;
	//Стр.Изменение = Истина;
	//Стр.Удаление = Истина;
	//
	//Стр = ТаблицаПравил.Добавить();
	//Стр.Настройка = "УправлениеПравами";
	//Стр.УправлениеПравами = Истина;
	
	ТаблицаПравил = Новый ТаблицаЗначений;
	ВызватьИсключение "Доработать!!!";
	Возврат ТаблицаПравил;
	
КонецФункции

// Устанавливает или очищает родителя папки.
//
Процедура УстановитьРодителяПапки(Папка, ПапкаРодитель) Экспорт
	
	ПапкаОбъект = Папка.ПолучитьОбъект();
	ЗаблокироватьДанныеДляРедактирования(Папка);
	
	// Установка привилегированного режима, т.к. перенос из папки в папку
	// проверяется программно
	УстановитьПривилегированныйРежим(Истина);
	
	СообщениеОбОшибке = "";
	//Если Не ДокументооборотПраваДоступа.ЕстьПравоПеремещенияПапки(
	//	Папка, ПапкаРодитель, СообщениеОбОшибке) Тогда
	//	ВызватьИсключение СообщениеОбОшибке;
	//КонецЕсли;
	
	Если ЗначениеЗаполнено(Папка)
		И ЗначениеЗаполнено(ПапкаРодитель)
		И ПапкаРодитель.ПринадлежитЭлементу(Папка) Тогда
		СообщениеОбОшибке = НСтр("ru = 'Нельзя перемещать папки в собственные подпапки.'");
		ВызватьИсключение СообщениеОбОшибке;
	КонецЕсли;
	
	ПапкаОбъект.Родитель = ПапкаРодитель;
	ПапкаОбъект.Записать();
	
КонецПроцедуры

// Возвращает вариант отображения количества писем в папке по умолчанию.
//
Функция ПолучитьВариантОтображенияКоличестваПисемВПапкеПоУмолчанию(ВидПапки) Экспорт
	
	Если ВидПапки = Перечисления.ВидыПапокПисем.Входящие Тогда
		Возврат Перечисления.ВариантыОтображенияКоличестваПисемВПапке.Непрочтенные;
	ИначеЕсли ВидПапки = Перечисления.ВидыПапокПисем.Исходящие Тогда
		Возврат Перечисления.ВариантыОтображенияКоличестваПисемВПапке.Все;
	ИначеЕсли ВидПапки = Перечисления.ВидыПапокПисем.Корзина Тогда
		Возврат Перечисления.ВариантыОтображенияКоличестваПисемВПапке.НеОтображать;
	ИначеЕсли ВидПапки = Перечисления.ВидыПапокПисем.Общая Тогда
		Возврат Перечисления.ВариантыОтображенияКоличестваПисемВПапке.Непрочтенные;
	ИначеЕсли ВидПапки = Перечисления.ВидыПапокПисем.Отправленные Тогда
		Возврат Перечисления.ВариантыОтображенияКоличестваПисемВПапке.Непрочтенные;
	ИначеЕсли ВидПапки = Перечисления.ВидыПапокПисем.Черновики Тогда
		Возврат Перечисления.ВариантыОтображенияКоличестваПисемВПапке.Все;
	КонецЕсли;
	
КонецФункции

Функция ПолучитьПолныйПутьПапки(ПапкаСсылка) Экспорт
	
	Если Не ЗначениеЗаполнено(ПапкаСсылка) Тогда
		Возврат "";
	КонецЕсли;
	
	Родитель = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ПапкаСсылка, "Родитель");
	Если ЗначениеЗаполнено(Родитель) Тогда
		Возврат ПолучитьПолныйПутьПапки(Родитель) + "\" + Строка(ПапкаСсылка);
	Иначе
		Возврат Строка(ПапкаСсылка);
	КонецЕсли;
	
КонецФункции

#КонецЕсли