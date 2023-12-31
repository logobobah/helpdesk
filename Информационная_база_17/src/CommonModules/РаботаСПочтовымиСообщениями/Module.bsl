////////////////////////////////////////////////////////////////////////////////
// Подсистема "Работа с почтовыми сообщениями".
//
////////////////////////////////////////////////////////////////////////////////
//

#Область ПрограммныйИнтерфейс

// Выполняет отправку почтовых сообщений.
//
// Параметры:
//  УчетнаяЗапись - СправочникСсылка.УчетныеЗаписиЭлектроннойПочты - ссылка на
//                 учетную запись электронной почты.
//  ПараметрыПисьма - Структура - содержит всю необходимую информацию о письме:
//
//   * Кому      - Массив структур, строка - (обязательный) Интернет адрес получателя письма.
//                 Адрес         - строка - почтовый адрес.
//                 Представление - строка - имя адресата.
//
//   * ПолучателиСообщения - Массив - массив структур, описывающий получателей:
//                            * ИсточникКонтактнойИнформации - СправочникСсылка - владелец контактной информации.
//                            * Адрес - Строка - Почтовый адрес получателя сообщения.
//                            * Представление - Строка - представление адресата.
//
//   * Копии      - Массив - коллекция структур адресов:
//                   * Адрес         - строка - почтовый адрес (должно быть обязательно заполнено).
//                   * Представление - строка - имя адресата.
//                  
//                - Строка - интернет адреса получателей письма, разделитель - ";".
//
//   * СлепыеКопии - Массив, Строка - см. описание поля Копии.
//
//   * Тема       - Строка - (обязательный) тема почтового сообщения.
//   * Тело       - Строка - (обязательный) текст почтового сообщения (простой текст в кодировке win-1251).
//   * Важность   - ВажностьИнтернетПочтовогоСообщения.
//   * Вложения   - Соответствие - список вложений, где:
//                   * ключ     - Строка - наименование вложения
//                   * значение - ДвоичныеДанные, АдресВоВременномХранилище - данные вложения;
//                              - Структура -    содержащая следующие свойства:
//                                 * ДвоичныеДанные - ДвоичныеДанные - двоичные данные вложения.
//                                 * Идентификатор  - Строка - идентификатор вложения, используется для хранения картинок,
//                                                             отображаемых в теле письма.
//
//   * АдресОтвета - Соответствие - см. описание поля Кому.
//   * ИдентификаторыОснований - Строка - идентификаторы оснований данного письма.
//   * ОбрабатыватьТексты  - Булево - необходимость обрабатывать тексты письма при отправке.
//   * УведомитьОДоставке  - Булево - необходимость запроса уведомления о доставке.
//   * УведомитьОПрочтении - Булево - необходимость запроса уведомления о прочтении.
//   * ТипТекста   - Строка, Перечисление.ТипыТекстовЭлектронныхПисем, ТипТекстаПочтовогоСообщения - определяет тип
//                  переданного теста допустимые значения:
//                  HTML/ТипыТекстовЭлектронныхПисем.HTML - текст почтового сообщения в формате HTML.
//                  ПростойТекст/ТипыТекстовЭлектронныхПисем.ПростойТекст - простой текст почтового сообщения.
//                                                                          Отображается "как есть" (значение по
//                                                                          умолчанию).
//                  РазмеченныйТекст/ТипыТекстовЭлектронныхПисем.РазмеченныйТекст - текст почтового сообщения в формате
//                                                                                  Rich Text.
//
//  Соединение - ИнтернетПочта - существующее соединение с почтовым сервером. Если не указано, то соединение
//                              устанавливается в теле функции.
//
// Возвращаемое значение:
//  Строка - идентификатор отправленного почтового сообщения на SMTP сервере.
//
// ПРИМЕЧАНИЕ: функция может вызвать исключение, которое требуется обработать.
// 
Функция ОтправитьПочтовоеСообщение(Знач УчетнаяЗапись,
	                               Знач ПараметрыПисьма,
	                               Знач Соединение = Неопределено) Экспорт
	
	Если ТипЗнч(УчетнаяЗапись) <> Тип("СправочникСсылка.УчетныеЗаписиЭлектроннойПочты")
		Или НЕ ЗначениеЗаполнено(УчетнаяЗапись) Тогда
		ВызватьИсключение НСтр("ru = 'Учетная запись не заполнена или заполнена неправильно.'");
	КонецЕсли;
	
	Если ПараметрыПисьма = Неопределено Тогда
		ВызватьИсключение НСтр("ru = 'Не заданы параметры отправки.'");
	КонецЕсли;
	
	ТипЗнчКому = ?(ПараметрыПисьма.Свойство("Кому"), ТипЗнч(ПараметрыПисьма.Кому), Неопределено);
	ТипЗнчКопии = ?(ПараметрыПисьма.Свойство("Копии"), ТипЗнч(ПараметрыПисьма.Копии), Неопределено);
	ТипЗнчСлепыеКопии = ?(ПараметрыПисьма.Свойство("СлепыеКопии"), ТипЗнч(ПараметрыПисьма.СлепыеКопии), Неопределено);
	
	Если ТипЗнчКому = Неопределено И ТипЗнчКопии = Неопределено И ТипЗнчСлепыеКопии = Неопределено Тогда
		ВызватьИсключение НСтр("ru = 'Не указано ни одного получателя.'");
	КонецЕсли;
	
	Если ТипЗнчКому = Тип("Строка") Тогда
		ПараметрыПисьма.Кому = ОбщегоНазначенияКлиентСервер.РазобратьСтрокуСПочтовымиАдресами(ПараметрыПисьма.Кому);
	ИначеЕсли ТипЗнчКому <> Тип("Массив") Тогда
		ПараметрыПисьма.Вставить("Кому", Новый Массив);
	КонецЕсли;
	
	Если ТипЗнчКопии = Тип("Строка") Тогда
		ПараметрыПисьма.Копии = ОбщегоНазначенияКлиентСервер.РазобратьСтрокуСПочтовымиАдресами(ПараметрыПисьма.Копии);
	ИначеЕсли ТипЗнчКопии <> Тип("Массив") Тогда
		ПараметрыПисьма.Вставить("Копии", Новый Массив);
	КонецЕсли;
	
	Если ТипЗнчСлепыеКопии = Тип("Строка") Тогда
		ПараметрыПисьма.СлепыеКопии = ОбщегоНазначенияКлиентСервер.РазобратьСтрокуСПочтовымиАдресами(ПараметрыПисьма.СлепыеКопии);
	ИначеЕсли ТипЗнчСлепыеКопии <> Тип("Массив") Тогда
		ПараметрыПисьма.Вставить("СлепыеКопии", Новый Массив);
	КонецЕсли;
	
	Если ПараметрыПисьма.Свойство("АдресОтвета") И ТипЗнч(ПараметрыПисьма.АдресОтвета) = Тип("Строка") Тогда
		ПараметрыПисьма.АдресОтвета = ОбщегоНазначенияКлиентСервер.РазобратьСтрокуСПочтовымиАдресами(ПараметрыПисьма.АдресОтвета);
	КонецЕсли;
	
	Если ПараметрыПисьма.Свойство("Вложения") Тогда
		Если ТипЗнч(ПараметрыПисьма.Вложения) = Тип("Соответствие") Тогда
			Для Каждого Вложение Из ПараметрыПисьма.Вложения Цикл
				ДанныеВложения = Вложение.Значение;
				ДанныеВложения = РаботаСПочтовымиСообщениямиСлужебный.ПривестиВложениеДляВставкиВПисьмо(ДанныеВложения);
				ПараметрыПисьма.Вложения.Вставить(Вложение.Ключ, ДанныеВложения);
			КонецЦикла;
		КонецЕсли;
	КонецЕсли;
	
	ИдентификаторСообщения = РаботаСПочтовымиСообщениямиСлужебный.ОтправитьСообщение(УчетнаяЗапись, ПараметрыПисьма, Соединение);
	
	Если ЗначениеЗаполнено(ИдентификаторСообщения) Тогда
		РаботаСПочтовымиСообщениямиПереопределяемый.ПослеОтправкиПисьма(ПараметрыПисьма);
	КонецЕсли;
	
	Возврат ИдентификаторСообщения;
	
КонецФункции

// Функция для загрузки сообщений. Проверяет корректность заполнения учетной
// записи и вызывает функцию, реализующую механику загрузки сообщений.
// 
// Параметры к функции см. в функции ЗагрузитьСообщения.
//
Функция ЗагрузитьПочтовыеСообщения(Знач УчетнаяЗапись,
                                   Знач ПараметрыЗагрузки = Неопределено) Экспорт
	
	ИспользоватьДляПолучения = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(УчетнаяЗапись, "ИспользоватьДляПолучения");
	Если НЕ ИспользоватьДляПолучения Тогда
		ВызватьИсключение НСтр("ru = 'Учетная запись не предназначена для получения сообщений.'");
	КонецЕсли;
	
	Если ПараметрыЗагрузки = Неопределено Тогда
		ПараметрыЗагрузки = Новый Структура;
	КонецЕсли;
	
	Результат = РаботаСПочтовымиСообщениямиСлужебный.ЗагрузитьСообщения(УчетнаяЗапись, ПараметрыЗагрузки);
	
	Возврат Результат;
	
КонецФункции

// Получить доступные учетные записи электронной почты.
//
//  Параметры:
//   ДляОтправки                    - Булево - Если установлено Истина, то будут выбирать только записи, с которых
//                                             можно отправлять почту.
//   ДляПолучения                   - Булево - Если установлено Истина, то будут выбирать только записи, по которым
//                                             можно получать почту.
//   ВключатьСистемнуюУчетнуюЗапись - Булево - включать системную учетную запись, если настроена для отправки/получения.
//
// Возвращаемое значение:
//  ДоступныеУчетныеЗаписи - ТаблицаЗначений - описание учетных записей:
//   Ссылка       - СправочникСсылка.УчетныеЗаписиЭлектроннойПочты - учетная запись;
//   Наименование - Строка - наименование учетной записи;
//   Адрес        - Строка - адрес электронной почты.
//
Функция ДоступныеУчетныеЗаписи(Знач ДляОтправки = Неопределено,
										Знач ДляПолучения  = Неопределено,
										Знач ВключатьСистемнуюУчетнуюЗапись = Истина) Экспорт
	
	Если Не ПравоДоступа("Чтение", Метаданные.Справочники.УчетныеЗаписиЭлектроннойПочты) Тогда
		Возврат Новый ТаблицаЗначений;
	КонецЕсли;
	
	ТекстЗапроса = 
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	УчетныеЗаписиЭлектроннойПочты.Ссылка КАК Ссылка,
	|	УчетныеЗаписиЭлектроннойПочты.Наименование КАК Наименование,
	|	УчетныеЗаписиЭлектроннойПочты.АдресЭлектроннойПочты КАК Адрес,
	|	ВЫБОР
	|		КОГДА УчетныеЗаписиЭлектроннойПочты.Ссылка = ЗНАЧЕНИЕ(Справочник.УчетныеЗаписиЭлектроннойПочты.СистемнаяУчетнаяЗаписьЭлектроннойПочты)
	|			ТОГДА 0
	|		ИНАЧЕ 1
	|	КОНЕЦ КАК Приоритет
	|ИЗ
	|	Справочник.УчетныеЗаписиЭлектроннойПочты КАК УчетныеЗаписиЭлектроннойПочты
	|ГДЕ
	|	УчетныеЗаписиЭлектроннойПочты.ПометкаУдаления = ЛОЖЬ
	|	И ВЫБОР
	|			КОГДА &ДляОтправки = НЕОПРЕДЕЛЕНО
	|				ТОГДА ИСТИНА
	|			ИНАЧЕ УчетныеЗаписиЭлектроннойПочты.ИспользоватьДляОтправки = &ДляОтправки
	|		КОНЕЦ
	|	И ВЫБОР
	|			КОГДА &ДляПолучения = НЕОПРЕДЕЛЕНО
	|				ТОГДА ИСТИНА
	|			ИНАЧЕ УчетныеЗаписиЭлектроннойПочты.ИспользоватьДляПолучения = &ДляПолучения
	|		КОНЕЦ
	|	И ВЫБОР
	|			КОГДА &ВключатьСистемнуюУчетнуюЗапись
	|				ТОГДА ИСТИНА
	|			ИНАЧЕ УчетныеЗаписиЭлектроннойПочты.Ссылка <> ЗНАЧЕНИЕ(Справочник.УчетныеЗаписиЭлектроннойПочты.СистемнаяУчетнаяЗаписьЭлектроннойПочты)
	|		КОНЕЦ
	|	И УчетныеЗаписиЭлектроннойПочты.АдресЭлектроннойПочты <> """"
	|	И ВЫБОР
	|			КОГДА УчетныеЗаписиЭлектроннойПочты.ИспользоватьДляПолучения
	|				ТОГДА УчетныеЗаписиЭлектроннойПочты.СерверВходящейПочты <> """"
	|			ИНАЧЕ ИСТИНА
	|		КОНЕЦ
	|	И ВЫБОР
	|			КОГДА УчетныеЗаписиЭлектроннойПочты.ИспользоватьДляОтправки
	|				ТОГДА УчетныеЗаписиЭлектроннойПочты.СерверИсходящейПочты <> """"
	|			ИНАЧЕ ИСТИНА
	|		КОНЕЦ
	|
	|УПОРЯДОЧИТЬ ПО
	|	Приоритет,
	|	Наименование";
	
	Запрос = Новый Запрос;
	Запрос.Текст = ТекстЗапроса;
	Запрос.Параметры.Вставить("ДляОтправки", ДляОтправки);
	Запрос.Параметры.Вставить("ДляПолучения", ДляПолучения);
	Запрос.Параметры.Вставить("ВключатьСистемнуюУчетнуюЗапись", ВключатьСистемнуюУчетнуюЗапись);
	
	Возврат Запрос.Выполнить().Выгрузить();
	
КонецФункции

// Получает ссылку на учетную запись по виду назначения учетной записи.
//
// Возвращаемое значение:
//  УчетнаяЗапись - СправочникСсылка.УчетныеЗаписиЭлектроннойПочты - ссылка
//                  на описание учетной записи.
//
Функция СистемнаяУчетнаяЗапись() Экспорт
	
	Возврат Справочники.УчетныеЗаписиЭлектроннойПочты.СистемнаяУчетнаяЗаписьЭлектроннойПочты;
	
КонецФункции

// Проверяет, что системная учетная запись доступна (может быть использована).
//
// Возвращаемое значение:
//  Булево.
Функция ПроверитьСистемнаяУчетнаяЗаписьДоступна() Экспорт
	
	Возврат РаботаСПочтовымиСообщениямиСлужебный.ПроверитьСистемнаяУчетнаяЗаписьДоступна();
	
КонецФункции

// Возвращает Истину, если доступна по меньшей мере одна настроенная учетная запись для отправки почты,
// либо достаточно прав на настройку учетной записи.
Функция ДоступнаОтправкаПисем() Экспорт
	
	Если ПравоДоступа("Изменение", Метаданные.Справочники.УчетныеЗаписиЭлектроннойПочты) Тогда
		Возврат Истина;
	КонецЕсли;
	
	Если Не ПравоДоступа("Чтение", Метаданные.Справочники.УчетныеЗаписиЭлектроннойПочты) Тогда
		Возврат Ложь;
	КонецЕсли;
		
	ТекстЗапроса = 
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ ПЕРВЫЕ 1
	|	1 КАК Количество
	|ИЗ
	|	Справочник.УчетныеЗаписиЭлектроннойПочты КАК УчетныеЗаписиЭлектроннойПочты
	|ГДЕ
	|	НЕ УчетныеЗаписиЭлектроннойПочты.ПометкаУдаления
	|	И УчетныеЗаписиЭлектроннойПочты.ИспользоватьДляОтправки
	|	И УчетныеЗаписиЭлектроннойПочты.АдресЭлектроннойПочты <> """"
	|	И УчетныеЗаписиЭлектроннойПочты.СерверИсходящейПочты <> """"";
	
	Запрос = Новый Запрос(ТекстЗапроса);
	Выборка = Запрос.Выполнить().Выбрать();
	
	Возврат Выборка.Следующий();
	
КонецФункции

// Проверяет, настроена ли учетная запись для отправки и/или получения почты.
//
// Параметры:
//  УчетнаяЗапись - Справочники.УчетныеЗаписиЭлектроннойПочты - проверяемая учетная запись;
//  ДляОтправки  - Булево - проверять параметры, необходимые для отправки почты;
//  ДляПолучения - Булево - проверять параметры, необходимые для получения почты.
// 
// Возвращаемое значение:
//  Булево.
Функция УчетнаяЗаписьНастроена(УчетнаяЗапись, ДляОтправки = Истина, ДляПолучения = Истина) Экспорт
	Параметры = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(УчетнаяЗапись, "АдресЭлектроннойПочты,СерверВходящейПочты,СерверИсходящейПочты");
	Возврат Не (ПустаяСтрока(Параметры.АдресЭлектроннойПочты) 
		Или ДляПолучения И ПустаяСтрока(Параметры.СерверВходящейПочты)
		Или ДляОтправки И ПустаяСтрока(Параметры.СерверИсходящейПочты));
КонецФункции

#КонецОбласти
