#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

// ИнтернетПоддержкаПользователей.ПолучениеОбновленийПрограммы

// Получает настройки обновления конфигурации.
//
// Возвращаемое значение:
//   Структура - со свойствами:
//     * РежимОбновления - Число - для файловой базы 0, для клиент-серверной 2.
//     * ДатаВремяОбновления - Дата - Дата запланированного обновления конфигурации.
//     * ВыслатьОтчетНаПочту - Булево - Признак необходимости отправки на электронную почту отчета об обновлении.
//     * АдресЭлектроннойПочты - Строка - Адрес электронной почты для отправки отчета обновлении.
//     * КодЗадачиПланировщика - Число - Код задачи планировщика Windows.
//     * ИмяФайлаОбновления - Строка - Имя файла, содержащего устанавливаемое обновление.
//     * СоздаватьРезервнуюКопию - Число - Признак необходимости создания резервной копии.
//     * ИмяКаталогаРезервнойКопииИБ - Строка - Каталог для создания резервной копии.
//     * ВосстанавливатьИнформационнуюБазу - Булево - Признак необходимости восстанавливать информационную базу
//                                                    в случае возникновения ошибок в процессе обновления.
//
Функция НастройкиОбновленияКонфигурации() Экспорт
	
	НастройкиПоУмолчанию = НастройкиПоУмолчанию();
	Настройки = ОбщегоНазначения.ХранилищеОбщихНастроекЗагрузить("ОбновлениеКонфигурации", "НастройкиОбновленияКонфигурации");
	
	Если Настройки <> Неопределено Тогда
		ЗаполнитьЗначенияСвойств(НастройкиПоУмолчанию, Настройки);
	КонецЕсли;
	
	Возврат НастройкиПоУмолчанию;
	
КонецФункции

// Сохраняет настройки обновления конфигурации.
//
// Параметры:
//    Настройки - Структура - См. возвращаемое значение процедуры НастройкиОбновленияКонфигурации.
//
Процедура СохранитьНастройкиОбновленияКонфигурации(Настройки) Экспорт
	
	НастройкиПоУмолчанию = НастройкиПоУмолчанию();
	ЗаполнитьЗначенияСвойств(НастройкиПоУмолчанию, Настройки);
	
	ОбщегоНазначения.ХранилищеОбщихНастроекСохранить(
		"ОбновлениеКонфигурации",
		"НастройкиОбновленияКонфигурации",
		НастройкиПоУмолчанию);
	
КонецПроцедуры

// Конец ИнтернетПоддержкаПользователей.ПолучениеОбновленийПрограммы

#КонецОбласти

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// Вызывается при завершении обновления конфигурации через COM-соединение.
//
// Параметры:
//  РезультатОбновления  - Булево - Результат обновления.
//
Процедура ЗавершитьОбновление(Знач РезультатОбновления, Знач ЭлектроннаяПочта, Знач ИмяАдминистратораОбновления) Экспорт

	ТекстСообщения = НСтр("ru = 'Завершение обновления из внешнего скрипта.'");
	ЗаписьЖурналаРегистрации(СобытиеЖурналаРегистрации(), УровеньЖурналаРегистрации.Информация,,,ТекстСообщения);
	
	Если Не ЕстьПраваНаУстановкуОбновления() Тогда
		ТекстСообщения = НСтр("ru = 'Недостаточно прав для завершения обновления конфигурации.'");
		ЗаписьЖурналаРегистрации(СобытиеЖурналаРегистрации(), УровеньЖурналаРегистрации.Ошибка,,,ТекстСообщения);
		ВызватьИсключение ТекстСообщения;
	КонецЕсли;
	
	ЗаписатьСтатусОбновления(ИмяАдминистратораОбновления, Ложь, Истина, РезультатОбновления);
	
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.РаботаСПочтовымиСообщениями")
		И Не ПустаяСтрока(ЭлектроннаяПочта) Тогда
		Попытка
			ОтправитьУведомлениеОбОбновлении(ИмяАдминистратораОбновления, ЭлектроннаяПочта, РезультатОбновления);
			ТекстСообщения = НСтр("ru = 'Уведомление об обновлении успешно отправлено на адрес электронной почты:'")
				+ " " + ЭлектроннаяПочта;
			ЗаписьЖурналаРегистрации(СобытиеЖурналаРегистрации(), УровеньЖурналаРегистрации.Информация,,,ТекстСообщения);
		Исключение
			ТекстСообщения = НСтр("ru = 'Ошибка при отправке письма электронной почты:'")
				+ " " + ЭлектроннаяПочта + Символы.ПС + ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
			ЗаписьЖурналаРегистрации(СобытиеЖурналаРегистрации(), УровеньЖурналаРегистрации.Ошибка,,,ТекстСообщения);
		КонецПопытки;
	КонецЕсли;
	
	Если РезультатОбновления Тогда
		ОбновлениеИнформационнойБазыСлужебный.ПослеЗавершенияОбновления();
	КонецЕсли;
	
КонецПроцедуры

Функция КаталогСкрипта() Экспорт
	
	КаталогСкрипта = "";
	Если СтандартныеПодсистемыСервер.ЭтоБазоваяВерсияКонфигурации() Тогда
		ПараметрЗапускаКлиента = ПараметрыСеанса.ПараметрыКлиентаНаСервере.Получить("ПараметрЗапуска");
		Если СтрНайти(ПараметрЗапускаКлиента, "ВыполнитьОбновлениеИЗавершитьРаботу") > 0 Тогда
			СтатусОбновления = Константы.СтатусОбновленияКонфигурации.Получить().Получить();
			Если СтатусОбновления <> Неопределено
				И СтатусОбновления.Свойство("КаталогСкрипта") Тогда
					КаталогСкрипта = СтатусОбновления.КаталогСкрипта;
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
	
	Возврат КаталогСкрипта;
	
КонецФункции

// Возвращает полное имя основной формы обработки УстановкаОбновлений.
//
Функция ИмяФормыУстановкиОбновления() Экспорт
	
	Возврат "Обработка.УстановкаОбновлений.Форма.Форма";
	
КонецФункции

////////////////////////////////////////////////////////////////////////////////
// Обработчики событий подсистем конфигурации.

// См. ОбновлениеИнформационнойБазыБСП.ПослеОбновленияИнформационнойБазы.
Процедура ПослеОбновленияИнформационнойБазы() Экспорт
	
	Если ОбщегоНазначения.РазделениеВключено() Тогда
		Возврат;
	КонецЕсли;
	
	ЗначениеХранилища = Константы.СтатусОбновленияКонфигурации.Получить();
	
	Статус = Неопределено;
	Если ЗначениеХранилища <> Неопределено Тогда
		Статус = ЗначениеХранилища.Получить();
	КонецЕсли;
	
	Если Статус <> Неопределено И Статус.ОбновлениеВыполнено И Статус.РезультатОбновленияКонфигурации <> Неопределено
		И Не Статус.РезультатОбновленияКонфигурации Тогда
		
		Статус.РезультатОбновленияКонфигурации = Истина;
		Константы.СтатусОбновленияКонфигурации.Установить(Новый ХранилищеЗначения(Статус));
		
	КонецЕсли;
	
КонецПроцедуры

// См. ОбщегоНазначенияПереопределяемый.ПараметрыРаботыКлиентаПриЗапуске.
Процедура ПриДобавленииПараметровРаботыКлиентаПриЗапуске(Параметры) Экспорт
	
	ПриДобавленииПараметровРаботыКлиента(Параметры);
	
КонецПроцедуры

// См. ОбщегоНазначенияПереопределяемый.ПараметрыРаботыКлиента.
Процедура ПриДобавленииПараметровРаботыКлиента(Параметры) Экспорт
	
	Если Не ОбщегоНазначения.ДоступноИспользованиеРазделенныхДанных()
		Или Не ОбщегоНазначенияКлиентСервер.ЭтоWindowsКлиент() Тогда
		Возврат;
	КонецЕсли;
	
	Параметры.Вставить("НастройкиОбновления", Новый ФиксированнаяСтруктура(НастройкиОбновления()));

КонецПроцедуры

Процедура ПроверитьСтатусОбновления(РезультатОбновления, КаталогСкрипта) Экспорт
	
	// Если это первый запуск после обновления конфигурации, то запоминаем и сбрасываем статус.
	РезультатОбновления = ОбновлениеКонфигурацииУспешно(КаталогСкрипта);
	Если РезультатОбновления <> Неопределено Тогда
		СброситьСтатусОбновленияКонфигурации();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Получить глобальные настройки обновления на сеанс 1С:Предприятия.
//
Функция НастройкиОбновления()
	
	Настройки = Новый Структура;
	Настройки.Вставить("КонфигурацияИзменена",?(ЕстьПраваНаУстановкуОбновления(), КонфигурацияИзменена(), Ложь));
	Настройки.Вставить("ПроверитьПрошлыеОбновленияБазы", ОбновлениеКонфигурацииУспешно() <> Неопределено);
	Настройки.Вставить("НастройкиОбновленияКонфигурации", НастройкиОбновленияКонфигурации());
	
	Возврат Настройки;
	
КонецФункции

// Возвращает признак успешного обновления конфигурации на основе данных константы настроек.
Функция ОбновлениеКонфигурацииУспешно(КаталогСкрипта = "") Экспорт

	Если Не ПравоДоступа("Чтение", Метаданные.Константы.СтатусОбновленияКонфигурации) Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	ЗначениеХранилища = Константы.СтатусОбновленияКонфигурации.Получить();
	
	Статус = Неопределено;
	Если ЗначениеХранилища <> Неопределено Тогда
		Статус = ЗначениеХранилища.Получить();
	КонецЕсли;

	Если Статус = Неопределено Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	Если Не СтандартныеПодсистемыСервер.ЭтоБазоваяВерсияКонфигурации()
		И Не Статус.ОбновлениеВыполнено
		Или (Статус.ИмяАдминистратораОбновления <> ИмяПользователя()) Тогда
		
		Возврат Неопределено;
		
	КонецЕсли;
	
	Если Статус.РезультатОбновленияКонфигурации <> Неопределено Тогда
		Статус.Свойство("КаталогСкрипта", КаталогСкрипта);
	КонецЕсли;
	
	Возврат Статус.РезультатОбновленияКонфигурации;

КонецФункции

// Устанавливает новое значение в константу настроек обновления
// соответственно успешности последней попытки обновления конфигурации.
Процедура ЗаписатьСтатусОбновления(Знач ИмяАдминистратораОбновления, Знач ОбновлениеЗапланировано,
	Знач ОбновлениеВыполнено, Знач РезультатОбновления, КаталогСкрипта = "", СообщенияДляЖурналаРегистрации = Неопределено) Экспорт
	
	ЖурналРегистрации.ЗаписатьСобытияВЖурналРегистрации(СообщенияДляЖурналаРегистрации);
	
	Статус = Новый Структура;
	Статус.Вставить("ИмяАдминистратораОбновления", ИмяАдминистратораОбновления);
	Статус.Вставить("ОбновлениеЗапланировано", ОбновлениеЗапланировано);
	Статус.Вставить("ОбновлениеВыполнено", ОбновлениеВыполнено);
	Статус.Вставить("РезультатОбновленияКонфигурации", РезультатОбновления);
	Статус.Вставить("КаталогСкрипта", КаталогСкрипта);
	
	Константы.СтатусОбновленияКонфигурации.Установить(Новый ХранилищеЗначения(Статус));
	
КонецПроцедуры

// Выполняет очистку всех настроек обновления конфигурации.
Процедура СброситьСтатусОбновленияКонфигурации() Экспорт
	
	Константы.СтатусОбновленияКонфигурации.Установить(Новый ХранилищеЗначения(Неопределено));
	
КонецПроцедуры

// Проверка доступа к подсистеме ОбновлениеКонфигурации.
Функция ЕстьПраваНаУстановкуОбновления() Экспорт
	Возврат Пользователи.ЭтоПолноправныйПользователь(, Истина);
КонецФункции

Процедура ОтправитьУведомлениеОбОбновлении(Знач ИмяПользователя, Знач АдресНазначения, Знач УспешноеОбновление)
	
	Тема = ? (УспешноеОбновление, НСтр("ru = 'Успешное обновление конфигурации ""%1"", версия %2'"), 
		НСтр("ru = 'Ошибка обновления конфигурации ""%1"", версия %2'"));
	Тема = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(Тема, Метаданные.КраткаяИнформация, Метаданные.Версия);
	
	Подробности = ?(УспешноеОбновление, НСтр("ru = 'Обновление конфигурации завершено успешно.'"), 
		НСтр("ru = 'При обновлении конфигурации произошли ошибки. Подробности записаны в журнал регистрации.'"));
	Текст = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru = '%1
		|
		|Конфигурация: %2
		|Версия: %3
		|Строка соединения: %4'"),
	Подробности, Метаданные.КраткаяИнформация, Метаданные.Версия, СтрокаСоединенияИнформационнойБазы());
	
	ПараметрыПисьма = Новый Структура;
	ПараметрыПисьма.Вставить("Тема", Тема);
	ПараметрыПисьма.Вставить("Тело", Текст);
	ПараметрыПисьма.Вставить("Кому", АдресНазначения);
	
	МодульРаботаСПочтовымиСообщениями = ОбщегоНазначения.ОбщийМодуль("РаботаСПочтовымиСообщениями");
	МодульРаботаСПочтовымиСообщениями.ОтправитьПочтовоеСообщение(
		МодульРаботаСПочтовымиСообщениями.СистемнаяУчетнаяЗапись(), ПараметрыПисьма);
	
КонецПроцедуры

// Возвращает имя события для записи журнала регистрации.
Функция СобытиеЖурналаРегистрации()
	Возврат НСтр("ru = 'Обновление конфигурации'", ОбщегоНазначенияКлиентСервер.КодОсновногоЯзыка());
КонецФункции

// Заполняет структуру настроек обновления конфигурации и возвращает их.
//
// Возвращаемое значение:
//   Структура   - структура настроек обновления.
//
Функция НастройкиПоУмолчанию()
	
	Результат = Новый Структура;
	Результат.Вставить("РежимОбновления", ?(ОбщегоНазначения.ИнформационнаяБазаФайловая(), 0, 2));
	Результат.Вставить("ДатаВремяОбновления", НачалоДня(ТекущаяДатаСеанса()) + 24*60*60);
	Результат.Вставить("ВыслатьОтчетНаПочту", Ложь);
	Результат.Вставить("АдресЭлектроннойПочты", "");
	Результат.Вставить("КодЗадачиПланировщика", 0);
	Результат.Вставить("ИмяФайлаОбновления", "");
	Результат.Вставить("СоздаватьРезервнуюКопию", 1);
	Результат.Вставить("ИмяКаталогаРезервнойКопииИБ", "");
	Результат.Вставить("ВосстанавливатьИнформационнуюБазу", Истина);
	Возврат Результат;

КонецФункции

Функция ВыполнитьОтложенныеОбработчики() Экспорт
	
	Возврат Не СтандартныеПодсистемыСервер.ЭтоБазоваяВерсияКонфигурации()
		И ОбновлениеИнформационнойБазыСлужебный.СтатусНевыполненныхОбработчиков() = "СтатусНеВыполнено";
	
КонецФункции
	
#КонецОбласти
