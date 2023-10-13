////////////////////////////////////////////////////////////////////////////////
// Подсистема "Работа с файлами".
//
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Переопределение настроек присоединенных файлов.
//
// Параметры:
//   Настройки - Структура - со свойствам:
//     * НеОчищатьФайлы - Массив - объекты, файлы которых не должны выводиться в настройках очистки файлов 
//                                 (например, служебные документы).
//     * НеСинхронизироватьФайлы - Массив - объекты, файлы которых не должны выводиться в настройках синхронизации 
//                                 с облачными сервисами (например, служебные документы).
//     * НеСоздаватьФайлыПоШаблону - Массив - объекты, для файлов которых отключена возможность создавать файлы 
//                                 по шаблонам.
//       
// Пример:
//       Настройки.НеОчищатьФайлы.Добавить(Метаданные.Справочники._ДемоПартнеры);
//       Настройки.НеСинхронизироватьФайлы.Добавить(Метаданные.Справочники._ДемоПартнеры);
//       Настройки.НеСоздаватьФайлыПоШаблону.Добавить(Метаданные.Справочники._ДемоПартнеры);
//       
Процедура ПриОпределенииНастроек(Настройки) Экспорт
	
КонецПроцедуры

// Позволяет переопределить справочники хранения файлов по типам владельцев.
// 
// Параметры:
//  ТипВладелецФайла  - Тип - тип ссылки объекта, к которому добавляется файл.
//
//  ИменаСправочников - Соответствие - содержит в ключах имена справочников.
//                      При вызове содержит стандартное имя одного справочника,
//                      помеченного, как основной (если существует).
//                      Основной справочник используется для интерактивного
//                      взаимодействия с пользователем. Чтобы указать основной
//                      справочник, нужно установить Истина в значение соответствия.
//                      Если установить Истина более одного раза, тогда будет ошибка.
//
Процедура ПриОпределенииСправочниковХраненияФайлов(ТипВладелецФайла, ИменаСправочников) Экспорт
	
КонецПроцедуры

// Позволяет отменить захват файла на основе анализа структуры с данными файла.
//
// Параметры:
//  ДанныеФайла    - Структура - с данными файла.
//  ОписаниеОшибки - Строка - содержащая текст ошибки в случае невозможности занять.
//                   Если не пустая, тогда файл невозможно занять.
//
Процедура ПриПопыткеЗанятьФайл(ДанныеФайла, ОписаниеОшибки = "") Экспорт
	
КонецПроцедуры

// Вызывается при создании файла. Например, может использоваться для обработки логически связанных данных,
// которые должны изменяться при создании новых файлов.
//
// Параметры:
//  Файл - СправочникСсылка.Файлы - ссылка на созданный файл.
//
Процедура ПриСозданииФайла(Файл) Экспорт
	
КонецПроцедуры

// Вызывается после копирования файла из исходного файла для заполнения таких реквизитов нового файла,
// которые не предусмотрены в БСП и были добавлены к справочнику Файлы или ВерсииФайлов в конфигурации.
//
// Параметры:
//  НовыйФайл    - СправочникСсылка.Файлы - ссылка на новый файл, который надо заполнить.
//  ИсходныйФайл - СправочникСсылка.Файлы - ссылка на исходный файл, откуда надо скопировать реквизиты.
//
Процедура ЗаполнитьРеквизитыФайлаИзИсходногоФайла(НовыйФайл, ИсходныйФайл) Экспорт
	
КонецПроцедуры

// Вызывается при захвате файла. Позволяет изменить структуру с данными файла перед захватом.
//
// Параметры:
//  ДанныеФайла - Структура - содержащая сведения о файле
//                см. функцию РаботаСФайламиСлужебныйВызовСервера.ПолучитьДанныеФайла().
//
//  УникальныйИдентификатор  - УникальныйИдентификатор - уникальный идентификатор формы.
//
Процедура ПриЗахватеФайла(ДанныеФайла, УникальныйИдентификатор) Экспорт
	
КонецПроцедуры

// Вызывается при освобождении файла. Позволяет изменить структуру с данными файла при освобождении.
//
// Параметры:
//  ДанныеФайла - Структура - содержащая сведения о файле
//                см. функцию РаботаСФайламиСлужебныйВызовСервера.ПолучитьДанныеФайла().
//
//  УникальныйИдентификатор -  - УникальныйИдентификатор - уникальный идентификатор формы.
//
Процедура ПриОсвобожденииФайла(ДанныеФайла, УникальныйИдентификатор) Экспорт
	
КонецПроцедуры

// Позволяет определить параметры штампов электронной подписи в подписанном
// табличном документе.
//
// Параметры:
//  ПараметрыШтампа - Структура - возвращаемый параметр, со свойствами:
//      * ТекстОтметки         - Строка - описание расположения подлинника подписанного документа.
//      * Логотип              - Картинка - логотип, который будет выведен в штампе.
//  Сертификат      - СертификатКриптографии - сертификат, по которому формируется штамп электронной подписи.
//
Процедура ПриПечатиФайлаСоШтампом(ПараметрыШтампа, Сертификат) Экспорт
	
КонецПроцедуры

#Область УстаревшиеПроцедурыИФункции

// Устарела. Следует использовать РаботаСФайламиПереопределяемый.ПриОпределенииНастроек().
//
// Формирует массив метаданных, которые не должны выводиться в настройках очистки файлов.
//
// Параметры:
//   МассивИсключений   - Массив - метаданные, которые не должны выводиться в настройках очистки файлов.
//
// Пример:
//   МассивИсключений.Добавить(Метаданные.Справочники.Файлы);
//
Процедура ПриОпределенииОбъектовИсключенияОчисткиФайлов(МассивИсключений) Экспорт
	
КонецПроцедуры

// Устарела. Следует использовать РаботаСФайламиПереопределяемый.ПриОпределенииНастроек().
//
// Формирует массив метаданных, которые не должны выводиться в настройках синхронизации файлов.
//
// Параметры:
//   МассивИсключений   - Массив - метаданные, которые не должны выводиться в настройках синхронизации файлов.
//
// Пример:
//   МассивИсключений.Добавить(Метаданные.Справочники.Файлы);
//
Процедура ПриОпределенииОбъектовИсключенияСинхронизацииФайлов(МассивИсключений) Экспорт
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

