/////////////////////////////////////////////////////////////////////////////////////////
// РАБОТА СО СТРУКТУРОЙ СООБЩЕНИЯ

// Формирует пустую структуру сообщения
Функция СформироватьСтруктуруСообщения() Экспорт
	
	СтруктураСообщения = Новый Структура;
	СтруктураСообщения.Вставить("УникальныйИдентификатор", "");
	СтруктураСообщения.Вставить("Тема", "");
	СтруктураСообщения.Вставить("ТипТекста", Неопределено);
	СтруктураСообщения.Вставить("Текст", "");
	СтруктураСообщения.Вставить("ТекстHTML", "");
	СтруктураСообщения.Вставить("ДатаОтправки", Дата(1, 1, 1));
	СтруктураСообщения.Вставить("ДатаПолучения", Дата(1, 1, 1));
	СтруктураСообщения.Вставить("ОбратныйАдрес", "");
	СтруктураСообщения.Вставить("Отправитель", "");
	СтруктураСообщения.Вставить("Кому", "");
	СтруктураСообщения.Вставить("Копия", "");
	СтруктураСообщения.Вставить("СкрытаяКопия", "");
	СтруктураСообщения.Вставить("Важность", "");
	СтруктураСообщения.Вставить("Идентификатор", "");
	СтруктураСообщения.Вставить("Вложения", Новый Массив);
	СтруктураСообщения.Вставить("Картинки", Новый Массив);
	СтруктураСообщения.Вставить("Размер", 0);
	СтруктураСообщения.Вставить("НеПрочтено", Ложь);
	СтруктураСообщения.Вставить("ПоляЗаголовка", Новый Массив);
	
	Возврат СтруктураСообщения;
	
КонецФункции

// Добавляет информацию о новом вложении в структуру сообщения
//
Функция ВложенияДобавитьСтроку(
	СтруктураСообщения,
	Знач Наименование,
	Знач ИмяФайла,
	Знач ПолноеИмяФайла,
	Знач Адрес,
	Знач Размер,
	Знач ТекстHTML = "",
	Знач Идентификатор = "") Экспорт
	
	ИменаФайлов = Новый Массив;
	Для каждого ВложенияСтрока Из СтруктураСообщения.Вложения Цикл
		ИменаФайлов.Добавить(ВложенияСтрока.ИмяФайла);
	КонецЦикла;
	
	ИмяФайлаИнфо = РаботаСоСтроками.РазложитьИмяФайла(ИмяФайла);
	Имя = ИмяФайлаИнфо.Имя;
	Расширение = ИмяФайлаИнфо.Расширение;
	Счетчик = 1;
	Пока ИменаФайлов.Найти(ИмяФайла) <> Неопределено Цикл
		Имя = ИмяФайлаИнфо.Имя + "(" + Формат(Счетчик, "ЧГ=0") + ")";
		Счетчик = Счетчик + 1;
		ИмяФайла = Имя + "." + Расширение;
	КонецЦикла;
	
	РазмерКб = Цел(Размер / 1024) + 1;
	
	ТекстПисьмаНРег = НРег(ТекстHTML);
	
	Если ЗначениеЗаполнено(Идентификатор) 
		И СтрНайти(ТекстПисьмаНРег, НРег(Идентификатор)) <> 0
		И ЗначениеЗаполнено(Адрес) Тогда
		
		Вложение = Новый Структура;
		Вложение.Вставить("ИмяФайла", ИмяФайла);
		Вложение.Вставить("ПолноеИмяФайла", ПолноеИмяФайла);
		Вложение.Вставить("Адрес", Адрес);
		Вложение.Вставить("Идентификатор", Идентификатор);
		Вложение.Вставить("Расширение", Расширение);
		
		СтруктураСообщения.Картинки.Добавить(Вложение);
		
	Иначе	
		
		Вложение = Новый Структура;
		Вложение.Вставить("Наименование", Наименование);
		Вложение.Вставить("ИмяФайла", ИмяФайла);
		Вложение.Вставить("ПолноеИмяФайла", ПолноеИмяФайла);
		Вложение.Вставить("Расширение", Расширение);
		Вложение.Вставить("Адрес", Адрес);
		Вложение.Вставить("Размер", Размер);
		Вложение.Вставить("РазмерКб", РазмерКб);
		Вложение.Вставить("ПодписанЭП", Неопределено);
		Вложение.Вставить("ОтпечаткиСертификатов", Новый СписокЗначений);
		
		СтруктураСообщения.Вложения.Добавить(Вложение);
		
	КонецЕсли;	
	
	Возврат Вложение;
	
КонецФункции

// Добавляет информацию о новом вложении - файле на диске в структуру сообщения
//
Процедура ДобавитьВложениеФайлНаДиске(
	СтруктураСообщения,
	ПолноеИмяФайла,
	Наименование,
	ИмяФайла) Экспорт
	
	Адрес = Неопределено;
	
	Файл = Новый Файл(ПолноеИмяФайла);
	Если Файл.Существует() Тогда
		ДвоичныеДанные = Новый ДвоичныеДанные(ПолноеИмяФайла);
		Адрес = ПоместитьВоВременноеХранилище(ДвоичныеДанные, СтруктураСообщения.УникальныйИдентификатор);
	КонецЕсли;	
	
	Размер = Файл.Размер();
	ВложенияСтрока = ВложенияДобавитьСтроку(
		СтруктураСообщения,
		Наименование,
		ИмяФайла,
		ПолноеИмяФайла,
		Адрес,
		Размер);
	
КонецПроцедуры

// Добавляет картинку из файла на диске
Функция ДобавитьКартинкуФайлНаДиске(
	Сообщение,
	ПолноеИмяФайла,
	ИмяФайла,
	Идентификатор) Экспорт
	
	Адрес = Неопределено;
	Расширение = "";
	
	Файл = Новый Файл(ПолноеИмяФайла);
	Если Файл.Существует() Тогда
		ДвоичныеДанные = Новый ДвоичныеДанные(ПолноеИмяФайла);
		Адрес = ПоместитьВоВременноеХранилище(ДвоичныеДанные);
		Расширение = Файл.Расширение;
	КонецЕсли;	
	
	Размер = Файл.Размер();
	
	Картинка = Новый Структура;
	Картинка.Вставить("ПолноеИмяФайла", ПолноеИмяФайла);
	Картинка.Вставить("ИмяФайла", ИмяФайла);
	Картинка.Вставить("Идентификатор", Идентификатор);
	Картинка.Вставить("Размер", Размер);
	Картинка.Вставить("Адрес", Адрес);
	Картинка.Вставить("Расширение", Расширение);
	
	Сообщение.Картинки.Добавить(Картинка);
	
	Возврат Картинка;
	
КонецФункции

// Добавляет представление почтового адреса получателя в структуру СтруктураПочтовогоСообщения
//
// Параметры:
// - СтруктураПочтовогоСообщения (Структура)
// - Поле (Строка) - "Кому", "Копия", "СкрытаяКопия"
// - Получатель (Строка, Контрагент, Контактное лицо, Пользователь)
//
Процедура ДобавитьПолучателя(СтруктураСообщения, Знач Поле, Знач АдресПолучателя) Экспорт
	
	Если ПустаяСтрока(АдресПолучателя) Тогда
		Возврат;
	КонецЕсли;
	
	АдресПолучателя = СокрЛП(АдресПолучателя);
	
	Если Найти(СтруктураСообщения[Поле], АдресПолучателя) = 0 Тогда
		ДобавитьЗначениеКСтрокеЧерезРазделитель(СтруктураСообщения[Поле], "; ", АдресПолучателя);
	КонецЕсли;
	
КонецПроцедуры


/////////////////////////////////////////////////////////////////////////////////////////
// ВЫБОР ПЕРИОДА ЗАГРУЗКИ СООБЩЕНИЙ

// Возвращает варианты выбора периода загрузки почтовых сообщений
//
Функция ПолучитьВариантыВыбораПериодаЗагрузки() Экспорт
	
	Результат = Новый Массив;
	Результат.Добавить(НСтр("ru = 'все'"));
	Результат.Добавить(НСтр("ru = 'за сегодня'"));
	Результат.Добавить(НСтр("ru = 'за 2 дня'"));
	Результат.Добавить(НСтр("ru = 'за 3 дня'"));
	Результат.Добавить(НСтр("ru = 'за неделю'"));
	Результат.Добавить(НСтр("ru = 'за месяц'"));
	Результат.Добавить(НСтр("ru = 'за год'"));
	Возврат Результат;
	
КонецФункции

// Возвращает период загрузки по умолчанию
//
Функция ПолучитьПериодЗагрузкиПоУмолчанию() Экспорт
	
	Возврат НСтр("ru = 'за сегодня'");
	
КонецФункции

// Возвращает строку, представляющую дату в формате dd/MM/yyyy
//
// Параметры:
// - ПериодЗагрузки (Строка)
//
Функция ПолучитьДатуПоПериодуЗагрузки(ПериодЗагрузки) Экспорт
	
	ЗагружатьСДаты = ТекущаяДата();
	Если ПериодЗагрузки = НСтр("ru = 'все'") Тогда
		Возврат "";
	ИначеЕсли ПериодЗагрузки = НСтр("ru = 'за сегодня'") Тогда
		ЗагружатьСДаты = ТекущаяДата();
	ИначеЕсли ПериодЗагрузки = НСтр("ru = 'за 2 дня'") Тогда
		ЗагружатьСДаты = ТекущаяДата() - 24*3600;
	ИначеЕсли ПериодЗагрузки = НСтр("ru = 'за 3 дня'") Тогда
		ЗагружатьСДаты = ТекущаяДата() - 2*24*3600;
	ИначеЕсли ПериодЗагрузки = НСтр("ru = 'за неделю'") Тогда
		ЗагружатьСДаты = ТекущаяДата() - 6*24*3600;
	ИначеЕсли ПериодЗагрузки = НСтр("ru = 'за месяц'") Тогда
		ЗагружатьСДаты = ДобавитьМесяц(ТекущаяДата(), -1);
	ИначеЕсли ПериодЗагрузки = НСтр("ru = 'за год'") Тогда
		ЗагружатьСДаты = ДобавитьМесяц(ТекущаяДата(), -12);
	Иначе
		ЗагружатьСДаты = ТекущаяДата();
	КонецЕсли;
	
	Возврат Формат(ЗагружатьСДаты, "ДЛФ=D");
	
КонецФункции


/////////////////////////////////////////////////////////////////////////////////////////
// РАБОТА С ПРОФИЛЯМИ

// Возвращает структуру данных профиля "Наименование, ВидПочтовогоКлиента, Использовать, Данные"
//
// Параметры:
// - Наименование (Строка)
// - ВидПочтовогоКлиента (Перечисление.ВидыПочтовыхКлиентов)
// - Использовать (Булево)
// - Данные (Структура)
//
Функция НовыйПрофиль(Наименование, ВидПочтовогоКлиента, Использовать, Данные = Неопределено) Экспорт
	
	Результат = Новый Структура;
	Результат.Вставить("Наименование", Наименование);
	Результат.Вставить("ВидПочтовогоКлиента", ВидПочтовогоКлиента);
	Результат.Вставить("Использовать", Использовать);
	Результат.Вставить("Данные", ?(Данные = Неопределено, Новый Структура, Данные));
	Возврат Результат;
	
КонецФункции

// Возвращает структуру профиля по наименованию или Неопределено если не найден
//
// Параметры:
// - Хранилище (СписокЗначений)
// - Наименование (Строка)
//
Функция ПолучитьПрофиль(Хранилище, Наименование) Экспорт
	
	Если ПустаяСтрока(Наименование) Тогда
		Возврат Неопределено;
	КонецЕсли;
	Для каждого Элемент Из Хранилище Цикл
		Если Элемент.Представление = Наименование Тогда
			Возврат Элемент.Значение;
		КонецЕсли;
	КонецЦикла;
	Возврат Неопределено;
	
КонецФункции

// Возвращает структуру профиля отправки по наименованию
//
// Параметры:
// - Наименование (Строка)
//
Функция ПолучитьПрофильДляОтправки(Наименование) Экспорт
	
	Если ПустаяСтрока(Наименование) Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	Хранилище = ОбщегоНазначенияВызовСервера.ХранилищеОбщихНастроекЗагрузить("РаботаСПочтой", "ПрофилиДляОтправки");	
	Если ТипЗнч(Хранилище) <> Тип("СписокЗначений") Тогда
		Хранилище = Новый СписокЗначений;
	КонецЕсли;
	
	Возврат ПолучитьПрофиль(Хранилище, Наименование);
	
КонецФункции

// Возвращает структуру профиля загрузки по наименованию
//
// Параметры:
// - Наименование (Строка)
//
Функция ПолучитьПрофильДляЗагрузки(Наименование) Экспорт
	
	Если ПустаяСтрока(Наименование) Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	Хранилище = ОбщегоНазначенияВызовСервера.ХранилищеОбщихНастроекЗагрузить("РаботаСПочтой", "ПрофилиДляЗагрузки");
	Если ТипЗнч(Хранилище) <> Тип("СписокЗначений") Тогда
		Хранилище = Новый СписокЗначений;
	КонецЕсли;
	
	Возврат ПолучитьПрофиль(Хранилище, Наименование);
	
КонецФункции

// Сохраняет структуру профиля в переданном списке значений
//
// Параметры:
// - Хранилище (СписокЗначений)
// - СтруктураПрофиля (Структура)
//
Функция СохранитьПрофиль(Хранилище, СтруктураПрофиля) Экспорт
	
	Если ПустаяСтрока(СтруктураПрофиля.Наименование) Тогда
		Возврат Ложь;
	КонецЕсли;
	Для каждого Элемент Из Хранилище Цикл
		Если Элемент.Представление = СтруктураПрофиля.Наименование Тогда
			Элемент.Значение = СтруктураПрофиля;
			Возврат Истина;
		КонецЕсли;
	КонецЦикла;
	Хранилище.Добавить(СтруктураПрофиля, СтруктураПрофиля.Наименование);
	Возврат Истина;
	
КонецФункции

// Обновляет структуру профиля в переданном списке значений,
// если структура профиля с списке не найдена, добавляет новую
//
// Параметры:
// - Хранилище (СписокЗначений)
// - Наименование (Строка) - представление в списке значений
// - СтруктураПрофиля (Структура)
//
Функция ОбновитьПрофиль(Хранилище, Наименование, СтруктураПрофиля) Экспорт
	
	Если ПустаяСтрока(Наименование) Или ПустаяСтрока(СтруктураПрофиля.Наименование) Тогда
		Возврат Ложь;
	КонецЕсли;
	Для каждого Элемент Из Хранилище Цикл
		Если Элемент.Представление = Наименование Тогда
			Хранилище.Удалить(Элемент);
			Хранилище.Добавить(СтруктураПрофиля, СтруктураПрофиля.Наименование);
			Возврат Истина;
		КонецЕсли;
	КонецЦикла;
	Возврат Ложь;
	
КонецФункции

// Устанавливает свойство "Использовать" в структуре профиля в списке значений
//
// Параметры:
// - Хранилище (СписокЗначений)
// - Наименование (Строка) - представление в списке значений
// - Использовать (Булево)
//
Функция УстановитьИспользованиеПрофиля(Хранилище, Наименование, Использовать) Экспорт
	
	Если ПустаяСтрока(Наименование) Тогда
		Возврат Ложь;
	КонецЕсли;
	Для каждого Элемент Из Хранилище Цикл
		Если Элемент.Представление = Наименование Тогда
			Элемент.Значение.Использовать = Использовать;
			Возврат Истина;
		КонецЕсли;
	КонецЦикла;
	Возврат Ложь;
	
КонецФункции

// Удаляет профиль из списка значений
//
// Параметры:
// - Хранилище (СписокЗначений)
// - Наименование (Строка) - представление в списке значений
//
Процедура УдалитьПрофиль(Хранилище, Наименование) Экспорт
	
	Если ПустаяСтрока(Наименование) Тогда
		Возврат;
	КонецЕсли;
	Для каждого Элемент Из Хранилище Цикл
		Если Элемент.Представление = Наименование Тогда
			Хранилище.Удалить(Элемент);
			Возврат;
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

// Возвращает вид почтового клиента профиля для отправки
//
// Параметры:
// - Профиль (Строка, СправочникСсылка.УчетныеЗаписиЭлектроннойПочты)
//
Функция ПолучитьВидПочтовогоКлиентаДляОтправки(Профиль) Экспорт
	
	Если Не ЗначениеЗаполнено(Профиль) Тогда
		Возврат Неопределено;
	КонецЕсли;
	Если ТипЗнч(Профиль) = Тип("СправочникСсылка.УчетныеЗаписиЭлектроннойПочты") Тогда
		Возврат ПредопределенноеЗначение("Перечисление.ВидыПочтовыхКлиентов.ИнтернетПочта");
	Иначе
		Хранилище = ОбщегоНазначенияВызовСервера.ХранилищеОбщихНастроекЗагрузить("РаботаСПочтой", "ПрофилиДляОтправки");	
		Если ТипЗнч(Хранилище) <> Тип("СписокЗначений") Тогда
			Хранилище = Новый СписокЗначений;
		КонецЕсли;
		Для каждого Элемент Из Хранилище Цикл
			Если Элемент.Представление = Профиль Тогда
				Возврат Элемент.Значение.ВидПочтовогоКлиента;
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	Возврат Неопределено;
	
КонецФункции

// Возвращает вид почтового клиента профиля для загрузки
//
// Параметры:
// - Профиль (Строка, СправочникСсылка.УчетныеЗаписиЭлектроннойПочты)
//
Функция ПолучитьВидПочтовогоКлиентаДляЗагрузки(Профиль) Экспорт
	
	Если Не ЗначениеЗаполнено(Профиль) Тогда
		Возврат Неопределено;
	КонецЕсли;
	Если ТипЗнч(Профиль) = Тип("СправочникСсылка.УчетныеЗаписиЭлектроннойПочты") Тогда
		Возврат ПредопределенноеЗначение("Перечисление.ВидыПочтовыхКлиентов.ИнтернетПочта");
	Иначе
		Хранилище = ОбщегоНазначенияВызовСервера.ХранилищеОбщихНастроекЗагрузить("РаботаСПочтой", "ПрофилиДляЗагрузки");
		Если ТипЗнч(Хранилище) <> Тип("СписокЗначений") Тогда
			Хранилище = Новый СписокЗначений;
		КонецЕсли;
		Для каждого Элемент Из Хранилище Цикл
			Если Элемент.Представление = Профиль Тогда
				Возврат Элемент.Значение.ВидПочтовогоКлиента;
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	Возврат Неопределено;
	
КонецФункции
