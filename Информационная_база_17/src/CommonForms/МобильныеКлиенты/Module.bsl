
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	// получаем данные необходимые для формирования строки подключения

	ПараметрыСинхронизации = 
		ОбменСМобильнымиСервер.ПолучитьПараметрыСинхронизации(Пользователи.ТекущийПользователь());

	УстановитьПривилегированныйРежим(Истина);

	ПользовательИБ = 
		ПользователиИнформационнойБазы.НайтиПоУникальномуИдентификатору(
			ОбщегоНазначения.ЗначениеРеквизитаОбъекта(
				Пользователи.ТекущийПользователь(), "ИдентификаторПользователяИБ"));

	АдресПодключения = СокрЛП(Константы.АдресПубликацииНаВебСервере.Получить());

	Если ПользовательИБ = Неопределено Тогда
		ИмяПользователя  = Строка(Пользователи.ТекущийПользователь());
		ПарольУстановлен = 1;
	Иначе
		ИмяПользователя  = ПользовательИБ.Имя;
		ПарольУстановлен = ?(ПользовательИБ.ПарольУстановлен, 1, 0);
	КонецЕсли;

	УстановитьПривилегированныйРежим(Ложь);

	ПодробныйПротокол = ?(ПараметрыСинхронизации.ПодробныйПротоколОбмена,1,0);
	СрокУстареванияДанных = ПараметрыСинхронизации.СрокУстареванияДанных;
	МаксимальныйРазмерФайла = ПараметрыСинхронизации.МаксимальныйРазмерФайла;

	// формируем ссылки на магазины и данные
	СсылкаApple   = "https://itunes.apple.com/ru/app/1s-dokumentooborot-2.1/id1119102464?mt=8";
	СсылкаGoogle  = "https://play.google.com/store/apps/details?id=com.e1c.mobiledocman21";
	СсылкаWindows = "https://www.microsoft.com/ru-ru/store/p/1%D0%A1-%D0%94%D0%BE%D0%BA%D1%83%D0%BC%D0%B5%D0%BD%D1%82%D0%BE%D0%BE%D0%B1%D0%BE%D1%80%D0%BE%D1%82-21/9nblggh4wrkz"; 

	ИспользуемаяОС = "Apple";

	СсылкаПараметры = СтрШаблон("%1;%2;%3;%4;%5;%6", 
		АдресПодключения, ИмяПользователя, ПарольУстановлен, 
		ПодробныйПротокол, СрокУстареванияДанных,  МаксимальныйРазмерФайла);

	// формируем QR-коды
	КодApple    = СформироватьQRКод(СсылкаApple);
	КодGoogle   = СформироватьQRКод(СсылкаGoogle);
	КодWindows  = СформироватьQRКод(СсылкаWindows);
	КодНастроек = СформироватьQRКод(СсылкаПараметры);

	Элементы.КнопкаНазад.Доступность = Ложь;

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ЗакрытьФорму(Команда)

	Закрыть(КодВозвратаДиалога.ОК);

КонецПроцедуры

&НаКлиенте
Процедура НастройкаСинхронизацииСМобильным(Команда)

	ОткрытьФорму("Обработка.НастройкаСинхронизацииСМобильнымКлиентом.Форма.НастройкаПравилСинхронизации");

КонецПроцедуры

&НаКлиенте
Процедура НастроитьУведомленияПоPush(Команда)
	
	//ОткрытьФорму("ОбщаяФорма.ПодпискиПользователя");
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовФормы

&НаКлиенте
Процедура Далее(Команда)

	Если Элементы.СтраницыМастераНастройки.ТекущаяСтраница = Элементы.СтраницаНастройкаНаСторонеСервера Тогда

	//	Элементы.СтраницыМастераНастройки.ТекущаяСтраница = Элементы.СтраницаЗагрузкаПриложения;
	//	Элементы.КнопкаНазад.Доступность = Истина;

	//ИначеЕсли Элементы.СтраницыМастераНастройки.ТекущаяСтраница = Элементы.СтраницаЗагрузкаПриложения Тогда
		Элементы.СтраницыМастераНастройки.ТекущаяСтраница = Элементы.СтраницаНастройкаПодключения;
		Элементы.ВариантыНижнейКомманднойПанели.ТекущаяСтраница = Элементы.ДляСтраницыТри;

	ИначеЕсли Элементы.СтраницыМастераНастройки.ТекущаяСтраница = Элементы.СтраницаНастройкаПодключения Тогда

	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура Назад(Команда)

	Если Элементы.СтраницыМастераНастройки.ТекущаяСтраница = Элементы.СтраницаНастройкаНаСторонеСервера Тогда
		

	ИначеЕсли Элементы.СтраницыМастераНастройки.ТекущаяСтраница = Элементы.СтраницаЗагрузкаПриложения Тогда
		Элементы.СтраницыМастераНастройки.ТекущаяСтраница = Элементы.СтраницаНастройкаНаСторонеСервера;
		Элементы.КнопкаНазад.Доступность = Ложь;

	ИначеЕсли Элементы.СтраницыМастераНастройки.ТекущаяСтраница = Элементы.СтраницаНастройкаПодключения Тогда
		//Элементы.СтраницыМастераНастройки.ТекущаяСтраница = Элементы.СтраницаЗагрузкаПриложения;
		//Элементы.ВариантыНижнейКомманднойПанели.ТекущаяСтраница = Элементы.ДляСтраницыОдинИДва;
		Элементы.СтраницыМастераНастройки.ТекущаяСтраница = Элементы.СтраницаНастройкаНаСторонеСервера;
		Элементы.КнопкаНазад.Доступность = Ложь;

	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ИспользуемаяОСПриИзменении(Элемент)

	Если ИспользуемаяОС = "Apple" Тогда
		Элементы.ВариантыQRКодовДляРазныхМагазинов.ТекущаяСтраница = Элементы.СтраницаApple;

	ИначеЕсли ИспользуемаяОС = "Google" Тогда
		Элементы.ВариантыQRКодовДляРазныхМагазинов.ТекущаяСтраница = Элементы.СтраницаGoogle;

	ИначеЕсли ИспользуемаяОС = "Microsoft" Тогда
		Элементы.ВариантыQRКодовДляРазныхМагазинов.ТекущаяСтраница = Элементы.СтраницаMicrosoft;

	КонецЕсли;

КонецПроцедуры


&НаКлиенте
Процедура QRКодAppleНажатие(Элемент, СтандартнаяОбработка)

	СтандартнаяОбработка = Ложь;
	ПерейтиПоНавигационнойСсылке(СсылкаApple);

КонецПроцедуры

&НаКлиенте
Процедура QRКодGoogleНажатие(Элемент, СтандартнаяОбработка)

	СтандартнаяОбработка = Ложь;

	ПерейтиПоНавигационнойСсылке(СсылкаGoogle);

КонецПроцедуры

&НаКлиенте
Процедура QRКодWindowsНажатие(Элемент, СтандартнаяОбработка)

	СтандартнаяОбработка = Ложь;

	ПерейтиПоНавигационнойСсылке(СсылкаWindows);

КонецПроцедуры

&НаКлиенте
Процедура ОтправитьНажатие(Элемент)

	// Получаем пользователя текущей записи
	Пользователь = ПользователиКлиентСервер.ТекущийПользователь();

	// Проверяем есть ли у пользователя учетные записи почты

	Если НЕ ЗначениеЗаполнено(АдресЭлектроннойПочты) Тогда
		ЗаголовоПредупреждения = НСтр("ru = 'Мобильные клиенты'");
		ТекстПредупреждения    = НСтр("ru = 'Необходимо указать e-mail'");
		ПоказатьПредупреждение(, ТекстПредупреждения,, ЗаголовоПредупреждения);
		Возврат;
	КонецЕсли;

	// Получаем содержимое письма
	ТемаПисьма = 
		НСтр("ru = 'Установите мобильный 1С:Система учета задач на смартфон или планшет'");

	ТекстСсылкиНаЭпл       = СтрШаблон(НСтр("ru = '<a href=""%1"">Apple AppStore</a>'"), СсылкаApple);
	ТекстСсылкиНаГугл      = СтрШаблон(НСтр("ru = '<a href=""%1"">Google Play</a>'"), СсылкаGoogle);
	ТекстСсылкиНаМикрософт = СтрШаблон(НСтр("ru = '<a href=""%1"">Microsoft Windows Phone Store</a>'"), СсылкаWindows);
	
	Описание = СтрШаблон(
		Нстр("ru = '<p>Перейдите в %1, если у Вас устройство под управлением iOS<p>
				   |<p>Перейдите в %2, если у Вас устройство под управлением Android<p>
				   |<p>Перейдите в %3, если у Вас устройство под управлением Windows<p>'"),
		ТекстСсылкиНаЭпл, ТекстСсылкиНаГугл, ТекстСсылкиНаМикрософт);

	// Настраиваем параметры отправки
	ПараметрыПисьма = Новый Структура;
	ПараметрыПисьма.Вставить("Тема", ТемаПисьма);
	ПараметрыПисьма.Вставить("Текст", Описание);
	ПараметрыПисьма.Вставить("Кому", АдресЭлектроннойПочты);
	ПараметрыПисьма.Вставить("ТипТекста", ПредопределенноеЗначение("Перечисление.ТипыТекстовПочтовыхСообщений.HTML"));

	// Выполняем отправку
	СообщениеОбОшибке = "";
	УведомлениеОтправлено = ЛегкаяПочтаСервер.ОтправитьИнтернетПочта(ПараметрыПисьма, , , СообщениеОбОшибке);

	// Сообщаем о результатах
	Если УведомлениеОтправлено Тогда
		 Состояние(НСтр("ru = 'Письмо с инструкциями по установке отправлено'"));
	Иначе
		ВызватьИсключение СообщениеОбОшибке;
	КонецЕсли;

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Функция СформироватьQRКод(ДанныеКода)

	ДанныеQRКода = УправлениеПечатью.ДанныеQRКода(ДанныеКода, 0, 250);

	Возврат ПоместитьВоВременноеХранилище(ДанныеQRКода, УникальныйИдентификатор);

КонецФункции

#КонецОбласти
