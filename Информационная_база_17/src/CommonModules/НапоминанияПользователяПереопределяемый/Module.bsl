#Область ПрограммныйИнтерфейс

// Переопределяет настройки подсистемы.
//
// Параметры:
//  Настройки - Структура - 
//   * Расписания - Соответствие:
//      ** Ключ     - Строка - представление расписания;
//      ** Значение - РасписаниеРегламентногоЗадания - вариант расписания.
//   * СтандартныеИнтервалы - Массив - содержит строковые представления интервалов времени.
Процедура ПриОпределенииНастроек(Настройки) Экспорт
	
КонецПроцедуры

// Переопределяет массив реквизитов объекта, относительно которых разрешается устанавливать время напоминания.
// Например, можно скрыть те реквизиты с датами, которые являются служебными или не имеют смысла для 
// установки напоминаний: дата документа или задачи и прочие.
// 
// Параметры:
//  Источник - ЛюбаяСсылка - ссылка на объект, для которого формируется массив реквизитов с датами;
//  РеквизитыСДатами - Массив - имена реквизитов (из метаданных), содержащих даты.
//
Процедура ПриЗаполненииСпискаРеквизитовИсточникаСДатамиДляНапоминания(Источник, РеквизитыСДатами) Экспорт
	
	//Для задача напоминание устанавливается до срока
	Если ТипЗнч(Источник) = Тип("ДокументСсылка.Задачи") Тогда
		РеквизитыСДатами = Новый Массив;
		РеквизитыСДатами.Добавить("Срок");
		РеквизитыСДатами.Добавить("ДатаСтатуса");
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
