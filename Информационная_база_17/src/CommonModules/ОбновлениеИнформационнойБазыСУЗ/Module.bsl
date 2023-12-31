Процедура ПриДобавленииПодсистемы(Описание) Экспорт
    Описание.Имя = "СистемаУчетаЗадач";
    Описание.Версия = "1.1.8.1";
    // Требуется библиотека стандартных подсистем.
    Описание.ТребуемыеПодсистемы.Добавить("СтандартныеПодсистемы");
КонецПроцедуры

Процедура ПриДобавленииОбработчиковОбновления(Обработчики) Экспорт
	// Обработчики, выполняемые при каждом обновлении ИБ.
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "*";
	Обработчик.ОбщиеДанные = Истина;
	Обработчик.УправлениеОбработчиками = Истина;
	Обработчик.МонопольныйРежим = Истина; // Для демонстрации условного выполнения в монопольном режиме.
	Обработчик.Процедура = "ОбновлениеИнформационнойБазыСУЗ.ВыполнятьВсегдаПриСменеВерсии";
	
	// Обработчики, выполняемые при заполнении пустой ИБ.
	
	Обработчик = Обработчики.Добавить();
	Обработчик.НачальноеЗаполнение = Истина;
	Обработчик.Процедура = "ОбновлениеИнформационнойБазыСУЗ.ПервыйЗапуск";
	
КонецПроцедуры

Процедура ПередОбновлениемИнформационнойБазы() Экспорт
КонецПроцедуры

Процедура ПослеОбновленияИнформационнойБазы(Знач ПредыдущаяВерсия, Знач ТекущаяВерсия,
        Знач ВыполненныеОбработчики, ВыводитьОписаниеОбновлений, МонопольныйРежим) Экспорт
КонецПроцедуры
	
Процедура ПриПодготовкеМакетаОписанияОбновлений(Знач Макет) Экспорт
КонецПроцедуры

Процедура ПриДобавленииОбработчиковПереходаСДругойПрограммы(Обработчики) Экспорт
КонецПроцедуры

Процедура ПриОпределенииРежимаОбновленияДанных(РежимОбновленияДанных, СтандартнаяОбработка) Экспорт
КонецПроцедуры 

Процедура ПриЗавершенииПереходаСДругойПрограммы(Знач ПредыдущееИмяКонфигурации, Знач ПредыдущаяВерсияКонфигурации, Параметры) Экспорт
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// Заполнение пустой ИБ

Процедура ПервыйЗапуск() Экспорт
	
	//Константы.ОграничиватьКоличествоЗадачВРаботе.Установить(Истина);
	Константы.ЗаголовокСистемы.Установить("Система учета задач");
	Константы.КоличествоМесяцевДляОпределенияОсновногоИсполнителя.Установить(3);
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// Обновление ИБ

Процедура ВыполнятьВсегдаПриСменеВерсии(Параметры = Неопределено) Экспорт
	
	КонтактнаяИнформацияОбновлениеИБ();
	
КонецПроцедуры

// Процедура обновления ИБ для справочника видов контактной информации
Процедура КонтактнаяИнформацияОбновлениеИБ() Экспорт
	
	ПользователиСлужебный.ОбновитьПредопределенныеВидыКонтактнойИнформацииПользователей();
	
	КонтактнаяИнформацияОбновлениеИБ_ВклГруппы(Справочники.ВидыКонтактнойИнформации.СправочникЗаказчики);
	КонтактнаяИнформацияОбновлениеИБ_ВклГруппы(Справочники.ВидыКонтактнойИнформации.СправочникКонтактныеЛицаЗаказчиков);
	КонтактнаяИнформацияОбновлениеИБ_ВклГруппы(Справочники.ВидыКонтактнойИнформации.СправочникЛичныеАдресаты);
	
    КонтактнаяИнформацияОбновлениеИБ_Email(Справочники.ВидыКонтактнойИнформации.EmailЗаказчика);
    КонтактнаяИнформацияОбновлениеИБ_Email(Справочники.ВидыКонтактнойИнформации.EmailКЛ);
    КонтактнаяИнформацияОбновлениеИБ_Email(Справочники.ВидыКонтактнойИнформации.EmailАдресата);
	
    КонтактнаяИнформацияОбновлениеИБ_Телефон(Справочники.ВидыКонтактнойИнформации.ТелефонЗаказчика);
    КонтактнаяИнформацияОбновлениеИБ_Телефон(Справочники.ВидыКонтактнойИнформации.ТелефонКЛ);
    КонтактнаяИнформацияОбновлениеИБ_Телефон(Справочники.ВидыКонтактнойИнформации.РабочийТелефонАдресата);
	
	КонтактнаяИнформацияОбновлениеИБ_Адрес(Справочники.ВидыКонтактнойИнформации.ФактическийАдресЗаказчика);
	КонтактнаяИнформацияОбновлениеИБ_Адрес(Справочники.ВидыКонтактнойИнформации.ПочтовыйАдресАдресата);
	
КонецПроцедуры

Процедура КонтактнаяИнформацияОбновлениеИБ_ВклГруппы(Знач Ссылка)
	
	Перем Объект;
	
	Объект = Ссылка.ПолучитьОбъект();
	Объект.Используется = Истина;
	Объект.Записать();

КонецПроцедуры

Процедура КонтактнаяИнформацияОбновлениеИБ_Email(Вид)
	
	Перем ПараметрыВида;
	
	ПараметрыВида = УправлениеКонтактнойИнформацией.ПараметрыВидаКонтактнойИнформации(Перечисления.ТипыКонтактнойИнформации.АдресЭлектроннойПочты);
	ПараметрыВида.Вид = Вид;
	ПараметрыВида.Используется = Истина;
	ПараметрыВида.Порядок = 1;
	ПараметрыВида.РазрешитьВводНесколькихЗначений = Истина;
	ПараметрыВида.НастройкиПроверки.Вставить("ПроверятьКорректность", Истина);
	УправлениеКонтактнойИнформацией.УстановитьСвойстваВидаКонтактнойИнформации(ПараметрыВида);
	
КонецПроцедуры

Процедура КонтактнаяИнформацияОбновлениеИБ_Телефон(Вид)
	
	Перем ПараметрыВида;
	
	ПараметрыВида = УправлениеКонтактнойИнформацией.ПараметрыВидаКонтактнойИнформации(Перечисления.ТипыКонтактнойИнформации.Телефон);
	ПараметрыВида.Вид = Вид;
	ПараметрыВида.Используется = Истина;
	ПараметрыВида.Порядок = 2;
	ПараметрыВида.РазрешитьВводНесколькихЗначений = Истина;
	ПараметрыВида.НастройкиПроверки.Вставить("ПроверятьКорректность", Истина);
	УправлениеКонтактнойИнформацией.УстановитьСвойстваВидаКонтактнойИнформации(ПараметрыВида);
	
КонецПроцедуры

Процедура КонтактнаяИнформацияОбновлениеИБ_Адрес(Вид)
	
	Перем ПараметрыВида;
	
	ПараметрыВида = УправлениеКонтактнойИнформацией.ПараметрыВидаКонтактнойИнформации(Перечисления.ТипыКонтактнойИнформации.Адрес);
	ПараметрыВида.Вид = Вид;
	ПараметрыВида.Используется = Истина;
	ПараметрыВида.Порядок = 3;
	ПараметрыВида.РазрешитьВводНесколькихЗначений = Истина;
	ПараметрыВида.НастройкиПроверки.Вставить("ПроверятьКорректность", Ложь);
	УправлениеКонтактнойИнформацией.УстановитьСвойстваВидаКонтактнойИнформации(ПараметрыВида);
	
КонецПроцедуры


