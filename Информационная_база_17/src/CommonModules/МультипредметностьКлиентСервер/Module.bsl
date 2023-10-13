////////////////////////////////////////////////////////////////////////////////
// Подсистема "Мультипредметность"
// Модуль МультипредметностьКлиентСервер: клиент, сервер
//
// Содержит процедуры и функции, обрабатываемые на сервере и на клиенте.
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// ПРОГРАММНЫЙ ИНТЕРФЕЙС

// Заполняет поля формы табличной части объекта "Предметы" у процесса или шаблона
// Параметры:
//  Объект - БизнесПроцессОбъект или СправочникОбъект
//
Процедура ЗаполнитьТаблицуПредметовФормы(Объект) Экспорт
	
	// Заполним таблицу предметов формы
	Для Каждого СтрокаПредмета Из Объект.Предметы Цикл
		СтрокаПредмета.ИсходноеИмяПредмета = СтрокаПредмета.ИмяПредмета;
		СтрокаПредмета.ПометкаУдаления = Ложь;
		Если СтрокаПредмета.Предмет <> Неопределено Тогда
			Попытка
				ПометкаУдаления = ОбщегоНазначенияСУЗВызовСервера.ЗначениеРеквизитаОбъекта(СтрокаПредмета.Предмет,"ПометкаУдаления");
				Если ПометкаУдаления <> Неопределено Тогда
					СтрокаПредмета.ПометкаУдаления = ПометкаУдаления;
				КонецЕсли;
			Исключение
				// Если у пользователя нет прав на предмет, то не отображаем пометку на удаление.
				ПометкаУдаления = Ложь;
			КонецПопытки;
		КонецЕсли;
		СтрокаПредмета.Картинка = ИндексКартинкиРолиПредмета(СтрокаПредмета.РольПредмета, СтрокаПредмета.ПометкаУдаления);
	КонецЦикла;
	
КонецПроцедуры

// Заполняет описание условия в строке по данным условия и вида предмета этой строки.
// Используется для заполнения строки условий в шаблонах процессов в ТЧ Исполнители и Предшественники этапов.
//
Процедура ЗаполнитьОписаниеУсловийФормы(Объект) Экспорт
	
	Для Каждого Строка Из Объект.Исполнители Цикл
		Строка.ОписаниеУсловия = ПолучитьТекстОписанияУсловия(Строка.ИмяПредметаУсловия, Строка.Условие);
	КонецЦикла;

КонецПроцедуры

// Возвращает строку описания условия по виду предмета и условию
//
Функция ПолучитьТекстОписанияУсловия(ИмяПредмета, Условие) Экспорт
	
	Если ЗначениеЗаполнено(ИмяПредмета) И ЗначениеЗаполнено(Условие) Тогда
		Возврат СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку("%1.%2", ИмяПредмета, Условие);
	Иначе
		Возврат НСтр("ru='Не установлено'");
	КонецЕсли;
	
КонецФункции

// Возвращает строковое представление предметов через запятую
// 
// Параметры
//	Предметы - табличная часть предметов задачи
//	Кавычки - признак установки предмета в кавычки
//	ЗаполнятьНеЗаданы - признак заполнения строки предметов словом "Не заданы" если предметы не установлены
//
Функция ПредметыСтрокой(Предметы, Кавычки = Ложь, ЗаполнятьНеЗаданы = Истина, ТолькоОсновные = Ложь) Экспорт
	
	СтрокаПредметов = "";
	
	Если ТипЗнч(Предметы) = Тип("Массив") Тогда
		МассивПредметов = Предметы;
	Иначе 
		МассивПредметов = Новый Массив;
		МассивВспомогательныхПредметов = Новый Массив;
		Для Каждого СтрокаПредмета Из Предметы Цикл
			Если ЗначениеЗаполнено(СтрокаПредмета.Предмет) Тогда
				СтруктураПредмета = Новый Структура;
				СтруктураПредмета.Вставить("ИмяПредмета", СтрокаПредмета.ИмяПредмета);
				СтруктураПредмета.Вставить("Предмет", СтрокаПредмета.Предмет);
				
				Если СтрокаПредмета.РольПредмета = ПредопределенноеЗначение("Перечисление.РолиПредметов.Основной") Тогда
					МассивПредметов.Добавить(СтруктураПредмета);
				ИначеЕсли ТолькоОсновные Тогда
					Продолжить;
				Иначе
					МассивВспомогательныхПредметов.Добавить(СтруктураПредмета);
				КонецЕсли;
				
			КонецЕсли;
		КонецЦикла;
		
		Для Каждого ВспомогательныйПредмет Из МассивВспомогательныхПредметов Цикл
			МассивПредметов.Добавить(ВспомогательныйПредмет);
		КонецЦикла;
		
	КонецЕсли;
	
	Для Каждого СтрокаПредмета Из МассивПредметов Цикл
		Если ТипЗнч(СтрокаПредмета) = Тип("Структура") Тогда
			Если ЗначениеЗаполнено(СтрокаПредмета.Предмет) Тогда
				СтрокаПредметов = СтрокаПредметов + ?(ПустаяСтрока(СтрокаПредметов),"",", ") 
					+ ?(Кавычки,"""","") + ОбщегоНазначенияСУЗВызовСервера.ПредметСтрокой(СтрокаПредмета.Предмет, СтрокаПредмета.ИмяПредмета) + ?(Кавычки,"""","");
			КонецЕсли;
		Иначе
			Если ЗначениеЗаполнено(СтрокаПредмета) Тогда
				СтрокаПредметов = СтрокаПредметов + ?(ПустаяСтрока(СтрокаПредметов),"",", ") 
					+ ?(Кавычки,"""","") + ОбщегоНазначенияСУЗВызовСервера.ПредметСтрокой(СтрокаПредмета) + ?(Кавычки,"""","");
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
	
	Если ПустаяСтрока(СтрокаПредметов) И ЗаполнятьНеЗаданы Тогда
		СтрокаПредметов = НСтр("ru='Не заданы'");
	КонецЕсли;
	
	Возврат СтрокаПредметов;
	
КонецФункции

// Заполняет наименование процесса по предметам
// Параметры:
//  Объект - объект процесса
//  Наименование - начальное наименование процесса
//
Процедура ЗаполнитьНаименованиеПроцесса(Объект, Наименование) Экспорт
	
	Объект.Наименование = ПолучитьНаименованиеСПредметами(Наименование, Объект.Предметы);
	
КонецПроцедуры

// Возвращает строку наименования с перечислением предметов через запятую
//
Функция ПолучитьНаименованиеСПредметами(ШаблонНаименования, Предметы) Экспорт
	
	Наименование = СокрЛП(ШаблонНаименования);
	ПредставлениеПредметов = ПредметыСтрокой(Предметы, Истина, Ложь);
	Если ЗначениеЗаполнено(ПредставлениеПредметов) Тогда
		Наименование = Наименование + " " + ПредставлениеПредметов;
	КонецЕсли;
	
	Возврат Наименование;
	
КонецФункции

// Возвращает массив, содержащий установленные предметы процесса или задачи
// Параметры:
//  Объект - ЗадачаОбъект, ЗадачаСсылка, БизнесПроцессОбъект, БизнесПроцессСсылка
//	ТипыПредметов - Отбираемые типы предметов
//
Функция ПолучитьМассивПредметовОбъекта(ОбъектСсылка, ТипыПредметов = Неопределено, Основные = Неопределено) Экспорт
	
	МассивПредметов = Новый Массив;
	
	Если ТипЗнч(ОбъектСсылка) = Тип("ДанныеФормыСтруктура") Тогда
		СтруктураПредметов = ОбъектСсылка;
		ЭтоЗадача = ТипЗнч(ОбъектСсылка.Ссылка) = Тип("ЗадачаСсылка.ЗадачаИсполнителя");
	ИначеЕсли ОбщегоНазначенияСУЗВызовСервера.ЭтоСсылка(ТипЗнч(ОбъектСсылка)) Тогда
		СтруктураПредметов = Новый Структура;
		
		Если ТипЗнч(ОбъектСсылка) = Тип("ЗадачаСсылка.ЗадачаИсполнителя") Тогда
			ЭтоЗадача = Истина;
			ЗначенияРеквизитов = МультипредметностьВызовСервера.ПолучитьЗначенияТабличныхРеквизитовДляКлиента(ОбъектСсылка,"Предметы");
			СтруктураПредметов.Вставить("Предметы", ЗначенияРеквизитов.Предметы);
		Иначе
			ЭтоЗадача = Ложь;
			СтруктураПредметов = МультипредметностьВызовСервера.ПолучитьЗначенияТабличныхРеквизитовДляКлиента(ОбъектСсылка,"Предметы, ПредметыЗадач");
		КонецЕсли;
	Иначе
		СтруктураПредметов = ОбъектСсылка;
		ЭтоЗадача = ТипЗнч(ОбъектСсылка.Ссылка) = Тип("ЗадачаСсылка.ЗадачаИсполнителя");
	КонецЕсли;
	
	Для Каждого СтрокаПредмета Из СтруктураПредметов.Предметы Цикл
		
		Если Не ЗначениеЗаполнено(СтрокаПредмета.Предмет) Тогда
			Продолжить;
		КонецЕсли;
		
		ОтборТип = Ложь;
		ОтборОсновные = Ложь;
		
		Если ТипыПредметов = Неопределено Тогда
			ОтборТип = Истина;
		Иначе
			Для Каждого ПроверяемыйТип Из ТипыПредметов Цикл
				Если ТипЗнч(СтрокаПредмета.Предмет) = ПроверяемыйТип Тогда
					ОтборТип = Истина;
					Прервать;
				КонецЕсли;                                                       
			КонецЦикла;
		КонецЕсли;
		
		Если Основные = Неопределено Тогда
			ОтборОсновные = Истина;
		Иначе
			Если СтрокаПредмета.РольПредмета = ПредопределенноеЗначение("Перечисление.РолиПредметов.Основной") Тогда
				ОтборОсновные = Истина;
			КонецЕсли;
		КонецЕсли;
		
		Если ОтборТип И ОтборОсновные Тогда
			МассивПредметов.Добавить(СтрокаПредмета.Предмет);
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат МассивПредметов;
	
КонецФункции

// Возвращает массив структур, содержащий установленные предметы и имена предметов процесса или задачи
// Параметры:
//  Объект - ЗадачаОбъект, ЗадачаСсылка, БизнесПроцессОбъект, БизнесПроцессСсылка
//	ТипыПредметов - Отбираемые типы предметов
//
Функция ПолучитьМассивСтруктурПредметовОбъекта(ОбъектСсылка, ТипыПредметов = Неопределено, Основные = Неопределено) Экспорт
	
	МассивПредметов = Новый Массив;
	
	Если ТипЗнч(ОбъектСсылка) = Тип("ДанныеФормыСтруктура") Тогда
		СтруктураПредметов = ОбъектСсылка;
		ЭтоЗадача = ТипЗнч(ОбъектСсылка.Ссылка) = Тип("ДокументСсылка.Задачи");
	ИначеЕсли ОбщегоНазначенияСУЗВызовСервера.ЭтоСсылка(ТипЗнч(ОбъектСсылка)) Тогда
		СтруктураПредметов = Новый Структура;
		
		Если ТипЗнч(ОбъектСсылка) = Тип("ДокументСсылка.Задачи") Тогда
			ЭтоЗадача = Истина;
			ЗначенияРеквизитов = МультипредметностьВызовСервера.ПолучитьЗначенияТабличныхРеквизитовДляКлиента(ОбъектСсылка,"Предметы");
			СтруктураПредметов.Вставить("Предметы", ЗначенияРеквизитов.Предметы);
		Иначе
			ЭтоЗадача = Ложь;
			СтруктураПредметов = МультипредметностьВызовСервера.ПолучитьЗначенияТабличныхРеквизитовДляКлиента(ОбъектСсылка,"Предметы, ПредметыЗадач");
		КонецЕсли;
	Иначе
		СтруктураПредметов = ОбъектСсылка;
		ЭтоЗадача = ТипЗнч(ОбъектСсылка.Ссылка) = Тип("ДокументСсылка.Задачи");
	КонецЕсли;
	
	Для Каждого СтрокаПредмета Из СтруктураПредметов.Предметы Цикл
		
		Если ЗначениеЗаполнено(СтрокаПредмета.Предмет) Тогда
			ОтборТип = Ложь;
			ОтборОсновные = Ложь;
			
			Если ТипыПредметов = Неопределено Тогда
				ОтборТип = Истина;
			Иначе
				Для Каждого ПроверяемыйТип Из ТипыПредметов Цикл
					Если ТипЗнч(СтрокаПредмета.Предмет) = ПроверяемыйТип Тогда
						ОтборТип = Истина;
						Прервать;
					КонецЕсли;                                                       
				КонецЦикла;
			КонецЕсли;
			
			Если Основные = Неопределено Тогда
				ОтборОсновные = Истина;
			Иначе
				Если СтрокаПредмета.РольПредмета = ПредопределенноеЗначение("Перечисление.РолиПредметов.Основной") Тогда
					ОтборОсновные = Истина;
				КонецЕсли;
			КонецЕсли;
			
			Если ОтборТип И ОтборОсновные Тогда
				СтруктураПредмета = Новый Структура;
				СтруктураПредмета.Вставить("ИмяПредмета", СтрокаПредмета.ИмяПредмета);
				СтруктураПредмета.Вставить("Предмет",СтрокаПредмета.Предмет);
				МассивПредметов.Добавить(СтруктураПредмета);
			КонецЕсли;
			
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат МассивПредметов;
	
КонецФункции

// Возвращает массив имен предметов объекта (процесса, шаблона или задачи)
//
Функция ПолучитьМассивИменПредметовОбъекта(Объект) Экспорт
	
	МассивВидов = Новый Массив;
	
	Для Каждого СтрокаПредмета Из Объект.Предметы Цикл
		Если ЗначениеЗаполнено(СтрокаПредмета.ИмяПредмета) Тогда
			МассивВидов.Добавить(СтрокаПредмета.ИмяПредмета);
		КонецЕсли;
	КонецЦикла;
	
	Возврат МассивВидов;
	
КонецФункции

// Возвращает картинку по типу предмета и признака пометки удаления
//
Функция УстановитьКартинкуПоРолиПредмета(РольПредмета, ПометкаУдаления = Ложь) Экспорт
	
	Если РольПредмета = ПредопределенноеЗначение("Перечисление.РолиПредметов.Основной") Тогда
		Возврат ?(ПометкаУдаления, БиблиотекаКартинок.ПредметОсновной16ПометкаУдаления, БиблиотекаКартинок.ПредметОсновной16);
	ИначеЕсли РольПредмета = ПредопределенноеЗначение("Перечисление.РолиПредметов.Вспомогательный") Тогда
		Возврат ?(ПометкаУдаления, БиблиотекаКартинок.ПредметВспомогательный16ПометкаУдаления, БиблиотекаКартинок.ПредметВспомогательный16);
	ИначеЕсли РольПредмета = ПредопределенноеЗначение("Перечисление.РолиПредметов.Заполняемый") Тогда
		Возврат ?(ПометкаУдаления, БиблиотекаКартинок.ПредметЗаполняемый16ПометкаУдаления, БиблиотекаКартинок.ПредметЗаполняемый16);
	Иначе
		Возврат Новый Картинка;
	КонецЕсли;
	
КонецФункции

// Возвращает индекс картинки по типу предмета и признака пометки удаления
//
Функция ИндексКартинкиРолиПредмета(РольПредмета, ПометкаУдаления = Ложь) Экспорт
	
	Если РольПредмета = ПредопределенноеЗначение("Перечисление.РолиПредметов.Основной") Тогда
		Возврат ?(ПометкаУдаления, 2, 1);
	ИначеЕсли РольПредмета = ПредопределенноеЗначение("Перечисление.РолиПредметов.Вспомогательный") Тогда
		Возврат ?(ПометкаУдаления, 4, 3);
	ИначеЕсли РольПредмета = ПредопределенноеЗначение("Перечисление.РолиПредметов.Заполняемый") Тогда
		Возврат ?(ПометкаУдаления, 6, 5);
	Иначе
		Возврат 0;
	КонецЕсли;
	
КонецФункции

// Устанавливает значение реквизита "Описание" в табличной части "Предметы" процесса
// Параметры:
//	СтрокаПредмета - строка табличной части "Предметы"
//	ПредметыЗадач - табличная часть "ПредметыЗадач"
//	ЭтоКомплексныйПроцесс - признак комплексного процесса
//
Процедура УстановитьОписаниеСтрокиПредмета(СтрокаПредмета, ПредметыЗадач, ЭтоКомплексныйПроцесс) Экспорт
	
	Если СтрокаПредмета.РольПредмета = ПредопределенноеЗначение("Перечисление.РолиПредметов.Основной")
		Или СтрокаПредмета.РольПредмета = ПредопределенноеЗначение("Перечисление.РолиПредметов.Вспомогательный") 
		Или (СтрокаПредмета.РольПредмета = ПредопределенноеЗначение("Перечисление.РолиПредметов.Заполняемый")
		     И ЗначениеЗаполнено(СтрокаПредмета.Предмет)) Тогда
		СтрокаПредмета.Описание = ОбщегоНазначенияСУЗВызовСервера.ПредметСтрокой(СтрокаПредмета.Предмет, СтрокаПредмета.ИмяПредмета);
	Иначе
		Отбор = Новый Структура("ИмяПредмета, ОбязательноеЗаполнение", СтрокаПредмета.ИмяПредмета, Истина);
		СтрокиТочек = ПредметыЗадач.НайтиСтроки(Отбор);

		Если СтрокаПредмета.Предмет = Неопределено Тогда
			ПредметСтрокой = НСтр("ru='любой доступный тип'");
		Иначе
			ПредметСтрокой = НРег(ТипЗнч(СтрокаПредмета.Предмет));
		КонецЕсли;
		
		Если СтрокиТочек.Количество() = 1 И Не ЭтоКомплексныйПроцесс Тогда 
			СтрокаПредмета.Описание = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru='%1, %2, заполняется в задаче ""%3""'"),
				Строка(СтрокаПредмета.ИмяПредмета), 
				НРег(ПредметСтрокой), 
				Строка(СтрокиТочек[0].ТочкаМаршрута));
		ИначеЕсли СтрокиТочек.Количество() >= 1 И ЭтоКомплексныйПроцесс Тогда
			СтрокаЭтаповЗаполнения = "";
			Для Каждого СтрокаТочки из СтрокиТочек Цикл
				Если СтрокаТочки.ОбязательноеЗаполнение Тогда
					ДополнитьСтрокуЭтаповЗаполнения(СтрокаЭтаповЗаполнения, СтрокаТочки);
				КонецЕсли;
			КонецЦикла;
			СтрокаПредмета.Описание = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru='%1, %2, заполняется в %3 %4'"),
				Строка(СтрокаПредмета.ИмяПредмета), 
				НРег(ПредметСтрокой),
				?(СтрокиТочек.Количество() = 1, НСтр("ru='задаче'"), НСтр("ru='задачах'")),
				СтрокаЭтаповЗаполнения);
		Иначе
			СтрокаПредмета.Описание = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru='%1, %2'"),
				Строка(СтрокаПредмета.ИмяПредмета), 
				НРег(ПредметСтрокой));
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

// Заполняет реквизит "Описание" табличной части "Предметы" шаблона процесса
//
Процедура ЗаполнитьОписаниеПредметовШаблона(Объект) Экспорт
	
	Для Каждого СтрокаПредмета Из Объект.Предметы Цикл
		
		УстановитьОписаниеСтрокиПредметаШаблона(СтрокаПредмета);
		
	КонецЦикла;
	
КонецПроцедуры

// Устанавливает значение реквизита "Описание" в строке табличной части "Предметы" шаблона процесса
//
Процедура УстановитьОписаниеСтрокиПредметаШаблона(СтрокаПредмета) Экспорт
	
	Если СтрокаПредмета.Предмет = Неопределено Тогда
		СтрокаТипа = НСтр("ru='любой доступный тип'");
	Иначе
		СтрокаТипа = НРег(ТипЗнч(СтрокаПредмета.Предмет));
	КонецЕсли;
	
	СтрокаПредмета.Описание = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку("%1 (%2)", 
		СтрокаПредмета.ИмяПредмета, СтрокаТипа);
	
КонецПроцедуры

// Устанавливает доступность кнопок управления предметами в зависимости от заполнения табличной части "Предметы"
//
Процедура УстановитьДоступностьКнопокУправленияПредметами(Форма) Экспорт
	
	Если Форма.Элементы.Найти("ПредметыИзменитьПредмет") <> Неопределено Тогда
		Форма.Элементы.ПредметыИзменитьПредмет.Доступность = Не Форма.Объект.Предметы.Количество() = 0;
	КонецЕсли;
	Если Форма.Элементы.Найти("ПредметыКонтекстноеМенюИзменитьПредмет") <> Неопределено Тогда
		Форма.Элементы.ПредметыКонтекстноеМенюИзменитьПредмет.Доступность = Не Форма.Объект.Предметы.Количество() = 0;
	КонецЕсли;
	Если Форма.Элементы.Найти("ОткрытьКарточку") <> Неопределено Тогда
		Форма.Элементы.ОткрытьКарточку.Доступность = Не Форма.Объект.Предметы.Количество() = 0;
	КонецЕсли;
	Если Форма.Элементы.Найти("ПредметыКонтекстноеМенюОткрытьКарточку") <> Неопределено Тогда
		Форма.Элементы.ПредметыКонтекстноеМенюОткрытьКарточку.Доступность = Не Форма.Объект.Предметы.Количество() = 0;
	КонецЕсли;
	Если Форма.Элементы.Найти("ПредметыИзменитьРоль") <> Неопределено Тогда
		Форма.Элементы.ПредметыИзменитьРоль.Доступность = Не Форма.Объект.Предметы.Количество() = 0;
	КонецЕсли;
	
КонецПроцедуры

// Устанавливает видимость таблицы предметов в зависимости от их количества.
//
Процедура УстановитьВидимостьТаблицыПредметов(Форма, Объект) Экспорт
	
	Если Форма.Элементы.Найти("ОписаниеСПредметами") = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если Объект.Предметы.Количество() > 0 Тогда
		Форма.Элементы.ГруппаОписаниеИПредметы.ТекущаяСтраница = 
			Форма.Элементы.ОписаниеСПредметами;
	Иначе
		Форма.Элементы.ГруппаОписаниеИПредметы.ТекущаяСтраница = 
			Форма.Элементы.ОписаниеБезПредметов;
	КонецЕсли;
	
КонецПроцедуры

// Дополняет строку описания заполнения данными о заполнении из этапа процесса
//
Процедура ДополнитьСтрокуЭтаповЗаполнения(СтрокаЗаполнения, Этап) Экспорт
	
	СтрокаЗаполнения = СтрокаЗаполнения + ?(ПустаяСтрока(СтрокаЗаполнения),"",", ") 
		+ ?(ЗначениеЗаполнено(Этап.ШаблонБизнесПроцесса), 
			СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку("""%1 (%2)""" ,
				Строка(Этап.ШаблонБизнесПроцесса), Строка(Этап.ТочкаМаршрута)), 
			Строка(Этап.ТочкаМаршрута));
	
КонецПроцедуры

// Добавляет предмет шаблона по результату выбора
//
Процедура ИзменитьПредметПоРезультатуВыбора(Форма, Объект, Результат, СтрокаПредмета = Неопределено) Экспорт
	
	Форма.Модифицированность = Истина;
	
	Если ТипЗнч(Результат) = Тип("Структура") Тогда
		СтруктураВыбора = Результат;
		ДанныеВыбора = Новый Массив;
		ДанныеВыбора.Добавить(Результат);
		
#Если Сервер Тогда
	ИначеЕсли ТипЗнч(Результат) = Тип("СтрокаТаблицыЗначений") Тогда
		СтруктураВыбора = Новый Структура;
		СтруктураВыбора.Вставить("ИмяПредмета");
		СтруктураВыбора.Вставить("ИмяПредметаОснование");
		СтруктураВыбора.Вставить("РольПредмета");
		СтруктураВыбора.Вставить("Предмет");
		СтруктураВыбора.Вставить("ШаблонОснование");
		ЗаполнитьЗначенияСвойств(СтруктураВыбора, Результат);
		ДанныеВыбора = Новый Массив;
		ДанныеВыбора.Добавить(СтруктураВыбора);
#КонецЕсли
	
	Иначе
		ДанныеВыбора = Результат;
	КонецЕсли;
	
	Для Каждого РезультатВыбора Из ДанныеВыбора Цикл
		
		Если СтрокаПредмета = Неопределено Тогда
			СтрокаДанных = Объект.Предметы.Добавить();
			СтрокаПредмета = СтрокаДанных;
			Добавление = Истина;
		Иначе
			СтрокаДанных = СтрокаПредмета;
			Добавление = Ложь;
		КонецЕсли;
		
		ЗаполнитьЗначенияСвойств(СтрокаДанных, РезультатВыбора);
		
		ЭтоКомплексныйПроцесс = МультипредметностьКлиентСервер.ЭтоКомплексныйПроцесс(Объект.Ссылка);
		
		Если (СтрокаДанных.ИмяПредмета <> СтрокаДанных.ИсходноеИмяПредмета) Тогда
			СтруктураПоиска = Новый Структура("ИмяПредмета",СтрокаДанных.ИсходноеИмяПредмета);
			ИсправляемыеСтроки = Объект.ПредметыЗадач.НайтиСтроки(СтруктураПоиска);
			
			Для Каждого ИсправляемаяСтрока Из ИсправляемыеСтроки Цикл
				ИсправляемаяСтрока.ИмяПредмета = СтрокаДанных.ИмяПредмета;
			КонецЦикла;
			
			Если ЗначениеЗаполнено(СтрокаДанных.ИсходноеИмяПредмета) Тогда
				СтруктураПоиска = Новый Структура("ИмяПредметаОснование",СтрокаДанных.ИсходноеИмяПредмета);
				ИсправляемыеСтроки = Объект.Предметы.НайтиСтроки(СтруктураПоиска);
				
				Для Каждого ИсправляемаяСтрока Из ИсправляемыеСтроки Цикл
					ИсправляемаяСтрока.ИмяПредметаОснование = СтрокаДанных.ИмяПредмета;
				КонецЦикла;
				
				ЗаменитьЗначенияАвтоподстановкиПоИмениПредмета(Форма, СтрокаДанных.ИсходноеИмяПредмета, СтрокаДанных.ИмяПредмета);
				ЗаменитьУсловияПоИмениПредмета(Форма, СтрокаДанных.ИсходноеИмяПредмета, СтрокаДанных.ИмяПредмета);
				
				Если ЭтоКомплексныйПроцесс Тогда
					
					ШаблоныДействий = Новый Массив;
					Если Форма.ИспользоватьСхемуПроцесса Тогда
						Для Каждого ПараметрыДействия Из Форма.СхемаКомплексногоПроцесса.ПараметрыДействий Цикл
							Если ЗначениеЗаполнено(ПараметрыДействия.ШаблонПроцесса) Тогда
								ШаблоныДействий.Добавить(ПараметрыДействия.ШаблонПроцесса);
							КонецЕсли;
						КонецЦикла;
					Иначе
						Для Каждого СтрокаШаблона Из Объект.Этапы Цикл
							ШаблоныДействий.Добавить(СтрокаШаблона.ШаблонБизнесПроцесса);
						КонецЦикла;
					КонецЕсли;
					
					МультипредметностьВызовСервера.ЗаменитьИмяПредметаВШаблонахПроцесса(
						Объект.Ссылка, ШаблоныДействий, СтрокаДанных.ИсходноеИмяПредмета, СтрокаДанных.ИмяПредмета);
				КонецЕсли;
				
			КонецЕсли;
			
			СтрокаДанных.ИсходноеИмяПредмета = СтрокаДанных.ИмяПредмета;
			
		КонецЕсли;
		
		Если Не ЗначениеЗаполнено(СтрокаДанных.Предмет) Тогда
			ПометкаУдаления = Ложь;
		Иначе
			ПометкаУдаления = ОбщегоНазначенияСУЗВызовСервера.ЗначениеРеквизитаОбъекта(СтрокаДанных.Предмет,"ПометкаУдаления");
		КонецЕсли;
		СтрокаДанных.Картинка = МультипредметностьКлиентСервер.ИндексКартинкиРолиПредмета(СтрокаДанных.РольПредмета, ПометкаУдаления);
		
		
		Если Объект.ПредметыЗадач.НайтиСтроки(Новый Структура("ИмяПредмета",СтрокаДанных.ИмяПредмета)).Количество() = 0 Тогда
			Для Каждого Действие Из Форма.ДействияПроцесса Цикл
				НоваяСтрока = Объект.ПредметыЗадач.Добавить();
				НоваяСтрока.ИмяПредмета = РезультатВыбора.ИмяПредмета;
				
				Если Не ЭтоКомплексныйПроцесс Тогда
					НоваяСтрока.ТочкаМаршрута = Действие.Значение;
				Иначе
					ЗаполнитьЗначенияСвойств(НоваяСтрока, Действие);
				КонецЕсли;
				Если Не ЭтоКомплексныйПроцесс Тогда
					Если РезультатВыбора.РольПредмета = ПредопределенноеЗначение("Перечисление.РолиПредметов.Заполняемый") 
						И НоваяСтрока.ТочкаМаршрута = РезультатВыбора.ТочкаМаршрута Тогда
						НоваяСтрока.ОбязательноеЗаполнение = Истина;
					КонецЕсли;
				КонецЕсли;
			КонецЦикла;
		ИначеЕсли РезультатВыбора.РольПредмета = ПредопределенноеЗначение("Перечисление.РолиПредметов.Заполняемый")  Тогда
			Если Не ЭтоКомплексныйПроцесс Тогда
				СтрокиИмениПредмета = Объект.ПредметыЗадач.НайтиСтроки(Новый Структура("ИмяПредмета",СтрокаДанных.ИмяПредмета));
				СтрокаТочкиСуществует = Ложь;
				Для Каждого Строка Из СтрокиИмениПредмета Цикл
					Если РезультатВыбора.ТочкаМаршрута = Строка.ТочкаМаршрута Тогда
						Строка.ОбязательноеЗаполнение = Истина;
						СтрокаТочкиСуществует = Истина;
					Иначе
						Строка.ОбязательноеЗаполнение = Ложь;
					КонецЕсли;
				КонецЦикла;
				Если Не СтрокаТочкиСуществует Тогда
					НоваяСтрока = Объект.ПредметыЗадач.Добавить();
					НоваяСтрока.ТочкаМаршрута = РезультатВыбора.ТочкаМаршрута;
					НоваяСтрока.ИмяПредмета = РезультатВыбора.ИмяПредмета;
					НоваяСтрока.ОбязательноеЗаполнение = Истина;
				КонецЕсли;
			КонецЕсли;
		КонецЕсли;
		
		Если ЭтоКомплексныйПроцесс Тогда
			
			Если РезультатВыбора.Свойство("ЭтапыЗаполнения") Тогда
				Для Каждого Строка Из РезультатВыбора.ЭтапыЗаполнения Цикл
					Отбор = Новый Структура;
					Отбор.Вставить("ИмяПредмета", СтрокаДанных.ИмяПредмета);
					Отбор.Вставить("ИдентификаторЭтапа", Строка.ИдентификаторЭтапа);
					Отбор.Вставить("ШаблонБизнесПроцесса", Строка.ШаблонБизнесПроцесса);
					Отбор.Вставить("ТочкаМаршрута", Строка.ТочкаМаршрута);
					СтрокиПредметовЗадач = Объект.ПредметыЗадач.НайтиСтроки(Отбор);
					Если СтрокиПредметовЗадач.Количество() = 0 Тогда
						НоваяСтрока = Объект.ПредметыЗадач.Добавить();
						ЗаполнитьЗначенияСвойств(НоваяСтрока, Строка);
						НоваяСтрока.ИмяПредмета = СтрокаДанных.ИмяПредмета;
					КонецЕсли;
				КонецЦикла;
			КонецЕсли;
				
			Для Каждого Строка Из Форма.ДействияПроцесса Цикл
				ОтборСтрокПредметаЗадач = Объект.ПредметыЗадач.НайтиСтроки(Новый Структура("ИмяПредмета", СтрокаДанных.ИмяПредмета));
				Если ОтборСтрокПредметаЗадач.Количество() = 0 Тогда
					СтрокаПредметаЗадач = Объект.ПредметыЗадач.Добавить();
					ЗаполнитьЗначенияСвойств(СтрокаПредметаЗадач, Строка);
					СтрокаПредметаЗадач.ИмяПредмета = СтрокаДанных.ИмяПредмета;
					Если РезультатВыбора.Свойство("ЭтапыЗаполнения") Тогда
						Если РезультатВыбора.ЭтапыЗаполнения.НайтиСтроки(Новый Структура("ТочкаМаршрута, ИдентификаторЭтапа, ШаблонБизнесПроцесса",
							Строка.ТочкаМаршрута, Строка.ИдентификаторЭтапа, Строка.ШаблонБизнесПроцесса)).Количество() > 0 Тогда
							СтрокаПредметаЗадач.ОбязательноеЗаполнение = Истина;
						КонецЕсли;
					КонецЕсли;
				Иначе
					Для Каждого СтрокаПредметаЗадач Из ОтборСтрокПредметаЗадач Цикл
						Если РезультатВыбора.Свойство("ЭтапыЗаполнения") Тогда
							Если РезультатВыбора.ЭтапыЗаполнения.НайтиСтроки(Новый Структура("ТочкаМаршрута, ИдентификаторЭтапа, ШаблонБизнесПроцесса",
								СтрокаПредметаЗадач.ТочкаМаршрута, СтрокаПредметаЗадач.ИдентификаторЭтапа, СтрокаПредметаЗадач.ШаблонБизнесПроцесса)).Количество() > 0 Тогда
								СтрокаПредметаЗадач.ОбязательноеЗаполнение = Истина;
							Иначе 
								СтрокаПредметаЗадач.ОбязательноеЗаполнение = Ложь;
							КонецЕсли;
						КонецЕсли;
					КонецЦикла;
				КонецЕсли;
			КонецЦикла;
			
			СтруктураПредмета = Новый Структура("Предмет, ИмяПредмета, РольПредмета");
			ЗаполнитьЗначенияСвойств(СтруктураПредмета, СтрокаДанных);
			
			ШаблоныДействий = Новый Массив;
			Если Форма.ИспользоватьСхемуПроцесса Тогда
				Для Каждого ПараметрыДействия Из Форма.СхемаКомплексногоПроцесса.ПараметрыДействий Цикл
					Если ЗначениеЗаполнено(ПараметрыДействия.ШаблонПроцесса) Тогда
						ШаблоныДействий.Добавить(ПараметрыДействия.ШаблонПроцесса);
					КонецЕсли;
				КонецЦикла;
			Иначе
				Для Каждого СтрокаШаблона Из Объект.Этапы Цикл
					ШаблоныДействий.Добавить(СтрокаШаблона.ШаблонБизнесПроцесса);
				КонецЦикла;
			КонецЕсли;
			
			Если Добавление Тогда
				МультипредметностьВызовСервера.ДобавитьПредметВШаблоныПроцесса(
					Объект.Ссылка, ШаблоныДействий, Объект.ПредметыЗадач, СтруктураПредмета);
			Иначе
				РолиПредметовЭтапов = Новый Массив;
				
				МультипредметностьВызовСервера.ОбновитьШаблоныПодДаннымПредметовЗадач(
					Объект.Ссылка, ШаблоныДействий, Объект.ПредметыЗадач, СтруктураПредмета, РолиПредметовЭтапов);
					
				Форма.РолиПредметовЭтапов.Очистить();
				Для Каждого Строка Из РолиПредметовЭтапов Цикл
					НоваяСтрока = Форма.РолиПредметовЭтапов.Добавить();
					ЗаполнитьЗначенияСвойств(НоваяСтрока, Строка);
				КонецЦикла;
			КонецЕсли;
			
		КонецЕсли;
		
		Если Не ДанныеВыбора.Найти(РезультатВыбора) = ДанныеВыбора.Количество() - 1 Тогда
			СтрокаПредмета = Неопределено;
		КонецЕсли;
		
	КонецЦикла;
	
	Форма.Элементы.Предметы.ТекущаяСтрока = СтрокаДанных.ПолучитьИдентификатор();
	
	УстановитьДоступностьКнопокУправленияПредметами(Форма);
	УстановитьВидимостьТаблицыПредметов(Форма, Объект);
	
КонецПроцедуры

// Удаляет условия по виду предмета из табличных частей шаблона процесса
//
Процедура УдалитьУсловияПоИмениПредмета(Форма, ИмяПредмета) Экспорт
	
	ПроверяемыеРеквизиты = Новый Соответствие;
	ПроверяемыеРеквизиты.Вставить("Исполнители", "ИсполнителиОписаниеУсловия");
	
	Для Каждого Реквизит Из ПроверяемыеРеквизиты Цикл
		Если Форма.Элементы.Найти(Реквизит.Ключ) <> Неопределено
		   И Форма.Элементы.Найти(Реквизит.Значение) <> Неопределено Тогда
			Для Каждого Строка Из Форма.Объект[Реквизит.Ключ] Цикл
				Если Строка.ИмяПредметаУсловия = ИмяПредмета Тогда
					Строка.ИмяПредметаУсловия = Неопределено;
					Строка.Условие = Неопределено;
					Строка.ОписаниеУсловия = НСтр("ru='Не установлено'");
				КонецЕсли;
			КонецЦикла;
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

// Удаляет элементы отбора с указанным именем предмета из условий схемы.
// Рекурсивная процедура.
//
// Параметры:
//  ЭлементыОтбора - КоллекцияЭлементовОтбораКомпоновкиДанных - элементы отбора.
//  ИмяПредмета - СправочникСсылка.ИменаПредметов - имя предмета.
//
Процедура УдалитьОтборСИменемПредметаИзУсловийСхемы(ЭлементыОтбора, ИмяПредмета) Экспорт
	
	ПолеУсловиеПоПредметам = Новый ПолеКомпоновкиДанных("УсловиеПоПредметам");
	
	ИндексЭлемента = ЭлементыОтбора.Количество() - 1;
	
	Пока ИндексЭлемента >= 0 Цикл
		
		ЭлементОтбора = ЭлементыОтбора[ИндексЭлемента];
		
		Если ТипЗнч(ЭлементОтбора) = Тип("ЭлементОтбораКомпоновкиДанных") Тогда
			Если ЭлементОтбора.ЛевоеЗначение = ПолеУсловиеПоПредметам
				И ЭлементОтбора.ПравоеЗначение.ИмяПредмета = ИмяПредмета Тогда
				
				ЭлементыОтбора.Удалить(ЭлементОтбора)
			КонецЕсли;
		Иначе
			УдалитьОтборСИменемПредметаИзУсловийСхемы(ЭлементОтбора.Элементы, ИмяПредмета);
		КонецЕсли;
		
		ИндексЭлемента = ИндексЭлемента - 1;
		
	КонецЦикла;
	
КонецПроцедуры

// Заменяет условия по виду предмета в табличных частях шаблона процесса 
//
Процедура ЗаменитьУсловияПоИмениПредмета(Форма, СтароеЗначение, НовоеЗначение) Экспорт
	
	ПроверяемыеРеквизиты = Новый Соответствие;
	ПроверяемыеРеквизиты.Вставить("Исполнители", "ИсполнителиОписаниеУсловия");
	
	Для Каждого Реквизит Из ПроверяемыеРеквизиты Цикл
		Если Форма.Элементы.Найти(Реквизит.Ключ) <> Неопределено
		   И Форма.Элементы.Найти(Реквизит.Значение) <> Неопределено Тогда
			Для Каждого Строка Из Форма.Объект[Реквизит.Ключ] Цикл
				Если Строка.ИмяПредметаУсловия = СтароеЗначение Тогда
					Строка.ИмяПредметаУсловия = НовоеЗначение;
					Строка.ОписаниеУсловия = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку("%1.%2", 
						Строка.ИмяПредметаУсловия, Строка.Условие);
				КонецЕсли;
			КонецЦикла;
		КонецЕсли;
	КонецЦикла;
	
	Если ТипЗнч(Форма.Объект.Ссылка) = Тип("БизнесПроцессСсылка.КомплексныйПроцесс") 
		Или ТипЗнч(Форма.Объект.Ссылка) = Тип("СправочникСсылка.ШаблоныКомплексныхБизнесПроцессов") Тогда
		
		Если Форма.ИспользоватьСхемуПроцесса Тогда
			Если Форма.КэшНастроекУсловий <> Неопределено Тогда
				Для Каждого НастройкаУсловия Из Форма.КэшНастроекУсловий Цикл
					ЗаменитьИмяПредметаВУсловииСхемыПроцесса(
						НастройкаУсловия.Значение.Отбор.Элементы, СтароеЗначение, НовоеЗначение);
				КонецЦикла;
			КонецЕсли;
		Иначе
			Для Каждого Строка Из Форма.Объект.ПредшественникиЭтапов Цикл
				Если Строка.ИмяПредметаУсловия = СтароеЗначение Тогда
					Строка.ИмяПредметаУсловия = НовоеЗначение;
				КонецЕсли;
			КонецЦикла;
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

// Заменяет имя предмета в элементах отбора компоновки данных условия.
// Рекурсивная процедура.
//
// Параметры:
//  ЭлементыОтбора - КоллекцияЭлементовОтбораКомпоновкиДанных - условие процесса.
//  ИсходноеИмяПредмета - СправочникСсылка.ИменаПредметов - исходное имя предмета.
//  ИмяПредмета - СправочникСсылка.ИменаПредметов - новое имя предмета.
//
Процедура ЗаменитьИмяПредметаВУсловииСхемыПроцесса(
	ЭлементыОтбора, ИсходноеИмяПредмета, ИмяПредмета) Экспорт
	
	ПолеУсловиеПоПредметам = Новый ПолеКомпоновкиДанных("УсловиеПоПредметам");
	
	Для Каждого ЭлементОтбора Из ЭлементыОтбора Цикл
		
		Если ТипЗнч(ЭлементОтбора) = Тип("ЭлементОтбораКомпоновкиДанных") Тогда
			Если ЭлементОтбора.ЛевоеЗначение = ПолеУсловиеПоПредметам
				И ЭлементОтбора.ПравоеЗначение.ИмяПредмета = ИсходноеИмяПредмета Тогда
				
				ЭлементОтбора.ПравоеЗначение.ИмяПредмета = ИмяПредмета;
			КонецЕсли;
		Иначе
			ЗаменитьИмяПредметаВУсловииСхемыПроцесса(ЭлементОтбора.Элементы, ИсходноеИмяПредмета, ИмяПредмета);
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

// Удаляет значения автоподстановки исполнителей шаблона процесса
//
Процедура УдалитьЗначенияАвтоподстановкиПоИмениПредмета(Форма, ИмяПредмета) Экспорт
	
	ПроверяемыеРеквизиты = СтроковыеФункцииКлиентСервер.РазложитьСтрокуВМассивПодстрок(
		"Исполнитель,Проверяющий,Контролер");
		
	СоответствиеТаблиц = Новый Соответствие;
	СоответствиеТаблиц.Вставить("Исполнитель", "Исполнители");
	
	ИмяПредметаСтрокой = Строка(ИмяПредмета);
	
	Для Каждого Реквизит Из ПроверяемыеРеквизиты Цикл
		Если Форма.Элементы.Найти(Реквизит) <> Неопределено Тогда
			Если Форма.Объект.Свойство(Реквизит) Тогда
				Если ТипЗнч(Форма.Объект[Реквизит]) = Тип("Строка") Тогда
					Если ТипЗнч(Форма.Объект[Реквизит]) = Тип("Строка")
						И Найти(Форма.Объект[Реквизит] + ".", ИмяПредметаСтрокой + ".") = 1 Тогда
						Форма.Объект[Реквизит] = "";
					КонецЕсли;
				КонецЕсли;
			Иначе
				СтрокиКУдалению = Новый Массив;
				Для Каждого Элемент Из Форма.Объект[СоответствиеТаблиц.Получить(Реквизит)] Цикл
					Если ТипЗнч(Элемент[Реквизит]) = Тип("Строка") 
						И Найти(Элемент[Реквизит] + ".", ИмяПредметаСтрокой + ".") = 1 Тогда
						СтрокиКУдалению.Добавить(Элемент);
					КонецЕсли;
				КонецЦикла;
				Для Каждого Строка Из СтрокиКУдалению Цикл
					Форма.Объект[СоответствиеТаблиц.Получить(Реквизит)].Удалить(Строка);
				КонецЦикла;
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

// Заменяет значения автоподстановки исполнителей шаблона процесса
//
Процедура ЗаменитьЗначенияАвтоподстановкиПоИмениПредмета(Форма, СтароеЗначение, НовоеЗначение) Экспорт
	
	ПроверяемыеРеквизиты = СтроковыеФункцииКлиентСервер.РазложитьСтрокуВМассивПодстрок(
		"Исполнитель,Проверяющий,Контролер");
		
	СоответствиеТаблиц = Новый Соответствие;
	СоответствиеТаблиц.Вставить("Исполнитель", "Исполнители");
	
	СтароеЗначениеСтрокой = Строка(СтароеЗначение);
	НовоеЗначениеСтрокой = Строка(НовоеЗначение);
	
	Для Каждого Реквизит Из ПроверяемыеРеквизиты Цикл
		Если Форма.Элементы.Найти(Реквизит) <> Неопределено Тогда
			Если Форма.Объект.Свойство(Реквизит) Тогда
				Если ТипЗнч(Форма.Объект[Реквизит]) = Тип("Строка") Тогда
					Если ТипЗнч(Форма.Объект[Реквизит]) = Тип("Строка") 
						И Найти(Форма.Объект[Реквизит] + ".", СтароеЗначениеСтрокой + ".") = 1 Тогда
						Форма.Объект[Реквизит] = СтрЗаменить(Форма.Объект[Реквизит], СтароеЗначениеСтрокой, НовоеЗначениеСтрокой);
					КонецЕсли;
				КонецЕсли;
			Иначе
				Для Каждого Элемент Из Форма.Объект[СоответствиеТаблиц.Получить(Реквизит)] Цикл
					Если ТипЗнч(Элемент[Реквизит]) = Тип("Строка") 
						И Найти(Элемент[Реквизит] + ".", СтароеЗначениеСтрокой + ".") = 1 Тогда
						Элемент[Реквизит] = СтрЗаменить(Элемент[Реквизит], СтароеЗначениеСтрокой, НовоеЗначениеСтрокой);
					КонецЕсли;
				КонецЦикла
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

