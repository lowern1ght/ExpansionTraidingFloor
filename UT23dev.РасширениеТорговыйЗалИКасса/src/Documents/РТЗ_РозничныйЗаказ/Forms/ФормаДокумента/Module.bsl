
#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Печать()
	//@skip-check use-non-recommended-method
	ПолучитьТабличныйДокументОтСервера(Объект.Ссылка)
		.Показать("Заказ_"+ТекущаяДата());
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Функция ПолучитьТабличныйДокументОтСервера(ДокументЗаказа)
	Возврат ДокументЗаказа.ПолучитьОбъект().ПечататьЗаказСервер();
КонецФункции

#КонецОбласти