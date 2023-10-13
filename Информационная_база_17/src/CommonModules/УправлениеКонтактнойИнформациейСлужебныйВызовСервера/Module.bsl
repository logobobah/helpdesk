#Область СлужебныеПроцедурыИФункции

// Разбирает представление контактной информации и возвращает строку XML со значениями полей.
//
//  Параметры:
//      Текст        - Строка - XML
//      ОжидаемыйТип - СправочникСсылка.ВидыКонтактнойИнформации, ПеречислениеСсылка.ТипыКонтактнойИнформации - для
//                     контроля типов.
//
//  Возвращаемое значение:
//      Строка - XML
//
Функция КонтактнаяИнформацияXMLПоПредставлению(Знач Текст, Знач ОжидаемыйВид) Экспорт
	Возврат УправлениеКонтактнойИнформацией.КонтактнаяИнформацияXMLПоПредставлению(Текст, ОжидаемыйВид);
КонецФункции

// Возвращает строку состава из значения контактной информации.
//
//  Параметры:
//      XMLДанные - Строка - XML данных контактной информации.
//
//  Возвращаемое значение:
//      Строка - содержимое
//      Неопределено - если значение состава сложного типа.
//
Функция СтрокаСоставаКонтактнойИнформации(Знач XMLДанные) Экспорт;
	Возврат УправлениеКонтактнойИнформациейСлужебный.СтрокаСоставаКонтактнойИнформации(XMLДанные);
КонецФункции

// Преобразует все входящие форматы контактной информации в XML.
//
Функция ПривестиКонтактнуюИнформациюXML(Знач Данные) Экспорт
	Возврат УправлениеКонтактнойИнформациейСлужебный.ПривестиКонтактнуюИнформациюXML(Данные);
КонецФункции

// Возвращает список идентификаторов строк доступных для копирования в текущий адресов.
// 
Функция ДоступныеДляКопированияАдреса(Знач ЗначенияПолейДляАнализа, Знач ВидАдреса) Экспорт
	
	Возврат УправлениеКонтактнойИнформациейСлужебный.ДоступныеДляКопированияАдреса(ЗначенияПолейДляАнализа, ВидАдреса);
	
КонецФункции

// Возвращает найденную ссылку или создает новую страну мира и возвращает ссылку на нее.
//
Функция СтранаМираПоДаннымКлассификатора(Знач КодСтраны) Экспорт
	
	Возврат УправлениеКонтактнойИнформацией.СтранаМираПоКодуИлиНаименованию(КодСтраны);
	
КонецФункции

// Заполняет коллекцию ссылками на найденные или созданные страны мира.
//
Процедура КоллекцияСтранМираПоДаннымКлассификатора(Коллекция) Экспорт
	
	Для Каждого КлючЗначение Из Коллекция Цикл
		Коллекция[КлючЗначение.Ключ] =  УправлениеКонтактнойИнформацией.СтранаМираПоКодуИлиНаименованию(КлючЗначение.Значение.Код);
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти
