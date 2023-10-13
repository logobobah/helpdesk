///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2021, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область СлужебныеПроцедурыИФункции
////////////////////////////////////////////////////////////////////////////////
// Обработчики операций

Функция Ping()
	Возврат "";
КонецФункции

Функция ПроверкаПодключения(ИмяПланаОбмена, КодУзлаПланаОбмена, СообщениеОбОшибке)
	
	СообщениеОбОшибке = "";
	
	// Проверяем наличие прав для выполнения обмена.
	Попытка
		ОбменДаннымиСлужебный.ПроверитьВозможностьВыполненияОбменов();
	Исключение
		СообщениеОбОшибке = КраткоеПредставлениеОшибки(ИнформацияОбОшибке());
		Возврат Ложь;
	КонецПопытки;
	
	// Проверяем блокировку информационной базы для обновления.
	Попытка
		ОбменДаннымиСлужебный.ПроверитьБлокировкуИнформационнойБазыДляОбновления();
	Исключение
		СообщениеОбОшибке = КраткоеПредставлениеОшибки(ИнформацияОбОшибке());
		Возврат Ложь;
	КонецПопытки;
	
	УстановитьПривилегированныйРежим(Истина);
	
	// Проверяем наличие узла плана обмена (возможно узел уже удален).
	Если ПланыОбмена[ИмяПланаОбмена].НайтиПоКоду(КодУзлаПланаОбмена).Пустая() Тогда
		СообщениеОбОшибке = НСтр("ru = 'Заданный узел плана обмена не найден. Обратитесь к администратору приложения.'");
		Возврат Ложь;
	КонецЕсли;
	
	Возврат Истина;
	
КонецФункции

// ConfirmGettingFile
//
Функция ПодтвердитьПолучениеДанных(ИдентификаторФайла, ПодтверждениеПолученияФайла, СообщениеОбОшибке)
	
	СообщениеОбОшибке = "";
	
	Попытка
		УдалитьФайлы(ОбменДаннымиСлужебный.ВременныйКаталогВыгрузки(ИдентификаторФайла));
	Исключение
		
		СообщениеОбОшибке = КраткоеПредставлениеОшибки(ИнформацияОбОшибке());
		ЗаписьЖурналаРегистрации(ОбменДаннымиСервер.СобытиеЖурналаРегистрацииУдалениеВременногоФайла(),
			УровеньЖурналаРегистрации.Ошибка,,, ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
			
	КонецПопытки;
		
	Возврат "";	
		
КонецФункции

Функция ПолучитьРезультатЗагрузкиДанных(ИдентификаторФоновогоЗадания, СообщениеОбОшибке)
	
	Возврат ОбменДаннымиСлужебный.ПолучитьСтатусВыполненияПолученияДанных(ИдентификаторФоновогоЗадания, СообщениеОбОшибке);
	
КонецФункции

Функция ПолучитьРезультатПодготовкиДанныхКВыгрузке(ИдентификаторФоновогоЗадания, СообщениеОбОшибке)
	
	Возврат ОбменДаннымиСлужебный.ПолучитьСтатусВыполненияПодготовкиДанныхКОтправке(ИдентификаторФоновогоЗадания, СообщениеОбОшибке);
	
КонецФункции

// PutFilePart
//
Функция ЗагрузитьЧастьФайла(ИдентификаторФайла, НомерЗагружаемойЧастиФайла, ЗагружаемаяЧастьФайла, СообщениеОбОшибке)
	
	Возврат ОбменДаннымиСлужебный.ЗагрузитьЧастьФайла(ИдентификаторФайла, НомерЗагружаемойЧастиФайла, ЗагружаемаяЧастьФайла, СообщениеОбОшибке);
	
КонецФункции

Функция ВыгрузитьЧастьФайла(ИдентификаторФайла, НомерВыгружаемойЧастиФайла, СообщениеОбОшибке)
	
	Возврат ОбменДаннымиСлужебный.ВыгрузитьЧастьФайла(ИдентификаторФайла, НомерВыгружаемойЧастиФайла, СообщениеОбОшибке);
	
КонецФункции

// PutData
//
Функция ЗагрузитьДанныеВИнформационнуюБазу(ИмяПланаОбмена, КодУзлаПланаОбмена, ИдентификаторФайла, ИдентификаторФоновогоЗадания, СообщениеОбОшибке)
	
	СообщениеОбОшибке = "";
	
	СтруктураПараметров = ОбменДаннымиСлужебный.ИнициализироватьПараметрыWebСервиса();
	СтруктураПараметров.ИмяПланаОбмена                         = ИмяПланаОбмена;
	СтруктураПараметров.КодУзлаПланаОбмена                     = КодУзлаПланаОбмена;
	СтруктураПараметров.ИдентификаторФайлаВоВременномХранилище = ОбменДаннымиСлужебный.ПодготовитьФайлДляЗагрузки(ИдентификаторФайла, СообщениеОбОшибке);
	СтруктураПараметров.ИмяWEBСервиса                          = "EnterpriseDataExchange_1_0_1_1";
	
	// Загружаем данные в информационную базу.
	ПараметрыПроцедуры = Новый Структура;
	ПараметрыПроцедуры.Вставить("ПараметрыWEBСервиса", СтруктураПараметров);
	ПараметрыПроцедуры.Вставить("СообщениеОбОшибке",   СообщениеОбОшибке);

	ПараметрыВыполнения = ДлительныеОперации.ПараметрыВыполненияВФоне(Новый УникальныйИдентификатор);
	ПараметрыВыполнения.НаименованиеФоновогоЗадания = НСтр("ru = 'Загрузка данных в информационную базу через web-сервис ""Enterprise Data Exchange""'");
	ПараметрыВыполнения.КлючФоновогоЗадания = Строка(Новый УникальныйИдентификатор);
	
	ПараметрыВыполнения.ОжидатьЗавершение = 0;
	ПараметрыВыполнения.ЗапуститьВФоне    = Истина;

	ФоновоеЗадание = ДлительныеОперации.ВыполнитьВФоне(
		"ОбменДаннымиСлужебный.ЗагрузитьДанныеXDTOВИнформационнуюБазу",
		ПараметрыПроцедуры,
		ПараметрыВыполнения);
	ИдентификаторФоновогоЗадания = Строка(ФоновоеЗадание.ИдентификаторЗадания);
	
	Возврат "";
	
КонецФункции

// PrepareDataForGetting
//
Функция ПодготовитьДанныеКПолучению(ИмяПланаОбмена, КодУзлаПланаОбмена, РазмерЧастиФайла, ИдентификаторФоновогоЗадания, СообщениеОбОшибке)
	
	СообщениеОбОшибке = "";
	
	СтруктураПараметров = ОбменДаннымиСлужебный.ИнициализироватьПараметрыWebСервиса();
	СтруктураПараметров.ИмяПланаОбмена                         = ИмяПланаОбмена;
	СтруктураПараметров.КодУзлаПланаОбмена                     = КодУзлаПланаОбмена;
	СтруктураПараметров.РазмерЧастиФайла                       = РазмерЧастиФайла;
	СтруктураПараметров.ИдентификаторФайлаВоВременномХранилище = Новый УникальныйИдентификатор();
	СтруктураПараметров.ИмяWEBСервиса                          = "EnterpriseDataExchange_1_0_1_1";
	
	// Подготавливаем данные к выгрузке из информационной базы.
	ПараметрыПроцедуры = Новый Структура;
	ПараметрыПроцедуры.Вставить("ПараметрыWEBСервиса", СтруктураПараметров);
	ПараметрыПроцедуры.Вставить("СообщениеОбОшибке",   СообщениеОбОшибке);

	ПараметрыВыполнения = ДлительныеОперации.ПараметрыВыполненияВФоне(Новый УникальныйИдентификатор);
	ПараметрыВыполнения.НаименованиеФоновогоЗадания = НСтр("ru = 'Подготовка к выгрузке данных из информационной базы через web-сервис ""Enterprise Data Exchange""'");
	ПараметрыВыполнения.КлючФоновогоЗадания = Строка(Новый УникальныйИдентификатор);
	
	ПараметрыВыполнения.ОжидатьЗавершение = 0;
	ПараметрыВыполнения.ЗапуститьВФоне    = Истина;

	ФоновоеЗадание = ДлительныеОперации.ВыполнитьВФоне(
		"ОбменДаннымиСлужебный.ПодготовитьДанныеДляВыгрузкиИзИнформационнойБазы",
		ПараметрыПроцедуры,
		ПараметрыВыполнения);
	ИдентификаторФоновогоЗадания = Строка(ФоновоеЗадание.ИдентификаторЗадания);
	
	Возврат "";
	
КонецФункции

#КонецОбласти