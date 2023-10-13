/////////////////////////////////////////////////////////////////////////////////////////
// ПРОВЕРКА ТИПОВ ЗНАЧЕНИЙ

// Проверка. Значение является входящим или исходящим письмом.
//
Функция ЭтоПисьмо(Значение) Экспорт
	
	Возврат ЭтоВходящееПисьмо(Значение) Или ЭтоИсходящееПисьмо(Значение);
	
КонецФункции

// Проверка. Значение является входящим письмом.
//
Функция ЭтоВходящееПисьмо(Значение) Экспорт
	
	#Если Сервер Тогда
		Возврат ТипЗнч(Значение) = Тип("ДокументСсылка.ВходящееПисьмо")
			Или ТипЗнч(Значение) = Тип("ДокументОбъект.ВходящееПисьмо");
	#Иначе
		Возврат ТипЗнч(Значение) = Тип("ДокументСсылка.ВходящееПисьмо");
	#КонецЕсли
	
КонецФункции

// Проверка. Значение является исходящим письмом.
//
Функция ЭтоИсходящееПисьмо(Значение) Экспорт
	
	#Если Сервер Тогда
		Возврат ТипЗнч(Значение) = Тип("ДокументСсылка.ИсходящееПисьмо")
			Или ТипЗнч(Значение) = Тип("ДокументОбъект.ИсходящееПисьмо");
	#Иначе
		Возврат ТипЗнч(Значение) = Тип("ДокументСсылка.ИсходящееПисьмо");
	#КонецЕсли
	
КонецФункции

// Проверка. Значение является папкой писем.
//
Функция ЭтоПапкаПисем(Значение) Экспорт
	
	Возврат (ТипЗнч(Значение) = Тип("СправочникСсылка.ПапкиПисем"));
	
КонецФункции

// Возвращает подпись к числу писем с учетом склонений русского
// языка.
Функция ПодписьКЧислуПисемСтрокой(ЧислоПисем) Экспорт
	
	Если ЧислоПисем <= 20 Тогда
		
		Если ЧислоПисем = 1 Тогда
			Возврат НСтр("ru = 'письмо'");
		ИначеЕсли ЧислоПисем = 2 Или ЧислоПисем = 3 Или ЧислоПисем = 4 Тогда
			Возврат НСтр("ru = 'письма'");
		Иначе
			Возврат НСтр("ru = 'писем'");
		КонецЕсли;
		
	Иначе
		
		ПоследняяЦифра = ЧислоПисем % 10;
		
		Если ПоследняяЦифра = 1 Тогда
			Возврат НСтр("ru = 'письмо'");
		ИначеЕсли ПоследняяЦифра = 2 Или ПоследняяЦифра = 3 Или ПоследняяЦифра = 4 Тогда
			Возврат НСтр("ru = 'письма'");
		Иначе
			Возврат НСтр("ru = 'писем'");
		КонецЕсли;
		
	КонецЕсли;
	
	Возврат НСтр("ru = 'писем'");
	
КонецФункции

// Возвращает подпись к числу задач с учетом склонений русского
// языка.
Функция ПодписьКЧислуЗадачСтрокой(ЧислоПисем) Экспорт
	
	ПоследняяЦифра = ЧислоПисем % 10;
	Если ЧислоПисем = 12 Или ЧислоПисем = 13 Или ЧислоПисем = 14 Тогда
		Возврат НСтр("ru = 'задач'");
	ИначеЕсли ПоследняяЦифра = 1 Тогда
		Возврат НСтр("ru = 'задача'");
	ИначеЕсли ПоследняяЦифра = 2 Или ПоследняяЦифра = 3 Или ПоследняяЦифра = 4 Тогда
		Возврат НСтр("ru = 'задачи'");
	КонецЕсли;
	
	Возврат НСтр("ru = 'задач'");
	
КонецФункции

// Возвращает подпись к числу предметов с учетом склонений русского языка.
// ПримерВызова: ПодписьКЧислу(Количество, НСтр("ru = 'задача'"), НСтр("ru = 'задачи'"), НСтр("ru = 'задач'"));
//
Функция ПодписьКЧислу(Число, Предмет, Предмета, Предметов) Экспорт
	
	ЧислоПоМодулю100 = Число % 100;
	ЧислоПоМодулю10 = Число % 10;
	Если ЧислоПоМодулю10 = 1 Тогда
		Если ЧислоПоМодулю100 = 11 Тогда
			Возврат Предметов;
		Иначе
			Возврат Предмет;
		КонецЕсли;
	ИначеЕсли ЧислоПоМодулю10 = 2 Или ЧислоПоМодулю10 = 3 Или ЧислоПоМодулю10 = 4 Тогда
		Если ЧислоПоМодулю100 = 12 Или ЧислоПоМодулю100 = 13 Или ЧислоПоМодулю100 = 14 Тогда
			Возврат Предметов;
		Иначе
			Возврат Предмета;
		КонецЕсли;
	Иначе
		Возврат Предметов;
	КонецЕсли;
	
КонецФункции

// Выделить представление (вида "Адресат") из строки вида "Адресат <adress@mail.ru>"
Функция ВыделитьПредставление(ПредставлениеИАдрес) Экспорт
	
	Представление = "";
	
	Поз = Найти(ПредставлениеИАдрес, "<");
	Если Поз <> 0 Тогда
		Представление = Лев(ПредставлениеИАдрес, Поз - 1);
	Иначе	
		Представление = ПредставлениеИАдрес;
	КонецЕсли;
	
	Представление = СокрЛП(Представление);
	
	Возврат Представление;
	
КонецФункции	

// Выделить домен из email адреса
Функция ПолучитьДомен(АдресЭП) Экспорт
	
	Домен = "";

	Поз = Найти(АдресЭП, "@");
	Если Поз <> 0 Тогда
		Домен = Сред(АдресЭП, Поз);
	КонецЕсли;
	
	Возврат Домен;

КонецФункции		

// Кодирует символы " ", ПС, "?", "&", "%"
Функция ЗакодироватьСсылкуMailto(СсылкаMailto) Экспорт
	
	ЗакодированнаяСсылкаMailto = СсылкаMailto;
	
	ЗакодированнаяСсылкаMailto = СтрЗаменить(ЗакодированнаяСсылкаMailto, "%", "%25");
	
	ЗакодированнаяСсылкаMailto = СтрЗаменить(ЗакодированнаяСсылкаMailto, Символы.ПС, "%0D%0A");
	ЗакодированнаяСсылкаMailto = СтрЗаменить(ЗакодированнаяСсылкаMailto, " ", "%20");
	ЗакодированнаяСсылкаMailto = СтрЗаменить(ЗакодированнаяСсылкаMailto, "?", "%3F");
	ЗакодированнаяСсылкаMailto = СтрЗаменить(ЗакодированнаяСсылкаMailto, "&", "%26");
	ЗакодированнаяСсылкаMailto = СтрЗаменить(ЗакодированнаяСсылкаMailto, """", "%22");
	ЗакодированнаяСсылкаMailto = СтрЗаменить(ЗакодированнаяСсылкаMailto, "<", "%3C");
	ЗакодированнаяСсылкаMailto = СтрЗаменить(ЗакодированнаяСсылкаMailto, ">", "%3E");
	
	Возврат ЗакодированнаяСсылкаMailto;
	
КонецФункции

// Раскодирует символы " ", ПС, "?", "&", "%"
Функция РаскодироватьСсылкуMailto(СсылкаMailto) Экспорт
	
	РаскодированнаяСсылкаMailto = СсылкаMailto;
	
	РаскодированнаяСсылкаMailto = СтрЗаменить(РаскодированнаяСсылкаMailto, "%0D%0A", Символы.ПС);
	РаскодированнаяСсылкаMailto = СтрЗаменить(РаскодированнаяСсылкаMailto, "%0A", Символы.ПС);
	РаскодированнаяСсылкаMailto = СтрЗаменить(РаскодированнаяСсылкаMailto, "%20", " ");
	РаскодированнаяСсылкаMailto = СтрЗаменить(РаскодированнаяСсылкаMailto, "%3F", "?");
	РаскодированнаяСсылкаMailto = СтрЗаменить(РаскодированнаяСсылкаMailto, "%26", "&");
	РаскодированнаяСсылкаMailto = СтрЗаменить(РаскодированнаяСсылкаMailto, "%22", """");
	РаскодированнаяСсылкаMailto = СтрЗаменить(РаскодированнаяСсылкаMailto, "%3C", "<");
	РаскодированнаяСсылкаMailto = СтрЗаменить(РаскодированнаяСсылкаMailto, "%3E", ">");
	
	РаскодированнаяСсылкаMailto = СтрЗаменить(РаскодированнаяСсылкаMailto, "%25", "%");
	
	Возврат РаскодированнаяСсылкаMailto;
	
КонецФункции

// Формирует ссылку mailto
Функция СформироватьСсылкуMailto(
	Кому = "",
	Копия = "",
	СкрытаяКопия = "",
	ТемаПисьма = "",
	ТекстПисьма = "",
	ТипТекста = Неопределено,
	Представление = "") Экспорт
	
	Если ТипТекста = Неопределено Тогда
		ПредопределенноеЗначение("Перечисление.ТипыТекстовПочтовыхСообщений.HTML")
	КонецЕсли;
	
	СсылкаMailto = "";
	НачатоЗаполнениеПараметров = Ложь;
	
	ДобавитьПараметрКСсылкеMailto(СсылкаMailto, "to", Кому, НачатоЗаполнениеПараметров);
	ДобавитьПараметрКСсылкеMailto(СсылкаMailto, "cc", Копия, НачатоЗаполнениеПараметров);
	ДобавитьПараметрКСсылкеMailto(СсылкаMailto, "bcc", СкрытаяКопия, НачатоЗаполнениеПараметров);
	ДобавитьПараметрКСсылкеMailto(СсылкаMailto, "subject", ТемаПисьма, НачатоЗаполнениеПараметров);
	ДобавитьПараметрКСсылкеMailto(СсылкаMailto, "body", ТекстПисьма, НачатоЗаполнениеПараметров);
	
	Если Не ПустаяСтрока(СсылкаMailto) Тогда
		
		Если ТипТекста = ПредопределенноеЗначение("Перечисление.ТипыТекстовПочтовыхСообщений.HTML") Тогда
			
			Если ПустаяСтрока(Представление) Тогда
				Представление = СсылкаMailto;
			КонецЕсли;
			
			СсылкаMailto = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				"<a href=""mailto:%1"">%2</a>", 
				СсылкаMailto,
				Представление);
			
		Иначе
			
			СсылкаMailto = "mailto:" + СсылкаMailto;
			
		КонецЕсли;
		
	КонецЕсли;
	
	Возврат СсылкаMailto;
	
КонецФункции

// Дописывает в ссылку новый параметр, если значение параметра заполнено
Процедура ДобавитьПараметрКСсылкеMailto(СсылкаMailto, НазваниеПараметра, ЗначениеПараметра, НачатоЗаполнениеПараметров)
	
	Если ПустаяСтрока(ЗначениеПараметра) Тогда
		Возврат;
	КонецЕсли;
	
	ЗначениеПараметра = ВстроеннаяПочтаКлиентСервер.ЗакодироватьСсылкуMailto(ЗначениеПараметра);
	
	Если НазваниеПараметра = "to" Тогда
		
		СсылкаMailto = СсылкаMailto + ЗначениеПараметра;
		Возврат;
		
	КонецЕсли;
	
	Если НачатоЗаполнениеПараметров Тогда
		
		СимволРазделитель = "&";
		
	Иначе
		
		СимволРазделитель = "?";
		НачатоЗаполнениеПараметров = Истина;
		
	КонецЕсли;
	
	СсылкаMailto = СсылкаMailto + СимволРазделитель + НазваниеПараметра + "=" + ЗначениеПараметра;
	
	Возврат;
	
КонецПроцедуры

// Функция возвращает массив символов, которые используются в качестве разделителей слов адреса.
Функция ПолучитьРазделителиСловПочтовогоАдреса() Экспорт
	
	РазделителиСлов = Новый Массив;
	РазделителиСлов.Добавить(" ");
	РазделителиСлов.Добавить(",");
	РазделителиСлов.Добавить(":");
	РазделителиСлов.Добавить(";");
	РазделителиСлов.Добавить("~");
	РазделителиСлов.Добавить("!");
	РазделителиСлов.Добавить("#");
	РазделителиСлов.Добавить("%");
	РазделителиСлов.Добавить("^");
	РазделителиСлов.Добавить("&");
	РазделителиСлов.Добавить("*");
	РазделителиСлов.Добавить("(");
	РазделителиСлов.Добавить(")");
	РазделителиСлов.Добавить("+");
	РазделителиСлов.Добавить("=");
	РазделителиСлов.Добавить("/");
	РазделителиСлов.Добавить("\");
	РазделителиСлов.Добавить("|");
	РазделителиСлов.Добавить("[");
	РазделителиСлов.Добавить("]");
	РазделителиСлов.Добавить("{");
	РазделителиСлов.Добавить("}");
	РазделителиСлов.Добавить("?");
	РазделителиСлов.Добавить("'");
	РазделителиСлов.Добавить("""");
	РазделителиСлов.Добавить("«");
	РазделителиСлов.Добавить("»");
	РазделителиСлов.Добавить("<");
	РазделителиСлов.Добавить(">");
	РазделителиСлов.Добавить("№");
	РазделителиСлов.Добавить(Символы.ВК);
	РазделителиСлов.Добавить(Символы.Таб);
	РазделителиСлов.Добавить(Символы.ПС);

	Возврат РазделителиСлов;
	
КонецФункции

// Функция разбивает переданную строку на отдельные слова
Функция СтрокуПочтовогоАдресаВСлова(Знач СтрокаАдреса,РазделителиСлов = Неопределено) Экспорт 
	
	Если ТипЗнч(РазделителиСлов) <> Тип("Массив") Тогда
		РазделителиСлов = ПолучитьРазделителиСловПочтовогоАдреса();
	КонецЕсли;
	
	СтрокаАдреса = СтрЗаменить(СтрокаАдреса, "ё", "е");
	СтрокаАдреса = СтрЗаменить(СтрокаАдреса, "Ё", "Е");
	
	СловаАдреса = Новый Массив;
	
	ДлинаСтр = СтрДлина(СтрокаАдреса);
	НачалоСлова = 0;
	ДлинаСлова = 0;
	Для Счетчик = 1 По ДлинаСтр Цикл
		
		ТекущийСимвол = Сред(СтрокаАдреса,Счетчик,1);
		
		Если РазделителиСлов.Найти(ТекущийСимвол) <> Неопределено Тогда
			
			Если НачалоСлова > 0 и ДлинаСлова > 0 Тогда
				
				Слово = Сред(СтрокаАдреса,НачалоСлова,ДлинаСлова);
				СловаАдреса.Добавить(Слово);
				
			КонецЕсли;
			
			ДлинаСлова = 0;
			НачалоСлова = 0;
			
		Иначе
			
			Если НачалоСлова = 0 Тогда
				НачалоСлова = Счетчик;
			КонецЕсли;
			
			ДлинаСлова = ДлинаСлова + 1;
			
		КонецЕсли;
		
	КонецЦикла;
	
	Если НачалоСлова > 0 и ДлинаСлова > 0 Тогда
		
		Слово = Сред(СтрокаАдреса,НачалоСлова,Счетчик-1);
		СловаАдреса.Добавить(Слово);
		
	КонецЕсли;
	
	Возврат СловаАдреса;
	
КонецФункции

// Функция разбивает переданную строку на структуры (слово и его позиция)
Функция СтрокуПочтовогоАдресаВСтруктурыСлов(Знач СтрокаАдреса,РазделителиСлов = Неопределено) Экспорт 
	
	Если ТипЗнч(РазделителиСлов) <> Тип("Массив") Тогда
		РазделителиСлов = ПолучитьРазделителиСловПочтовогоАдреса();
	КонецЕсли;
	
	СтрокаАдреса = СтрЗаменить(СтрокаАдреса, "ё", "е");
	СтрокаАдреса = СтрЗаменить(СтрокаАдреса, "Ё", "Е");
	
	СловаАдреса = Новый Массив;
	
	ДлинаСтр = СтрДлина(СтрокаАдреса);
	НачалоСлова = 0;
	ДлинаСлова = 0;
	Для Счетчик = 1 По ДлинаСтр Цикл
		
		ТекущийСимвол = Сред(СтрокаАдреса,Счетчик,1);
		
		Если РазделителиСлов.Найти(ТекущийСимвол) <> Неопределено Тогда
			
			Если НачалоСлова > 0 и ДлинаСлова > 0 Тогда
				
				Слово = Сред(СтрокаАдреса,НачалоСлова,ДлинаСлова);
				СловаАдреса.Добавить(Новый Структура("Слово, Позиция", Слово, НачалоСлова));
				
			КонецЕсли;
			
			ДлинаСлова = 0;
			НачалоСлова = 0;
			
		Иначе
			
			Если НачалоСлова = 0 Тогда
				НачалоСлова = Счетчик;
			КонецЕсли;
			
			ДлинаСлова = ДлинаСлова + 1;
			
		КонецЕсли;
		
	КонецЦикла;
	
	Если НачалоСлова > 0 и ДлинаСлова > 0 Тогда
		
		Слово = Сред(СтрокаАдреса,НачалоСлова,Счетчик-1);
		СловаАдреса.Добавить(Новый Структура("Слово, Позиция", Слово, НачалоСлова));
		
	КонецЕсли;
	
	Возврат СловаАдреса;
	
КонецФункции

// Возвращает стандартный шрифт программы для почты
//
// Параметры:
//  Имя параметра - Список типов - Текстовое описание параметра
//
// Возвращаемое значение:
//  Шрифт - Шрифт Microsoft Sans Serif, размер 10
Функция ПолучитьШрифтПочтыПоУмолчанию() Экспорт
	
	Возврат Новый Шрифт("Arial", 10);
	
КонецФункции

// Возвращает Истина, если адресатов много
Функция ЭтоРассылка(ЧислоАдресатов) Экспорт
	
	Если ЧислоАдресатов > 50 Тогда
		Возврат Истина;
	КонецЕсли;	
	
	Возврат Ложь;
	
КонецФункции	