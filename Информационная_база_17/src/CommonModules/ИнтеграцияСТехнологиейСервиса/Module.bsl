////////////////////////////////////////////////////////////////////////////////
// Интеграция с Библиотекой технологий сервиса (БТС)
// Здесь размещена обработка программных событий, возникающих в подсистемах БСП,
// и в обратную сторону.
//


// Обработка программных событий, возникающих в подсистемах БТС.
// Только для вызовов из библиотеки БТС в БСП.

#Область ПрограммныйИнтерфейс

#Область ВыгрузкаЗагрузкаДанных

// См. ВыгрузкаЗагрузкаДанныхПереопределяемый.ПриЗаполненииТиповОбщихДанныхПоддерживающихСопоставлениеСсылокПриЗагрузке.
Процедура ПриЗаполненииТиповОбщихДанныхПоддерживающихСопоставлениеСсылокПриЗагрузке(Типы) Экспорт
	
	СтандартныеПодсистемыСервер.ПриЗаполненииТиповОбщихДанныхПоддерживающихСопоставлениеСсылокПриЗагрузке(Типы);
	
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.Банки") Тогда
		МодульРаботаСБанками = ОбщегоНазначения.ОбщийМодуль("РаботаСБанками");
		МодульРаботаСБанками.ПриЗаполненииТиповОбщихДанныхПоддерживающихСопоставлениеСсылокПриЗагрузке(Типы);
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.ВариантыОтчетов") Тогда
		МодульВариантыОтчетов = ОбщегоНазначения.ОбщийМодуль("ВариантыОтчетов");
		МодульВариантыОтчетов.ПриЗаполненииТиповОбщихДанныхПоддерживающихСопоставлениеСсылокПриЗагрузке(Типы);
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.ДатыЗапретаИзменения") Тогда
		МодульДатыЗапретаИзмененияСлужебный = ОбщегоНазначения.ОбщийМодуль("ДатыЗапретаИзмененияСлужебный");
		МодульДатыЗапретаИзмененияСлужебный.ПриЗаполненииТиповОбщихДанныхПоддерживающихСопоставлениеСсылокПриЗагрузке(Типы);
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.КалендарныеГрафики") Тогда
		МодульКалендарныеГрафики = ОбщегоНазначения.ОбщийМодуль("КалендарныеГрафики");
		МодульКалендарныеГрафики.ПриЗаполненииТиповОбщихДанныхПоддерживающихСопоставлениеСсылокПриЗагрузке(Типы);
	КонецЕсли;
	
КонецПроцедуры

// См. ВыгрузкаЗагрузкаДанныхПереопределяемый.ПриЗаполненииТиповОбщихДанныхНеТребующихСопоставлениеСсылокПриЗагрузке.
Процедура ПриЗаполненииТиповОбщихДанныхНеТребующихСопоставлениеСсылокПриЗагрузке(Типы) Экспорт
	
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.РаботаСФайлами") Тогда
		МодульРаботаСФайламиСлужебный = ОбщегоНазначения.ОбщийМодуль("РаботаСФайламиСлужебный");
		МодульРаботаСФайламиСлужебный.ПриЗаполненииТиповОбщихДанныхНеТребующихСопоставлениеСсылокПриЗагрузке(Типы);
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.УправлениеДоступом") Тогда
		МодульУправлениеДоступомСлужебный = ОбщегоНазначения.ОбщийМодуль("УправлениеДоступомСлужебный");
		МодульУправлениеДоступомСлужебный.ПриЗаполненииТиповОбщихДанныхНеТребующихСопоставлениеСсылокПриЗагрузке(Типы);
	КонецЕсли;
	
КонецПроцедуры

// См. ВыгрузкаЗагрузкаДанныхПереопределяемый.ПриЗаполненииТиповИсключаемыхИзВыгрузкиЗагрузки.
Процедура ПриЗаполненииТиповИсключаемыхИзВыгрузкиЗагрузки(Типы) Экспорт
	
	СтандартныеПодсистемыСервер.ПриЗаполненииТиповИсключаемыхИзВыгрузкиЗагрузки(Типы);
	
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.ЗавершениеРаботыПользователей") Тогда
		МодульСоединенияИБ = ОбщегоНазначения.ОбщийМодуль("СоединенияИБ");
		МодульСоединенияИБ.ПриЗаполненииТиповИсключаемыхИзВыгрузкиЗагрузки(Типы);
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.ВариантыОтчетов") Тогда
		МодульВариантыОтчетов = ОбщегоНазначения.ОбщийМодуль("ВариантыОтчетов");
		МодульВариантыОтчетов.ПриЗаполненииТиповИсключаемыхИзВыгрузкиЗагрузки(Типы);
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.Взаимодействия") Тогда
		МодульВзаимодействия = ОбщегоНазначения.ОбщийМодуль("Взаимодействия");
		МодульВзаимодействия.ПриЗаполненииТиповИсключаемыхИзВыгрузкиЗагрузки(Типы);
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.ВнешниеКомпоненты") Тогда
		МодульВнешниеКомпонентыСлужебный = ОбщегоНазначения.ОбщийМодуль("ВнешниеКомпонентыСлужебный");
		МодульВнешниеКомпонентыСлужебный.ПриЗаполненииТиповИсключаемыхИзВыгрузкиЗагрузки(Типы);
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.РегламентныеЗадания") Тогда
		МодульРегламентныеЗаданияСлужебный = ОбщегоНазначения.ОбщийМодуль("РегламентныеЗаданияСлужебный");
		МодульРегламентныеЗаданияСлужебный.ПриЗаполненииТиповИсключаемыхИзВыгрузкиЗагрузки(Типы);
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.РаботаВМоделиСервиса.АдресныйКлассификаторВМоделиСервиса") Тогда
		МодульАдресныйКлассификаторВМоделиСервисаСлужебный = ОбщегоНазначения.ОбщийМодуль("АдресныйКлассификаторВМоделиСервисаСлужебный");
		МодульАдресныйКлассификаторВМоделиСервисаСлужебный.ПриЗаполненииТиповИсключаемыхИзВыгрузкиЗагрузки(Типы);
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.РаботаВМоделиСервиса.БазоваяФункциональностьВМоделиСервиса") Тогда
		МодульРаботаВМоделиСервиса = ОбщегоНазначения.ОбщийМодуль("РаботаВМоделиСервиса");
		МодульРаботаВМоделиСервиса.ПриЗаполненииТиповИсключаемыхИзВыгрузкиЗагрузки(Типы);
	КонецЕсли;

	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.РаботаВМоделиСервиса.ОбменСообщениями") Тогда
		МодульОбменСообщениямиВнутренний = ОбщегоНазначения.ОбщийМодуль("ОбменСообщениямиВнутренний");
		МодульОбменСообщениямиВнутренний.ПриЗаполненииТиповИсключаемыхИзВыгрузкиЗагрузки(Типы);
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.РаботаВМоделиСервиса.ОбновлениеВерсииИБВМоделиСервиса") Тогда
		МодульОбновлениеИнформационнойБазыСлужебныйВМоделиСервиса = ОбщегоНазначения.ОбщийМодуль("ОбновлениеИнформационнойБазыСлужебныйВМоделиСервиса");
		МодульОбновлениеИнформационнойБазыСлужебныйВМоделиСервиса.ПриЗаполненииТиповИсключаемыхИзВыгрузкиЗагрузки(Типы);
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.РаботаВМоделиСервиса.ОчередьЗаданий") Тогда
		МодульОчередьЗаданийСлужебныйРазделениеДанных = ОбщегоНазначения.ОбщийМодуль("ОчередьЗаданийСлужебныйРазделениеДанных");
		МодульОчередьЗаданийСлужебныйРазделениеДанных.ПриЗаполненииТиповИсключаемыхИзВыгрузкиЗагрузки(Типы);
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.РаботаВМоделиСервиса.РезервноеКопированиеОбластейДанных") Тогда
		МодульРезервноеКопированиеОбластейДанных = ОбщегоНазначения.ОбщийМодуль("РезервноеКопированиеОбластейДанных");
		МодульРезервноеКопированиеОбластейДанных.ПриЗаполненииТиповИсключаемыхИзВыгрузкиЗагрузки(Типы);
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.РаботаВМоделиСервиса.ФайловыеФункцииВМоделиСервиса") Тогда
		МодульФайловыеФункцииСлужебныйВМоделиСервиса = ОбщегоНазначения.ОбщийМодуль("ФайловыеФункцииСлужебныйВМоделиСервиса");
		МодульФайловыеФункцииСлужебныйВМоделиСервиса.ПриЗаполненииТиповИсключаемыхИзВыгрузкиЗагрузки(Типы);
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.УправлениеДоступом") Тогда
		МодульУправлениеДоступомСлужебный = ОбщегоНазначения.ОбщийМодуль("УправлениеДоступомСлужебный");
		МодульУправлениеДоступомСлужебный.ПриЗаполненииТиповИсключаемыхИзВыгрузкиЗагрузки(Типы);
	КонецЕсли;
	
КонецПроцедуры

// См. ВыгрузкаЗагрузкаДанныхПереопределяемый.ПослеЗагрузкиДанных.
Процедура ПослеЗагрузкиДанных(Контейнер) Экспорт
	
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.Пользователи") Тогда
		МодульПользователиСлужебный = ОбщегоНазначения.ОбщийМодуль("ПользователиСлужебный");
		МодульПользователиСлужебный.ПослеЗагрузкиДанных(Контейнер);
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.РаботаВМоделиСервиса.БазоваяФункциональностьВМоделиСервиса") Тогда
		МодульРаботаВМоделиСервиса = ОбщегоНазначения.ОбщийМодуль("РаботаВМоделиСервиса");
		МодульРаботаВМоделиСервиса.ПослеЗагрузкиДанных(Контейнер);
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("РаботаВМоделиСервиса.ВалютыВМоделиСервиса") Тогда
		МодульКурсыВалютСлужебныйВМоделиСервиса = ОбщегоНазначения.ОбщийМодуль("КурсыВалютСлужебныйВМоделиСервиса");
		МодульКурсыВалютСлужебныйВМоделиСервиса.ПослеЗагрузкиДанных(Контейнер);
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.РаботаВМоделиСервиса.БазоваяФункциональностьВМоделиСервиса") Тогда
		МодульОчередьЗаданийСлужебныйРазделениеДанных = ОбщегоНазначения.ОбщийМодуль("ОчередьЗаданийСлужебныйРазделениеДанных");
		МодульОчередьЗаданийСлужебныйРазделениеДанных.ПослеЗагрузкиДанных(Контейнер);
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.РаботаВМоделиСервиса.ОбновлениеВерсииИБВМоделиСервиса") Тогда
		МодульОбновлениеИнформационнойБазыСлужебныйВМоделиСервиса = ОбщегоНазначения.ОбщийМодуль("ОбновлениеИнформационнойБазыСлужебныйВМоделиСервиса");
		МодульОбновлениеИнформационнойБазыСлужебныйВМоделиСервиса.ПослеЗагрузкиДанных(Контейнер);
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.РаботаВМоделиСервиса.УправлениеДоступомВМоделиСервиса") Тогда
		МодульУправлениеДоступомСлужебныйВМоделиСервиса = ОбщегоНазначения.ОбщийМодуль("УправлениеДоступомСлужебныйВМоделиСервиса");
		МодульУправлениеДоступомСлужебныйВМоделиСервиса.ПослеЗагрузкиДанных(Контейнер);
	КонецЕсли;
	
КонецПроцедуры

// См. ВыгрузкаЗагрузкаДанныхПереопределяемый.ПриРегистрацииОбработчиковВыгрузкиДанных.
Процедура ПриРегистрацииОбработчиковВыгрузкиДанных(ТаблицаОбработчиков) Экспорт
	
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.УправлениеДоступом") Тогда
		МодульУправлениеДоступомСлужебный = ОбщегоНазначения.ОбщийМодуль("УправлениеДоступомСлужебный");
		МодульУправлениеДоступомСлужебный.ПриРегистрацииОбработчиковВыгрузкиДанных(ТаблицаОбработчиков);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

// Обработка программных событий, возникающих в подсистемах БСП.
// Только для вызовов из библиотеки БСП в БТС.

#Область СлужебныйПрограммныйИнтерфейс

#Область БазоваяФункциональность

// См. ОбщегоНазначенияПереопределяемый.ПриДобавленииИсключенийПоискаСсылок.
Процедура ПриДобавленииИсключенийПоискаСсылок(ИсключенияПоискаСсылок) Экспорт
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ТехнологияСервиса.БазоваяФункциональность") Тогда
		МодульТехнологияСервисаИнтеграцияСБСП = ОбщегоНазначения.ОбщийМодуль("ТехнологияСервисаИнтеграцияСБСП");
		МодульТехнологияСервисаИнтеграцияСБСП.ПриДобавленииИсключенийПоискаСсылок(ИсключенияПоискаСсылок);
	КонецЕсли;
	
КонецПроцедуры

// См. ПриОтправкеДанныхГлавному в синтаксис-помощнике.
Процедура ПриОтправкеДанныхГлавному(ЭлементДанных, ОтправкаЭлемента, Получатель) Экспорт
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ТехнологияСервиса.БазоваяФункциональность") Тогда
		МодульТехнологияСервисаИнтеграцияСБСП = ОбщегоНазначения.ОбщийМодуль("ТехнологияСервисаИнтеграцияСБСП");
		МодульТехнологияСервисаИнтеграцияСБСП.ПриОтправкеДанныхГлавному(ЭлементДанных, ОтправкаЭлемента, Получатель);
	КонецЕсли;
	
КонецПроцедуры

// См. ПриОтправкеДанныхПодчиненному в синтаксис-помощнике.
Процедура ПриОтправкеДанныхПодчиненному(ЭлементДанных, ОтправкаЭлемента, СозданиеНачальногоОбраза, Получатель) Экспорт
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ТехнологияСервиса.БазоваяФункциональность") Тогда
		МодульТехнологияСервисаИнтеграцияСБСП = ОбщегоНазначения.ОбщийМодуль("ТехнологияСервисаИнтеграцияСБСП");
		МодульТехнологияСервисаИнтеграцияСБСП.ПриОтправкеДанныхПодчиненному(ЭлементДанных, ОтправкаЭлемента, СозданиеНачальногоОбраза, Получатель);
	КонецЕсли;
	
КонецПроцедуры

// См. ПриПолученииДанныхОтГлавного в синтаксис-помощнике.
Процедура ПриПолученииДанныхОтГлавного(ЭлементДанных, ПолучениеЭлемента, ОтправкаНазад, Отправитель) Экспорт
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ТехнологияСервиса.БазоваяФункциональность") Тогда
		МодульТехнологияСервисаИнтеграцияСБСП = ОбщегоНазначения.ОбщийМодуль("ТехнологияСервисаИнтеграцияСБСП");
		МодульТехнологияСервисаИнтеграцияСБСП.ПриПолученииДанныхОтГлавного(ЭлементДанных, ПолучениеЭлемента, ОтправкаНазад, Отправитель);
	КонецЕсли;
	
КонецПроцедуры

// См. ПриПолученииДанныхОтПодчиненного в синтаксис-помощнике.
Процедура ПриПолученииДанныхОтПодчиненного(ЭлементДанных, ПолучениеЭлемента, ОтправкаНазад, Отправитель) Экспорт
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ТехнологияСервиса.БазоваяФункциональность") Тогда
		МодульТехнологияСервисаИнтеграцияСБСП = ОбщегоНазначения.ОбщийМодуль("ТехнологияСервисаИнтеграцияСБСП");
		МодульТехнологияСервисаИнтеграцияСБСП.ПриПолученииДанныхОтПодчиненного(ЭлементДанных, ПолучениеЭлемента, ОтправкаНазад, Отправитель);
	КонецЕсли;
	
КонецПроцедуры

// См. РаботаВМоделиСервисаПереопределяемый.ПриВключенииРазделенияПоОбластямДанных.
Процедура ПриВключенииРазделенияПоОбластямДанных() Экспорт
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ТехнологияСервиса.БазоваяФункциональность") Тогда
		МодульТехнологияСервисаИнтеграцияСБСП = ОбщегоНазначения.ОбщийМодуль("ТехнологияСервисаИнтеграцияСБСП");
		МодульТехнологияСервисаИнтеграцияСБСП.ПриВключенииРазделенияПоОбластямДанных();
	КонецЕсли;
	
КонецПроцедуры

// См. ОбщегоНазначенияПереопределяемый.ПриОпределенииПоддерживаемыхВерсийПрограммныхИнтерфейсов.
Процедура ПриОпределенииПоддерживаемыхВерсийПрограммныхИнтерфейсов(Знач СтруктураПоддерживаемыхВерсий) Экспорт
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ТехнологияСервиса.БазоваяФункциональность") Тогда
		МодульТехнологияСервисаИнтеграцияСБСП = ОбщегоНазначения.ОбщийМодуль("ТехнологияСервисаИнтеграцияСБСП");
		МодульТехнологияСервисаИнтеграцияСБСП.ПриОпределенииПоддерживаемыхВерсийПрограммныхИнтерфейсов(СтруктураПоддерживаемыхВерсий);
	КонецЕсли;
	
КонецПроцедуры

// См. ОбщегоНазначенияПереопределяемый.ПараметрыРаботыКлиентаПриЗапуске.
Процедура ПриДобавленииПараметровРаботыКлиентаПриЗапуске(Параметры) Экспорт
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ТехнологияСервиса.БазоваяФункциональность") Тогда
		МодульТехнологияСервисаИнтеграцияСБСП = ОбщегоНазначения.ОбщийМодуль("ТехнологияСервисаИнтеграцияСБСП");
		МодульТехнологияСервисаИнтеграцияСБСП.ПриДобавленииПараметровРаботыКлиентаПриЗапуске(Параметры);
	КонецЕсли;
	
КонецПроцедуры

// См. ОбщегоНазначенияПереопределяемый.ПараметрыРаботыКлиента.
Процедура ПриДобавленииПараметровРаботыКлиента(Параметры) Экспорт
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ТехнологияСервиса.БазоваяФункциональность") Тогда
		МодульТехнологияСервисаИнтеграцияСБСП = ОбщегоНазначения.ОбщийМодуль("ТехнологияСервисаИнтеграцияСБСП");
		МодульТехнологияСервисаИнтеграцияСБСП.ПриДобавленииПараметровРаботыКлиента(Параметры);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ДополнительныеОтчетыИОбработки

// Вызывается при определении наличия у текущего пользователя права на добавление дополнительного
// отчета или обработки в область данных.
//
// Параметры:
//  ДополнительнаяОбработка - СправочникОбъект.ДополнительныеОтчетыИОбработки, элемент справочника,
//    который записывается пользователем.
//  Результат - Булево, в этот параметр в данной процедуре устанавливается флаг наличия права,
//  СтандартнаяОбработка - Булево, в этот параметр в данной процедуре устанавливается флаг выполнения
//    стандартной обработки проверки права.
//
Процедура ПриПроверкеПраваДобавления(Знач ДополнительнаяОбработка, Результат, СтандартнаяОбработка) Экспорт
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ТехнологияСервиса.БазоваяФункциональность") Тогда
		МодульТехнологияСервисаИнтеграцияСБСП = ОбщегоНазначения.ОбщийМодуль("ТехнологияСервисаИнтеграцияСБСП");
		МодульТехнологияСервисаИнтеграцияСБСП.ПриПроверкеПраваДобавления(ДополнительнаяОбработка, Результат, СтандартнаяОбработка);
	КонецЕсли;
	
КонецПроцедуры

// Вызывается при проверке возможности загрузки дополнительного отчета или обработки из файла.
//
// Параметры:
//  ДополнительнаяОбработка - СправочникСсылка.ДополнительныеОтчетыИОбработки,
//  Результат - Булево, в этот параметр в данной процедуре устанавливается флаг наличия возможности
//    загрузки дополнительного отчета или обработки из файла,
//  СтандартнаяОбработка - Булево, в этот параметр в данной процедуре устанавливается флаг выполнения
//    стандартной обработки проверки возможности загрузки дополнительного отчета или обработки из файла.
//
Процедура ПриПроверкеВозможностиЗагрузкиОбработкиИзФайла(Знач ДополнительнаяОбработка, Результат, СтандартнаяОбработка) Экспорт
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ТехнологияСервиса.БазоваяФункциональность") Тогда
		МодульТехнологияСервисаИнтеграцияСБСП = ОбщегоНазначения.ОбщийМодуль("ТехнологияСервисаИнтеграцияСБСП");
		МодульТехнологияСервисаИнтеграцияСБСП.ПриПроверкеВозможностиЗагрузкиОбработкиИзФайла(ДополнительнаяОбработка, Результат, СтандартнаяОбработка);
	КонецЕсли;
	
КонецПроцедуры

// Вызывается при проверке возможности выгрузки дополнительного отчета или обработки в файл.
//
// Параметры:
//  ДополнительнаяОбработка - СправочникСсылка.ДополнительныеОтчетыИОбработки,
//  Результат - Булево, в этот параметр в данной процедуре устанавливается флаг наличия возможности
//    выгрузки дополнительного отчета или обработки в файл,
//  СтандартнаяОбработка - Булево, в этот параметр в данной процедуре устанавливается флаг выполнения
//    стандартной обработки проверки возможности выгрузки дополнительного отчета или обработки в файл.
//
Процедура ПриПроверкеВозможностиВыгрузкиОбработкиВФайл(Знач ДополнительнаяОбработка, Результат, СтандартнаяОбработка) Экспорт
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ТехнологияСервиса.БазоваяФункциональность") Тогда
		МодульТехнологияСервисаИнтеграцияСБСП = ОбщегоНазначения.ОбщийМодуль("ТехнологияСервисаИнтеграцияСБСП");
		МодульТехнологияСервисаИнтеграцияСБСП.ПриПроверкеВозможностиВыгрузкиОбработкиВФайл(ДополнительнаяОбработка, Результат, СтандартнаяОбработка);
	КонецЕсли;
	
КонецПроцедуры

// Заполняет виды публикации дополнительных отчетов и обработок, недоступные для использования
// в текущей модели информационной базы.
//
// Параметры:
//  НедоступныеВидыПубликации - Массив строк.
//
Процедура ПриЗаполненииНедоступныхВидовПубликации(Знач НедоступныеВидыПубликации) Экспорт
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ТехнологияСервиса.БазоваяФункциональность") Тогда
		МодульТехнологияСервисаИнтеграцияСБСП = ОбщегоНазначения.ОбщийМодуль("ТехнологияСервисаИнтеграцияСБСП");
		МодульТехнологияСервисаИнтеграцияСБСП.ПриЗаполненииНедоступныхВидовПубликации(НедоступныеВидыПубликации);
	КонецЕсли;
	
КонецПроцедуры

// Процедура должна вызываться из события ПередЗаписью справочника
//  ДополнительныеОтчетыИОбработки, выполняет проверку правомерности изменения реквизитов
//  элементов данного справочника для дополнительных обработок, полученных из
//  каталога дополнительных обработок менеджера сервиса.
//
// Параметры:
//  Источник - СправочникОбъект.ДополнительныеОтчетыИОбработки,
//  Отказ - булево, флаг отказа от выполнения записи элемента справочника.
//
Процедура ПередЗаписьюДополнительнойОбработки(Источник, Отказ) Экспорт
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ТехнологияСервиса.БазоваяФункциональность") Тогда
		МодульТехнологияСервисаИнтеграцияСБСП = ОбщегоНазначения.ОбщийМодуль("ТехнологияСервисаИнтеграцияСБСП");
		МодульТехнологияСервисаИнтеграцияСБСП.ПередЗаписьюДополнительнойОбработки(Источник, Отказ);
	КонецЕсли;
	
КонецПроцедуры

// Процедура должна вызываться из события ПередУдалением справочника
//  ДополнительныеОтчетыИОбработки.
//
// Параметры:
//  Источник - СправочникОбъект.ДополнительныеОтчетыИОбработки,
//  Отказ - булево, флаг отказа от выполнения удаления элемента справочника из информационной базы.
//
Процедура ПередУдалениемДополнительнойОбработки(Источник, Отказ) Экспорт
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ТехнологияСервиса.БазоваяФункциональность") Тогда
		МодульТехнологияСервисаИнтеграцияСБСП = ОбщегоНазначения.ОбщийМодуль("ТехнологияСервисаИнтеграцияСБСП");
		МодульТехнологияСервисаИнтеграцияСБСП.ПередУдалениемДополнительнойОбработки(Источник, Отказ);
	КонецЕсли;
	
КонецПроцедуры

// Вызывается при получении регистрационных данных для нового дополнительного отчета
// или обработки.
//
Процедура ПриПолученииРегистрационныхДанных(Объект, РегистрационныеДанные, СтандартнаяОбработка) Экспорт
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ТехнологияСервиса.БазоваяФункциональность") Тогда
		МодульТехнологияСервисаИнтеграцияСБСП = ОбщегоНазначения.ОбщийМодуль("ТехнологияСервисаИнтеграцияСБСП");
		МодульТехнологияСервисаИнтеграцияСБСП.ПриПолученииРегистрационныхДанных(Объект, РегистрационныеДанные, СтандартнаяОбработка);
	КонецЕсли;
	
КонецПроцедуры

// Вызывается при подключении внешней обработки.
//
// Параметры:
//  Ссылка - СправочникСсылка.ДополнительныеОтчетыИОбработки,
//  СтандартнаяОбработка - Булево, флаг необходимости выполнения стандартной обработки подключения
//    внешней обработки,
//  Результат - Строка - имя подключенного внешнего отчета или обработки (в том случае, если в обработчике
//    для параметра СтандартнаяОбработка было установлено значение Ложь).
//
Процедура ПриПодключенииВнешнейОбработки(Знач Ссылка, СтандартнаяОбработка, Результат) Экспорт
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ТехнологияСервиса.БазоваяФункциональность") Тогда
		МодульТехнологияСервисаИнтеграцияСБСП = ОбщегоНазначения.ОбщийМодуль("ТехнологияСервисаИнтеграцияСБСП");
		МодульТехнологияСервисаИнтеграцияСБСП.ПриПодключенииВнешнейОбработки(Ссылка, СтандартнаяОбработка, Результат);
	КонецЕсли;
	
КонецПроцедуры

// Вызывается при создании объекта внешней обработки.
//
// Параметры:
//  Ссылка - СправочникСсылка.ДополнительныеОтчетыИОбработки,
//  СтандартнаяОбработка - Булево, флаг необходимости выполнения стандартной обработки подключения
//    внешней обработки,
//  Результат - ВнешняяОбработкаОбъект, ВнешнийОтчетОбъект - объект подключенного внешнего отчета или
//    обработки (в том случае, если в обработчике для параметра СтандартнаяОбработка было установлено значение Ложь).
//
Процедура ПриСозданииВнешнейОбработки(Знач Ссылка, СтандартнаяОбработка, Результат) Экспорт
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ТехнологияСервиса.БазоваяФункциональность") Тогда
		МодульТехнологияСервисаИнтеграцияСБСП = ОбщегоНазначения.ОбщийМодуль("ТехнологияСервисаИнтеграцияСБСП");
		МодульТехнологияСервисаИнтеграцияСБСП.ПриСозданииВнешнейОбработки(Ссылка, СтандартнаяОбработка, Результат);
	КонецЕсли;
	
КонецПроцедуры

// Вызывается при получении разрешений сессии безопасного режима.
//
// Параметры:
//  КлючСессии - УникальныйИдентификатор,
//  ОписанияРазрешений - ТаблицаЗначений:
//    * ВидРазрешения - Строка,
//    * Параметры - ХранилищеЗначения,
//  СтандартнаяОбработка - Булево, флаг необходимости выполнения стандартной обработки.
//
Процедура ПриПолученииРазрешенийСессииБезопасногоРежима(Знач КлючСессии, ОписанияРазрешений, СтандартнаяОбработка) Экспорт
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ТехнологияСервиса.БазоваяФункциональность") Тогда
		МодульТехнологияСервисаИнтеграцияСБСП = ОбщегоНазначения.ОбщийМодуль("ТехнологияСервисаИнтеграцияСБСП");
		МодульТехнологияСервисаИнтеграцияСБСП.ПриПолученииРазрешенийСессииБезопасногоРежима(КлючСессии, ОписанияРазрешений, СтандартнаяОбработка);
	КонецЕсли;
	
КонецПроцедуры

// Вызывается перед записью изменений регламентного задания дополнительных отчетов и обработок в модели сервиса.
//
// Параметры:
//   Объект - СправочникОбъект.ДополнительныеОтчетыИОбработки - Объект дополнительного отчета или обработки.
//   Команда - СправочникТабличнаяЧастьСтрока.ДополнительныеОтчетыИОбработки.Команды - Описание команды.
//   Задание - РегламентноеЗадание, СтрокаТаблицыЗначений - Описание регламентного задания.
//       См. описание возвращаемого значения функции РегламентныеЗаданияСервер.Задание().
//   Изменения - Структура - Значения реквизитов задания, которые необходимо изменить.
//       См. описание 2го параметра процедуры РегламентныеЗаданияСервер.ИзменитьЗадание().
//       Если установить Неопределено, то регламентное задание не будет изменено.
//
Процедура ПередОбновлениемЗадания(Объект, Команда, Задание, Изменения) Экспорт
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ТехнологияСервиса.БазоваяФункциональность") Тогда
		МодульТехнологияСервисаИнтеграцияСБСП = ОбщегоНазначения.ОбщийМодуль("ТехнологияСервисаИнтеграцияСБСП");
		МодульТехнологияСервисаИнтеграцияСБСП.ПередОбновлениемЗадания(Объект, Команда, Задание, Изменения);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область Пользователи

// Вызывается, если не удалось найти пользователя в справочнике, который
// соответствует текущему пользователю ИБ. При этом можно включить автоматическое
// создание элемента справочника Пользователи для текущего пользователя.
//
// Параметры:
//  СоздатьПользователя - Булево - (возвращаемое значение) - если указать Истина,
//       то автоматически будет создан пользователь в справочнике.
//       Переопределить свойства создаваемого пользователя можно перед его записью
//       в процедуре ПриАвтоматическомСозданииТекущегоПользователяВСправочнике.
//
Процедура ПриОтсутствииТекущегоПользователяВСправочнике(СоздатьПользователя) Экспорт
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ТехнологияСервиса.БазоваяФункциональность") Тогда
		МодульТехнологияСервисаИнтеграцияСБСП = ОбщегоНазначения.ОбщийМодуль("ТехнологияСервисаИнтеграцияСБСП");
		МодульТехнологияСервисаИнтеграцияСБСП.ПриОтсутствииТекущегоПользователяВСправочнике(СоздатьПользователя);
	КонецЕсли;
	
КонецПроцедуры

// Вызывается при автоматическом создании элемента справочника Пользователи в момент
// интерактивного входа пользователя или при первом обращении из кода.
//
// Параметры:
//  НовыйПользователь - СправочникОбъект.Пользователи - новый пользователь перед записью.
//
Процедура ПриАвтоматическомСозданииТекущегоПользователяВСправочнике(НовыйПользователь) Экспорт
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ТехнологияСервиса.БазоваяФункциональность") Тогда
		МодульТехнологияСервисаИнтеграцияСБСП = ОбщегоНазначения.ОбщийМодуль("ТехнологияСервисаИнтеграцияСБСП");
		МодульТехнологияСервисаИнтеграцияСБСП.ПриАвтоматическомСозданииТекущегоПользователяВСправочнике(НовыйПользователь);
	КонецЕсли;
	
КонецПроцедуры

// Вызывается при авторизации нового пользователя информационной базы.
//
// Параметры:
//  ПользовательИБ - ПользовательИнформационнойБазы, текущий пользователь информационной базы,
//  СтандартнаяОбработка - Булево, значение может быть установлено внутри обработчика, в этом случае
//    стандартная обработка авторизации нового пользователя ИБ выполняться не будет.
//
Процедура ПриАвторизацииНовогоПользователяИБ(ПользовательИБ, СтандартнаяОбработка) Экспорт
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ТехнологияСервиса.БазоваяФункциональность") Тогда
		МодульТехнологияСервисаИнтеграцияСБСП = ОбщегоНазначения.ОбщийМодуль("ТехнологияСервисаИнтеграцияСБСП");
		МодульТехнологияСервисаИнтеграцияСБСП.ПриАвторизацииНовогоПользователяИБ(ПользовательИБ, СтандартнаяОбработка);
	КонецЕсли;
	
КонецПроцедуры

// Вызывается при начале обработки пользователя информационной базы.
//
// Параметры:
//  ПараметрыОбработки - Структура, см. комментарий к процедуре НачатьОбработкуПользователяИБ().
//  ОписаниеПользователяИБ - Структура, см. комментарий к процедуре НачатьОбработкуПользователяИБ().
//
Процедура ПриНачалеОбработкиПользователяИБ(ПараметрыОбработки, ОписаниеПользователяИБ) Экспорт
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ТехнологияСервиса.БазоваяФункциональность") Тогда
		МодульТехнологияСервисаИнтеграцияСБСП = ОбщегоНазначения.ОбщийМодуль("ТехнологияСервисаИнтеграцияСБСП");
		МодульТехнологияСервисаИнтеграцияСБСП.ПриНачалеОбработкиПользователяИБ(ПараметрыОбработки, ОписаниеПользователяИБ);
	КонецЕсли;
	
КонецПроцедуры

// Вызывается перед записью пользователя информационной базы.
//
// Параметры:
//  ПользовательИБ - ПользовательИнформационнойБазы - пользователь, который будет записан.
//
Процедура ПередЗаписьюПользователяИБ(ПользовательИБ) Экспорт
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ТехнологияСервиса.БазоваяФункциональность") Тогда
		МодульТехнологияСервисаИнтеграцияСБСП = ОбщегоНазначения.ОбщийМодуль("ТехнологияСервисаИнтеграцияСБСП");
		МодульТехнологияСервисаИнтеграцияСБСП.ПередЗаписьюПользователяИБ(ПользовательИБ);
	КонецЕсли;
	
КонецПроцедуры

// Вызывается перед удалением пользователя информационной базы.
//
// Параметры:
//  ПользовательИБ - ПользовательИнформационнойБазы - пользователь, который будет удален.
//
Процедура ПередУдалениемПользователяИБ(ПользовательИБ) Экспорт
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ТехнологияСервиса.БазоваяФункциональность") Тогда
		МодульТехнологияСервисаИнтеграцияСБСП = ОбщегоНазначения.ОбщийМодуль("ТехнологияСервисаИнтеграцияСБСП");
		МодульТехнологияСервисаИнтеграцияСБСП.ПередУдалениемПользователяИБ(ПользовательИБ);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ПрофилиБезопасности

// Вызывается при проверке возможности настройки профилей безопасности.
//
// Параметры:
//  Отказ - Булево. Если для информационной базы недоступно использование профилей безопасности -
//    значение данного параметра нужно установить равным Истина.
//
Процедура ПриПроверкеВозможностиНастройкиПрофилейБезопасности(Отказ) Экспорт
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ТехнологияСервиса.БазоваяФункциональность") Тогда
		МодульТехнологияСервисаИнтеграцияСБСП = ОбщегоНазначения.ОбщийМодуль("ТехнологияСервисаИнтеграцияСБСП");
		МодульТехнологияСервисаИнтеграцияСБСП.ПриПроверкеВозможностиНастройкиПрофилейБезопасности(Отказ);
	КонецЕсли;
	
КонецПроцедуры

// См. РаботаВБезопасномРежимеПереопределяемый.ПриЗапросеРазрешенийНаИспользованиеВнешнихРесурсов.
Процедура ПриЗапросеРазрешенийНаИспользованиеВнешнихРесурсов(Знач ПрограммныйМодуль, Знач Владелец, Знач РежимЗамещения, Знач ДобавляемыеРазрешения, Знач УдаляемыеРазрешения, СтандартнаяОбработка, Результат) Экспорт
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ТехнологияСервиса.БазоваяФункциональность") Тогда
		МодульТехнологияСервисаИнтеграцияСБСП = ОбщегоНазначения.ОбщийМодуль("ТехнологияСервисаИнтеграцияСБСП");
		МодульТехнологияСервисаИнтеграцияСБСП.ПриЗапросеРазрешенийНаИспользованиеВнешнихРесурсов(ПрограммныйМодуль, Владелец, РежимЗамещения, ДобавляемыеРазрешения, УдаляемыеРазрешения, СтандартнаяОбработка, Результат);
	КонецЕсли;
	
КонецПроцедуры

// См. РаботаВБезопасномРежимеПереопределяемый.ПриЗапросеСозданияПрофиляБезопасности.
Процедура ПриЗапросеСозданияПрофиляБезопасности(Знач ПрограммныйМодуль, СтандартнаяОбработка, Результат) Экспорт
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ТехнологияСервиса.БазоваяФункциональность") Тогда
		МодульТехнологияСервисаИнтеграцияСБСП = ОбщегоНазначения.ОбщийМодуль("ТехнологияСервисаИнтеграцияСБСП");
		МодульТехнологияСервисаИнтеграцияСБСП.ПриЗапросеСозданияПрофиляБезопасности(ПрограммныйМодуль, СтандартнаяОбработка, Результат);
	КонецЕсли;
	
КонецПроцедуры

// См. РаботаВБезопасномРежимеПереопределяемый.ПриЗапросеУдаленияПрофиляБезопасности.
Процедура ПриЗапросеУдаленияПрофиляБезопасности(Знач ПрограммныйМодуль, СтандартнаяОбработка, Результат) Экспорт
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ТехнологияСервиса.БазоваяФункциональность") Тогда
		МодульТехнологияСервисаИнтеграцияСБСП = ОбщегоНазначения.ОбщийМодуль("ТехнологияСервисаИнтеграцияСБСП");
		МодульТехнологияСервисаИнтеграцияСБСП.ПриЗапросеУдаленияПрофиляБезопасности(ПрограммныйМодуль, СтандартнаяОбработка, Результат);
	КонецЕсли;
	
КонецПроцедуры

// См. РаботаВБезопасномРежимеПереопределяемый.ПриПодключенииВнешнегоМодуля.
Процедура ПриПодключенииВнешнегоМодуля(Знач ВнешнийМодуль, БезопасныйРежим) Экспорт
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ТехнологияСервиса.БазоваяФункциональность") Тогда
		МодульТехнологияСервисаИнтеграцияСБСП = ОбщегоНазначения.ОбщийМодуль("ТехнологияСервисаИнтеграцияСБСП");
		МодульТехнологияСервисаИнтеграцияСБСП.ПриПодключенииВнешнегоМодуля(ВнешнийМодуль, БезопасныйРежим);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область РаботаВМоделиСервиса_БазоваяФункциональностьВМоделиСервиса

// См. РаботаВМоделиСервисаПереопределяемый.ПриЗаполненииТаблицыПараметровИБ.
Процедура ПриЗаполненииТаблицыПараметровИБ(Знач ТаблицаПараметров) Экспорт
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ТехнологияСервиса.БазоваяФункциональность") Тогда
		МодульТехнологияСервисаИнтеграцияСБСП = ОбщегоНазначения.ОбщийМодуль("ТехнологияСервисаИнтеграцияСБСП");
		МодульТехнологияСервисаИнтеграцияСБСП.ПриЗаполненииТаблицыПараметровИБ(ТаблицаПараметров);
	КонецЕсли;
	
КонецПроцедуры

// Вызывается при определении псевдонима пользователя для отображения в интерфейсе.
//
// Параметры:
//  ИдентификаторПользователя - УникальныйИдентификатор,
//  Псевдоним - Строка, псевдоним пользователя.
//
Процедура ПриОпределенииПсевдонимаПользователя(ИдентификаторПользователя, Псевдоним) Экспорт
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ТехнологияСервиса.БазоваяФункциональность") Тогда
		МодульТехнологияСервисаИнтеграцияСБСП = ОбщегоНазначения.ОбщийМодуль("ТехнологияСервисаИнтеграцияСБСП");
		МодульТехнологияСервисаИнтеграцияСБСП.ПриОпределенииПсевдонимаПользователя(ИдентификаторПользователя, Псевдоним);
	КонецЕсли;
	
КонецПроцедуры

// Вызывается при определении списка метаданных, которые являются не разделенными
// и которые можно записывать из разделенного сеанса. Процедура должна в массив Исключения добавить ссылки
// на исключаемые при проверке объекты метаданных. Эти метаданные могут отсутствовать в подписках, которые
// проверяют запрет на запись неразделенных данных из разделенного сеанса.
Процедура ПриОпределенииИсключенийНеразделенныхДанных(Исключения) Экспорт
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ТехнологияСервиса.БазоваяФункциональность") Тогда
		МодульТехнологияСервисаИнтеграцияСБСП = ОбщегоНазначения.ОбщийМодуль("ТехнологияСервисаИнтеграцияСБСП");
		МодульТехнологияСервисаИнтеграцияСБСП.ПриОпределенииИсключенийНеразделенныхДанных(Исключения);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область РаботаВМоделиСервиса_ОбменСообщениями

// См. ОбменСообщениямиПереопределяемый.ПолучитьОбработчикиКаналовСообщений.
Процедура ПриОпределенииОбработчиковКаналовСообщений(Обработчики) Экспорт
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ТехнологияСервиса.БазоваяФункциональность") Тогда
		МодульТехнологияСервисаИнтеграцияСБСП = ОбщегоНазначения.ОбщийМодуль("ТехнологияСервисаИнтеграцияСБСП");
		МодульТехнологияСервисаИнтеграцияСБСП.ПриОпределенииОбработчиковКаналовСообщений(Обработчики);
	КонецЕсли;
	
КонецПроцедуры

// См. ИнтерфейсыСообщенийВМоделиСервисаПереопределяемый.ЗаполнитьОбработчикиПринимаемыхСообщений.
Процедура РегистрацияИнтерфейсовПринимаемыхСообщений(МассивОбработчиков) Экспорт
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ТехнологияСервиса.БазоваяФункциональность") Тогда
		МодульТехнологияСервисаИнтеграцияСБСП = ОбщегоНазначения.ОбщийМодуль("ТехнологияСервисаИнтеграцияСБСП");
		МодульТехнологияСервисаИнтеграцияСБСП.РегистрацияИнтерфейсовПринимаемыхСообщений(МассивОбработчиков);
	КонецЕсли;
	
КонецПроцедуры

// См. ИнтерфейсыСообщенийВМоделиСервисаПереопределяемый.ЗаполнитьОбработчикиОтправляемыхСообщений.
Процедура РегистрацияИнтерфейсовОтправляемыхСообщений(МассивОбработчиков) Экспорт
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ТехнологияСервиса.БазоваяФункциональность") Тогда
		МодульТехнологияСервисаИнтеграцияСБСП = ОбщегоНазначения.ОбщийМодуль("ТехнологияСервисаИнтеграцияСБСП");
		МодульТехнологияСервисаИнтеграцияСБСП.РегистрацияИнтерфейсовОтправляемыхСообщений(МассивОбработчиков);
	КонецЕсли;
	
КонецПроцедуры

// См. ИнтерфейсыСообщенийВМоделиСервисаПереопределяемый.ПриОпределенииВерсииИнтерфейсаКорреспондента.
Процедура ПриОпределенииВерсииИнтерфейсаКорреспондента(Знач ИнтерфейсСообщения, Знач ПараметрыПодключения, Знач ПредставлениеПолучателя, Результат) Экспорт
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ТехнологияСервиса.БазоваяФункциональность") Тогда
		МодульТехнологияСервисаИнтеграцияСБСП = ОбщегоНазначения.ОбщийМодуль("ТехнологияСервисаИнтеграцияСБСП");
		МодульТехнологияСервисаИнтеграцияСБСП.ПриОпределенииВерсииИнтерфейсаКорреспондента(ИнтерфейсСообщения, ПараметрыПодключения, ПредставлениеПолучателя, Результат);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область РаботаВМоделиСервиса_ОчередьЗаданий

// См. ОчередьЗаданийПереопределяемый.ПриОпределенииПсевдонимовОбработчиков.
Процедура ПриОпределенииПсевдонимовОбработчиков(СоответствиеИменПсевдонимам) Экспорт
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ТехнологияСервиса.БазоваяФункциональность") Тогда
		МодульТехнологияСервисаИнтеграцияСБСП = ОбщегоНазначения.ОбщийМодуль("ТехнологияСервисаИнтеграцияСБСП");
		МодульТехнологияСервисаИнтеграцияСБСП.ПриОпределенииПсевдонимовОбработчиков(СоответствиеИменПсевдонимам);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область РаботаВМоделиСервиса_ПоставляемыеДанные

// См. ПоставляемыеДанныеПереопределяемый.ПолучитьОбработчикиПоставляемыхДанных.
Процедура ПриОпределенииОбработчиковПоставляемыхДанных(Обработчики) Экспорт
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ТехнологияСервиса.БазоваяФункциональность") Тогда
		МодульТехнологияСервисаИнтеграцияСБСП = ОбщегоНазначения.ОбщийМодуль("ТехнологияСервисаИнтеграцияСБСП");
		МодульТехнологияСервисаИнтеграцияСБСП.ПриОпределенииОбработчиковПоставляемыхДанных(Обработчики);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область УправлениеДоступом

// Вызывается при обновлении ролей пользователя информационной базы.
//
// Параметры:
//  ИдентификаторПользователяИБ - УникальныйИдентификатор,
//  Отказ - Булево. При установке значения параметра в значение Ложь внутри обработчика события
//    обновление ролей для этого пользователя информационной базы будет пропущено.
//
Процедура ПриОбновленииРолейПользователяИБ(ИдентификаторПользователяИБ, Отказ) Экспорт
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ТехнологияСервиса.БазоваяФункциональность") Тогда
		МодульТехнологияСервисаИнтеграцияСБСП = ОбщегоНазначения.ОбщийМодуль("ТехнологияСервисаИнтеграцияСБСП");
		МодульТехнологияСервисаИнтеграцияСБСП.ПриОбновленииРолейПользователяИБ(ИдентификаторПользователяИБ, Отказ);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти
