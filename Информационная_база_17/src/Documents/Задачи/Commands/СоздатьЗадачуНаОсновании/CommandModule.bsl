
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	ПараметрыФормы = Новый Структура();
	ПараметрыФормы.Вставить("Основание", ПараметрКоманды);
	
	Открытьформу("Документ.Задачи.ФормаОбъекта", ПараметрыФормы, ПараметрыВыполненияКоманды.Источник);
	
КонецПроцедуры
