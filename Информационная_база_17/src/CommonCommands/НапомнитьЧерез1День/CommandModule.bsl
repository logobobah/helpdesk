
#Область ОбработчикиСобытий

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	НапоминанияПользователяКлиент.НапомнитьВУказанноеВремя("Напомнить через 1 день", ТекущаяДата() + 86400, ПараметрКоманды);
	ПоказатьОповещениеПользователя(НСтр("ru = 'Напоминание.'"),,НСтр("ru = 'Установлено напоминание ""Напомнить через 1 день"".'"));
КонецПроцедуры

#КонецОбласти
