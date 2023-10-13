Функция ИмяФайлаОписания()
	Возврат "1cv8.mft";
КонецФункции

Функция ПолучитьВерсиюКонфигурацииНаСайтеОбновлений() Экспорт
	Перем Версия;
	Возврат Версия; //ВРЕМЕННО!!!
	
	Попытка
		МетаАдрес = Метаданные.АдресКаталогаОбновлений;
		СтруктураАдреса = ОбщегоНазначенияКлиентСервер.СтруктураURI(МетаАдрес);
		ЗащищенноеСоединение = ?(СтруктураАдреса.Схема = "https", Новый ЗащищенноеСоединениеOpenSSL(),Неопределено);
		Соединение = Новый HTTPСоединение(СтруктураАдреса.Хост, СтруктураАдреса.Порт,,,,3,ЗащищенноеСоединение, Ложь);
		Запрос = Новый HTTPЗапрос(СтруктураАдреса.ПутьНаСервере + "/" + ИмяФайлаОписания());
		Ответ = Соединение.Получить(Запрос);
		Описание = Ответ.ПолучитьТелоКакСтроку();
		
		Текст = Новый ТекстовыйДокумент;
		Текст.УстановитьТекст(Описание);
		Шаблон = "Version=";
		ДлинаШаблона = СтрДлина(Шаблон);
		Для Сч = 1 По Текст.КоличествоСтрок() Цикл
			Стр = Текст.ПолучитьСтроку(Сч);
			Если Нрег(Лев(Стр, ДлинаШаблона)) = НРег(Шаблон) Тогда
				Версия = Сред(Стр, ДлинаШаблона + 1);
			КонецЕсли;
		КонецЦикла;
	Исключение
		ЗаписьЖурналаРегистрации(
			НСтр("ru = 'СУЗ.Получение версии конфигурации с сайта обновлений'", ОбщегоНазначенияКлиентСервер.КодОсновногоЯзыка()),
			УровеньЖурналаРегистрации.Ошибка,
			,
			,
			ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
	КонецПопытки;
	
	Возврат Версия;
КонецФункции

Функция ПолучитьИнформациюОФайлеОбновленияССайтаОбновлений() Экспорт
	
	МетаАдрес = Метаданные.АдресКаталогаОбновлений;
	СтруктураАдреса = ОбщегоНазначенияКлиентСервер.СтруктураURI(МетаАдрес);
	ЗащищенноеСоединение = ?(СтруктураАдреса.Схема = "https", Новый ЗащищенноеСоединениеOpenSSL(),Неопределено);
	Соединение = Новый HTTPСоединение(СтруктураАдреса.Хост, СтруктураАдреса.Порт,,,,13,ЗащищенноеСоединение, Ложь);
	Запрос = Новый HTTPЗапрос(СтруктураАдреса.ПутьНаСервере + "/" + ИмяФайлаОписания());
	Ответ = Соединение.Получить(Запрос);
	Описание = Ответ.ПолучитьТелоКакСтроку();
	
	Текст = Новый ТекстовыйДокумент;
	Текст.УстановитьТекст(Описание);
	Шаблон = "Source=";
	ДлинаШаблона = СтрДлина(Шаблон);
	Для Сч = 1 По Текст.КоличествоСтрок() Цикл
		Стр = Текст.ПолучитьСтроку(Сч);
		Если Нрег(Лев(Стр, ДлинаШаблона)) = НРег(Шаблон) Тогда
			СтруктураАдреса.ПутьНаСервере = СтруктураАдреса.ПутьНаСервере + "/" + Сред(Стр, ДлинаШаблона + 1);
			Возврат СтруктураАдреса;
		КонецЕсли;
	КонецЦикла;
	
КонецФункции