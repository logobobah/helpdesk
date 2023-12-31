
Функция ПолучитьОсновнойПроектЗаказчика(Заказчик) Экспорт
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	               |	Проекты.Ссылка КАК Проект
	               |ИЗ
	               |	Справочник.Проекты КАК Проекты
	               |ГДЕ
	               |	НЕ Проекты.ПометкаУдаления
	               |	И Проекты.ОсновнойЗаказчик = &Заказчик
	               |	И Проекты.Актуален";
	Запрос.УстановитьПараметр("Заказчик",Заказчик);
	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Количество() = 1 Тогда
		Выборка.Следующий();
		Возврат Выборка.Проект;
	КонецЕсли;
	Возврат Справочники.Проекты.ПустаяСсылка();
КонецФункции

Функция ПроектЗаказчикаПоНаименованию(Наименование, Заказчик) Экспорт
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	               |	Проекты.Ссылка КАК Проект
	               |ИЗ
	               |	Справочник.Проекты КАК Проекты
	               |ГДЕ
	               |	НЕ Проекты.ПометкаУдаления
	               |	И Проекты.Наименование = &Наименование
	               |	И Проекты.ОсновнойЗаказчик = &Заказчик
	               |	И Проекты.Актуален";
	Запрос.УстановитьПараметр("Наименование",Наименование);
	Запрос.УстановитьПараметр("Заказчик",Заказчик);
	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Количество() = 1 Тогда
		Выборка.Следующий();
		Возврат Выборка.Проект;
	КонецЕсли;
	Возврат Справочники.Проекты.ПустаяСсылка();
КонецФункции
