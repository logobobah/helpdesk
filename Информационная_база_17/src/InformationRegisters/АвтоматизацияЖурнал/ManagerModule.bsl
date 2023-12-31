#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

Процедура ОтразитьВЖурнале(Сценарий, Источник, Тип = Неопределено, Сообщение = "", Дата = Неопределено) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	ТипЗаписи = Перечисления.АвтоматизацияВидыЗаписейЖурнала.Информация;
	ТипЖурналаРегистрации = УровеньЖурналаРегистрации.Информация;
	Если ЗначениеЗаполнено(Тип) Тогда
		ТипЗаписи = Тип;
		ТипЖурналаРегистрации = УровеньЖурналаРегистрации[XMLСтрока(Тип)];
	КонецЕсли;
	МенеджерЗаписи = РегистрыСведений.АвтоматизацияЖурнал.СоздатьМенеджерЗаписи();
	МенеджерЗаписи.Сценарий	= Сценарий;
	МенеджерЗаписи.Источник	= Источник;
	МенеджерЗаписи.Дата	= ?(ЗначениеЗаполнено(Дата), Дата, ТекущаяДатаСеанса());
	МенеджерЗаписи.Сообщение = Сообщение;
	МенеджерЗаписи.Вид = ТипЗаписи;
	МенеджерЗаписи.Записать();
	
	ЗаписьЖурналаРегистрации(НСтр("ru = 'Автоматизация: Сценарии'"), 
		ТипЖурналаРегистрации, 
		Метаданные.Справочники.АвтоматизацияСценарии, , 
		Сообщение
	);			
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли