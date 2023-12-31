#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// Пропускаем инициализацию, чтобы гарантировать получение формы при передаче параметра "АвтоТест".
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	Если Объект.Ссылка.Пустая() Тогда
		
		ПараметрыОтбора = Новый Структура;
		
		Если Параметры.Свойство("Пользователь") И ЗначениеЗаполнено(Параметры.Пользователь) Тогда 
			Ответственный = Параметры.Пользователь;
		Иначе 
			Ответственный = ПользователиКлиентСервер.ТекущийПользователь();
		КонецЕсли;
		
		ПараметрыОтбора.Вставить("Пользователь", Ответственный); 
		НайденныеСтроки = Объект.ОтветственныеЗаОбработкуПисем.НайтиСтроки(ПараметрыОтбора);
		Если НайденныеСтроки.Количество() = 0 Тогда
			Строка = Объект.ОтветственныеЗаОбработкуПисем.Добавить();
			Строка.Пользователь = Ответственный;
		КонецЕсли;
		
		Объект.ИмяПользователя = Строка(Ответственный);
		
	КонецЕсли;
	
	ВидимостьНастроекПочтовогоКлиента =
		Не Объект.Ссылка.Пустая()
		И Объект.ВариантИспользования = Перечисления.ВариантыИспользованияПочты.Встроенная;
	
	Элементы.СтраницаПапки.Доступность = ВидимостьНастроекПочтовогоКлиента;
	
	ПредставлениеАдреса = ПолучитьПредставлениеАдреса(Объект);
	
	Если Объект.Ссылка.Пустая() Тогда
		Объект.ИспользоватьДляОтправки = Истина;
		Объект.ИспользоватьДляПолучения = Истина;
	Иначе
		
		Если Не ЗначениеЗаполнено(Объект.ПользовательSMTP) Тогда
			Объект.ПользовательSMTP = Объект.Пользователь;
		КонецЕсли;		
		
	КонецЕсли;
	
	УдалятьПисьмаССервера = Объект.ПериодХраненияСообщенийНаСервере > 0;
	Если Не УдалятьПисьмаССервера Тогда
		Объект.ПериодХраненияСообщенийНаСервере = 10;
	КонецЕсли;
	
	Если НЕ Объект.Ссылка.Пустая() Тогда
		
		УстановитьПривилегированныйРежим(Истина);
		Пароли = ОбщегоНазначения.ПрочитатьДанныеИзБезопасногоХранилища(Объект.Ссылка, "Пароль, ПарольSMTP");
		УстановитьПривилегированныйРежим(Ложь);
		
		Если Не ЗначениеЗаполнено(Объект.ПротоколВходящейПочты) Тогда
			Объект.ПротоколВходящейПочты = "POP";
			
			Если Не ЗначениеЗаполнено(Пароли.ПарольSMTP) Тогда
				Пароли.ПарольSMTP = Пароли.Пароль;
				УстановитьПривилегированныйРежим(Истина);
				ОбщегоНазначения.ЗаписатьДанныеВБезопасноеХранилище(Объект.Ссылка, Пароли.ПарольSMTP, "ПарольSMTP");
				УстановитьПривилегированныйРежим(Ложь);
			КонецЕсли;		
			
		КонецЕсли;	
		
		Пароль = ?(ЗначениеЗаполнено(Пароли.Пароль), ЭтотОбъект.УникальныйИдентификатор, "");
		ПарольSMTP = ?(ЗначениеЗаполнено(Пароли.ПарольSMTP), ЭтотОбъект.УникальныйИдентификатор, "");
	КонецЕсли;
	
	//ПротоколированиеРаботыПользователей.ЗаписатьОткрытие(Объект.Ссылка);
	
	ОбновитьСвойстваЭлементовФормы();
	
КонецПроцедуры

&НаСервере
Процедура ПриЗаписиНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	Если ПарольИзменен Тогда
		УстановитьПривилегированныйРежим(Истина);
		ОбщегоНазначения.ЗаписатьДанныеВБезопасноеХранилище(ТекущийОбъект.Ссылка, Пароль);
		УстановитьПривилегированныйРежим(Ложь);
	КонецЕсли;
	
	Если ПарольSMTPИзменен Тогда
		УстановитьПривилегированныйРежим(Истина);
		ОбщегоНазначения.ЗаписатьДанныеВБезопасноеХранилище(ТекущийОбъект.Ссылка, ПарольSMTP, "ПарольSMTP");
		УстановитьПривилегированныйРежим(Ложь);
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	ПараметрыЗаписи.Вставить("ЭтоНовыйОбъект", НЕ ЗначениеЗаполнено(ТекущийОбъект.Ссылка));
	
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)
	
	//ПротоколированиеРаботыПользователей.ЗаписатьСоздание(Объект.Ссылка, ПараметрыЗаписи.ЭтоНовыйОбъект);
	//ПротоколированиеРаботыПользователей.ЗаписатьИзменение(Объект.Ссылка);
	
	// Создание папок почты при необходимости
	Если Объект.ВариантИспользования = Перечисления.ВариантыИспользованияПочты.Встроенная Тогда
		Если Не ЗначениеЗаполнено(ПапкаВходящие) 
			И Не ЗначениеЗаполнено(ПапкаИсходящие) 
			И Не ЗначениеЗаполнено(ПапкаОтправленные) 
			И Не ЗначениеЗаполнено(ПапкаЧерновики) 
			И Не ЗначениеЗаполнено(ПапкаКорзина) Тогда
			
			УстановитьПривилегированныйРежим(Истина);
			
			// Создание корневой папки для учетной записи
			КорневаяПапка = Справочники.ПапкиПисем.СоздатьЭлемент();
			КорневаяПапка.ВидПапки = Перечисления.ВидыПапокПисем.Общая;
			КорневаяПапка.ВариантОтображенияКоличестваПисем =
				Справочники.ПапкиПисем.ПолучитьВариантОтображенияКоличестваПисемВПапкеПоУмолчанию(
					Перечисления.ВидыПапокПисем.Общая);
			КорневаяПапка.Наименование = Объект.Наименование;
			КорневаяПапка.Записать();
			
			// Сохранение сведений о принадлежности созданной папке к учетной записи
			РегистрыСведений.ПапкиУчетныхЗаписей.УстановитьПапку(
				Объект.Ссылка,
				КорневаяПапка.ВидПапки,
				КорневаяПапка.Ссылка);
			//СформироватьПраваДоступаКПапке(КорневаяПапка.Ссылка);
			
			// Создание предопределенных папок
			СоздатьПредопределеннуюПодпапку(КорневаяПапка.Ссылка, Перечисления.ВидыПапокПисем.Входящие);
			СоздатьПредопределеннуюПодпапку(КорневаяПапка.Ссылка, Перечисления.ВидыПапокПисем.Исходящие);
			СоздатьПредопределеннуюПодпапку(КорневаяПапка.Ссылка, Перечисления.ВидыПапокПисем.Отправленные);
			СоздатьПредопределеннуюПодпапку(КорневаяПапка.Ссылка, Перечисления.ВидыПапокПисем.Черновики);
			СоздатьПредопределеннуюПодпапку(КорневаяПапка.Ссылка, Перечисления.ВидыПапокПисем.Корзина);
			
			УстановитьПривилегированныйРежим(Ложь);
			
			// Перечитать информацию о папках
			ПолучитьПредопределенныеПапки(Объект.Ссылка);
			
		КонецЕсли;	
	КонецЕсли;	
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Функция СоздатьПредопределеннуюПодпапку(КорневаяПапка, ВидПапки)
	
	// Создание папки
	Папка = Справочники.ПапкиПисем.СоздатьЭлемент();
	Папка.Родитель = КорневаяПапка;
	Папка.ВидПапки = ВидПапки;
	Папка.ВариантОтображенияКоличестваПисем =
		Справочники.ПапкиПисем.ПолучитьВариантОтображенияКоличестваПисемВПапкеПоУмолчанию(ВидПапки);
	Папка.Наименование = Строка(ВидПапки);
	Папка.Записать();
	
	// Сохранение сведений о принадлежности созданной папке к учетной записи
	РегистрыСведений.ПапкиУчетныхЗаписей.УстановитьПапку(
		Объект.Ссылка,
		ВидПапки,
		Папка.Ссылка);
	
	Возврат Папка.Ссылка;
	
КонецФункции

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	ПолучитьПредопределенныеПапки(ТекущийОбъект);
	
	ОбновитьСвойстваЭлементовФормы();
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	
	Оповестить("УчетнаяЗаписьЭлектроннойПочтыСохранена", Объект.Ссылка);
	
	Если ПараметрыЗаписи.Свойство("ЗаписатьИЗакрыть") Тогда
		Закрыть();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	УстановитьДоступностьЭлементов();
КонецПроцедуры

&НаСервере
Процедура ПолучитьПредопределенныеПапки(ТекущийОбъект)
	
	ПапкаВходящие = РегистрыСведений.ПапкиУчетныхЗаписей.ПолучитьПапку(
		ТекущийОбъект.Ссылка,
		Перечисления.ВидыПапокПисем.Входящие);
	
	ПапкаИсходящие = РегистрыСведений.ПапкиУчетныхЗаписей.ПолучитьПапку(
		ТекущийОбъект.Ссылка,
		Перечисления.ВидыПапокПисем.Исходящие);
	
	ПапкаОтправленные = РегистрыСведений.ПапкиУчетныхЗаписей.ПолучитьПапку(
		ТекущийОбъект.Ссылка,
		Перечисления.ВидыПапокПисем.Отправленные);
	
	ПапкаЧерновики = РегистрыСведений.ПапкиУчетныхЗаписей.ПолучитьПапку(
		ТекущийОбъект.Ссылка,
		Перечисления.ВидыПапокПисем.Черновики);
	
	ПапкаКорзина = РегистрыСведений.ПапкиУчетныхЗаписей.ПолучитьПапку(
		ТекущийОбъект.Ссылка,
		Перечисления.ВидыПапокПисем.Корзина);
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьСвойстваЭлементовФормы()
	
	//Если Объект.ВариантИспользования = Перечисления.ВариантыИспользованияПочты.Встроенная Тогда
		Элементы.СтраницаПапки.Доступность = Истина;
	//Иначе
	//	Элементы.СтраницаПапки.Доступность = Ложь;
	//КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура АдресЭлектроннойПочтыПриИзменении(Элемент)
	
	Объект.АдресЭлектроннойПочты = СокрЛП(Объект.АдресЭлектроннойПочты);
	
	АдресИнфо = РаботаСоСтроками.РазложитьПредставлениеАдресаЭлектроннойПочты(Объект.АдресЭлектроннойПочты);
	НастройкиПочтовогоСервера = ПолучитьПредопределенныеНастройкиПочтовогоСервера(Объект.АдресЭлектроннойПочты);
	
	Если ЗначениеЗаполнено(НастройкиПочтовогоСервера) Тогда
		Если Не ЗначениеЗаполнено(Объект.СерверВходящейПочты)
			И НастройкиПочтовогоСервера.Свойство("СерверВходящейПочты")
			И ЗначениеЗаполнено(НастройкиПочтовогоСервера.СерверВходящейПочты) Тогда
			Объект.СерверВходящейПочты = НастройкиПочтовогоСервера.СерверВходящейПочты;
		КонецЕсли;
		Если Не ЗначениеЗаполнено(Объект.СерверИсходящейПочты)
			И НастройкиПочтовогоСервера.Свойство("СерверИсходящейПочты")
			И ЗначениеЗаполнено(НастройкиПочтовогоСервера.СерверИсходящейПочты) Тогда
			Объект.СерверИсходящейПочты= НастройкиПочтовогоСервера.СерверИсходящейПочты;
		КонецЕсли;
		Если Не ЗначениеЗаполнено(Объект.Пользователь)
			И НастройкиПочтовогоСервера.Свойство("Пользователь")
			И ЗначениеЗаполнено(НастройкиПочтовогоСервера.Пользователь) Тогда
			Объект.Пользователь = НастройкиПочтовогоСервера.Пользователь;
		КонецЕсли;
	Иначе
		Объект.Пользователь = АдресИнфо.Пользователь;
	КонецЕсли;
	
	Объект.Наименование = Объект.АдресЭлектроннойПочты;
	
	ОбновитьПредставлениеАдреса();
	
КонецПроцедуры

&НаКлиенте
Функция ПолучитьПредопределенныеНастройкиПочтовогоСервера(Адрес)
	
	АдресИнфо = РаботаСоСтроками.РазложитьПредставлениеАдресаЭлектроннойПочты(Адрес);
	
	Результат = Новый Структура;
	Если ВРег(АдресИнфо.Домен) = ВРег("mail.ru") Тогда
		Результат.Вставить("СерверВходящейПочты", "pop.mail.ru");
		Результат.Вставить("СерверИсходящейПочты", "smtp.mail.ru");
		Результат.Вставить("Пользователь", Адрес);
		Результат.Вставить("СпособPOP3Аутентификации", ПредопределенноеЗначение("Перечисление.СпособыPOP3Аутентификации.Обычная"));
		Результат.Вставить("SMTPАутентификация", ПредопределенноеЗначение("Перечисление.ВариантыSMTPАутентификации.АналогичноPOP3"));
	Иначе
		Возврат Неопределено;
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

&НаКлиенте
Процедура ИмяПользователяПриИзменении(Элемент)
	
	ОбновитьПредставлениеАдреса();
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьПредставлениеАдреса()
	
	ПредставлениеАдреса = ПолучитьПредставлениеАдреса(Объект);
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Функция ПолучитьПредставлениеАдреса(Объект)
		
	ПредставлениеАдреса = РаботаСоСтроками.ПолучитьПредставлениеАдресаЭлектроннойПочты(Объект.ИмяПользователя, Объект.АдресЭлектроннойПочты);
		
	Возврат ПредставлениеАдреса;
	
КонецФункции

&НаКлиенте
Процедура ВариантИспользованияПриИзменении(Элемент)
	
	ОбновитьСвойстваЭлементовФормы();
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗаписью(Отказ, ПараметрыЗаписи)
	
	ОбщегоНазначенияСУЗКлиент.УдалитьПустыеСтрокиТаблицы(Объект.ОтветственныеЗаОбработкуПисем, "Пользователь");
	
	Если Не УдалятьПисьмаССервера Тогда
		Объект.ПериодХраненияСообщенийНаСервере = 0;
	КонецЕсли;
	
	Если Объект.ПротоколВходящейПочты = "IMAP" Тогда
		Объект.ОставлятьКопииСообщенийНаСервере = Истина;
		Объект.ПериодХраненияСообщенийНаСервере = 0;
	КонецЕсли;
	
	// Проверка списка Ответственных на дубли
	Для каждого	Эл Из Объект.ОтветственныеЗаОбработкуПисем Цикл
		
		Для Индекс = Эл.НомерСтроки ПО Объект.ОтветственныеЗаОбработкуПисем.Количество() - 1 Цикл
			
			Если Эл.Пользователь = Объект.ОтветственныеЗаОбработкуПисем[Индекс].Пользователь Тогда
				
				ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
					НСтр("ru = 'Ответственный указан дважды.'"),
					,
					"Объект.ОтветственныеЗаОбработкуПисем[" + Индекс + "].Пользователь",
					,
					Отказ);

				Отказ = Истина;
				
			КонецЕсли;	
					
		КонецЦикла;
		
	КонецЦикла;	
	
КонецПроцедуры

&НаКлиенте
Процедура ПротоколПриИзменении(Элемент)
	
	Если Объект.ПротоколВходящейПочты = "IMAP" Тогда
		Если СтрНачинаетсяС(Объект.СерверВходящейПочты, "pop.") Тогда
			Объект.СерверВходящейПочты = "imap." + Сред(Объект.СерверВходящейПочты, 5);
		КонецЕсли
	Иначе
		Если ПустаяСтрока(Объект.ПротоколВходящейПочты) Тогда
			Объект.ПротоколВходящейПочты = "POP";
		КонецЕсли;
		Если СтрНачинаетсяС(Объект.СерверВходящейПочты, "imap.") Тогда
			Объект.СерверВходящейПочты = "pop." + Сред(Объект.СерверВходящейПочты, 6);
		КонецЕсли;
	КонецЕсли;
	
	УстановитьПортВходящейПочты();
	УстановитьДоступностьЭлементов();
КонецПроцедуры

&НаКлиенте
Процедура СерверВходящейПочтыПриИзменении(Элемент)
	Объект.СерверВходящейПочты = СокрЛП(НРег(Объект.СерверВходящейПочты));
КонецПроцедуры

&НаКлиенте
Процедура СерверИсходящейПочтыПриИзменении(Элемент)
	Объект.СерверИсходящейПочты = СокрЛП(НРег(Объект.СерверИсходящейПочты));
КонецПроцедуры

&НаКлиенте
Процедура ИспользоватьЗащищенноеСоединениеДляИсходящейПочтыПриИзменении(Элемент)
	УстановитьПортИсходящейПочты();
КонецПроцедуры

&НаКлиенте
Процедура ИспользоватьЗащищенноеСоединениеДляВходящейПочтыПриИзменении(Элемент)
	УстановитьПортВходящейПочты();
КонецПроцедуры

&НаКлиенте
Процедура ОставлятьКопииПисемНаСервереПриИзменении(Элемент)
	УстановитьДоступностьЭлементов();
КонецПроцедуры

&НаКлиенте
Процедура УдалятьПисьмаССервераПриИзменении(Элемент)
	УстановитьДоступностьЭлементов();
КонецПроцедуры

&НаКлиенте
Процедура ПарольДляПолученияПисемПриИзменении(Элемент)
	ПарольИзменен = Истина;
КонецПроцедуры

&НаКлиенте
Процедура ПарольДляОтправкиПисемПриИзменении(Элемент)
	ПарольSMTPИзменен = Истина;
КонецПроцедуры

&НаКлиенте
Процедура УстановитьПортВходящейПочты()
	Если Объект.ПротоколВходящейПочты = "IMAP" Тогда
		Если Объект.ИспользоватьЗащищенноеСоединениеДляВходящейПочты Тогда
			Объект.ПортСервераВходящейПочты = 993;
		Иначе
			Объект.ПортСервераВходящейПочты = 143;
		КонецЕсли;
	Иначе
		Если Объект.ИспользоватьЗащищенноеСоединениеДляВходящейПочты Тогда
			Объект.ПортСервераВходящейПочты = 995;
		Иначе
			Объект.ПортСервераВходящейПочты = 110;
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура УстановитьПортИсходящейПочты()
	Если Объект.ИспользоватьЗащищенноеСоединениеДляИсходящейПочты Тогда
		Объект.ПортСервераИсходящейПочты = 465;
	Иначе
		Объект.ПортСервераИсходящейПочты = 25;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытиемПодтверждениеПолучено(РезультатВопроса, ДополнительныеПараметры) Экспорт
	Записать(Новый Структура("ЗаписатьИЗакрыть"));
КонецПроцедуры

&НаКлиенте
Процедура УстановитьДоступностьЭлементов()
	
	ИспользуетсяПротоколPOP = Объект.ПротоколВходящейПочты = "POP";
	Элементы.POPПередSMTP.Видимость = ИспользуетсяПротоколPOP;
	Элементы.ОставлятьПисьмаНаСервере.Видимость = ИспользуетсяПротоколPOP;
	
	Элементы.НастройкаПериодаХраненияПисем.Доступность = Объект.ОставлятьКопииСообщенийНаСервере;
	Элементы.ПериодХраненияСообщенийНаСервере.Доступность = УдалятьПисьмаССервера;
	
	ИспользуетсяПротоколIMAP = Объект.ПротоколВходящейПочты = "IMAP";
	Элементы.СохранятьКопиюВОтправленные.Видимость = ИспользуетсяПротоколIMAP;
	
	Если Объект.ПротоколВходящейПочты = "IMAP" Тогда
		Объект.ОставлятьКопииСообщенийНаСервере = Истина;
		Объект.ПериодХраненияСообщенийНаСервере = 0;
	КонецЕсли;	
	
КонецПроцедуры

#КонецОбласти
