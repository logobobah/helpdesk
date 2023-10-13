
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	ПользовательПредставление = Параметры.ПользовательПредставление;
	РазделПредставление       = Параметры.РазделПредставление;
	ОбъектПредставление       = Параметры.ОбъектПредставление;
	ОписаниеДатыЗапрета       = Параметры.ОписаниеДатыЗапрета;
	КоличествоДнейРазрешения  = Параметры.КоличествоДнейРазрешения;
	ДатаЗапрета               = Параметры.ДатаЗапрета;
	
	РазрешитьИзменениеДанныхДоДатыЗапрета = КоличествоДнейРазрешения > 0;
	
	Если НЕ ЗначениеЗаполнено(РазделПредставление) Тогда
		Элементы.РазделПредставление.Видимость = Ложь;
	КонецЕсли;
	
	Если НЕ ЗначениеЗаполнено(ОбъектПредставление) Тогда
		Элементы.ОбъектПредставление.Видимость = Ложь;
	КонецЕсли;
	
	Если НЕ Параметры.РазрешитьПоУмолчанию Тогда
		Элементы.ОписаниеДатыЗапрета.СписокВыбора.Удалить(0);
	КонецЕсли;
	
	// Кэширование текущей даты на сервере.
	ТекущаяДатаНаСервере = ТекущаяДатаСеанса();
	
	ОбщаяДатаЗапретаСОписаниемПриИзмененииДополнительно(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()
	
	ОповеститьОВыборе(ВозвращаемоеЗначение);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

////////////////////////////////////////////////////////////////////////////////
// Одинаковые обработчики событий форм ДатыЗапретаИзменения и РедактированиеДатыЗапрета.

&НаКлиенте
Процедура ОписаниеДатыЗапретаПриИзменении(Элемент)
	
	ОбщаяДатаЗапретаСОписаниемПриИзмененииДополнительно(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ДатаЗапретаПриИзменении(Элемент)
	
	ОбщаяДатаЗапретаСОписаниемПриИзмененииДополнительно(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура РазрешитьИзменениеДанныхДоДатыЗапретаПриИзменении(Элемент)
	
	ОбщаяДатаЗапретаСОписаниемПриИзмененииДополнительно(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура КоличествоДнейРазрешенияПриИзменении(Элемент)
	
	ОбщаяДатаЗапретаСОписаниемПриИзмененииДополнительно(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура КоличествоДнейРазрешенияАвтоПодбор(Элемент, Текст, ДанныеВыбора, Ожидание, СтандартнаяОбработка)
	
	КоличествоДнейРазрешения = Текст;
	
	ОбщаяДатаЗапретаСОписаниемПриИзмененииДополнительно(ЭтотОбъект);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОК(Команда)
	
	ВозвращаемоеЗначение = Новый Структура;
	ВозвращаемоеЗначение.Вставить("ОписаниеДатыЗапрета",      ОписаниеДатыЗапрета);
	ВозвращаемоеЗначение.Вставить("КоличествоДнейРазрешения", КоличествоДнейРазрешения);
	ВозвращаемоеЗначение.Вставить("ДатаЗапрета",              ДатаЗапрета);
	
	Закрыть();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиентеНаСервереБезКонтекста
Процедура ОбщаяДатаЗапретаСОписаниемПриИзмененииДополнительно(Знач Контекст)
	
	Если Контекст.ОписаниеДатыЗапрета = "" Тогда
		Контекст.Элементы.СвойстваНепроизвольнойДаты.ТекущаяСтраница =
			Контекст.Элементы.НепроизвольнаяДатаНеИспользуется;
		
		Контекст.Элементы.ПроизвольнаяДата.ТекущаяСтраница =
			Контекст.Элементы.ПроизвольнаяДатаНеИспользуется;
		
		Контекст.РазрешитьИзменениеДанныхДоДатыЗапрета = Ложь;
		Контекст.КоличествоДнейРазрешения = 0;
		Контекст.ДатаЗапрета = '00000000';
	Иначе
		ОбщаяДатаЗапретаСОписаниемПриИзменении(Контекст);
	КонецЕсли;
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// Одинаковые процедуры и функции форм ДатыЗапретаИзменения и РедактированиеДатыЗапрета.

&НаКлиентеНаСервереБезКонтекста
Процедура ОбщаяДатаЗапретаСОписаниемПриИзменении(Знач Контекст, РассчитатьДатуЗапрета = Истина)
	
	Сутки = 60*60*24;
	
	Если Контекст.ОписаниеДатыЗапрета = "ПроизвольнаяДата" Тогда
		Контекст.Элементы.СвойстваНепроизвольнойДаты.ТекущаяСтраница =
			Контекст.Элементы.НепроизвольнаяДатаНеИспользуется;
		
		Контекст.Элементы.ПроизвольнаяДата.ТекущаяСтраница =
			Контекст.Элементы.ПроизвольнаяДатаИспользуется;
		
		Контекст.РазрешитьИзменениеДанныхДоДатыЗапрета = Ложь;
		Контекст.КоличествоДнейРазрешения = 0;
	Иначе
		Контекст.Элементы.СвойстваНепроизвольнойДаты.ТекущаяСтраница =
			Контекст.Элементы.НепроизвольнаяДатаИспользуется;
		
		Контекст.Элементы.ПроизвольнаяДата.ТекущаяСтраница =
			Контекст.Элементы.ПроизвольнаяДатаНеИспользуется;
		
		Если Контекст.ОписаниеДатыЗапрета = "ПредыдущийДень" Тогда
			Контекст.Элементы.РазрешитьИзменениеДанныхДоДатыЗапрета.Доступность = Ложь;
			Контекст.РазрешитьИзменениеДанныхДоДатыЗапрета = Ложь;
		Иначе
			Контекст.Элементы.РазрешитьИзменениеДанныхДоДатыЗапрета.Доступность = Истина;
		КонецЕсли;
		РасчетныеДатыЗапрета = РасчетДатыЗапрета(
			Контекст.ОписаниеДатыЗапрета, Контекст.ТекущаяДатаНаСервере);
		
		Если РассчитатьДатуЗапрета Тогда
			Контекст.ДатаЗапрета = РасчетныеДатыЗапрета.Текущая;
		КонецЕсли;
		ТекстНадписи = "";
		Если Контекст.РазрешитьИзменениеДанныхДоДатыЗапрета Тогда
			СкорректироватьКоличествоДнейРазрешения(
				Контекст.ОписаниеДатыЗапрета, Контекст.КоличествоДнейРазрешения);
			
			Контекст.Элементы.СвойствоКоличествоДнейРазрешенияИзменения.ТекущаяСтраница =
				Контекст.Элементы.ИзменениеДанныхДоДатыЗапретаРазрешено;
			
			СрокРазрешения = РасчетныеДатыЗапрета.Текущая + Контекст.КоличествоДнейРазрешения * Сутки;
			
			Если Контекст.ТекущаяДатаНаСервере > СрокРазрешения Тогда
				ШаблонНадписи = НСтр("ru = 'Срок возможности изменения данных с %2 по %3 истек %1'");
			Иначе
				Если РассчитатьДатуЗапрета Тогда
					Контекст.ДатаЗапрета = РасчетныеДатыЗапрета.Предыдущая;
				КонецЕсли;
				ШаблонНадписи =
					НСтр("ru = 'По %1 возможно изменение данных с %2 по %3
					           |После %1 будет запрещено изменение данных по %3'")
					+ Символы.ПС;
			КонецЕсли;
			ТекстНадписи = Символы.ПС + СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(ШаблонНадписи,
				Формат(СрокРазрешения, "ДЛФ=Д"),
				Формат(РасчетныеДатыЗапрета.Предыдущая + Сутки, "ДЛФ=Д"),
				Формат(РасчетныеДатыЗапрета.Текущая, "ДЛФ=Д"));
		Иначе
			Контекст.Элементы.СвойствоКоличествоДнейРазрешенияИзменения.ТекущаяСтраница =
				Контекст.Элементы.ИзменениеДанныхДоДатыЗапретаНеРазрешено;
			
			Контекст.КоличествоДнейРазрешения = 0;
		КонецЕсли;
		Контекст.Элементы.ПояснениеНепроизвольнойДаты.Заголовок =
			СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru = 'Запрещено изменение данных по %1'"),
				Формат(Контекст.ДатаЗапрета, "ДЛФ=Д"))
			+ ТекстНадписи;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Функция РасчетДатыЗапрета(Знач ВариантДатыЗапрета, Знач ТекущаяДатаНаСервере)
	
	Сутки = 60*60*24;
	
	ТекущаяДатаЗапрета    = '00000000';
	ПредыдущаяДатаЗапрета = '00000000';
	
	Если ВариантДатыЗапрета = "КонецПрошлогоГода" Тогда
		ТекущаяДатаЗапрета    = НачалоГода(ТекущаяДатаНаСервере) - Сутки;
		ПредыдущаяДатаЗапрета = НачалоГода(ТекущаяДатаЗапрета)   - Сутки;
		
	ИначеЕсли ВариантДатыЗапрета = "КонецПрошлогоКвартала" Тогда
		ТекущаяДатаЗапрета    = НачалоКвартала(ТекущаяДатаНаСервере) - Сутки;
		ПредыдущаяДатаЗапрета = НачалоКвартала(ТекущаяДатаЗапрета)   - Сутки;
		
	ИначеЕсли ВариантДатыЗапрета = "КонецПрошлогоМесяца" Тогда
		ТекущаяДатаЗапрета    = НачалоМесяца(ТекущаяДатаНаСервере) - Сутки;
		ПредыдущаяДатаЗапрета = НачалоМесяца(ТекущаяДатаЗапрета)   - Сутки;
		
	ИначеЕсли ВариантДатыЗапрета = "КонецПрошлойНедели" Тогда
		ТекущаяДатаЗапрета    = НачалоНедели(ТекущаяДатаНаСервере) - Сутки;
		ПредыдущаяДатаЗапрета = НачалоНедели(ТекущаяДатаЗапрета)   - Сутки;
		
	ИначеЕсли ВариантДатыЗапрета = "ПредыдущийДень" Тогда
		ТекущаяДатаЗапрета    = НачалоДня(ТекущаяДатаНаСервере) - Сутки;
		ПредыдущаяДатаЗапрета = НачалоДня(ТекущаяДатаЗапрета)   - Сутки;
	КонецЕсли;
	
	Возврат Новый Структура("Текущая, Предыдущая", ТекущаяДатаЗапрета, ПредыдущаяДатаЗапрета);
	
КонецФункции

&НаКлиентеНаСервереБезКонтекста
Процедура СкорректироватьКоличествоДнейРазрешения(Знач ОписаниеДатыЗапрета, КоличествоДнейРазрешения)
	
	Если КоличествоДнейРазрешения = 0 Тогда
		КоличествоДнейРазрешения = 1;
		
	ИначеЕсли ОписаниеДатыЗапрета = "КонецПрошлогоГода" Тогда
		Если КоличествоДнейРазрешения > 90 Тогда
			КоличествоДнейРазрешения = 90;
		КонецЕсли;
		
	ИначеЕсли ОписаниеДатыЗапрета = "КонецПрошлогоКвартала" Тогда
		Если КоличествоДнейРазрешения > 60 Тогда
			КоличествоДнейРазрешения = 60;
		КонецЕсли;
		
	ИначеЕсли ОписаниеДатыЗапрета = "КонецПрошлогоМесяца" Тогда
		Если КоличествоДнейРазрешения > 25 Тогда
			КоличествоДнейРазрешения = 25;
		КонецЕсли;
		
	ИначеЕсли ОписаниеДатыЗапрета = "КонецПрошлойНедели" Тогда
		Если КоличествоДнейРазрешения > 5 Тогда
			КоличествоДнейРазрешения = 5;
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
