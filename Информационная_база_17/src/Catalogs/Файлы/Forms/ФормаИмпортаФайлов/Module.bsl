////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ФОРМЫ

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// Пропускаем инициализацию, чтобы гарантировать получение формы при передаче параметра "АвтоТест".
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	Если НЕ Параметры.Свойство("ПапкаДляДобавления") Тогда 	
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru = 'Данная обработка вызывается из других процедур конфигурации. Вручную ее вызывать запрещено.'")); 
		Отказ = Истина;
		Возврат;
	КонецЕсли;
	
	//Если Параметры.Свойство("Проект") Тогда 	
	//	Проект = Параметры.Проект;
	//КонецЕсли;
	
	Если Параметры.ПапкаДляДобавления <> Неопределено Тогда
		ВладелецФайлов = Параметры.ПапкаДляДобавления;
		Если ТипЗнч(ВладелецФайлов) = Тип("СправочникСсылка.ПапкиФайлов") Тогда
			ПапкаДляДобавления = ВладелецФайлов;
		Иначе
			Элементы.ПапкаДляДобавления.Видимость = Ложь;
		КонецЕсли;	
	КонецЕсли;
	
	Если Параметры.МассивИменФайлов <> Неопределено Тогда
		Для Каждого ПутьФайла Из Параметры.МассивИменФайлов Цикл
			ФайлПеренесенный = Новый Файл(ПутьФайла);
			НовыйЭлемент = ВыбранныеФайлы.Добавить();
			НовыйЭлемент.Путь = ПутьФайла;
			НовыйЭлемент.Наименование = ФайлПеренесенный.Имя;
			НовыйЭлемент.ИндексКартинки = ФайловыеФункцииКлиентСервер.ПолучитьИндексПиктограммыФайла(ФайлПеренесенный.Расширение);
			ЧислоФайлов = ЧислоФайлов + 1;
			
			//Если ДелопроизводствоКлиентСервер.ЭтоРасширениеСканКопии(ФайлПеренесенный.Расширение) Тогда 
			//	НовыйЭлемент.Оригинал = Истина;
			//КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	
	Заголовок = СформироватьЗаголовок(ЧислоФайлов);
	
	//ИспользоватьРаспознавание = РаботаСФайламиВызовСервера.ПолучитьИспользоватьРаспознавание();
	//Элементы.ГруппаРаспознавание.Видимость = ИспользоватьРаспознавание;
	//Если ИспользоватьРаспознавание = Ложь Тогда
		СтратегияРаспознавания = Перечисления.СтратегииРаспознаванияТекста.НеРаспознавать;
	//Иначе
	//	ЯзыкРаспознавания = ОбщегоНазначения.ХранилищеОбщихНастроекЗагрузить("Распознавание", "ЯзыкРаспознавания");
	//	Если НЕ ЗначениеЗаполнено(ЯзыкРаспознавания) Тогда
	//		ЯзыкРаспознавания = РаботаСФайламиВызовСервера.ПолучитьЯзыкРаспознавания();
	//	КонецЕсли;
	//	
	//	СтратегияРаспознавания = Перечисления.СтратегииРаспознаванияТекста.ПоместитьТолькоВТекстовыйОбраз;
	//	ПредставлениеНастроекРаспознавания = РаботаСФайламиВызовСервера.ПолучитьПредставлениеНастроекРаспознавания(СтратегияРаспознавания, ЯзыкРаспознавания);
	//	Команды.Настройка.Подсказка = ПредставлениеНастроекРаспознавания;
	//	
	//КонецЕсли;	
	
	//ИспользоватьКатегории = ПолучитьФункциональнуюОпцию("ИспользоватьКатегорииДанных");
	//
	//Если НЕ ИспользоватьКатегории Тогда
	//	Элементы.ГруппаКатегории.Видимость = Ложь;
	//Иначе
	//	Если Параметры.Свойство("СписокКатегорий")
	//		И Параметры.СписокКатегорий <> Неопределено Тогда
	//		Для Каждого КатегорияВСписке Из Параметры.СписокКатегорий Цикл
	//			НоваяСтрока = СписокКатегорий.Добавить();
	//			НоваяСтрока.Значение = КатегорияВСписке;
	//			НоваяСтрока.ПолноеНаименование = РаботаСКатегориямиДанных.ПолучитьПолныйПутьКатегорииДанных(КатегорияВСписке);
	//		КонецЦикла;
	//	КонецЕсли;
	//КонецЕсли;
	//
	//ВестиУчетСканКопийОригиналовДокументов = 
	//	ПолучитьФункциональнуюОпцию("ВестиУчетСканКопийОригиналовДокументов");
	//Если Не ДелопроизводствоКлиентСервер.ЭтоДокумент(ВладелецФайлов) 
	//	Или Не ВестиУчетСканКопийОригиналовДокументов Тогда 
	//	Элементы.Оригинал.Видимость = Ложь;
	//	Элементы.ВыбранныеФайлы.Шапка = Ложь;
	//КонецЕсли;	
	
	//Программная загрузка файлов
	Если Параметры.Свойство("НеОткрыватьФорму") Тогда 	
		НеОткрыватьФорму = Параметры.НеОткрыватьФорму;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	ХранитьВерсии = Истина;
	//Программная загрузка файлов
	Если НеОткрыватьФорму Тогда
		Отказ =Истина;
		УдалятьФайлыПослеДобавления = Ложь;
		ДобавитьВыполнить();
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаВыбора(ВыбранноеЗначение, ИсточникВыбора)
	Если ВРег(ИсточникВыбора.ИмяФормы) = ВРег("Справочник.Файлы.Форма.ВыборКодировки") Тогда
		Если ТипЗнч(ВыбранноеЗначение) <> Тип("Структура") Тогда
			Возврат;
		КонецЕсли;
		КодировкаТекстаФайла = ВыбранноеЗначение.Значение;
		КодировкаПредставление = ВыбранноеЗначение.Представление;
		УстановитьПредставлениеКомандыКодировки(КодировкаПредставление);
	КонецЕсли;
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ЭЛЕМЕНТОВ ФОРМЫ

&НаКлиенте
Процедура ВыбранныеФайлыПередНачаломДобавления(Элемент, Отказ, Копирование)
	Отказ = Истина;
КонецПроцедуры

&НаКлиенте
Процедура ОригиналПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.ВыбранныеФайлы.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда 
		Возврат;
	КонецЕсли;	
	
	Расширение = ФайловыеФункцииКлиентСервер.ПолучитьРасширениеИмениФайла(ТекущиеДанные.Путь);
	
	Если ТекущиеДанные.Оригинал Тогда 
		Если Не ДелопроизводствоКлиентСервер.ЭтоРасширениеСканКопии(Расширение) Тогда 
			ТекстВопроса = НСтр("ru = 'Выбранный файл, возможно, не является скан-копией. 
			|Вы действительно хотите отметить его как оригинал?'");
			
			ПараметрыВыполнения = Новый Структура;
			ПараметрыВыполнения.Вставить("ТекущаяСтрока", Элементы.ВыбранныеФайлы.ТекущаяСтрока);
			
			Обработчик = Новый ОписаниеОповещения("ПослеВопросаПроОригинал", ЭтотОбъект, ПараметрыВыполнения);
			ПоказатьВопрос(Обработчик, ТекстВопроса, РежимДиалогаВопрос.ДаНет,,КодВозвратаДиалога.Нет, 
				НСтр("ru = 'Отметка оригинала'"));
		КонецЕсли;	
	КонецЕсли;	
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеВопросаПроОригинал(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат <> КодВозвратаДиалога.Да Тогда
		
		ТекущиеДанные = ВыбранныеФайлы.НайтиПоИдентификатору(ДополнительныеПараметры.ТекущаяСтрока);
		ТекущиеДанные.Оригинал = Не ТекущиеДанные.Оригинал;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПапкаДляДобавленияПриИзменении(Элемент)
	
	ВладелецФайлов = ПапкаДляДобавления;	
	
КонецПроцедуры

&НаКлиенте
Процедура СписокКатегорийПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа, Параметр)
	
	Отказ = Истина;
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ КОМАНД ФОРМЫ

&НаКлиенте
Процедура НастройкиРаспознавания(Команда)
	
	ПараметрыОткрытия = Новый Структура("СтратегияРаспознавания, ЯзыкРаспознавания", СтратегияРаспознавания, ЯзыкРаспознавания);	
	РежимОткрытия = РежимОткрытияОкнаФормы.БлокироватьВесьИнтерфейс;
	Обработчик = Новый ОписаниеОповещения("ПослеВыбораНастроекРаспознавания", ЭтотОбъект);
	ОткрытьФорму("Справочник.Файлы.Форма.НастройкаРаспознавания", ПараметрыОткрытия, ЭтаФорма,,,,Обработчик, РежимОткрытия);
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеВыбораНастроекРаспознавания(РезультатОткрытия, ДополнительныеПараметры) Экспорт
	
	Если ТипЗнч(РезультатОткрытия) = Тип("Структура") Тогда
		СтратегияРаспознавания = РезультатОткрытия.СтратегияРаспознавания;
		ЯзыкРаспознавания = РезультатОткрытия.ЯзыкРаспознавания;
		УстановитьПредставлениеНастроекРаспознавания(СтратегияРаспознавания, ЯзыкРаспознавания);
	КонецЕсли;	
	
КонецПроцедуры

&НаСервере
Процедура УстановитьПредставлениеНастроекРаспознавания(СтратегияРаспознавания, ЯзыкРаспознавания)
	
	ПредставлениеНастроекРаспознавания = РаботаСФайламиВызовСервера.ПолучитьПредставлениеНастроекРаспознавания(СтратегияРаспознавания, ЯзыкРаспознавания);
	Команды.Настройка.Подсказка = ПредставлениеНастроекРаспознавания;
	
КонецПроцедуры

&НаКлиенте
Процедура ВыбратьКодировку(Команда)
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("ТекущаяКодировка", КодировкаТекстаФайла);
	ОткрытьФорму("Справочник.Файлы.Форма.ВыборКодировки", ПараметрыФормы, ЭтаФорма);
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ

&НаСервере
Процедура УстановитьПредставлениеКомандыКодировки(Представление)
	
	Команды.ВыбратьКодировку.Заголовок = Представление;
	
КонецПроцедуры

&НаКлиенте
Процедура ДобавитьВыполнить()
	
	ОчиститьСообщения();
	
	ПоляНеЗаполнены = Ложь;
	
	Если ВыбранныеФайлы.Количество() = 0 Тогда
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru = 'Нет файлов для добавления.'"), , "ВыбранныеФайлы");
		ПоляНеЗаполнены = Истина;
	КонецЕсли;
	
	ВладелецФайловДляДобавления = ВладелецФайлов;
	Если ТипЗнч(ВладелецФайлов) = Тип("СправочникСсылка.ПапкиФайлов") Тогда
		ВладелецФайловДляДобавления = ПапкаДляДобавления;
	КонецЕсли;	

	Если НЕ ЗначениеЗаполнено(ВладелецФайловДляДобавления) Тогда
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru = 'Не выбрана папка.'"), , "ПапкаДляДобавления");
		ПоляНеЗаполнены = Истина;
	КонецЕсли;
	
	Если ПоляНеЗаполнены = Истина Тогда
		Возврат;
	КонецЕсли;
	
	ВыбранныеФайлыСписокЗначений = Новый СписокЗначений;
	Для Каждого СтрокаСписка Из ВыбранныеФайлы Цикл
		ВыбранныеФайлыСписокЗначений.Добавить(СтрокаСписка.Путь);
	КонецЦикла;
	
	#Если ВебКлиент Тогда
		
		МассивОпераций = Новый Массив;
		
		Для Каждого СтрокаСписка Из ВыбранныеФайлы Цикл
			ОписаниеВызова = Новый Массив;
			ОписаниеВызова.Добавить("ПоместитьФайлы");
			
			ПомещаемыеФайлы = Новый Массив;
			Описание = Новый ОписаниеПередаваемогоФайла(СтрокаСписка.Путь, "");
			ПомещаемыеФайлы.Добавить(Описание);
			ОписаниеВызова.Добавить(ПомещаемыеФайлы);
			
			ОписаниеВызова.Добавить(Неопределено);  // не используется
			ОписаниеВызова.Добавить(Неопределено);  // не используется
			ОписаниеВызова.Добавить(Ложь); 			// Интерактивно = Ложь
			
			МассивОпераций.Добавить(ОписаниеВызова);
		КонецЦикла;
		
		Если НЕ ЗапроситьРазрешениеПользователя(МассивОпераций) Тогда
			// пользователь не дал разрешения
			Закрыть();
			Возврат;
		КонецЕсли;	
	#КонецЕсли	
	
	ДобавленныеФайлы = Новый Массив;
	ПараметрыРаспознавания = Новый Структура("СтратегияРаспознавания, ЯзыкРаспознавания", 
		СтратегияРаспознавания, ЯзыкРаспознавания);
		
	ПараметрыОбработчика = Новый Структура;
	ПараметрыОбработчика.Вставить("ДобавленныеФайлы", ДобавленныеФайлы);
	ПараметрыОбработчика.Вставить("ВладелецФайловДляДобавления", ВладелецФайловДляДобавления);
	Обработчик = Новый ОписаниеОповещения("ДобавитьВыполнитьПослеИмпортаФайлов", ЭтотОбъект, ПараметрыОбработчика);
	
	ПараметрыВыполнения = РаботаСФайламиКлиент.ПараметрыИмпортаФайлов();
	ПараметрыВыполнения.ОбработчикРезультата = Обработчик;
	ПараметрыВыполнения.Владелец = ВладелецФайловДляДобавления;
	ПараметрыВыполнения.ВыбранныеФайлы = ВыбранныеФайлыСписокЗначений; 
	ПараметрыВыполнения.Комментарий = Комментарий;
	ПараметрыВыполнения.ХранитьВерсии = ХранитьВерсии;
	ПараметрыВыполнения.УдалятьФайлыПослеДобавления = УдалятьФайлыПослеДобавления;
	ПараметрыВыполнения.Рекурсивно = Ложь;
	ПараметрыВыполнения.ИдентификаторФормы = УникальныйИдентификатор;
	ПараметрыВыполнения.ДобавленныеФайлы = ДобавленныеФайлы;
	ПараметрыВыполнения.Кодировка = КодировкаТекстаФайла;
	//ПараметрыВыполнения.ПараметрыРаспознавания = ПараметрыРаспознавания;
	//ПараметрыВыполнения.СписокКатегорий = СписокКатегорий;
	//ПараметрыВыполнения.Проект = Проект;
	
	РаботаСФайламиКлиент.ВыполнитьИмпортФайлов(ПараметрыВыполнения);
	
КонецПроцедуры

&НаКлиенте
Процедура ДобавитьВыполнитьПослеИмпортаФайлов(Результат, ПараметрыВыполнения) Экспорт
	
	Закрыть();
	
	ПараметрКоманды = Неопределено;
	Если Результат.ДобавленныеФайлы.Количество() > 0 Тогда
		Индекс = Результат.ДобавленныеФайлы.Количество() - 1;
		ПараметрКоманды = Результат.ДобавленныеФайлы[Индекс].ФайлСсылка;
	КонецЕсли;
	
	МассивСсылокФайлов = Новый Массив;
	Для Каждого ОписаниеФайла Из Результат.ДобавленныеФайлы Цикл
		МассивСсылокФайлов.Добавить(ОписаниеФайла.ФайлСсылка);
	КонецЦикла;	
	
	СтруктураВозврата = Новый Структура("МассивСсылокФайлов, ВладелецФайлов",
		МассивСсылокФайлов, ВладелецФайлов);
	
	Оповестить("ИмпортФайловЗавершен", ПараметрКоманды, СтруктураВозврата);
	
КонецПроцедуры

&НаКлиенте
Процедура ВыбратьФайлыВыполнить()
	
	Обработчик = Новый ОписаниеОповещения("ВыбратьФайлыВыполнитьПослеУстановкиРасширения", ЭтотОбъект);
	ФайловыеФункцииСлужебныйКлиент.ПоказатьВопросОбУстановкеРасширенияРаботыСФайлами(Обработчик);
	
КонецПроцедуры	

&НаКлиенте
Процедура ВыбратьФайлыВыполнитьПослеУстановкиРасширения(РасширениеУстановлено, ПараметрыВыполнения) Экспорт
	
	Если Не РасширениеУстановлено Тогда
		ФайловыеФункцииСлужебныйКлиент.ПоказатьПредупреждениеОНеобходимостиРасширенияРаботыСФайлами(Неопределено);
		Возврат;
	КонецЕсли;
	
	Режим = РежимДиалогаВыбораФайла.Открытие;
	
	ДиалогОткрытияФайла = Новый ДиалогВыбораФайла(Режим);
	ДиалогОткрытияФайла.ПолноеИмяФайла = "";
	Фильтр = НСтр("ru = 'Все файлы(*.*)|*.*'");
	ДиалогОткрытияФайла.Фильтр = Фильтр;
	ДиалогОткрытияФайла.МножественныйВыбор = Истина;
	ДиалогОткрытияФайла.Заголовок = НСтр("ru = 'Выберите файлы'");
	Если ДиалогОткрытияФайла.Выбрать() Тогда
		
		МассивФайлов = ДиалогОткрытияФайла.ВыбранныеФайлы;
		Для Каждого ИмяФайла Из МассивФайлов Цикл
			ФайлПеренесенный = Новый Файл(ИмяФайла);
			НовыйЭлемент = ВыбранныеФайлы.Добавить();
			НовыйЭлемент.Путь = ИмяФайла;
			НовыйЭлемент.Наименование = ФайлПеренесенный.Имя;
			НовыйЭлемент.ИндексКартинки = ФайловыеФункцииКлиентСервер.ПолучитьИндексПиктограммыФайла(ФайлПеренесенный.Расширение);
			ЧислоФайлов = ЧислоФайлов + 1;
			
			Если ДелопроизводствоКлиентСервер.ЭтоРасширениеСканКопии(ФайлПеренесенный.Расширение) Тогда 
				НовыйЭлемент.Оригинал = Истина;
			КонецЕсли;
		КонецЦикла;
		
		Заголовок = СформироватьЗаголовок(ЧислоФайлов);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ВыбранныеФайлыПослеУдаления(Элемент)
	
	ЧислоФайлов = ЧислоФайлов - 1;
	Заголовок = СформироватьЗаголовок(ЧислоФайлов);
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Функция СформироватьЗаголовок(ЧислоФайлов)
	
	ЗаголовокФормы = "";
	
	Если ЧислоФайлов = 0 Тогда
		ЗаголовокФормы = НСтр("ru='Загрузка файлов'");
	Иначе
		ЗаголовокФормы = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru='Загрузка файлов (%1)'"), Строка(ЧислоФайлов));
	КонецЕсли;	
		
	Возврат ЗаголовокФормы;
	
КонецФункции

&НаКлиенте
Процедура ПоказыватьПолныйПутьПриИзменении(Элемент)
	Элементы.ВыбранныеФайлыПуть.Видимость = ПоказыватьПолныйПуть;
	Элементы.ВыбранныеФайлыНаименование.Видимость = Не ПоказыватьПолныйПуть; 
КонецПроцедуры
