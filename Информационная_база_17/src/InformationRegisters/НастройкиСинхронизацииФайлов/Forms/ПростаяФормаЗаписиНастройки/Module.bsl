#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ИдентификаторВладельцаФайлов = Неопределено;
	
	Если Параметры.Свойство("ВладелецФайла") Тогда
		Запись.ВладелецФайла = Параметры.ВладелецФайла;
	КонецЕсли;
	
	Если Параметры.Свойство("ТипВладельцаФайла") Тогда
		Запись.ТипВладельцаФайла = Параметры.ТипВладельцаФайла;
	КонецЕсли;
	
	Если Параметры.Свойство("ЭтоФайл") Тогда
		Запись.ЭтоФайл = Параметры.ЭтоФайл;
	КонецЕсли;
	
	ПредставлениеВладельца = ОбщегоНазначения.ПредметСтрокой(Запись.ВладелецФайла);
	
	Заголовок = НСтр("ru='Настройка синхронизации файлов:'")
		+ " " + ПредставлениеВладельца;
	
КонецПроцедуры

#КонецОбласти