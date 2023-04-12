
#Область ОбработчикиСобытийФормы

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	Если Не ПустаяСтрока(Пароль) Тогда
		Менеджер = РТЗ_НайтиКлиентаПоПаролю(Пароль);
		Закрыть(Менеджер);
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Готово()	
	Закрыть();
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

//Находит пользователя по паролю в ИБ
// Параметры:
//  Пароль - Строка - содержит символьное представление от пользователя.
//
// Возвращаемое значение: 
//  - СправочникСсылка.Пользователи - ссылка на пользователя информационной базы.
//  - Неопределено - если не найден пользователь по паролю.
&НаСервере
Функция РТЗ_НайтиКлиентаПоПаролю(Пароль="")
	Если ПустаяСтрока(Пароль) Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	_Пользователи = ПользователиИнформационнойБазы.ПолучитьПользователей();
	Для Каждого _Пользователь Из _Пользователи Цикл
		Если Найти(_Пользователь.СохраняемоеЗначениеПароля, ПолучитьХешПароля(Пароль)) Тогда
			Возврат Справочники.Пользователи.ПолучитьСсылку(_Пользователь.УникальныйИдентификатор);
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
