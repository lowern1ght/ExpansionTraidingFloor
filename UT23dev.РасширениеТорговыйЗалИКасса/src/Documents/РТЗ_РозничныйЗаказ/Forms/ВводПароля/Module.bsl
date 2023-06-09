
#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Готово()
	
	ПользовательСсылка = Неопределено;
	
	Если Не ПустаяСтрока(Пароль) Тогда
		ПользовательСсылка = РТЗ_НайтиКлиентаПоПаролю(Пароль);
		Если ПользовательСсылка = Неопределено Тогда
			#Если НЕ ВебКлиент Тогда
				Сигнал();
			#КонецЕсли
		КонецЕсли;
	КонецЕсли;
	
	Закрыть(ПользовательСсылка);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

//Находит пользователя по паролю в ИБ
// Параметры:
//  Пароль - Строка - содержит символьное представление от пользователя.
//
// Возвращаемое значение: 
//  - СправочникСсылка.Пользователи - ссылка на пользователя информационной базы.
//  - Неопределено
&НаСервере
Функция РТЗ_НайтиКлиентаПоПаролю(Пароль="")
	
	УстановитьПривилегированныйРежим(Истина);
	
	Если ПустаяСтрока(Пароль) Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	_Пользователи = ПользователиИнформационнойБазы.ПолучитьПользователей();
	Для Каждого _Пользователь Из _Пользователи Цикл
		Если Найти(_Пользователь.СохраняемоеЗначениеПароля, ПолучитьХешПароля(Пароль)) Тогда
			Возврат Справочники.Пользователи.НайтиПоНаименованию(_Пользователь.ПолноеИмя, Истина);
		КонецЕсли;
	КонецЦикла;

	Возврат Неопределено;
	
КонецФункции

&НаСервере
Функция ПолучитьХешПароля(_Пароль="")
	
	ХешированныеДанные = Новый ХешированиеДанных(ХешФункция.SHA1);
	ХешированныеДанные.Добавить(_Пароль);
	
	Возврат Base64Строка(ХешированныеДанные.ХешСумма);
	
КонецФункции

#КонецОбласти
