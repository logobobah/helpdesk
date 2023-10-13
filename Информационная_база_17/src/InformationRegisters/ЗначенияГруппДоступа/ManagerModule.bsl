#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныеПроцедурыИФункции

// Процедура обновляет данные регистра при изменении
// - разрешенных значений групп доступа,
// - разрешенных значений профилей групп доступа,
// - использования видов доступа.
// 
// Параметры:
//  ГруппыДоступа - СправочникСсылка.ГруппыДоступа.
//                - Массив значений указанных выше типов.
//                - Неопределено - без отбора.
//
//  ЕстьИзменения - Булево (возвращаемое значение) - если производилась запись,
//                  устанавливается Истина, иначе не изменяется.
//
Процедура ОбновитьДанныеРегистра(ГруппыДоступа = Неопределено, ЕстьИзменения = Неопределено) Экспорт
	
	Блокировка = Новый БлокировкаДанных;
	ЭлементБлокировки = Блокировка.Добавить("РегистрСведений.ЗначенияГруппДоступа");
	ЭлементБлокировки = Блокировка.Добавить("РегистрСведений.ЗначенияГруппДоступаПоУмолчанию");
	
	НачатьТранзакцию();
	Попытка
		Блокировка.Заблокировать();
		
		ИспользуемыеВидыДоступа = Новый ТаблицаЗначений;
		ИспользуемыеВидыДоступа.Колонки.Добавить("ВидДоступа", Метаданные.ОпределяемыеТипы.ЗначениеДоступа.Тип);
		ИспользуемыеВидыДоступа.Колонки.Добавить("ВидДоступаПользователи",        Новый ОписаниеТипов("Булево"));
		ИспользуемыеВидыДоступа.Колонки.Добавить("ВидДоступаВнешниеПользователи", Новый ОписаниеТипов("Булево"));
		СвойстваВидовДоступа = УправлениеДоступомСлужебный.СвойстваВидаДоступа();
		
		Для каждого СвойстваВидаДоступа Из СвойстваВидовДоступа Цикл
			Если Не УправлениеДоступомСлужебный.ВидДоступаИспользуется(СвойстваВидаДоступа.Ссылка)
			   И Не СвойстваВидаДоступа.Имя = "ДополнительныеОтчетыИОбработки" Тогда
				Продолжить;
			КонецЕсли;
			НоваяСтрока = ИспользуемыеВидыДоступа.Добавить();
			НоваяСтрока.ВидДоступа = СвойстваВидаДоступа.Ссылка;
			НоваяСтрока.ВидДоступаПользователи        = (СвойстваВидаДоступа.Имя = "Пользователи");
			НоваяСтрока.ВидДоступаВнешниеПользователи = (СвойстваВидаДоступа.Имя = "ВнешниеПользователи");
		КонецЦикла;
		
		ОбновитьРазрешенныеЗначения(ИспользуемыеВидыДоступа, ГруппыДоступа, ЕстьИзменения);
		
		ОбновитьРазрешенныеЗначенияПоУмолчанию(ИспользуемыеВидыДоступа, ГруппыДоступа, ЕстьИзменения);
		
		ЗафиксироватьТранзакцию();
	Исключение
		ОтменитьТранзакцию();
		ВызватьИсключение;
	КонецПопытки;
	
КонецПроцедуры

Процедура ОбновитьРазрешенныеЗначения(ИспользуемыеВидыДоступа, ГруппыДоступа = Неопределено, ЕстьИзменения = Неопределено)
	
	УстановитьПривилегированныйРежим(Истина);
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("ИспользуемыеВидыДоступа", ИспользуемыеВидыДоступа);
	
	Запрос.УстановитьПараметр("ТипыГруппИЗначенийВидовДоступа",
		УправлениеДоступомСлужебныйПовтИсп.ТипыГруппИЗначенийВидовДоступа());
	
	ТекстЗапросовВременныхТаблиц =
	"ВЫБРАТЬ
	|	ИспользуемыеВидыДоступа.ВидДоступа,
	|	ИспользуемыеВидыДоступа.ВидДоступаПользователи,
	|	ИспользуемыеВидыДоступа.ВидДоступаВнешниеПользователи
	|ПОМЕСТИТЬ ИспользуемыеВидыДоступа
	|ИЗ
	|	&ИспользуемыеВидыДоступа КАК ИспользуемыеВидыДоступа
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	ИспользуемыеВидыДоступа.ВидДоступа
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	НазначениеПрофилей.Профиль,
	|	ИспользуемыеВидыДоступа.ВидДоступа
	|ПОМЕСТИТЬ ВидыДоступаПрофилейВсеЗапрещены
	|ИЗ
	|	ИспользуемыеВидыДоступа КАК ИспользуемыеВидыДоступа
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ (ВЫБРАТЬ
	|			Назначение.Ссылка КАК Профиль,
	|			МИНИМУМ(ТИПЗНАЧЕНИЯ(Назначение.ТипПользователей) = ТИП(Справочник.Пользователи)) КАК ТолькоДляПользователей,
	|			МИНИМУМ(ТИПЗНАЧЕНИЯ(Назначение.ТипПользователей) <> ТИП(Справочник.Пользователи)
	|					И Назначение.ТипПользователей <> НЕОПРЕДЕЛЕНО) КАК ТолькоДляВнешнихПользователей
	|		ИЗ
	|			Справочник.ПрофилиГруппДоступа.Назначение КАК Назначение
	|		
	|		СГРУППИРОВАТЬ ПО
	|			Назначение.Ссылка) КАК НазначениеПрофилей
	|		ПО (НЕ(НЕ(ИспользуемыеВидыДоступа.ВидДоступаПользователи
	|							И НЕ НазначениеПрофилей.ТолькоДляПользователей)
	|					И НЕ(ИспользуемыеВидыДоступа.ВидДоступаВнешниеПользователи
	|							И НЕ НазначениеПрофилей.ТолькоДляВнешнихПользователей)))
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	НазначениеПрофилей.Профиль,
	|	ИспользуемыеВидыДоступа.ВидДоступа
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ТипыГруппИЗначенийВидовДоступа.ВидДоступа,
	|	ТипыГруппИЗначенийВидовДоступа.ТипГруппИЗначений
	|ПОМЕСТИТЬ ТипыГруппИЗначенийВидовДоступа
	|ИЗ
	|	&ТипыГруппИЗначенийВидовДоступа КАК ТипыГруппИЗначенийВидовДоступа
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	ТипыГруппИЗначенийВидовДоступа.ТипГруппИЗначений,
	|	ТипыГруппИЗначенийВидовДоступа.ВидДоступа
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ГруппыДоступа.Профиль КАК Профиль,
	|	ГруппыДоступа.Ссылка КАК ГруппаДоступа,
	|	ЗначенияДоступаПрофиля.ВидДоступа,
	|	ЗначенияДоступаПрофиля.ЗначениеДоступа,
	|	ВЫБОР
	|		КОГДА ВидыДоступаПрофиля.ВсеРазрешены
	|			ТОГДА ЛОЖЬ
	|		ИНАЧЕ ИСТИНА
	|	КОНЕЦ КАК ЗначениеРазрешено
	|ПОМЕСТИТЬ НастройкиЗначений
	|ИЗ
	|	Справочник.ГруппыДоступа КАК ГруппыДоступа
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.ПрофилиГруппДоступа.ВидыДоступа КАК ВидыДоступаПрофиля
	|		ПО ГруппыДоступа.Профиль = ВидыДоступаПрофиля.Ссылка
	|			И (ВидыДоступаПрофиля.Предустановленный)
	|			И (НЕ ГруппыДоступа.ПометкаУдаления)
	|			И (НЕ ВидыДоступаПрофиля.Ссылка.ПометкаУдаления)
	|			И (&УсловиеОтбораГруппДоступа1)
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.ПрофилиГруппДоступа.ЗначенияДоступа КАК ЗначенияДоступаПрофиля
	|		ПО (ЗначенияДоступаПрофиля.Ссылка = ВидыДоступаПрофиля.Ссылка)
	|			И (ЗначенияДоступаПрофиля.ВидДоступа = ВидыДоступаПрофиля.ВидДоступа)
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	ЗаданныеВидыДоступа.Ссылка,
	|	ВидыДоступа.Ссылка,
	|	ЗначенияДоступа.ВидДоступа,
	|	ЗначенияДоступа.ЗначениеДоступа,
	|	ВЫБОР
	|		КОГДА ВидыДоступа.ВсеРазрешены
	|			ТОГДА ЛОЖЬ
	|		ИНАЧЕ ИСТИНА
	|	КОНЕЦ
	|ИЗ
	|	Справочник.ГруппыДоступа.ВидыДоступа КАК ВидыДоступа
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.ПрофилиГруппДоступа.ВидыДоступа КАК ЗаданныеВидыДоступа
	|		ПО ВидыДоступа.Ссылка.Профиль = ЗаданныеВидыДоступа.Ссылка
	|			И ВидыДоступа.ВидДоступа = ЗаданныеВидыДоступа.ВидДоступа
	|			И (НЕ ЗаданныеВидыДоступа.Предустановленный)
	|			И (НЕ ВидыДоступа.Ссылка.ПометкаУдаления)
	|			И (НЕ ЗаданныеВидыДоступа.Ссылка.ПометкаУдаления)
	|			И (&УсловиеОтбораГруппДоступа2)
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.ГруппыДоступа.ЗначенияДоступа КАК ЗначенияДоступа
	|		ПО (ЗначенияДоступа.Ссылка = ВидыДоступа.Ссылка)
	|			И (ЗначенияДоступа.ВидДоступа = ВидыДоступа.ВидДоступа)
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	НастройкиЗначений.ГруппаДоступа,
	|	НастройкиЗначений.ЗначениеДоступа,
	|	МАКСИМУМ(НастройкиЗначений.ЗначениеРазрешено) КАК ЗначениеРазрешено
	|ПОМЕСТИТЬ НовыеДанные
	|ИЗ
	|	НастройкиЗначений КАК НастройкиЗначений
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ТипыГруппИЗначенийВидовДоступа КАК ТипыГруппИЗначенийВидовДоступа
	|		ПО НастройкиЗначений.ВидДоступа = ТипыГруппИЗначенийВидовДоступа.ВидДоступа
	|			И (ТИПЗНАЧЕНИЯ(НастройкиЗначений.ЗначениеДоступа) = ТИПЗНАЧЕНИЯ(ТипыГруппИЗначенийВидовДоступа.ТипГруппИЗначений))
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ИспользуемыеВидыДоступа КАК ИспользуемыеВидыДоступа
	|		ПО НастройкиЗначений.ВидДоступа = ИспользуемыеВидыДоступа.ВидДоступа
	|			И (НЕ (НастройкиЗначений.Профиль, НастройкиЗначений.ВидДоступа) В
	|					(ВЫБРАТЬ
	|						ВидыДоступаПрофилейВсеЗапрещены.Профиль,
	|						ВидыДоступаПрофилейВсеЗапрещены.ВидДоступа
	|					ИЗ
	|						ВидыДоступаПрофилейВсеЗапрещены КАК ВидыДоступаПрофилейВсеЗапрещены))
	|
	|СГРУППИРОВАТЬ ПО
	|	НастройкиЗначений.ГруппаДоступа,
	|	НастройкиЗначений.ЗначениеДоступа
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	НастройкиЗначений.ГруппаДоступа,
	|	НастройкиЗначений.ЗначениеДоступа,
	|	ЗначениеРазрешено
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|УНИЧТОЖИТЬ НастройкиЗначений";
	
	ТекстЗапроса =
	"ВЫБРАТЬ
	|	НовыеДанные.ГруппаДоступа,
	|	НовыеДанные.ЗначениеДоступа,
	|	НовыеДанные.ЗначениеРазрешено,
	|	&ПодстановкаПоляВидИзмененияСтроки
	|ИЗ
	|	НовыеДанные КАК НовыеДанные";
	
	// Подготовка выбираемых полей с необязательным отбором.
	Поля = Новый Массив; 
	Поля.Добавить(Новый Структура("ГруппаДоступа", "&УсловиеОтбораГруппДоступа3"));
	Поля.Добавить(Новый Структура("ЗначениеДоступа"));
	Поля.Добавить(Новый Структура("ЗначениеРазрешено"));
	
	Запрос.Текст = УправлениеДоступомСлужебный.ТекстЗапросаВыбораИзменений(
		ТекстЗапроса, Поля, "РегистрСведений.ЗначенияГруппДоступа", ТекстЗапросовВременныхТаблиц);
	
	УправлениеДоступомСлужебный.УстановитьУсловиеОтбораВЗапросе(Запрос, ГруппыДоступа, "ГруппыДоступа",
		"&УсловиеОтбораГруппДоступа1:ГруппыДоступа.Ссылка
		|&УсловиеОтбораГруппДоступа2:ВидыДоступа.Ссылка
		|&УсловиеОтбораГруппДоступа3:СтарыеДанные.ГруппаДоступа");
	
	Данные = Новый Структура;
	Данные.Вставить("МенеджерРегистра",      РегистрыСведений.ЗначенияГруппДоступа);
	Данные.Вставить("ИзмененияСоставаСтрок", Запрос.Выполнить().Выгрузить());
	Данные.Вставить("ИзмеренияОтбора",       "ГруппаДоступа");
	
	УправлениеДоступомСлужебный.ОбновитьРегистрСведений(Данные, ЕстьИзменения);
	
КонецПроцедуры

Процедура ОбновитьРазрешенныеЗначенияПоУмолчанию(ИспользуемыеВидыДоступа, ГруппыДоступа = Неопределено, ЕстьИзменения = Неопределено)
	
	УстановитьПривилегированныйРежим(Истина);
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("ИспользуемыеВидыДоступа", ИспользуемыеВидыДоступа);
	
	Запрос.УстановитьПараметр("ТипыГруппИЗначенийВидовДоступа",
		УправлениеДоступомСлужебныйПовтИсп.ТипыГруппИЗначенийВидовДоступа());
	
	ТекстЗапросовВременныхТаблиц =
	"ВЫБРАТЬ
	|	ИспользуемыеВидыДоступа.ВидДоступа,
	|	ИспользуемыеВидыДоступа.ВидДоступаПользователи,
	|	ИспользуемыеВидыДоступа.ВидДоступаВнешниеПользователи
	|ПОМЕСТИТЬ ИспользуемыеВидыДоступа
	|ИЗ
	|	&ИспользуемыеВидыДоступа КАК ИспользуемыеВидыДоступа
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	ИспользуемыеВидыДоступа.ВидДоступа
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	НазначениеПрофилей.Профиль,
	|	ИспользуемыеВидыДоступа.ВидДоступа,
	|	ЛОЖЬ КАК ЗначениеЛожь
	|ПОМЕСТИТЬ ВидыДоступаПрофилейВсеЗапрещены
	|ИЗ
	|	ИспользуемыеВидыДоступа КАК ИспользуемыеВидыДоступа
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ (ВЫБРАТЬ
	|			Назначение.Ссылка КАК Профиль,
	|			МИНИМУМ(ТИПЗНАЧЕНИЯ(Назначение.ТипПользователей) = ТИП(Справочник.Пользователи)) КАК ТолькоДляПользователей,
	|			МИНИМУМ(ТИПЗНАЧЕНИЯ(Назначение.ТипПользователей) <> ТИП(Справочник.Пользователи)
	|					И Назначение.ТипПользователей <> НЕОПРЕДЕЛЕНО) КАК ТолькоДляВнешнихПользователей
	|		ИЗ
	|			Справочник.ПрофилиГруппДоступа.Назначение КАК Назначение
	|		
	|		СГРУППИРОВАТЬ ПО
	|			Назначение.Ссылка) КАК НазначениеПрофилей
	|		ПО (НЕ(НЕ(ИспользуемыеВидыДоступа.ВидДоступаПользователи
	|							И НЕ НазначениеПрофилей.ТолькоДляПользователей)
	|					И НЕ(ИспользуемыеВидыДоступа.ВидДоступаВнешниеПользователи
	|							И НЕ НазначениеПрофилей.ТолькоДляВнешнихПользователей)))
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	НазначениеПрофилей.Профиль,
	|	ИспользуемыеВидыДоступа.ВидДоступа
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ТипыГруппИЗначенийВидовДоступа.ВидДоступа,
	|	ТипыГруппИЗначенийВидовДоступа.ТипГруппИЗначений
	|ПОМЕСТИТЬ ТипыГруппИЗначенийВидовДоступа
	|ИЗ
	|	&ТипыГруппИЗначенийВидовДоступа КАК ТипыГруппИЗначенийВидовДоступа
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	ТипыГруппИЗначенийВидовДоступа.ТипГруппИЗначений,
	|	ТипыГруппИЗначенийВидовДоступа.ВидДоступа
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ГруппыДоступа.Ссылка КАК Ссылка,
	|	ГруппыДоступа.Профиль КАК Профиль
	|ПОМЕСТИТЬ ГруппыДоступа
	|ИЗ
	|	Справочник.ГруппыДоступа КАК ГруппыДоступа
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.ПрофилиГруппДоступа КАК ПрофилиГруппДоступа
	|		ПО ГруппыДоступа.Профиль = ПрофилиГруппДоступа.Ссылка
	|			И (НЕ ГруппыДоступа.ПометкаУдаления)
	|			И (НЕ ПрофилиГруппДоступа.ПометкаУдаления)
	|			И (&УсловиеОтбораГруппДоступа1)
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	ГруппыДоступа.Ссылка,
	|	ГруппыДоступа.Профиль
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ГруппыДоступа.Ссылка КАК ГруппаДоступа,
	|	ВидыДоступаПрофиля.ВидДоступа,
	|	ВидыДоступаПрофиля.ВсеРазрешены
	|ПОМЕСТИТЬ НастройкиВидовДоступа
	|ИЗ
	|	ГруппыДоступа КАК ГруппыДоступа
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.ПрофилиГруппДоступа.ВидыДоступа КАК ВидыДоступаПрофиля
	|		ПО ГруппыДоступа.Профиль = ВидыДоступаПрофиля.Ссылка
	|			И (ВидыДоступаПрофиля.Предустановленный)
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ИспользуемыеВидыДоступа КАК ИспользуемыеВидыДоступа
	|		ПО (ВидыДоступаПрофиля.ВидДоступа = ИспользуемыеВидыДоступа.ВидДоступа)
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	ВидыДоступа.Ссылка,
	|	ВидыДоступа.ВидДоступа,
	|	ВидыДоступа.ВсеРазрешены
	|ИЗ
	|	ГруппыДоступа КАК ГруппыДоступа
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.ГруппыДоступа.ВидыДоступа КАК ВидыДоступа
	|		ПО (ВидыДоступа.Ссылка = ГруппыДоступа.Ссылка)
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.ПрофилиГруппДоступа.ВидыДоступа КАК ЗаданныеВидыДоступа
	|		ПО (ЗаданныеВидыДоступа.Ссылка = ГруппыДоступа.Профиль)
	|			И (ЗаданныеВидыДоступа.ВидДоступа = ВидыДоступа.ВидДоступа)
	|			И (НЕ ЗаданныеВидыДоступа.Предустановленный)
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ИспользуемыеВидыДоступа КАК ИспользуемыеВидыДоступа
	|		ПО (ВидыДоступа.ВидДоступа = ИспользуемыеВидыДоступа.ВидДоступа)
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	НастройкиЗначений.ГруппаДоступа,
	|	ТипыГруппИЗначенийВидовДоступа.ВидДоступа,
	|	ИСТИНА КАК СНастройкой
	|ПОМЕСТИТЬ НаличиеНастроекЗначений
	|ИЗ
	|	ТипыГруппИЗначенийВидовДоступа КАК ТипыГруппИЗначенийВидовДоступа
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.ЗначенияГруппДоступа КАК НастройкиЗначений
	|		ПО (ТИПЗНАЧЕНИЯ(ТипыГруппИЗначенийВидовДоступа.ТипГруппИЗначений) = ТИПЗНАЧЕНИЯ(НастройкиЗначений.ЗначениеДоступа))
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ИспользуемыеВидыДоступа КАК ИспользуемыеВидыДоступа
	|		ПО ТипыГруппИЗначенийВидовДоступа.ВидДоступа = ИспользуемыеВидыДоступа.ВидДоступа
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ГруппыДоступа.Ссылка КАК ГруппаДоступа,
	|	ТипыГруппИЗначенийВидовДоступа.ТипГруппИЗначений КАК ТипЗначенийДоступа,
	|	МАКСИМУМ(ЕСТЬNULL(ВидыДоступаПрофилейВсеЗапрещены.ЗначениеЛожь, ЕСТЬNULL(НастройкиВидовДоступа.ВсеРазрешены, ИСТИНА))) КАК ВсеРазрешены,
	|	МАКСИМУМ(ЕСТЬNULL(ВидыДоступаПрофилейВсеЗапрещены.ЗначениеЛожь, НастройкиВидовДоступа.ВсеРазрешены ЕСТЬ NULL )) КАК ВидДоступаНеИспользуется,
	|	МАКСИМУМ(ЕСТЬNULL(НаличиеНастроекЗначений.СНастройкой, ЛОЖЬ)) КАК СНастройкой
	|ПОМЕСТИТЬ ЗаготовкаДляНовыхДанных
	|ИЗ
	|	ГруппыДоступа КАК ГруппыДоступа
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ТипыГруппИЗначенийВидовДоступа КАК ТипыГруппИЗначенийВидовДоступа
	|		ПО (ИСТИНА)
	|		ЛЕВОЕ СОЕДИНЕНИЕ ВидыДоступаПрофилейВсеЗапрещены КАК ВидыДоступаПрофилейВсеЗапрещены
	|		ПО (ВидыДоступаПрофилейВсеЗапрещены.Профиль = ГруппыДоступа.Профиль)
	|			И (ВидыДоступаПрофилейВсеЗапрещены.ВидДоступа = ТипыГруппИЗначенийВидовДоступа.ВидДоступа)
	|		ЛЕВОЕ СОЕДИНЕНИЕ НастройкиВидовДоступа КАК НастройкиВидовДоступа
	|		ПО (НастройкиВидовДоступа.ГруппаДоступа = ГруппыДоступа.Ссылка)
	|			И (НастройкиВидовДоступа.ВидДоступа = ТипыГруппИЗначенийВидовДоступа.ВидДоступа)
	|		ЛЕВОЕ СОЕДИНЕНИЕ НаличиеНастроекЗначений КАК НаличиеНастроекЗначений
	|		ПО (НаличиеНастроекЗначений.ГруппаДоступа = НастройкиВидовДоступа.ГруппаДоступа)
	|			И (НаличиеНастроекЗначений.ВидДоступа = НастройкиВидовДоступа.ВидДоступа)
	|
	|СГРУППИРОВАТЬ ПО
	|	ГруппыДоступа.Ссылка,
	|	ТипыГруппИЗначенийВидовДоступа.ТипГруппИЗначений
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	ГруппыДоступа.Ссылка,
	|	ТипыГруппИЗначенийВидовДоступа.ТипГруппИЗначений
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ЗаготовкаДляНовыхДанных.ГруппаДоступа,
	|	ЗаготовкаДляНовыхДанных.ТипЗначенийДоступа,
	|	ЗаготовкаДляНовыхДанных.ВсеРазрешены,
	|	ВЫБОР
	|		КОГДА ЗаготовкаДляНовыхДанных.ВсеРазрешены = ИСТИНА
	|				И ЗаготовкаДляНовыхДанных.СНастройкой = ЛОЖЬ
	|			ТОГДА ИСТИНА
	|		ИНАЧЕ ЛОЖЬ
	|	КОНЕЦ КАК ВсеРазрешеныБезИсключений,
	|	ЗаготовкаДляНовыхДанных.ВидДоступаНеИспользуется КАК БезНастройки
	|ПОМЕСТИТЬ НовыеДанные
	|ИЗ
	|	ЗаготовкаДляНовыхДанных КАК ЗаготовкаДляНовыхДанных
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	ЗаготовкаДляНовыхДанных.ГруппаДоступа,
	|	ЗаготовкаДляНовыхДанных.ТипЗначенийДоступа,
	|	ЗаготовкаДляНовыхДанных.ВсеРазрешены,
	|	ВсеРазрешеныБезИсключений,
	|	БезНастройки
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|УНИЧТОЖИТЬ НастройкиВидовДоступа";
	
	ТекстЗапроса =
	"ВЫБРАТЬ
	|	НовыеДанные.ГруппаДоступа,
	|	НовыеДанные.ТипЗначенийДоступа,
	|	НовыеДанные.ВсеРазрешены,
	|	НовыеДанные.ВсеРазрешеныБезИсключений,
	|	НовыеДанные.БезНастройки,
	|	&ПодстановкаПоляВидИзмененияСтроки
	|ИЗ
	|	НовыеДанные КАК НовыеДанные";
	
	// Подготовка выбираемых полей с необязательным отбором.
	Поля = Новый Массив; 
	Поля.Добавить(Новый Структура("ГруппаДоступа", "&УсловиеОтбораГруппДоступа2"));
	Поля.Добавить(Новый Структура("ТипЗначенийДоступа"));
	Поля.Добавить(Новый Структура("ВсеРазрешены"));
	Поля.Добавить(Новый Структура("ВсеРазрешеныБезИсключений"));
	Поля.Добавить(Новый Структура("БезНастройки"));
	
	Запрос.Текст = УправлениеДоступомСлужебный.ТекстЗапросаВыбораИзменений(
		ТекстЗапроса, Поля, "РегистрСведений.ЗначенияГруппДоступаПоУмолчанию", ТекстЗапросовВременныхТаблиц);
	
	УправлениеДоступомСлужебный.УстановитьУсловиеОтбораВЗапросе(Запрос, ГруппыДоступа, "ГруппыДоступа",
		"&УсловиеОтбораГруппДоступа1:ГруппыДоступа.Ссылка
		|&УсловиеОтбораГруппДоступа2:СтарыеДанные.ГруппаДоступа");
	
	Данные = Новый Структура;
	Данные.Вставить("МенеджерРегистра",      РегистрыСведений.ЗначенияГруппДоступаПоУмолчанию);
	Данные.Вставить("ИзмененияСоставаСтрок", Запрос.Выполнить().Выгрузить());
	Данные.Вставить("ИзмеренияОтбора",       "ГруппаДоступа");
	
	УправлениеДоступомСлужебный.ОбновитьРегистрСведений(Данные, ЕстьИзменения);
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли