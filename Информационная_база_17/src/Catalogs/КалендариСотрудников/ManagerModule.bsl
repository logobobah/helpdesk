#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаПолученияДанныхВыбора(ДанныеВыбора, Параметры, СтандартнаяОбработка)
	
	ДоступныеКалендари = ДоступныеСотрудникуКалендари().ВыгрузитьКолонку("Календарь");
	Параметры.Отбор.Вставить("Ссылка", ДоступныеКалендари);
	
КонецПроцедуры

#КонецОбласти

#Область ПрограммныйИнтерфейс

Функция ДоступныеСотрудникуКалендари(Сотрудник = Неопределено) Экспорт
	
	СотрудникиПользователя = ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(
			?(Сотрудник = Неопределено,ПользователиКлиентСервер.ТекущийПользователь(),Сотрудник));
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ
		|	КалендариСотрудников.Ссылка КАК Календарь,
		|	КалендариСотрудников.Наименование КАК Наименование,
		|	ИСТИНА КАК ЯвляетсяВладельцем
		|ИЗ
		|	Справочник.КалендариСотрудников КАК КалендариСотрудников
		|ГДЕ
		|	КалендариСотрудников.ПометкаУдаления = ЛОЖЬ
		|	И КалендариСотрудников.ВладелецКалендаря В(&СотрудникиПользователя)
		|
		|ОБЪЕДИНИТЬ
		|
		|ВЫБРАТЬ РАЗЛИЧНЫЕ
		|	КалендариСотрудниковДоступ.Ссылка,
		|	КалендариСотрудниковДоступ.Ссылка.Наименование,
		|	ЛОЖЬ
		|ИЗ
		|	Справочник.КалендариСотрудников.Доступ КАК КалендариСотрудниковДоступ
		|ГДЕ
		|	КалендариСотрудниковДоступ.Ссылка.ПометкаУдаления = ЛОЖЬ
		|	И КалендариСотрудниковДоступ.Сотрудник В(&СотрудникиПользователя)
		|
		|УПОРЯДОЧИТЬ ПО
		|	ЯвляетсяВладельцем УБЫВ,
		|	Наименование";
	
	Запрос.УстановитьПараметр("СотрудникиПользователя", СотрудникиПользователя);
	Таблица = Запрос.Выполнить().Выгрузить();
	
	Возврат Таблица;
	
КонецФункции

Функция СсылкаПоИдентификатору(Идентификатор, Пользователь) Экспорт
	
	Запрос = Новый Запрос(
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ ПЕРВЫЕ 1
	|	КалендариСотрудников.Ссылка
	|ИЗ
	|	Справочник.КалендариСотрудников КАК КалендариСотрудников
	|ГДЕ
	|	КалендариСотрудников.ВладелецКалендаря = &Пользователь
	|	И КалендариСотрудников.key = &key");
	Запрос.УстановитьПараметр("Пользователь", Пользователь);
	Запрос.УстановитьПараметр("key",
	ОбменСGoogle.КлючИзИдентификатора(Идентификатор, ТипЗнч(Справочники.КалендариСотрудников)));
	
	РезультатЗапроса = Запрос.Выполнить();
	Если РезультатЗапроса.Пустой() Тогда
		Возврат Справочники.КалендариСотрудников.ПустаяСсылка();
	КонецЕсли;
	
	Выборка = РезультатЗапроса.Выбрать();
	Выборка.Следующий();
	Возврат Выборка.Ссылка;
	
КонецФункции

Процедура ПроверитьСоздатьКалендарьСотрудника(Пользователь = Неопределено) Экспорт
	
	Если Пользователь = Неопределено Тогда
		Пользователь = Пользователи.АвторизованныйПользователь();
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ ПЕРВЫЕ 1
		|	КалендариСотрудников.Ссылка
		|ИЗ
		|	Справочник.КалендариСотрудников КАК КалендариСотрудников
		|ГДЕ
		|	КалендариСотрудников.ВладелецКалендаря = &ВладелецКалендаря";
	
	Запрос.УстановитьПараметр("ВладелецКалендаря", Пользователь);
	
	РезультатЗапроса = Запрос.Выполнить();
	Если Не РезультатЗапроса.Пустой() Тогда
		Возврат;
	КонецЕсли;
	
	ДанныеЗаполнения = Новый Структура;
	ДанныеЗаполнения.Вставить("ВладелецКалендаря", Пользователь);
	ДанныеЗаполнения.Вставить("Наименование", Строка(Пользователь));
	
	НовыйКалендарь = Справочники.КалендариСотрудников.СоздатьЭлемент();
	НовыйКалендарь.УстановитьНовыйКод();
	НовыйКалендарь.Заполнить(ДанныеЗаполнения);
	НовыйКалендарь.Записать();
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли