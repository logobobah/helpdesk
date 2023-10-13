
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	ЭтоНовый = Объект.Ссылка.Пустая();
	
	Если ЭтоНовый Тогда
		Параметры.ПоказатьДиалогЗагрузкиИзФайлаПриОткрытии = Истина;
	КонецЕсли;

	УстановитьВидимостьДоступность();
	
	Если Не ВнешниеКомпонентыСлужебный.ДоступнаЗагрузкаССайта() Тогда 
		
		Элементы.ОбновлятьССайта.Видимость = Ложь;
		Элементы.ФормаОбновитьССайта.Видимость = Ложь;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	Если Параметры.ПоказатьДиалогЗагрузкиИзФайлаПриОткрытии Тогда
		ПодключитьОбработчикОжидания("ЗагрузитьКомпонентуИзФайла", 0.1, Истина);
	КонецЕсли
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	// Если вызвана команда "Перечитать" необходимо удалить буфер данных компоненты
	Если ЭтоАдресВременногоХранилища(АдресДвоичныхДанныхКомпоненты) Тогда
		УдалитьИзВременногоХранилища(АдресДвоичныхДанныхКомпоненты);
		АдресДвоичныхДанныхКомпоненты = Неопределено;
	КонецЕсли;
	
	УстановитьВидимостьДоступность();
	
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	// Если есть двоичные данные компоненты, которые надо сохранить, то помещаем их в ДополнительныеСвойства.
	Если ЭтоАдресВременногоХранилища(АдресДвоичныхДанныхКомпоненты) Тогда
		ДвоичныеДанныеКомпоненты = ПолучитьИзВременногоХранилища(АдресДвоичныхДанныхКомпоненты);
		ТекущийОбъект.ДополнительныеСвойства.Вставить("ДвоичныеДанныеКомпоненты", ДвоичныеДанныеКомпоненты);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)
	
	Если Не ПараметрыЗаписи.Свойство("ЗаписатьИЗакрыть") Тогда
		УстановитьВидимостьДоступность();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	
	Если ПараметрыЗаписи.Свойство("ЗаписатьИЗакрыть") Тогда
		ЗакрытьСПараметромЗакрытия();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ИспользованиеПриИзменении(Элемент)
	
	УстановитьВидимостьДоступность();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ЗаписатьИЗакрыть(Команда)
	
	ОчиститьСообщения();
	Записать(Новый Структура("ЗаписатьИЗакрыть"));
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьССайта(Команда)
	
	ОчиститьСообщения();
	ОбновитьКомпонентуССайта();
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьИзФайла(Команда)
	
	ОчиститьСообщения();
	ЗагрузитьКомпонентуИзФайла();
	
КонецПроцедуры

&НаКлиенте
Процедура СохранитьКак(Команда)
	
	Если ЭтоАдресВременногоХранилища(АдресДвоичныхДанныхКомпоненты) Тогда
		ПоказатьПредупреждение(, НСтр("ru = 'Перед сохранение компоненты в файл элемент справочника нужно записать.'"));
	Иначе 
		ОчиститьСообщения();
		ВнешниеКомпонентыСлужебныйКлиент.СохранитьКомпонентуВФайл(Объект.Ссылка);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Строит диалог загрузки компоненты из файла.
&НаКлиенте
Процедура ЗагрузитьКомпонентуИзФайла()
	
	Оповещение = Новый ОписаниеОповещения("ЗагрузитьКомпонентуПослеПредупрежденияБезопасности", ЭтотОбъект);
	ПараметрыФормы = Новый Структура("Ключ", "ПередДобавлениемВнешнейКомпоненты");
	ОткрытьФорму("ОбщаяФорма.ПредупреждениеБезопасности", ПараметрыФормы,,,,, Оповещение);
	
КонецПроцедуры

// Продолжение процедуры ЗагрузитьКомпонентуИзФайла.
&НаКлиенте
Процедура ЗагрузитьКомпонентуПослеПредупрежденияБезопасности(Ответ, Контекст) Экспорт
	
	// Ответ: 
	// - "Продолжить" - Загрузить.
	// - КодВозвратаДиалога.Отмена - Отклонить.
	// - Неопределено - Закрыто окно.
	Если Ответ <> "Продолжить" Тогда
		ЗагрузитьКомпонентуЗавершение(Контекст);
		Возврат;
	КонецЕсли;

	ПараметрыДиалога = Новый Структура;
	ПараметрыДиалога.Вставить("Режим",     РежимДиалогаВыбораФайла.Открытие);
	ПараметрыДиалога.Вставить("Заголовок", НСтр("ru = 'Выберите файл внешней компоненты'"));
	ПараметрыДиалога.Вставить("Фильтр",    НСтр("ru = 'Внешняя компонента (*.zip)|*.zip|Все файлы(*.*)|*.*'"));

	Оповещение = Новый ОписаниеОповещения("ЗагрузитьКомпонентуПослеПомещенияФайла", ЭтотОбъект, Контекст);
	СтандартныеПодсистемыКлиент.ПоказатьПомещениеФайла(Оповещение,
		УникальныйИдентификатор, Объект.ИмяФайла, ПараметрыДиалога);

КонецПроцедуры

// Продолжение процедуры ЗагрузитьКомпонентуИзФайла.
&НаКлиенте
Процедура ЗагрузитьКомпонентуПослеПомещенияФайла(ПомещенныеФайлы, Контекст) Экспорт
	
	Если ПомещенныеФайлы = Неопределено Или ПомещенныеФайлы.Количество() = 0 Тогда
		ЗагрузитьКомпонентуЗавершение(Контекст);
		Возврат;
	КонецЕсли;
	
	ОписаниеФайла = ПомещенныеФайлы[0];
	
	ПараметрыЗагрузки = Новый Структура;
	ПараметрыЗагрузки.Вставить("АдресХранилищаФайла", ОписаниеФайла.Хранение);
	ПараметрыЗагрузки.Вставить("ИмяФайла",            ТолькоИмяФайла(ОписаниеФайла.Имя));
	
	Результат = ЗагрузитьКомпонентуИзФайлаНаСервере(ПараметрыЗагрузки);
	Если Не Результат.Загружено
		Или Не ЭтоАдресВременногоХранилища(АдресДвоичныхДанныхКомпоненты)Тогда
		
		// Ошибка при загрузке.
		
		Оповещение = Новый ОписаниеОповещения("ЗагрузитьКомпонентуПослеОтображенияОшибки", ЭтотОбъект, Контекст);
		
		ПараметрыФормы = Новый Структура("ОписаниеОшибки", Результат.ОписаниеОшибки);
		ОткрытьФорму("Справочник.ВнешниеКомпоненты.Форма.ОшибкаЗагрузкиКомпоненты", ПараметрыФормы, ЭтотОбъект,
			УникальныйИдентификатор,,, Оповещение);
			
	Иначе
		
		// Успешно загружена.
		
		Если ПроверитьЗаполнение() Тогда
			ЗагрузитьКомпонентуЗавершение(Контекст);
		КонецЕсли;
	
	КонецЕсли;
	
КонецПроцедуры

// Продолжение процедуры ЗагрузитьКомпонентуИзФайла.
&НаКлиенте
Процедура ЗагрузитьКомпонентуПослеОтображенияОшибки(РезультатЗакрытия, Контекст) Экспорт 
	
	ЗагрузитьКомпонентуЗавершение(Контекст);
	
КонецПроцедуры

// Продолжение процедуры ЗагрузитьКомпонентуИзФайла.
&НаКлиенте
Процедура ЗагрузитьКомпонентуЗавершение(Контекст)
	
	Если Параметры.ПоказатьДиалогЗагрузкиИзФайлаПриОткрытии И Открыта() Тогда
		Закрыть();
	КонецЕсли;
	
КонецПроцедуры

// Выполняет обновление компоненты с сайта.
&НаКлиенте
Процедура ОбновитьКомпонентуССайта()
	
	ДлительнаяОперация = НачатьОбновлениеКомпонентыССайтаНаСервере();
	
	Если ДлительнаяОперация = Неопределено Тогда 
		Возврат;
	КонецЕсли;
	
	ПараметрыОжидания = ДлительныеОперацииКлиент.ПараметрыОжидания(ЭтотОбъект);
	ПараметрыОжидания.ТекстСообщения = НСтр("ru = 'Выполняется обновление внешней компоненты...'");
	ПараметрыОжидания.ВыводитьОкноОжидания = Истина;
	
	Оповещение = Новый ОписаниеОповещения("ОбновитьКомпонентуССайтаЗавершение", ЭтотОбъект);
	
	ДлительныеОперацииКлиент.ОжидатьЗавершение(ДлительнаяОперация, Оповещение, ПараметрыОжидания);
	
КонецПроцедуры

// Продолжение процедуры ОбновитьКомпонентуССайта.
&НаКлиенте
Процедура ОбновитьКомпонентуССайтаЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	// Ответ:
	// - Структура - Выполнено - результат в структуре.
	// - Неопределено - Отменено пользователем.
	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;
		
	Если Результат.Статус = "Ошибка" Тогда
		ПоказатьПредупреждение(, Результат.КраткоеПредставлениеОшибки);
	КонецЕсли;
	
	Если Результат.Статус = "Выполнено" Тогда 
		ЗавершитьОбновлениеКомпонентыССайтаНаСервере(Результат);
		ПоказатьОповещениеПользователя(НСтр("ru = 'Обновление с сайта'"),,
			НСтр("ru = 'Внешняя компонента успешно обновлена.'"), БиблиотекаКартинок.Успешно32);
	КонецЕсли;

КонецПроцедуры

/////////////////////////////////////////////////////////
// Серверная логика модели представления.

// Серверная логика процедуры ЗагрузитьКомпонентуИзФайла.
&НаСервере
Функция ЗагрузитьКомпонентуИзФайлаНаСервере(ПараметрыЗагрузки)
	
	Если Не Пользователи.ЭтоПолноправныйПользователь(,, Ложь) Тогда
		ВызватьИсключение НСтр("ru = 'Не достаточно прав для совершения операции.'");
	КонецЕсли;
	
	Зарегистрирована = Ложь;
	
	ОбъектСправочника = РеквизитФормыВЗначение("Объект");
	
	Информация = ВнешниеКомпонентыСлужебный.ИнформацияОКомпоненте(ПараметрыЗагрузки.АдресХранилищаФайла);
	
	Если Не Информация.Разобрано Тогда 
		Возврат Новый Структура("Загружено, ОписаниеОшибки", Ложь, Информация.ОписаниеОшибки);
	КонецЕсли;
	
	ЗаполнитьЗначенияСвойств(ОбъектСправочника, Информация.Реквизиты); // По данным манифеста.
	ОбъектСправочника.ИмяФайла =  ПараметрыЗагрузки.ИмяФайла;          // Установка имени файла.
	АдресДвоичныхДанныхКомпоненты = ПоместитьВоВременноеХранилище(Информация.ДвоичныеДанные,
		УникальныйИдентификатор);
		
	ЗначениеВРеквизитФормы(ОбъектСправочника, "Объект");
	
	Модифицированность = Истина;
	УстановитьВидимостьДоступность();
	
	Возврат Новый Структура("Загружено", Истина);
	
КонецФункции

// Серверная логика обновления компоненты с сайта.
&НаСервере
Функция НачатьОбновлениеКомпонентыССайтаНаСервере()
	
	Если Не ВнешниеКомпонентыСлужебный.ДоступнаЗагрузкаССайта() Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	ЭтоНовый = Объект.Ссылка.Пустая();
	Если ЭтоНовый Тогда 
		Возврат Неопределено;
	КонецЕсли;
	
	МассивСсылок = Новый Массив;
	МассивСсылок.Добавить(Объект.Ссылка);
	
	ПараметрыВыполнения = ДлительныеОперации.ПараметрыВыполненияВФоне(УникальныйИдентификатор);
	ПараметрыВыполнения.НаименованиеФоновогоЗадания = НСтр("ru = 'Обновление внешней компоненты.'");

	Возврат ДлительныеОперации.ВыполнитьВФоне("ВнешниеКомпонентыСлужебный.ОбновитьКомпонентыССайта",
		МассивСсылок, ПараметрыВыполнения);
	
КонецФункции

// Серверная логика обновления компоненты с сайта.
&НаСервере
Функция ЗавершитьОбновлениеКомпонентыССайтаНаСервере(Результат)
	
	// Обновление формы по новому значению объекта в ИБ.
	ЭтотОбъект.Прочитать();
	
	Модифицированность = Ложь;
	УстановитьВидимостьДоступность();
	
КонецФункции

/////////////////////////////////////////////////////////
// Представление данных на форме.

// Для внутреннего использования.
&НаСервере
Процедура УстановитьВидимостьДоступность()
	
	ЭтоНовый = Объект.Ссылка.Пустая();
	
	// Отображение описания ошибки.
	Элементы.ОшибкаКомпоненты.Видимость = Ложь;
	
	// Зависимость использования и автоматического обновления.
	КомпонентаОтключена = (Объект.Использование = Перечисления.ВариантыИспользованияВнешнихКомпонент.Отключена);
	Элементы.ОбновлятьССайта.Доступность = Не КомпонентаОтключена;
	
	// Параметры отображения предупреждений при редактировании
	ОтображатьПредупреждение = ОтображениеПредупрежденияПриРедактировании.Отображать;
	НеОтображатьПредупреждение = ОтображениеПредупрежденияПриРедактировании.НеОтображать;
	Если ЗначениеЗаполнено(Объект.Наименование) Тогда
		Элементы.Наименование.ОтображениеПредупрежденияПриРедактировании = ОтображатьПредупреждение;
	Иначе
		Элементы.Наименование.ОтображениеПредупрежденияПриРедактировании = НеОтображатьПредупреждение;
	КонецЕсли;
	Если ЗначениеЗаполнено(Объект.Идентификатор) Тогда 
		Элементы.Идентификатор.ОтображениеПредупрежденияПриРедактировании = ОтображатьПредупреждение;
	Иначе 
		Элементы.Идентификатор.ОтображениеПредупрежденияПриРедактировании = НеОтображатьПредупреждение;
	КонецЕсли;
	Если ЗначениеЗаполнено(Объект.Версия) Тогда 
		Элементы.Версия.ОтображениеПредупрежденияПриРедактировании = ОтображатьПредупреждение;
	Иначе 
		Элементы.Версия.ОтображениеПредупрежденияПриРедактировании = НеОтображатьПредупреждение;
	КонецЕсли;
	
	// Доступность кнопки Сохранить в файл
	Элементы.ФормаСохранитьКак.Доступность = Не ЭтоНовый;
	Элементы.ФормаОбновитьССайта.Доступность = Не ЭтоНовый;
	
КонецПроцедуры

/////////////////////////////////////////////////////////
// Прочее.

// Для внутреннего использования.
&НаКлиенте
Функция ЗакрытьСПараметромЗакрытия()
	
	ПараметрЗакрытия = Неопределено;
	
	Если Параметры.ВернутьРезультатЗагрузкиИзФайла Тогда 
		
		ПараметрЗакрытия = Новый Структура;
		ПараметрЗакрытия.Вставить("Идентификатор", Объект.Идентификатор);
		ПараметрЗакрытия.Вставить("Версия"       , Объект.Версия);
		ПараметрЗакрытия.Вставить("Наименование" , Объект.Наименование);
		
	КонецЕсли;
	
	Закрыть(ПараметрЗакрытия);
	
КонецФункции

// Для внутреннего использования.
&НаКлиенте
Функция ТолькоИмяФайла(ВыбранноеИмяФайла)
	
	// Использовать критично на клиенте, т.к. ПолучитьРазделительПути() на сервере может быть другим.
	МассивПодстрок = СтрРазделить(ВыбранноеИмяФайла, ПолучитьРазделительПути(), Ложь);
	Возврат МассивПодстрок.Получить(МассивПодстрок.ВГраница());
	
КонецФункции

#КонецОбласти