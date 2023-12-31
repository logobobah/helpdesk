#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, СтандартнаяОбработка)
	
	Если ЭтоГруппа Тогда
		Возврат;
	КонецЕсли;
	
	Если ЭтоНовый() Тогда
		Автор = ПользователиКлиентСервер.ТекущийПользователь();
		Если ДанныеЗаполнения <> Неопределено И ДанныеЗаполнения.Свойство("Документ") Тогда
			Документ = ДанныеЗаполнения.Документ;
			ТемаДокумента = Истина;
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

Процедура ПередЗаписью(Отказ)
	
	Если ОбменДанными.Загрузка
		И ЗначениеЗаполнено(ОбменДанными.Отправитель) Тогда
		Возврат;
	КонецЕсли;
	
	Если ЭтоГруппа Тогда
		Возврат;
	КонецЕсли;
	
	Если Не ЗначениеЗаполнено(Папка) Тогда
		Отказ = Истина;
		ВызватьИсключение НСтр("ru = 'Не указан раздел темы'");
	КонецЕсли;
	
	Если ЗначениеЗаполнено(Документ) И Папка <> Справочники.ПапкиФорума.ТемыДокументов Тогда
		Отказ = Истина;
		ВызватьИсключение НСтр("ru = 'Темы документов могут располагаться только в разделе тем документов'");
	КонецЕсли;
	
	Если НЕ ЗначениеЗаполнено(Документ) И Папка = Справочники.ПапкиФорума.ТемыДокументов Тогда
		Отказ = Истина;
		ВызватьИсключение НСтр("ru = 'Общие темы не могут располагаться в разделе тем документов'");
	КонецЕсли;
	
	Если ЭтоНовый() Тогда 
		ДатаСоздания = ТекущаяДатаСеанса();
	КонецЕсли;
	ДополнительныеСвойства.Вставить("ПометкаНовый", ЭтоНовый());
	
	Если НЕ ЗначениеЗаполнено(Документ) Тогда
		// Обработка рабочей группы
		СсылкаОбъекта = Ссылка;
		// Установка ссылки нового
		Если Не ЗначениеЗаполнено(СсылкаОбъекта) Тогда
			СсылкаОбъекта = ПолучитьСсылкуНового();
			Если Не ЗначениеЗаполнено(СсылкаОбъекта) Тогда
				СсылкаНового = Справочники.ТемыОбсуждений.ПолучитьСсылку();
				УстановитьСсылкуНового(СсылкаНового);
				СсылкаОбъекта = СсылкаНового;
			КонецЕсли;
		КонецЕсли;
		
	КонецЕсли;
	
	// Проверка изменения пометки удаления.
	ПредыдущаяПометкаУдаления = Ложь;
	Если Не Ссылка.Пустая() Тогда
		ПредыдущаяПометкаУдаления = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Ссылка, "ПометкаУдаления");
	КонецЕсли;
	ДополнительныеСвойства.Вставить("ПредыдущаяПометкаУдаления", ПредыдущаяПометкаУдаления);
	
КонецПроцедуры

Процедура ПриЗаписи(Отказ)
	
	Если ОбменДанными.Загрузка
		И ЗначениеЗаполнено(ОбменДанными.Отправитель) Тогда
		Возврат;
	КонецЕсли;
	
	Если ЭтоГруппа Тогда
		Возврат;
	КонецЕсли;
	
	Если ДополнительныеСвойства.Свойство("ПредыдущаяПометкаУдаления")
			И ДополнительныеСвойства.Свойство("ПометкаНовый")
			И ПометкаУдаления <> ДополнительныеСвойства.ПредыдущаяПометкаУдаления 
			И Не ДополнительныеСвойства.ПометкаНовый Тогда
			
		// Отбираем сообщения и пытаемся поставить им пометку удаления
		УстановитьПривилегированныйРежим(Истина);
		Запрос = Новый Запрос;
		Запрос.Текст = 
			"ВЫБРАТЬ
			|	СообщенияОбсуждений.Ссылка КАК Ссылка
			|ИЗ
			|	Справочник.СообщенияОбсуждений КАК СообщенияОбсуждений
			|ГДЕ
			|	СообщенияОбсуждений.ВладелецСообщения = &ВладелецСообщения";	
		Запрос.УстановитьПараметр("ВладелецСообщения", Ссылка);
		Результат = Запрос.Выполнить();
		Выборка = Результат.Выбрать();
		
		Пока Выборка.Следующий() Цикл
			
			Сообщение = Выборка.Ссылка.ПолучитьОбъект();
			
			Попытка
				
				Сообщение.Заблокировать();
				Сообщение.УстановитьПометкуУдаления(ПометкаУдаления);
				
			Исключение
				
				// Вызывается при удалении первого сообщения темы.
				Инфо = ИнформацияОбОшибке();

				Если Инфо.Описание = "Ошибка при вызове метода контекста (Заблокировать)" Тогда
					
					Если Не Сообщение.ПервоеСообщениеТемы Тогда
						
						Отказ = Истина;
						ВызватьИсключение;
						
					КонецЕсли;
					
				Иначе
					
					ВызватьИсключение;
					
				КонецЕсли;
				
			КонецПопытки;
			
		КонецЦикла;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли