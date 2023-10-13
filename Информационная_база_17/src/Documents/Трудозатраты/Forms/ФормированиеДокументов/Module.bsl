
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Месяц = Параметры.Месяц;
КонецПроцедуры

&НаКлиенте
Процедура МасяцФормированияПриИзменении(Элемент)
	Месяц = НачалоМесяца(Месяц);
КонецПроцедуры

&НаСервере
Процедура СформироватьНаСервере(Сообщение)
	Документы.Трудозатраты.СформироватьТрудозатраты(Месяц, Организация, Подразделение, Сообщение);
КонецПроцедуры

&НаКлиенте
Процедура Сформировать(Команда)
	Если НЕ ЗначениеЗаполнено(Подразделение) Тогда
		Сообщить("Не указано подразделение. Действие отменено.");
		Возврат;
	КонецЕсли;
	Если НЕ ЗначениеЗаполнено(Месяц) Тогда
		Сообщить("Не указан месяц формирования. Действие отменено.");
		Возврат;
	КонецЕсли;
	Сообщение = "";
	СформироватьНаСервере(Сообщение);
	ЭтаФорма.Закрыть();
	Сообщить(Сообщение);
	Сообщить("Действие завершено.");
	Оповестить("ФормированиеТрудозатратЗавершено");
КонецПроцедуры
