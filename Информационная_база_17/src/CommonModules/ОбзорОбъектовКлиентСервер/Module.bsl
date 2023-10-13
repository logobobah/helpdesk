
////////////////////////////////////////////////////////////////////////////////
// Обзор объектов клиент сервер: модуль содержит общие процедуры и функции для
//                               формирования HTML-обзора объектов системы.
//  
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Удаляет вредоносный код html из текста.
//
// Параметры:
//   Текст - Строка - текст
//
Процедура УдалитьВредоносныйКодИзТекста(Текст) Экспорт
	
	НРегТекст = НРег(Текст);
	
	МассивСтрокБезВредоносногоТекста = Новый Массив;
	
	// Удаление скриптов
	НомерСкрипта = 1;
	ПозицияНачалаОбработки = 1;
	
	Пока Истина Цикл
		
		ПозицияНачалаОткрывающегоТегаScript = СтрНайти(НРегТекст, "<script",,, НомерСкрипта);
		ПозицияНачалаЗакрывающегоТегаScript = СтрНайти(НРегТекст, "</script",,, НомерСкрипта);
		
		Если ПозицияНачалаОткрывающегоТегаScript = 0 Или ПозицияНачалаЗакрывающегоТегаScript = 0 Тогда
			Прервать;
		КонецЕсли;
		
		ПозицияОкончанияОткрывающегоТегаScript = СтрНайти(НРегТекст, ">",, ПозицияНачалаОткрывающегоТегаScript + 1);
		ПозицияОкончанияЗакрывающегоТегаScript = СтрНайти(НРегТекст, ">",, ПозицияНачалаЗакрывающегоТегаScript + 1);
		
		Если ПозицияОкончанияОткрывающегоТегаScript = 0 Или ПозицияОкончанияЗакрывающегоТегаScript = 0 Тогда
			Прервать;
		КонецЕсли;
		
		// Добавим текст до скрипта
		ТекстДоСкрипта = Сред(Текст, ПозицияНачалаОбработки, ПозицияНачалаОткрывающегоТегаScript - ПозицияНачалаОбработки);
		МассивСтрокБезВредоносногоТекста.Добавить(ТекстДоСкрипта);
		
		ПозицияНачалаОбработки = ПозицияОкончанияЗакрывающегоТегаScript + 1;
		НомерСкрипта = НомерСкрипта + 1;
		
	КонецЦикла;
	
	Если МассивСтрокБезВредоносногоТекста.Количество() > 0 Тогда
		
		// Добавим текст после последнего скрипта
		ТекстДоСкрипта = Сред(Текст, ПозицияНачалаОбработки);
		МассивСтрокБезВредоносногоТекста.Добавить(ТекстДоСкрипта);
		
		// Сформируем итоговую строку без скрипта
		Текст = СтрСоединить(МассивСтрокБезВредоносногоТекста);
	КонецЕсли;
	
КонецПроцедуры

// Добавляет в текст html реквизит в формате "Наименование реквизита: значение реквизита".
//   HTMLТекст - Строка - текст html.
//   Подпись - Строка - название реквизита.
//   Значение - Любой тип - значение реквизита
//   Цвет - строка – шестнадцатеричное представление цвета (например: E9B7FF) значения реквизита.
//
Процедура ДобавитьРеквизит(HTMLТекст, Подпись, Значение, Цвет = "") Экспорт
	
	ДобавитьПодпись(HTMLТекст, Подпись);
	ДобавитьЗначение(HTMLТекст, Значение, Цвет); 
	HTMLТекст = HTMLТекст + "<br>";
	
КонецПроцедуры

// Добавляет переданную строку в текст html.
//
// Параметры:
//   HTMLТекст - Строка - текст html
//   Подпись - Строка - добавляемая строка
//
Процедура ДобавитьПодпись(HTMLТекст, Подпись) Экспорт
	
	Если ЗначениеЗаполнено(Подпись) Тогда 
		HTMLТекст = HTMLТекст + "<FONT color=#413003>";
		HTMLТекст = HTMLТекст + Подпись + " ";
		HTMLТекст = HTMLТекст + "</FONT>";
	КонецЕсли;
	
КонецПроцедуры

// Добавляет значение любого типа в текст html.
// Если в процедуру передается ссылочный тип данных, то в текст html
// добавляется навигационная ссылка с представлением переданного значения.
//
// Параметры:
//   HTMLТекст - Строка - текст html
//   Значение - Любой тип - значение реквизита
//   Цвет - строка – шестнадцатеричное представление цвета (например: E9B7FF) значения реквизита.
//
Процедура ДобавитьЗначение(HTMLТекст, ЗначениеДанных, Цвет) Экспорт
	
	Значение = ЗначениеДанных;
	
	Если ТипЗнч(Значение) = Тип("Строка") Тогда 
		Если ЗначениеЗаполнено(Цвет) Тогда 
			HTMLТекст = HTMLТекст + "<FONT color=#"+Цвет+">";
			HTMLТекст = HTMLТекст + РаботаС_HTML.ЗаменитьСпецСимволыHTML(Значение);
			HTMLТекст = HTMLТекст + "</FONT>";
		Иначе	
			HTMLТекст = HTMLТекст + РаботаС_HTML.ЗаменитьСпецСимволыHTML(Значение);
		КонецЕсли;
		
	ИначеЕсли ТипЗнч(Значение) = Тип("Дата")
		Или ТипЗнч(Значение) = Тип("Число")
		Или ТипЗнч(Значение) = Тип("Булево") Тогда 
		РаботаС_HTML.ЗаменитьСпецСимволыHTML(Значение);
		
		Если ЗначениеЗаполнено(Цвет) Тогда 
			HTMLТекст = HTMLТекст + "<FONT color=#"+Цвет+">";
			HTMLТекст = HTMLТекст + Значение;
			HTMLТекст = HTMLТекст + "</FONT>";
		Иначе	
			HTMLТекст = HTMLТекст + Значение;
		КонецЕсли;	
	Иначе
		HTMLТекст = HTMLТекст + СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			"<A href=v8doc:%1>%2</A>",
			ПолучитьНавигационнуюСсылку(Значение),
			РаботаС_HTML.ЗаменитьСпецСимволыHTML(Строка(Значение)));
	КонецЕсли;
	
КонецПроцедуры

// Добавляет картинку в текст html.
//
// Параметры:
//   HTMLТекст - Строка - текст html.
//   Картинка - Картинка
//   Ссылка - Строка - ссылки для вставки в тег <a>
//
Процедура ДобавитьКартинку(HTMLТекст, Картинка, Ссылка = "") Экспорт
	
	ДвоичныеДанныеКартинки = Картинка.ПолучитьДвоичныеДанные();
	Base64ДанныеКартинки = Base64Строка(ДвоичныеДанныеКартинки);
	
	Если ЗначениеЗаполнено(Ссылка) Тогда
		HTMLТекст = HTMLТекст + "<a href=" + Ссылка + ">";
	КонецЕсли;
	
	HTMLТекст = HTMLТекст
		+ "<img src='data:image/"
		+ Картинка.Формат()
		+ ";base64,"
		+ Base64ДанныеКартинки + "'>";
		
	Если ЗначениеЗаполнено(Ссылка) Тогда
		HTMLТекст = HTMLТекст + "</a>";
	КонецЕсли;
	
КонецПроцедуры

// Добавляет значение типа Задача, но с представлением пользователя.
// В текст html добавляется навигационная ссылка с представлением пользователя.
//
// Параметры:
//   HTMLТекст - Строка - текст html
//   Значение - Задача - значение реквизита
//   Представление - Строка
//
Процедура ДобавитьЗадачу(HTMLТекст, Задача, Представление) Экспорт
	
	HTMLТекст = HTMLТекст + СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
		"<A href=v8doc:%1>%2</A>",
		"Подзадача_" + Задача.УникальныйИдентификатор(),
		Представление);
	
КонецПроцедуры

// Возвращает общий стиль для документов html.
//
Функция СтильHTML() Экспорт
	
	Возврат "<style type=""text/css"">
		|	body {
		|		overflow:    auto;
		|		margin-top:  2px;
		|		margin-left: 2px;
		|		font-family: Arial;
		|		font-size:   10pt;}
		|	table {
		|		width:       100%;
		|		font-family: Arial;
		|		font-size:   10pt;
		|		border: 0px solid;}
		|	td {vertical-align: top;}
		| 	a:link {
		|		color: #006699; text-decoration: none;}
		|	a:visited {
		|		color: #006699; text-decoration: none;}
		|	a:hover {
		|		color: #006699; text-decoration: underline;}
		|	p {
		|		margin-top: 15px;}
		|	table.frame {
		|		border-collapse: collapse;
		|		border: 1px solid #C8C8C8;}
		|	td.frame {
		|		border: 1px solid #C8C8C8;}
		|</style>";
	
КонецФункции

#КонецОбласти

