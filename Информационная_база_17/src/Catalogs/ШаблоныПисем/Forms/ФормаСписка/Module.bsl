#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ТекущийПользователь = ПользователиКлиентСервер.ТекущийПользователь();
	
	МассивГруппПользователей = ПользователиСерверПовтИсп.ПолучитьМассивГруппПользователя(ТекущийПользователь);
	МассивГруппПользователей.Добавить(ТекущийПользователь);
		
	Список.Параметры.УстановитьЗначениеПараметра("Пользователь", ТекущийПользователь);
	Список.Параметры.УстановитьЗначениеПараметра("МассивГруппПользователей", МассивГруппПользователей);
	
	НастройкиФормы = ОбщегоНазначенияВызовСервера.ХранилищеСистемныхНастроекЗагрузить(ИмяФормы + "/ТекущиеДанные", "");
	Если НастройкиФормы = Неопределено Или НастройкиФормы.Получить("ПоказыватьУдаленные") = Неопределено Тогда
		Элементы.ПоказыватьУдаленные.Пометка = ПоказыватьУдаленные;
		УстановитьОтбор();
	КонецЕсли;
	
	УстановитьУсловноеОформление();
	
	ИнициализироватьОтборы();
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	Если ИмяСобытия = "Запись_ШаблоныСообщений" Тогда
		ИнициализироватьОтборы();
		УстановитьФильтрНазначение(Назначение);
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ПриЗагрузкеДанныхИзНастроекНаСервере(Настройки)
	
	Если Настройки["ПоказыватьУдаленные"] <> Неопределено Тогда
		ПоказыватьУдаленные = Настройки["ПоказыватьУдаленные"];
		Элементы.ПоказыватьУдаленные.Пометка = ПоказыватьУдаленные;
		УстановитьОтбор();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура НазначениеФильтрПриИзменении(Элемент)
	УстановитьФильтрНазначение(Назначение);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыСписок

&НаСервереБезКонтекста
Процедура СписокПриПолученииДанныхНаСервере(ИмяЭлемента, Настройки, Строки)
	Запрос = Новый Запрос("ВЫБРАТЬ 
	  | ШаблоныСообщенийПечатныеФормыИВложения.Ссылка КАК Ссылка
      |ИЗ
      |	Справочник.ШаблоныПисем.ПечатныеФормыИВложения КАК ШаблоныСообщенийПечатныеФормыИВложения
	  |ГДЕ
	  | ШаблоныСообщенийПечатныеФормыИВложения.Ссылка В (&ШаблоныСообщений)
	  |СГРУППИРОВАТЬ ПО
	  | ШаблоныСообщенийПечатныеФормыИВложения.Ссылка");
	Запрос.УстановитьПараметр("ШаблоныСообщений", Строки.ПолучитьКлючи());
	Результат = Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Ссылка");
	Для каждого ШаблонСообщений Из Результат Цикл
		СтрокаСписка = Строки[ШаблонСообщений];
		СтрокаСписка.Данные["ЕстьФайлы"] = 1;
	КонецЦикла;	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Письмо(Команда)
	
	Если Элементы.Список.ТекущиеДанные = Неопределено Тогда 
		Возврат;
	КонецЕсли;
	
	ВстроеннаяПочтаКлиент.СоздатьПисьмоНаОсновании(Элементы.Список.ТекущаяСтрока);
	
КонецПроцедуры

&НаКлиенте
Процедура ПоказыватьУдаленные(Команда)
	
	ПоказыватьУдаленные = Не ПоказыватьУдаленные;
	Элементы.ПоказыватьУдаленные.Пометка = ПоказыватьУдаленные;
	УстановитьОтбор();
	
КонецПроцедуры

&НаСервере
Процедура УстановитьУсловноеОформление()
	
	Список.УсловноеОформление.Элементы.Очистить();
	Элемент = Список.УсловноеОформление.Элементы.Добавить();
	
	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Ссылка.ВладелецШаблона");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Заполнено;
	ОтборЭлемента.ПравоеЗначение = Истина;
	
	Элемент.Оформление.УстановитьЗначениеПараметра("ЦветТекста", ЦветаСтиля.ТекстЗапрещеннойЯчейкиЦвет);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура УстановитьФильтрНазначение(Знач ВыбранноеЗначение)
	
	Если ПустаяСтрока(ВыбранноеЗначение) Тогда
		ОбщегоНазначенияКлиентСервер.УдалитьЭлементыГруппыОтбора(Список.Отбор, "Назначение");
	Иначе
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбора(Список.Отбор, "Назначение", ВыбранноеЗначение, ВидСравненияКомпоновкиДанных.Равно);
	КонецЕсли;

КонецПроцедуры

&НаСервере
Процедура ИнициализироватьОтборы()
	
	Элементы.НазначениеФильтр.СписокВыбора.Очистить();
	
	Список.Параметры.УстановитьЗначениеПараметра("Назначение", "");
	
	Элементы.НазначениеФильтр.СписокВыбора.Добавить("", НСтр("ru = 'Все'"));
	
	ОбщийПредставление = НСтр("ru = 'Общий'");
	Список.Параметры.УстановитьЗначениеПараметра("Общий",    ОбщийПредставление);
	Элементы.НазначениеФильтр.СписокВыбора.Добавить("Общий", ОбщийПредставление);
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ
		|	ШаблоныСообщений.Назначение КАК Назначение
		|ИЗ
		|	Справочник.ШаблоныПисем КАК ШаблоныСообщений
		|ГДЕ
		|	ШаблоныСообщений.Назначение <> """" И ШаблоныСообщений.Назначение <> ""Служебный""
		|	И ШаблоныСообщений.Назначение <> &Общий
		|
		|СГРУППИРОВАТЬ ПО
		|	ШаблоныСообщений.Назначение
		|
		|УПОРЯДОЧИТЬ ПО
		|	Назначение";
	
	Запрос.УстановитьПараметр("Общий", ОбщийПредставление);
	РезультатЗапроса = Запрос.Выполнить().Выбрать();
	
	Пока РезультатЗапроса.Следующий() Цикл
		Элементы.НазначениеФильтр.СписокВыбора.Добавить(РезультатЗапроса.Назначение, РезультатЗапроса.Назначение);
	КонецЦикла;
	
	Назначение = "";
	
КонецПроцедуры

&НаСервере
Процедура УстановитьОтбор()
	
	Если Не ПоказыватьУдаленные Тогда
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
			Список, "ПометкаУдаления", Ложь,
			ВидСравненияКомпоновкиДанных.Равно, , Истина);
	Иначе
		ОбщегоНазначенияКлиентСервер.УдалитьЭлементыГруппыОтбораДинамическогоСписка(Список, "ПометкаУдаления");
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
