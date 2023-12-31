/////////////////////////////////////////////////////////////////////////////////////////
// ПРОВЕРКА ТИПОВ ЗНАЧЕНИЙ

// Возвращает Истина, если переданное значение является
// ссылкой на Проекты или Объектом типа Проекты
Функция ЭтоПроект(Значение) Экспорт
	
	#Если Сервер Тогда
		Возврат ТипЗнч(Значение) = Тип("СправочникСсылка.Проекты")
			Или ТипЗнч(Значение) = Тип("СправочникОбъект.Проекты");
	#Иначе
		Возврат ТипЗнч(Значение) = Тип("СправочникСсылка.Проекты");
	#КонецЕсли
	
КонецФункции

// Возвращает Истина, если переданное значение является
// ссылкой на СообщенияОбсуждений или Объектом типа СообщенияОбсуждений
Функция ЭтоСообщение(Значение) Экспорт
	
	#Если Сервер Тогда
		Возврат ТипЗнч(Значение) = Тип("СправочникСсылка.СообщенияОбсуждений")
			Или ТипЗнч(Значение) = Тип("СправочникОбъект.СообщенияОбсуждений");
	#Иначе
		Возврат ТипЗнч(Значение) = Тип("СправочникСсылка.СообщенияОбсуждений");
	#КонецЕсли
	
КонецФункции

// Возвращает Истина, если переданное значение является
// ссылкой на ЗадачаИсполнителя или Объектом типа ЗадачаИсполнителя
Функция ЭтоЗадачаИсполнителя(Значение) Экспорт
	
	#Если Сервер Тогда
		Возврат ТипЗнч(Значение) = Тип("ДокументСсылка.Задачи")
			Или ТипЗнч(Значение) = Тип("ДокументОбъект.Задачи");
	#Иначе
		Возврат ТипЗнч(Значение) = Тип("ДокументСсылка.Задачи");
	#КонецЕсли
	
КонецФункции

// Возвращает Истина, если переданное значение является
// ссылкой на Файлы или Объектом типа Файлы
Функция ЭтоФайл(Значение) Экспорт
	
	#Если Сервер Тогда
		Возврат ТипЗнч(Значение) = Тип("СправочникСсылка.Файлы")
			Или ТипЗнч(Значение) = Тип("СправочникОбъект.Файлы");
	#Иначе
		Возврат ТипЗнч(Значение) = Тип("СправочникСсылка.Файлы");
	#КонецЕсли
	
КонецФункции

// Сформировать заголовок группы Файлы
Функция КоличествоФайловВЗаголовок(КоличествоФайлов) Экспорт
	
	Заголовок = НСтр("ru = 'Файлы'");
	
	Если КоличествоФайлов <> 0 Тогда
		Заголовок = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = 'Файлы (%1)'"),
			КоличествоФайлов);
	КонецЕсли;
	
	Возврат Заголовок;
	
КонецФункции

// Получает строковое строку из регистрационного номера и даты регистрации
Функция ПредставлениеНомераИДаты(РегистрационныйНомер, ДатаРегистрации) Экспорт
	
	Если ЗначениеЗаполнено(РегистрационныйНомер) И ЗначениеЗаполнено(ДатаРегистрации) Тогда
		
		ПредставлениеНомераИДаты = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = '№ %1 от %2'"),
			РегистрационныйНомер,
			Формат(ДатаРегистрации, "ДЛФ=D"));
		
	ИначеЕсли ЗначениеЗаполнено(РегистрационныйНомер) Тогда
		
		ПредставлениеНомераИДаты = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = '№ %1'"),
			РегистрационныйНомер);
		
	Иначе
		
		ПредставлениеНомераИДаты = "";
	
	КонецЕсли;
	
	Возврат ПредставлениеНомераИДаты;
	
КонецФункции

// Подпись к количеству лет по склонениям
Функция ПодписьЛет(Количество) Экспорт
	
	Если Количество > 10 И Количество < 20 Тогда
		Возврат НСтр("ru = 'лет'");
	Иначе
		Срок = Количество - Цел(Количество / 10) * 10;
		Если Срок = 0 Тогда
			Возврат НСтр("ru = 'лет'");
		ИначеЕсли Срок = 1 Тогда
			Возврат НСтр("ru = 'год'");
		ИначеЕсли Срок < 5 Тогда
			Возврат НСтр("ru = 'года'");
		Иначе
			Возврат НСтр("ru = 'лет'");
		КонецЕсли;
	КонецЕсли;
	
КонецФункции

// Строковое описание разности дат в днях с учетом склонений
Функция РазностьДатВДнях(Дата1, Дата2) Экспорт
	
	ЧислоЧасов = 0;
	ЧислоДней = (НачалоДня(Дата1) - НачалоДня(Дата2)) / (60*60*24);
		
	Если ЧислоЧасов < 0 Тогда
		ЧислоДней = ЧислоДней - 1;
		ЧислоЧасов = ЧислоЧасов + 24;
	КонецЕсли;
	ПодписьДней = ПолучитьПодписьДней(ЧислоДней);
	ПодписьЧасов = ПолучитьПодписьЧасов(ЧислоЧасов);
	
	Если ЧислоДней > 0 Тогда
		Возврат СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			"%1 %2",
			Строка(ЧислоДней),
			ПодписьДней);
	Иначе
		Возврат НСтр("ru = 'Менее 1 дня'");
	КонецЕсли;
	
КонецФункции

// Подпись к количеству дней по склонениям
Функция ПолучитьПодписьДней(ЧислоДней) Экспорт
	
	Если ЧислоДней > 10 И ЧислоДней < 20 Тогда
		Подпись = НСтр("ru = 'дней'");
	Иначе
		ПоследниеДвеЦифры = ЧислоДней - Цел(ЧислоДней / 100) * 100;
		ПоследняяЦифра = ЧислоДней - Цел(ЧислоДней / 10) * 10;
		
		Если ПоследняяЦифра = 0 Тогда
			Подпись = НСтр("ru = 'дней'");
		ИначеЕсли ПоследниеДвеЦифры > 10 И ПоследниеДвеЦифры < 20 Тогда
			Подпись = Нстр("ru = 'дней'");
		ИначеЕсли ПоследниеДвеЦифры < 10 Или ПоследниеДвеЦифры > 20 Тогда
			Если ПоследняяЦифра = 1 Тогда
				Подпись = Нстр("ru = 'день'");
			ИначеЕсли ПоследняяЦифра < 5 Тогда
				Подпись = НСтр("ru = 'дня'");
			Иначе
				Подпись = НСтр("ru = 'дней'");
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
	
	Возврат Подпись;
	
КонецФункции

// Подпись к количеству рабочих дней по склонениям
Функция ПолучитьПодписьРабочихДней(ЧислоДней) Экспорт
	
	Если ЧислоДней > 10 И ЧислоДней < 20 Тогда
		Подпись = НСтр("ru = 'рабочих дней'");
	Иначе
		ПоследниеДвеЦифры = ЧислоДней - Цел(ЧислоДней / 100) * 100;
		ПоследняяЦифра = ЧислоДней - Цел(ЧислоДней / 10) * 10;
		
		Если ПоследняяЦифра = 0 Тогда
			Подпись = НСтр("ru = 'рабочих дней'");
		ИначеЕсли ПоследниеДвеЦифры > 10 И ПоследниеДвеЦифры < 20 Тогда
			Подпись = Нстр("ru = 'рабочих дней'");
		ИначеЕсли ПоследниеДвеЦифры < 10 Или ПоследниеДвеЦифры > 20 Тогда
			Если ПоследняяЦифра = 1 Тогда
				Подпись = Нстр("ru = 'рабочий день'");
			ИначеЕсли ПоследняяЦифра < 5 Тогда
				Подпись = НСтр("ru = 'рабочих дня'");
			Иначе
				Подпись = НСтр("ru = 'рабочих дней'");
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
	
	Возврат Подпись;
	
КонецФункции

// Подпись к количеству часов по склонениям
Функция ПолучитьПодписьЧасов(ЧислоЧасов) Экспорт
	
	Если ЧислоЧасов > 10 И ЧислоЧасов < 20 Тогда
		Подпись = НСтр("ru = 'часов'");
	Иначе
		Срок = ЧислоЧасов - Цел(ЧислоЧасов / 10) * 10;
		Если Срок = 0 Тогда
			Подпись = НСтр("ru = 'часов'");
		ИначеЕсли Срок = 1 Тогда
			Подпись = Нстр("ru = 'час'");
		ИначеЕсли Срок < 5 Тогда
			Подпись = НСтр("ru = 'часа'");
		Иначе
			Подпись = НСтр("ru = 'часов'");
		КонецЕсли;
	КонецЕсли;
	
	Возврат Подпись;
	
КонецФункции

// Подпись к количеству минут по склонениям
Функция ПолучитьПодписьМинут(ЧислоМинут) Экспорт
	
	Если ЧислоМинут > 10 И ЧислоМинут < 20 Тогда
		Подпись = НСтр("ru = 'минут'");
	Иначе
		Срок = ЧислоМинут - Цел(ЧислоМинут / 10) * 10;
		Если Срок = 0 Тогда
			Подпись = НСтр("ru = 'минут'");
		ИначеЕсли Срок = 1 Тогда
			Подпись = НСтр("ru = 'минута'");
		ИначеЕсли Срок < 5 Тогда
			Подпись = НСтр("ru = 'минуты'");
		Иначе
			Подпись = НСтр("ru = 'минут'");
		КонецЕсли;
	КонецЕсли;
	
	Возврат Подпись;
	
КонецФункции

// Подпись к количеству месяцев по склонениям
Функция ПолучитьПодписьМесяцев(ЧислоМесяцев) Экспорт
	
	Если ЧислоМесяцев > 10 И ЧислоМесяцев < 20 Тогда
		Подпись = НСтр("ru = 'месяцев'");
	Иначе
		Срок = ЧислоМесяцев - Цел(ЧислоМесяцев / 10) * 10;
		Если Срок = 0 Тогда
			Подпись = НСтр("ru = 'месяцев'");
		ИначеЕсли Срок = 1 Тогда
			Подпись = НСтр("ru = 'месяц'");
		ИначеЕсли Срок < 5 Тогда
			Подпись = НСтр("ru = 'месяца'");
		Иначе
			Подпись = НСтр("ru = 'месяцев'");
		КонецЕсли;
	КонецЕсли;
	
	Возврат Подпись;
	
КонецФункции

// Подпись к количеству недель по склонениям
Функция ПолучитьПодписьНедель(ЧислоНедель) Экспорт
	
	Если ЧислоНедель > 10 И ЧислоНедель < 20 Тогда
		Подпись = НСтр("ru = 'недель'");
	Иначе
		Срок = ЧислоНедель - Цел(ЧислоНедель / 10) * 10;
		Если Срок = 0 Тогда
			Подпись = НСтр("ru = 'недель'");
		ИначеЕсли Срок = 1 Тогда
			Подпись = НСтр("ru = 'неделя'");
		ИначеЕсли Срок < 5 Тогда
			Подпись = НСтр("ru = 'недели'");
		Иначе
			Подпись = НСтр("ru = 'недель'");
		КонецЕсли;
	КонецЕсли;
	
	Возврат Подпись;
	
КонецФункции

// Подпись к количеству секунд по склонениям
Функция ПолучитьПодписьСекунд(ЧислоСекунд) Экспорт
	
	Если ЧислоСекунд > 10 И ЧислоСекунд < 20 Тогда
		Подпись = НСтр("ru = 'секунд'");
	Иначе
		ПоследниеДвеЦифры = ЧислоСекунд - Цел(ЧислоСекунд / 100) * 100;
		ПоследняяЦифра = ЧислоСекунд - Цел(ЧислоСекунд / 10) * 10;
		
		Если ПоследняяЦифра = 0 Тогда
			Подпись = НСтр("ru = 'секунд'");
		ИначеЕсли ПоследниеДвеЦифры > 10 И ПоследниеДвеЦифры < 20 Тогда
			Подпись = Нстр("ru = 'секунд'");
		ИначеЕсли ПоследниеДвеЦифры < 10 Или ПоследниеДвеЦифры > 20 Тогда
			Если ПоследняяЦифра = 1 Тогда
				Подпись = Нстр("ru = 'секунда'");
			ИначеЕсли ПоследняяЦифра < 5 Тогда
				Подпись = НСтр("ru = 'секунды'");
			Иначе
				Подпись = НСтр("ru = 'секунд'");
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
	
	Возврат Подпись;
	
КонецФункции

// Подпись к количеству писем по склонениям
Функция ПолучитьПодписьПисем(ЧислоПисем) Экспорт
	
	Если ЧислоПисем > 10 И ЧислоПисем < 20 Тогда
		Подпись = НСтр("ru = 'писем'");
	Иначе
		ПоследниеДвеЦифры = ЧислоПисем - Цел(ЧислоПисем / 100) * 100;
		ПоследняяЦифра = ЧислоПисем - Цел(ЧислоПисем / 10) * 10;
		
		Если ПоследняяЦифра = 0 Тогда
			Подпись = НСтр("ru = 'писем'");
		ИначеЕсли ПоследниеДвеЦифры > 10 И ПоследниеДвеЦифры < 20 Тогда
			Подпись = Нстр("ru = 'писем'");
		ИначеЕсли ПоследниеДвеЦифры < 10 Или ПоследниеДвеЦифры > 20 Тогда
			Если ПоследняяЦифра = 1 Тогда
				Подпись = Нстр("ru = 'письмо'");
			ИначеЕсли ПоследняяЦифра < 5 Тогда
				Подпись = НСтр("ru = 'письма'");
			Иначе
				Подпись = НСтр("ru = 'писем'");
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
	
	Возврат Подпись;
	
КонецФункции

// Формирует текстовое представление группы полей подписания
//
Функция ПолучитьСтрокуПодписи(Объект) Экспорт
	
	СтрокаПодпись = "";
	
	Если Объект.РезультатПодписания
		= ПредопределенноеЗначение("Перечисление.РезультатыПодписания.Подписан") Тогда
			РезультатПодписания = НСтр("ru = 'Да'");
	ИначеЕсли Объект.РезультатПодписания
		= ПредопределенноеЗначение("Перечисление.РезультатыПодписания.Отклонен") Тогда
			РезультатПодписания = НСтр("ru = 'Отклонен'");
	Иначе
			РезультатПодписания = НСтр("ru = 'Нет'");
	КонецЕсли;
	
	Если ЗначениеЗаполнено(Объект.ДатаПодписания)
		И (Объект.РезультатПодписания
			= ПредопределенноеЗначение("Перечисление.РезультатыПодписания.Подписан")
			Или Объект.РезультатПодписания
			= ПредопределенноеЗначение("Перечисление.РезультатыПодписания.Отклонен")) Тогда
				СтрокаПодпись = СтрШаблон("%1 (%2, %3)",
					РезультатПодписания, Объект.Подписал, Формат(Объект.ДатаПодписания, "ДЛФ=D"));
	Иначе
		СтрокаПодпись = СтрШаблон("%1 (%2)",
			РезультатПодписания, Объект.Подписал);
	КонецЕсли;
	
	Если Прав(СтрокаПодпись, 2) = "()" Тогда
		СтрокаПодпись = Лев(СтрокаПодпись, СтрДлина(СтрокаПодпись) - 3);
	КонецЕсли;
	
	Если ЗначениеЗаполнено(Объект.КомментарийПодписи) Тогда
		СтрокаПодпись = СтрокаПодпись + " " + Объект.КомментарийПодписи;
	КонецЕсли;
	
	Возврат СтрокаПодпись;
	
КонецФункции


	
