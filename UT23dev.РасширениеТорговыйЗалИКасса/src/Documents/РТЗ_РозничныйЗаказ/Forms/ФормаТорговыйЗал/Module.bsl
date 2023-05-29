#Область ОбработчикиСобытийФормы

// При открытии.
// 
// Параметры:
//  Отказ - Булево - Отказ
&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	Если Не УспешноЗаполнитьНастройкамиТемриналаИВернутьСтатус() Тогда
		ОбщегоНазначенияКлиент.СообщитьПользователю("Ошибка при заполнении настроек, обратитесь в IT-отдел!");
		Отказ = Истина;
	КонецЕсли;
	
	АвтоЗаголовок = Ложь;
	Заголовок = ("Рабочее место менеджера торгового зала / " + "Терминал: <" + ПолучитьНаименоваиеТекущегоТерминала() + ">");
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаВыбора(ВыбранноеЗначение, ИсточникВыбора)
	
	Если ИсточникВыбора.ИмяФормы = "Обработка.ПодборТоваровВДокументПродажи.Форма.Форма" Тогда
		ОбработкаВыбораПодборТовара(ВыбранноеЗначение);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОформитьВозврат(Команда)
	ОформитьВозвратНаСервере();
КонецПроцедуры

// Сформировать.
&НаКлиенте
Процедура Сформировать()
	
	Если Объект.Корзина.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	Оповещение = Новый ОписаниеОповещения("ПослеЗакрытияВводаПароля", ЭтотОбъект);
	
	ОткрытьФорму("Документ.РТЗ_РозничныйЗаказ.Форма.ВводПароля",,,,,,
		Оповещение, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца)
		
КонецПроцедуры

&НаКлиенте
Процедура Подбор()
	
	ОткрытьФорму("Обработка.ПодборТоваровВДокументПродажи.Форма", 
				 ЗаполнитьПараметрыПодбораНаСервере(),
				 ЭтотОбъект, 
				 УникальныйИдентификатор);
				 
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Заполнить параметры подбора на сервере.
// 
// Возвращаемое значение:
//  Структура - Заполнить параметры подбора на сервере:
// * Дата - Дата -
// * Валюта - СправочникСсылка.Валюты -
// * ВидЦены - СправочникСсылка.ВидыЦен -
// * Документ - ДокументСсылка.РТЗ_РозничныйЗаказ -
// * Заголовок - Строка -
// * ЦенаВключаетНДС - Булево -
// * ЗапрашиватьКоличество - Булево -
// * СкрыватьРучныеСкидки - Булево -
// * ЗапрашиватьКоличество - Булево -
// * СкрыватьКолонкуВидЦены - Булево -
// * СкрыватьНастройкуПодбора - Булево -
// * ВозвращатьМногооборотнуюТару - Булево -
// * СкрыватьКнопкуЗапрашиватьКоличество - Булево -
// * РежимПодбораБезСоглашенийСКлиентами - Булево -
// * РежимПодбораИсключитьГруппыДоступныеВЗаказах - Булево -
// * РежимПодбораИспользоватьСкладыВТабличнойЧасти - Булево -
// * ОграничиватьВариантыОбеспечения - Булево -
// * ВариантОбеспеченияИФлагОбособленно - ПеречислениеСсылка.ВариантыОбеспечения -
// * Склад - Произвольный, СправочникСсылка.Склады -
// * НалогообложениеНДС - Произвольный, ПеречислениеСсылка.ТипыНалогообложенияНДС -
&НаСервере
Функция ЗаполнитьПараметрыПодбораНаСервере()
	
	ПараметрЗаголовок = НСтр("ru = 'Подбор товаров в розничный заказ'");
	
	Дата = ОбщегоНазначения.ТекущаяДатаПользователя();

	ПараметрыФормы = Новый Структура;
	
	ПараметрыФормы.Вставить("Дата", 										Дата);
	ПараметрыФормы.Вставить("Валюта", 										Валюта);
	ПараметрыФормы.Вставить("ВидЦены", 										ВидЦены);
	ПараметрыФормы.Вставить("Документ", 									Объект.Ссылка);
	ПараметрыФормы.Вставить("Заголовок", 									ПараметрЗаголовок);
	ПараметрыФормы.Вставить("ЦенаВключаетНДС", 								ЦенаВключаетНДС);
	ПараметрыФормы.Вставить("ЗапрашиватьКоличество", 						Истина);
	ПараметрыФормы.Вставить("СкрыватьРучныеСкидки",							Истина);
	ПараметрыФормы.Вставить("ЗапрашиватьКоличество", 						Истина);
	ПараметрыФормы.Вставить("СкрыватьКолонкуВидЦены", 						Истина);
	ПараметрыФормы.Вставить("СкрыватьНастройкуПодбора", 					Истина);
	ПараметрыФормы.Вставить("ВозвращатьМногооборотнуюТару", 				Истина);
	ПараметрыФормы.Вставить("СкрыватьКнопкуЗапрашиватьКоличество",        	Истина);
	ПараметрыФормы.Вставить("РежимПодбораБезСоглашенийСКлиентами ", 		Истина);
	ПараметрыФормы.Вставить("РежимПодбораИсключитьГруппыДоступныеВЗаказах", Истина);
	ПараметрыФормы.Вставить("РежимПодбораИспользоватьСкладыВТабличнойЧасти",Истина);
	
	ПараметрыФормы.Вставить("ОграничиватьВариантыОбеспечения", 				Истина);
	ПараметрыФормы.Вставить("ВариантОбеспеченияИФлагОбособленно", Перечисления.ВариантыОбеспечения.СоСклада);
	
	//Группу складов и розничное налогооблажение берем из константы
	ПараметрыФормы.Вставить("Склад", 				Константы.РТЗ_ГруппаСкладовПредприятия.Получить());
	ПараметрыФормы.Вставить("НалогообложениеНДС", 	Константы.РТЗ_ТерминалНалогооблажениеНДС.Получить());
	
	Возврат ПараметрыФормы;
	
КонецФункции

&НаСервере
Процедура ОбработкаВыбораПодборТовара(ВыбранноеЗначение)
	
	Если ЗначениеЗаполнено(ВыбранноеЗначение) Тогда
		ТаблицаТоваров = ПолучитьИзВременногоХранилища(ВыбранноеЗначение.АдресТоваровВХранилище);
		ЗаполнитьКорзинуПодобраннымТоваром(ТаблицаТоваров);
	КонецЕсли;
	
КонецПроцедуры

// Заполнить корзину подобранным товаром.
// 
// Параметры:
//  ТаблицаЗначнений - ТаблицаЗначений - таблица значений с подобранным товаром
&НаСервере
Процедура ЗаполнитьКорзинуПодобраннымТоваром(ТаблицаЗначнений = Неопределено)
	
	Если Не ЗначениеЗаполнено(ТаблицаЗначнений) Тогда
		Возврат;
	КонецЕсли;
	
	СписокСвойств = "Номенклатура,Упаковка,Склад,Количество";
	КопияКорзина = Объект.Корзина.Выгрузить();
	
	Для Каждого СтрокаТаблицы Из ТаблицаЗначнений Цикл
		
		ТекущаяСтрокаКорзины = КопияКорзина.Добавить();
		ЗаполнитьЗначенияСвойств(ТекущаяСтрокаКорзины, СтрокаТаблицы, СписокСвойств,"");
		
	КонецЦикла;

	КопияКорзина.Свернуть("Номенклатура,Упаковка,Склад", "Количество");
	Объект.Корзина.Загрузить(КопияКорзина);

КонецПроцедуры

&НаСервере
Функция УспешноЗаполнитьНастройкамиТемриналаИВернутьСтатус()
	
	Запрос = Новый Запрос;
	Запрос.Текст =
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ
		|	ВидыЦен.Ссылка,
		|	ВидыЦен.ВалютаЦены.Ссылка
		|ИЗ
		|	Справочник.ВидыЦен КАК ВидыЦен";
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
			ВидЦены = ВыборкаДетальныеЗаписи.Ссылка;
			ЦенаВключаетНДС = ВидЦены.ПолучитьОбъект().ЦенаВключаетНДС;
			Валюта = ВидЦены.ПолучитьОбъект().ВалютаЦены.ПолучитьОбъект().Ссылка;
	КонецЦикла;

	Возврат Истина;
	
КонецФункции

&НаСервере
Процедура ОформитьВозвратНаСервере()
	//TODO: Вставить содержимое обработчика
КонецПроцедуры

// Возвращает имя текущего пользоватя
// Возвращаемое значение:
//  - Строка
&НаСервере
Функция ПолучитьНаименоваиеТекущегоТерминала()
	
	Возврат ПользователиИнформационнойБазы.ТекущийПользователь().Имя;
	
КонецФункции

//Вызывается в случае успешных проверок и нахождения менеджера
// Параметры:
//  Менеджер - СправочникСсылка.Пользователи - ссылка на справочник пользователи
// Возвращаемое значение:
//  - ТабличныйДокумент
&НаСервере
Функция СформироватьНаСервере(Менеджер)
	
	ДокументЗаказа = Документы.РТЗ_РозничныйЗаказ.СоздатьДокумент();
	
	ДокументЗаказа.ВидЦены = ВидЦены;
	ДокументЗаказа.Менеджер = Менеджер;
	ДокументЗаказа.Корзина.Загрузить(Объект.Корзина.Выгрузить());
	
	ДокументЗаказа.Записать(РежимЗаписиДокумента.Проведение, РежимПроведенияДокумента.Оперативный);
	
	Возврат ДокументЗаказа.ПечататьЗаказСервер();
	
КонецФункции

// Обработка оповещения
// Параметры:
//  ПользовательСсылка - СправочникСсылка.Пользователи - Ссылка на менеджера
//  ДопПараметры - Неопределено
&НаКлиенте
Процедура ПослеЗакрытияВводаПароля(ПользовательСсылка, ДопПараметры = Неопределено) Экспорт
	
	Если Не ЗначениеЗаполнено(ПользовательСсылка) Тогда
		Возврат;
	КонецЕсли;
	
	СформироватьНаСервере(ПользовательСсылка).Показать("Заказ_"+ОбщегоНазначенияКлиент.ДатаСеанса());
	
	Объект.Корзина.Очистить();
	
КонецПроцедуры

#КонецОбласти
