#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Возвращает текущее состояние классификатора контактов.
// 
// Возвращаемое значение:
//  Структура - Ключи: 
//    * КлассификаторКонтактовЗаполнен - Булево
//    * ЕстьКонтактыСозданныеПоСобытию - Булево
//
Функция ТекущееСостояние() Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	Запрос = Новый Запрос(
	"ВЫБРАТЬ ПЕРВЫЕ 1
	|	КлассификаторКонтактов.Ссылка
	|ИЗ
	|	Справочник.КлассификаторКонтактов КАК КлассификаторКонтактов
	|ГДЕ
	|	КлассификаторКонтактов.Пользователь = &Пользователь
	|	И НЕ КлассификаторКонтактов.СозданПоСобытию
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ ПЕРВЫЕ 1
	|	КлассификаторКонтактов.Ссылка
	|ИЗ
	|	Справочник.КлассификаторКонтактов КАК КлассификаторКонтактов
	|ГДЕ
	|	КлассификаторКонтактов.Пользователь = &Пользователь
	|	И КлассификаторКонтактов.СозданПоСобытию");
	Запрос.УстановитьПараметр("Пользователь", ПользователиКлиентСервер.АвторизованныйПользователь());
	
	РезультатЗапроса = Запрос.ВыполнитьПакет();
	
	Результат = Новый Структура;
	Результат.Вставить("КлассификаторКонтактовЗаполнен", Не РезультатЗапроса[0].Пустой());
	Результат.Вставить("ЕстьКонтактыСозданныеПоСобытию", Не РезультатЗапроса[1].Пустой());
	
	Возврат Результат;
	
КонецФункции

// Возвращает ссылку на КлассификаторКонтактов по указанному идентификатору.
//
// Параметры:
//  Идентификатор	 - Строка - идентификатор объекта
//  Пользователь	 - СправочникСсылка.Пользователи - пользователь,для которого будет производиться поиск объекта.
// 
// Возвращаемое значение:
//  СправочникСсылка.КлассификаторКонтактов - ссылка на найденный элемент справочника КлассификаторКонтактов.
//  Для случая когда элемент с указанным идентификатором не найден, возвращается ПустаяСсылка.
//
Функция СсылкаПоИдентификатору(Идентификатор, Пользователь) Экспорт
	
	Если Не ЗначениеЗаполнено(Идентификатор) Тогда
		Возврат Справочники.КлассификаторКонтактов.ПустаяСсылка();
	КонецЕсли;
	
	Запрос = Новый Запрос(
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ ПЕРВЫЕ 1
	|	КлассификаторКонтактов.Ссылка
	|ИЗ
	|	Справочник.КлассификаторКонтактов КАК КлассификаторКонтактов
	|ГДЕ
	|	КлассификаторКонтактов.Пользователь = &Пользователь
	|	И КлассификаторКонтактов.Key = &Key");
	
	Запрос.УстановитьПараметр("Пользователь", Пользователь);
	Запрос.УстановитьПараметр("Key",
	ОбменСGoogle.КлючИзИдентификатора(Идентификатор, ТипЗнч(Справочники.КлассификаторКонтактов)));
	
	РезультатЗапроса = Запрос.Выполнить();
	Если РезультатЗапроса.Пустой() Тогда
		Возврат Справочники.КлассификаторКонтактов.ПустаяСсылка();
	КонецЕсли;
	
	Выборка = РезультатЗапроса.Выбрать();
	Выборка.Следующий();
	Возврат Выборка.Ссылка;
	
КонецФункции

// Возвращает объект типа КлассификаторКонтактовОбъект по указанному идентификатору.
// В случае если объект по переданным параметрам не будет найден,
// будет создан новый объект и заполнен переданными параметрами.
//
// Параметры:
//  Идентификатор	 - Строка - идентификатор объекта
//  Пользователь	 - СправочникСсылка.Пользователи - пользователь,для которого будет производиться поиск объекта.
// 
// Возвращаемое значение:
//  СправочникОбъект.КлассификаторКонтактов - найденный или созданный в соответствии с параметрами объект.
//  Неопределено - для случая когда Идентификатор не указан.
//
Функция ОбъектПоИдентификатору(Идентификатор, Пользователь) Экспорт
	
	Если Не ЗначениеЗаполнено(Идентификатор) Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	СсылкаНаОбъект = СсылкаПоИдентификатору(Идентификатор, Пользователь);
	Если ЗначениеЗаполнено(СсылкаНаОбъект) Тогда
		Возврат СсылкаНаОбъект.ПолучитьОбъект();
	КонецЕсли;
	
	Результат = СоздатьЭлемент();
	Результат.Пользователь = Пользователь;
	Результат.Id = Идентификатор;
	Возврат Результат;
	
КонецФункции

// Заполняет контактную информацию контрагента или контактного лица
// из реквизита JSON классификатора контактов
//
// Параметры:
//  КонтактнаяИнформация - ДанныеФормыКолленкция - контактная информация для заполнения
//  ДанныеКонтактаJSON	 - Строка - значение реквизита JSON из классификатора
//                         для заполнения контактной информации
//  ТипЗначения			 - Тип - тип объекта, для которого заполняется контактная информация
Процедура ЗаполнитьКонтактнуюИнформациюИзJSON(КонтактнаяИнформация, Знач ДанныеКонтактаJSON, Знач ТипЗначения) Экспорт
	
	Если Не ЗначениеЗаполнено(ДанныеКонтактаJSON) Тогда
		Возврат;
	КонецЕсли;
	
	ЧтениеJSON = Новый ЧтениеJSON;
	ЧтениеJSON.УстановитьСтроку(ДанныеКонтактаJSON);
	ПрочитанныеДанные = ПрочитатьJSON(ЧтениеJSON, Истина);
	
	ЗаполнитьEmail(КонтактнаяИнформация, ПрочитанныеДанные["gd$email"], ТипЗначения);
	ЗаполнитьНомераТелефонов(КонтактнаяИнформация, ПрочитанныеДанные["gd$phoneNumber"], ТипЗначения);
	ЗаполнитьАдреса(КонтактнаяИнформация, ПрочитанныеДанные["gd$structuredPostalAddress"], ТипЗначения);
	ЗаполнитьСайты(КонтактнаяИнформация, ПрочитанныеДанные["gContact$website"], ТипЗначения);
	
КонецПроцедуры

// Функция возвращает список значений для обработчика АвтоПодбор в поле выбора
//
// Параметры:
//  СтрокаПоиска			 - Строка - строка, используемая при поиске данных, по которой осуществляется быстрый выбор
//  ТолькоКлассификатор		 - Булево - при установке в значение Истина поиск будет осуществляться только по классификатору,
//                             Ложь - данные для выбора будут предлагаться в консолидированном виде, по справочнику и классификатору
//  ТипЗначения				 - Тип - тип значения, которое будет подставляться в поле ввода
//  Отбор					 - Структура - значение, передаваемое в обработчик АвтоПодбора Параметры.Отбор
// 
// Возвращаемое значение:
//  СписокЗначений - значение параметра ДанныеВыбора для обработчика АвтоПодбор
//  Неопределено - в случае когда параметр СтрокаПоиска не указан
//
Функция СписокАвтоПодбора(Знач СтрокаПоиска, Знач ТолькоКлассификатор, Знач ТипЗначения, Знач Отбор) Экспорт
	
	Если ПустаяСтрока(СтрокаПоиска) Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	Результат = Новый СписокЗначений;
	
	Запрос = ЗапросДляСпискаАвтоПодбора(СтрокаПоиска, ТипЗначения, Отбор);
	РезультатЗапроса = Запрос.Выполнить();
	Если РезультатЗапроса.Пустой() Тогда
		Возврат Результат;
	КонецЕсли;
	
	Выборка = РезультатЗапроса.Выбрать();
	
	Пока Выборка.Следующий() Цикл
		
		Если Выборка.Порядок = 1 Тогда
			
			Если ТолькоКлассификатор Тогда
				Продолжить;
			КонецЕсли;
			
			Результат.Добавить(Выборка.Ссылка, ПредставлениеЭлементаСписка(Выборка.Представление, СтрокаПоиска));
			Продолжить;
			
		КонецЕсли;
		
		// Выборка.СозданПоСобытию может быть Null
		Если Выборка.СозданПоСобытию = Ложь Тогда
			ДобавитьПредставлениеКонтакта(Результат, Выборка, СтрокаПоиска);
		ИначеЕсли Выборка.СозданПоСобытию = Истина Тогда
			ДобавитьПредставлениеСозданногоПоСобытиюКонтакта(Результат, Выборка, СтрокаПоиска);
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

Функция КонтактКакСвязаться(ЭлементКлассификатораКонтактов) Экспорт
	
	Результат = Новый Структура("Контакт, КакСвязаться");
	
	ДанныеКонтакта = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(
	ЭлементКлассификатораКонтактов,
	"Id, Title, JSON, СозданПоСобытию");
	
	Результат.Контакт = ДанныеКонтакта.Title;
	
	Если ДанныеКонтакта.СозданПоСобытию Тогда
		Результат.КакСвязаться = ДанныеКонтакта.Id;
		Возврат Результат;
	КонецЕсли;
	
	ЧтениеJSON = Новый ЧтениеJSON;
	ЧтениеJSON.УстановитьСтроку(ДанныеКонтакта.JSON);
	ПрочитанныеДанные = ПрочитатьJSON(ЧтениеJSON, Истина);
	Если ЗначениеЗаполнено(ПрочитанныеДанные["gd$email"]) Тогда
		Результат.КакСвязаться = ПрочитанныеДанные["gd$email"][0]["address"];
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

Процедура УстановитьКонтактКакСвязаться(КонтактОбъект, Контакт, КакСвязаться) Экспорт
	
	ДанныеДляЗаписи = Новый Соответствие;
	ДанныеДляЗаписи["gd$email"] = Новый Массив;
	ДанныеДляЗаписи["gd$email"].Добавить(Новый Структура("address", КакСвязаться));
	
	ЗаписьJSON = Новый ЗаписьJSON;
	ЗаписьJSON.УстановитьСтроку();
	ЗаписатьJSON(ЗаписьJSON, ДанныеДляЗаписи);
	
	КонтактОбъект.JSON = ЗаписьJSON.Закрыть();
	КонтактОбъект.Title = Контакт;
	КонтактОбъект.ДатаСинхронизации = ТекущаяДатаСеанса();
	КонтактОбъект.СозданПоСобытию = Истина;
	
КонецПроцедуры

Функция ЗаполнитьФИО(Знач ДанныеКонтактаJSON) Экспорт
	
	Если Не ЗначениеЗаполнено(ДанныеКонтактаJSON) Тогда
		Возврат "";
	КонецЕсли;
	
	ЧтениеJSON = Новый ЧтениеJSON;
	ЧтениеJSON.УстановитьСтроку(ДанныеКонтактаJSON);
	ПрочитанныеДанные = ПрочитатьJSON(ЧтениеJSON, Истина);
	ДанныеНаименования = ПрочитанныеДанные["gd$name"];
	
	Имя = "";
	Фамилия = "";
	Отчество = "";
	
	ПолеСоответствия =  ДанныеНаименования.Получить("gd$givenName");
	Если ПолеСоответствия <> НЕопределено Тогда
		Имя = ПолеСоответствия["$t"];
	КонецЕсли;
	ПолеСоответствия =  ДанныеНаименования.Получить("gd$familyName");
	Если ПолеСоответствия <> НЕопределено Тогда
		Фамилия = ПолеСоответствия["$t"];
	КонецЕсли;
	ПолеСоответствия =  ДанныеНаименования.Получить("gd$additionalName");
	Если ПолеСоответствия <> НЕопределено Тогда
		Отчество = ПолеСоответствия["$t"];
	КонецЕсли;
	
	Возврат СокрЛП(Фамилия + ?(ПустаяСтрока(Имя),""," " + Имя) + ?(ПустаяСтрока(Отчество),""," " + Отчество));
КонецФункции

#КонецОбласти

#Область ОбработчикиСобытий

Процедура ОбработкаПолученияДанныхВыбора(ДанныеВыбора, Параметры, СтандартнаяОбработка)
	
	ДанныеВыбора = СписокАвтоПодбора(Параметры.СтрокаПоиска, Истина, Тип("СправочникСсылка.Контрагенты"), Параметры.Отбор);
	СтандартнаяОбработка = Не ЗначениеЗаполнено(ДанныеВыбора);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ЗапросДляСпискаАвтоПодбора(СтрокаПоиска, ТипЗначения, Отбор)
	
	ТекстЗапроса =
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ ПЕРВЫЕ 10
	|	ЭлементыСправочника.Ссылка КАК Ссылка,
	|	ЭлементыСправочника.Наименование КАК Представление,
	|	"""" КАК Организация,
	|	1 КАК Порядок
	|ПОМЕСТИТЬ Существующие
	|ИЗ
	|	Справочник.Заказчики КАК ЭлементыСправочника
	|ГДЕ
	|	ЭлементыСправочника.Наименование ПОДОБНО &СтрокаПоиска
	|	И НЕ ЭлементыСправочника.ПометкаУдаления
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗРЕШЕННЫЕ ПЕРВЫЕ 10
	|	Существующие.Ссылка,
	|	Существующие.Представление,
	|	Существующие.Организация,
	|	NULL КАК Идентификатор,
	|	NULL КАК СозданПоСобытию,
	|	Существующие.Порядок
	|ИЗ
	|	Существующие КАК Существующие
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ ПЕРВЫЕ 10
	|	КлассификаторКонтактов.Ссылка,
	|	КлассификаторКонтактов.Title,
	|	КлассификаторКонтактов.Organization,
	|	КлассификаторКонтактов.Id,
	|	КлассификаторКонтактов.СозданПоСобытию,
	|	2
	|ИЗ
	|	Справочник.КлассификаторКонтактов КАК КлассификаторКонтактов
	|ГДЕ
	|	КлассификаторКонтактов.Пользователь = &Пользователь
	|	И (КлассификаторКонтактов.Title ПОДОБНО &СтрокаПоиска
	|			ИЛИ КлассификаторКонтактов.Organization ПОДОБНО &СтрокаПоиска
	|			ИЛИ ВЫБОР
	|				КОГДА КлассификаторКонтактов.СозданПоСобытию
	|					ТОГДА КлассификаторКонтактов.Id ПОДОБНО &СтрокаПоиска
	|				ИНАЧЕ ЛОЖЬ
	|			КОНЕЦ)
	|	И НЕ КлассификаторКонтактов.ПометкаУдаления
	|	И НЕ КлассификаторКонтактов.Title В
	|				(ВЫБРАТЬ
	|					Существующие.Представление
	|				ИЗ
	|					Существующие)
	|
	|УПОРЯДОЧИТЬ ПО
	|	Существующие.Порядок,
	|	Существующие.Представление";
	
	ОбъектМетаданных = Метаданные.НайтиПоТипу(ТипЗначения);
	
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса,
	"Справочник.Заказчики",
	ОбъектМетаданных.ПолноеИмя());
	
	НаложитьОтборПоПризнакуНедействителен(ТекстЗапроса, ОбъектМетаданных);
	
	НаложитьОтборПоГруппе(ТекстЗапроса, ОбъектМетаданных);
	
	Результат = Новый Запрос(
	ТекстЗапросаСОтборамиПоПолямВводПоСтроке(ТекстЗапроса, ОбъектМетаданных));
	
	НаложитьОтбор(Результат, Отбор);
	
	Результат.УстановитьПараметр("СтрокаПоиска", "%" + СтрокаПоиска + "%");
	Результат.УстановитьПараметр("Пользователь", ПользователиКлиентСервер.АвторизованныйПользователь());
	
	Возврат Результат;
	
КонецФункции

Процедура НаложитьОтборПоПризнакуНедействителен(ТекстЗапроса, ОбъектМетаданных)
	
	Если Не ОбщегоНазначения.ЕстьРеквизитОбъекта("Недействителен", ОбъектМетаданных) Тогда
		Возврат;
	КонецЕсли;
	
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса,
	"И НЕ ЭлементыСправочника.ПометкаУдаления",
	"И НЕ ЭлементыСправочника.Недействителен
	|И НЕ ЭлементыСправочника.ПометкаУдаления");
	
КонецПроцедуры

Процедура НаложитьОтборПоГруппе(ТекстЗапроса, ОбъектМетаданных)
	
	Если Не ОбъектМетаданных.Иерархический Тогда
		Возврат;
	КонецЕсли;
	
	Если ОбъектМетаданных.ВидИерархии <> Метаданные.СвойстваОбъектов.ВидИерархии.ИерархияГруппИЭлементов Тогда
		Возврат;
	КонецЕсли;
	
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса,
	"И НЕ ЭлементыСправочника.ПометкаУдаления",
	"И НЕ ЭлементыСправочника.ПометкаУдаления
	|И НЕ ЭлементыСправочника.ЭтоГруппа");
	
КонецПроцедуры

Функция ТекстЗапросаСОтборамиПоПолямВводПоСтроке(ТекстЗапроса, ОбъектМетаданных)
	
	КомпонентыЗапроса = СтрРазделить(ТекстЗапроса, ";");
	
	ШаблонДляДобавления = КомпонентыЗапроса[0];
	
	ШаблонДляДобавления = СтрЗаменить(ШаблонДляДобавления, "РАЗРЕШЕННЫЕ", "");
	ШаблонДляДобавления = СтрЗаменить(ШаблонДляДобавления, "ПОМЕСТИТЬ Существующие", "");
	
	ДобавленныеКомпоненты = Новый Массив;
	ДобавленныеКомпоненты.Добавить(КомпонентыЗапроса[0]);
	
	Для Каждого Поле Из ОбъектМетаданных.ВводПоСтроке Цикл
		
		Если Поле.Имя = "Наименование" Тогда
			Продолжить;
		КонецЕсли;
		
		ДобавляемыйКомпонент = СтрЗаменить(
		ШаблонДляДобавления,
		"ЭлементыСправочника.Наименование ПОДОБНО &СтрокаПоиска",
		СтрШаблон("ЭлементыСправочника.%1 ПОДОБНО &СтрокаПоиска", Поле.Имя));
		
		ДобавляемыйКомпонент = СтрЗаменить(
		ДобавляемыйКомпонент,
		"ЭлементыСправочника.Наименование КАК Представление",
		СтрШаблон("ЭлементыСправочника.%1 + "" ("" + ЭлементыСправочника.Наименование + "")"" КАК Представление",
		Поле.Имя));
		
		ДобавленныеКомпоненты.Добавить(ДобавляемыйКомпонент);
		
	КонецЦикла;
	
	Результат = Новый Массив;
	Результат.Добавить(СтрСоединить(ДобавленныеКомпоненты, "
	|ОБЪЕДИНИТЬ ВСЕ
	|"));
	
	Результат.Добавить(КомпонентыЗапроса[1]);
	
	Возврат СтрСоединить(Результат, ";");
	
КонецФункции

Процедура НаложитьОтбор(Запрос, Отбор)
	
	Если Не ЗначениеЗаполнено(Отбор) Тогда
		Возврат;
	КонецЕсли;
	
	Для Каждого КлючИЗначение Из Отбор Цикл
		Запрос.Текст = СтрЗаменить(Запрос.Текст,
		"И НЕ ЭлементыСправочника.ПометкаУдаления",
		СтрШаблон("И ЭлементыСправочника.%1 = &Параметр%1
		|И НЕ ЭлементыСправочника.ПометкаУдаления", КлючИЗначение.Ключ));
		Запрос.УстановитьПараметр(СтрШаблон("Параметр%1", КлючИЗначение.Ключ), КлючИЗначение.Значение);
	КонецЦикла;
	
КонецПроцедуры

Функция ПредставлениеЭлементаСписка(Представление, СтрокаПоиска)
	
	Позиция = Найти(НРег(Представление), НРег(СтрокаПоиска));
	Если Позиция>0 Тогда
		ТекстДо = Лев(Представление, Позиция-1);
		ТекстЦентр = Сред(Представление, Позиция, СтрДлина(СтрокаПоиска));
		ТекстПосле = Сред(Представление, Позиция+СтрДлина(СтрокаПоиска));
		ВыделенныйТекст = Новый ФорматированнаяСтрока(ТекстЦентр, Новый Шрифт(Новый Шрифт,,, Истина), WebЦвета.ЗеленыйЛес);
		Результат = Новый ФорматированнаяСтрока(ТекстДо, ВыделенныйТекст, ТекстПосле);
	Иначе
		Результат = Представление;
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

Процедура ЗаполнитьНомераТелефонов(КонтактнаяИнформация, ДанныеТелефонов, ТипЗначения)
	
	Если ТипЗнч(ДанныеТелефонов) <> Тип("Массив") Тогда
		Возврат;
	КонецЕсли;
	
	Для Каждого ТекЭлемент Из ДанныеТелефонов Цикл
		
		ТекЗначение = ТекЭлемент["$t"];
		
		Если Не ЗначениеЗаполнено(ТекЗначение) Тогда
			Продолжить;
		КонецЕсли;
		
		НайденныеСтроки = КонтактнаяИнформация.НайтиСтроки(
		Новый Структура("Представление", ТекЗначение));
		
		Если ЗначениеЗаполнено(НайденныеСтроки) Тогда
			Продолжить;
		КонецЕсли;
		
		СтрокаКИ = НайтиИлиДобавитьНовуюСтрокуКИ(КонтактнаяИнформация, Перечисления.ТипыКонтактнойИнформации.Телефон);
		
		СтрокаКИ.Представление = ТекЗначение;
		Если ТипЗначения = Тип("СправочникСсылка.Заказчики") Тогда
			СтрокаКИ.Вид = Справочники.ВидыКонтактнойИнформации.ТелефонЗаказчика;
		ИначеЕсли ТипЗначения = Тип("СправочникСсылка.КонтактныеЛицаЗаказчиков") Тогда
			СтрокаКИ.Вид = Справочники.ВидыКонтактнойИнформации.ТелефонКЛ;
		ИначеЕсли ТипЗначения = Тип("СправочникСсылка.Пользователи") Тогда
			СтрокаКИ.Вид = Справочники.ВидыКонтактнойИнформации.ТелефонПользователя;
		КонецЕсли;
		
		СтрокаКИ.ЗначенияПолей = ЗначенияПолейНомерТелефона(ТекЭлемент);
		
	КонецЦикла;
	
КонецПроцедуры

Функция ЗначенияПолейНомерТелефона(ДанныеТелефона)
	
	Если Не ЗначениеЗаполнено(ДанныеТелефона["uri"]) Тогда
		Возврат ДанныеТелефона["$t"];
	КонецЕсли;
	
	ЗначениеДляРазбора = СтрЗаменить(ДанныеТелефона["uri"], "tel:", "");
	
	Результат = УправлениеКонтактнойИнформацией.КонтактнаяИнформацияXMLПоПредставлению(
	ЗначениеДляРазбора,
	Перечисления.ТипыКонтактнойИнформации.Телефон);
	
	Возврат Результат;
	
КонецФункции

Процедура ЗаполнитьEmail(КонтактнаяИнформация, ДанныеЭлектроннойПочты, ТипЗначения)
	
	Если ТипЗнч(ДанныеЭлектроннойПочты) <> Тип("Массив") Тогда
		Возврат;
	КонецЕсли;
	
	Для Каждого ТекЭлемент Из ДанныеЭлектроннойПочты Цикл
		
		ТекЗначение = ТекЭлемент["address"];
		
		Если Не ЗначениеЗаполнено(ТекЗначение) Тогда
			Продолжить;
		КонецЕсли;
		
		НайденныеСтроки = КонтактнаяИнформация.НайтиСтроки(
		Новый Структура("Представление", ТекЗначение));
		
		Если ЗначениеЗаполнено(НайденныеСтроки) Тогда
			Продолжить;
		КонецЕсли;
		
		СтрокаКИ = НайтиИлиДобавитьНовуюСтрокуКИ(КонтактнаяИнформация, Перечисления.ТипыКонтактнойИнформации.АдресЭлектроннойПочты);
		СтрокаКИ.Представление = ТекЗначение;
		Если ТипЗначения = Тип("СправочникСсылка.Заказчики") Тогда
			СтрокаКИ.Вид = Справочники.ВидыКонтактнойИнформации.EmailЗаказчика;
		ИначеЕсли ТипЗначения = Тип("СправочникСсылка.КонтактныеЛицаЗаказчиков") Тогда
			СтрокаКИ.Вид = Справочники.ВидыКонтактнойИнформации.EmailКЛ;
		ИначеЕсли ТипЗначения = Тип("СправочникСсылка.Пользователи") Тогда
			СтрокаКИ.Вид = Справочники.ВидыКонтактнойИнформации.EmailПользователя;
		КонецЕсли;
		
		СтрокаКИ.ЗначенияПолей = СтрокаКИ.Представление;
		
	КонецЦикла;
	
КонецПроцедуры

Процедура ЗаполнитьАдреса(КонтактнаяИнформация, ДанныеАдресов, ТипЗначения)
	
	Возврат; //Заполнение адресов не используется
	Если ТипЗначения <> Тип("СправочникСсылка.Заказчики") 
		И ТипЗначения <> Тип("СправочникСсылка.Пользователи") Тогда
		Возврат;
	КонецЕсли;
	
	Если ТипЗнч(ДанныеАдресов) <> Тип("Массив") Тогда
		Возврат;
	КонецЕсли;
	
	Для Каждого ТекЭлемент Из ДанныеАдресов Цикл
		
		КонтактнаяИнформацияАдрес = КонтактнаяИнформацияАдрес(ТекЭлемент);
		
		Если Не ЗначениеЗаполнено(КонтактнаяИнформацияАдрес) Тогда
			Продолжить;
		КонецЕсли;
		
		НайденныеСтроки = КонтактнаяИнформация.НайтиСтроки(
		Новый Структура("Представление", КонтактнаяИнформацияАдрес.Представление));
		
		Если ЗначениеЗаполнено(НайденныеСтроки) Тогда
			Продолжить;
		КонецЕсли;
		
		СтрокаКИ = НайтиИлиДобавитьНовуюСтрокуКИ(КонтактнаяИнформация, Перечисления.ТипыКонтактнойИнформации.Адрес);
		СтрокаКИ.Представление = КонтактнаяИнформацияАдрес.Представление;
		СтрокаКИ.ЗначенияПолей = КонтактнаяИнформацияАдрес.ЗначенияПолей;
		
		Если ТипЗначения = Тип("СправочникСсылка.Заказчики") Тогда
			СтрокаКИ.Вид = Справочники.ВидыКонтактнойИнформации.ФактическийАдресЗаказчика;
		КонецЕсли;
		
		Если ТипЗначения = Тип("СправочникСсылка.Пользователи") Тогда
			СтрокаКИ.Вид = Справочники.ВидыКонтактнойИнформации.АдресПользователя;
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

Функция КонтактнаяИнформацияАдрес(ДанныеАдреса)
	
	Результат = Новый Структура;
	
	Если ТипЗнч(ДанныеАдреса) <> Тип("Соответствие") Тогда
		Возврат Результат;
	КонецЕсли;
	
	СтруктураПолейАдреса = УправлениеКонтактнойИнформациейКлиентСервер.СтруктураКонтактнойИнформацииПоТипу(Перечисления.ТипыКонтактнойИнформации.Адрес);
	СтруктураПолейАдреса.Представление = КомпонентаАдреса(ДанныеАдреса["gd$formattedAddress"]);
	СтруктураПолейАдреса.Страна = КомпонентаАдреса(ДанныеАдреса["gd$country"]);
	СтруктураПолейАдреса.Индекс = КомпонентаАдреса(ДанныеАдреса["gd$postcode"]);
	СтруктураПолейАдреса.Регион = КомпонентаАдреса(ДанныеАдреса["gd$region"]);
	СтруктураПолейАдреса.Район = КомпонентаАдреса(ДанныеАдреса["gd$neighborhood"]);
	СтруктураПолейАдреса.Город = КомпонентаАдреса(ДанныеАдреса["gd$city"]);
	СтруктураПолейАдреса.Улица = КомпонентаАдреса(ДанныеАдреса["gd$street"]);
	СтруктураПолейАдреса.Дом = КомпонентаАдреса(ДанныеАдреса["gd$pobox"]);
	
	Результат.Вставить("ЗначенияПолей", 
	УправлениеКонтактнойИнформацией.КонтактнаяИнформацияВXML(
	СтруктураПолейАдреса,
	СтруктураПолейАдреса.Представление,
	Перечисления.ТипыКонтактнойИнформации.Адрес));
	
	Результат.Вставить("Представление", 
	УправлениеКонтактнойИнформацией.ПредставлениеКонтактнойИнформации(Результат.ЗначенияПолей));
	
	Возврат Результат;
	
КонецФункции

Функция КомпонентаАдреса(Компонента)
	
	Если ТипЗнч(Компонента) <> Тип("Соответствие") Тогда
		Возврат "";
	КонецЕсли;
	
	Возврат СокрЛП(СтрЗаменить(Компонента["$t"], Символы.ПС, " "));
	
КонецФункции

Процедура ЗаполнитьСайты(КонтактнаяИнформация, ДанныеВебсайтов, ТипЗначения)
	
	Возврат; //Заполнение не используется
	Если ТипЗначения <> Тип("СправочникСсылка.Заказчики") Тогда
		Возврат;
	КонецЕсли;
	
	Если ТипЗнч(ДанныеВебсайтов) <> Тип("Массив") Тогда
		Возврат;
	КонецЕсли;
	
	Для Каждого ТекЭлемент Из ДанныеВебсайтов Цикл
		
		ТекЗначение = ТекЭлемент["href"];
		
		НайденныеСтроки = КонтактнаяИнформация.НайтиСтроки(
		Новый Структура("Представление", ТекЗначение));
		
		Если ЗначениеЗаполнено(НайденныеСтроки) Тогда
			Продолжить;
		КонецЕсли;
		
		СтрокаКИ = НайтиИлиДобавитьНовуюСтрокуКИ(КонтактнаяИнформация, Перечисления.ТипыКонтактнойИнформации.ВебСтраница);
		СтрокаКИ.Представление = ТекЗначение;
		СтрокаКИ.Вид = Справочники.ВидыКонтактнойИнформации.ДругаяИнформацияКонтрагента;
		
		СтрокаКИ.ЗначенияПолей = СтрокаКИ.Представление;
		
	КонецЦикла;
	
КонецПроцедуры

Функция НайтиИлиДобавитьНовуюСтрокуКИ(КонтактнаяИнформация, ТипКонтактнойИнформации)
	
	НайденныеСтроки = КонтактнаяИнформация.НайтиСтроки(
	Новый Структура("Тип", ТипКонтактнойИнформации));
	
	Для Каждого НайденнаяСтрока Из НайденныеСтроки Цикл
		Если Не ЗначениеЗаполнено(НайденнаяСтрока.Представление) Тогда
			Возврат НайденнаяСтрока;
		КонецЕсли;
	КонецЦикла;
	
	// Добавляем новую строку КИ с группировкой по типу КИ
	КоличествоЭлементовКоллекции = КонтактнаяИнформация.Количество();
	ИндексВставки = КоличествоЭлементовКоллекции;
	
	Для ОбратныйИндекс = 1 По КоличествоЭлементовКоллекции Цикл
		ТекущийИндекс = КоличествоЭлементовКоллекции - ОбратныйИндекс;
		Если КонтактнаяИнформация[ТекущийИндекс].Тип = ТипКонтактнойИнформации Тогда
			ИндексВставки = ТекущийИндекс + 1;
			Прервать;
		КонецЕсли;
	КонецЦикла;
	
	Результат = КонтактнаяИнформация.Вставить(ИндексВставки);
	Результат.Тип = ТипКонтактнойИнформации;
	
	Возврат Результат;
	
КонецФункции

Процедура ДобавитьПредставлениеКонтакта(СписокКонтактов, Данные, СтрокаПоиска)
	
	Если ЗначениеЗаполнено(Данные.Организация) Тогда
		Представление = СтрШаблон("%1 (%2)", Данные.Представление, Данные.Организация);
	Иначе
		Представление = Данные.Представление;
	КонецЕсли;
	
	СписокКонтактов.Добавить(
	Данные.Ссылка,
	ПредставлениеЭлементаСписка(Представление, СтрокаПоиска),,
	БиблиотекаКартинок.GoogleДобавить);
	
КонецПроцедуры

Процедура ДобавитьПредставлениеСозданногоПоСобытиюКонтакта(СписокКонтактов, Данные, СтрокаПоиска)
	
	Если Данные.Представление <> Данные.Идентификатор Тогда
		Представление = СтрШаблон("%1 (%2)", Данные.Представление, Данные.Идентификатор);
	Иначе
		Представление = Данные.Представление;
	КонецЕсли;
	
	СписокКонтактов.Добавить(
	Данные.Ссылка,
	ПредставлениеЭлементаСписка(Представление, СтрокаПоиска),,
	БиблиотекаКартинок.КонтактнаяИнформацияЕмэйл);
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли