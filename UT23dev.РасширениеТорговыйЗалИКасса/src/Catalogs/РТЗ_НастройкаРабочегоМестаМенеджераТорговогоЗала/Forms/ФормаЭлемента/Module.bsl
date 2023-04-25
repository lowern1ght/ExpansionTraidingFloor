
#Область ОбработчикиСобытийЭлементовТаблицыФормыДоступныеСклады

&НаКлиенте
Процедура ДоступныеСкладыОсновнойПриИзменении(Элемент)
	Основной = Элементы.ДоступныеСклады.ТекущаяСтрока;
	Если Основной Тогда
		Для каждого СтрокаТаблицы Из Объект.ДоступныеСклады Цикл
			Если СтрокаТаблицы.НомерСтроки = Элементы.ДоступныеСклады.ДанныеСтроки(Основной).НомерСтроки Тогда 
				Продолжить;
			КонецЕсли;
			
			Если СтрокаТаблицы.Основной Тогда
				СтрокаТаблицы.Основной = Ложь;
			КонецЕсли;
		КонецЦикла
	КонецЕсли;
КонецПроцедуры

#КонецОбласти
