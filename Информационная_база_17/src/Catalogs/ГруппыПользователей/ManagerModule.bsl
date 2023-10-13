
//Возвращает массив пользователей
Функция ПолучитьПользователейГруппы(Группа) Экспорт
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	               |	СоставыГруппПользователей.Пользователь КАК Пользователь
	               |ИЗ
	               |	РегистрСведений.СоставыГруппПользователей КАК СоставыГруппПользователей
	               |ГДЕ
	               |	СоставыГруппПользователей.ГруппаПользователей = &ГруппаПользователей";
	Запрос.УстановитьПараметр("ГруппаПользователей", Группа);
	Возврат Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Пользователь");
КонецФункции