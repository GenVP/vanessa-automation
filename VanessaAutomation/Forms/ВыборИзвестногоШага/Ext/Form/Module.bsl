﻿
#Область ОписаниеПеременных

&НаКлиенте
Перем Ванесса;

#КонецОбласти

#Область ОбработкаСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ТаблицаИзвестныхStepDefinition.Загрузить(Параметры.ТаблицаИзвестныхStepDefinition.Выгрузить());
	
	ЯзыкГенератораGherkin = Параметры.ЯзыкГенератораGherkin;
	Элементы.ПоказатьШагиНаРусском.Видимость = (ЯзыкГенератораGherkin <> "ru");
	
	КаталогИнструментов   = Параметры.КаталогИнструментов;
	МакетШаблонПеревода   = Параметры.МакетШаблонПеревода;
	ДвоичныеДанныеФайлПеревода = ЗначениеВСтрокуВнутр(Параметры.ДвоичныеДанныеФайлПеревода);
	ПараметрСнипет = Параметры.Снипет;
	
	Для Каждого СтрокаТаблицаУжеСуществующихСценариев Из Параметры.ТаблицаУжеСуществующихСценариев Цикл
		СтрокаТаблицаИзвестныхStepDefinition = ТаблицаИзвестныхStepDefinition.Добавить();
		
		СтрокаТаблицаИзвестныхStepDefinition.ИмяФайла           = СтрокаТаблицаУжеСуществующихСценариев.ИмяФайла;
		СтрокаТаблицаИзвестныхStepDefinition.ТипШага            = СтрокаТаблицаУжеСуществующихСценариев.ТипШага;
		СтрокаТаблицаИзвестныхStepDefinition.ПредставлениеТеста = СтрокаТаблицаУжеСуществующихСценариев.ПримерИспользования;
		СтрокаТаблицаИзвестныхStepDefinition.ОписаниеШага       = СтрокаТаблицаУжеСуществующихСценариев.ОписаниеШага;
		СтрокаТаблицаИзвестныхStepDefinition.СтрокаДляПоиска    = СтрокаТаблицаУжеСуществующихСценариев.Снипет;
		СтрокаТаблицаИзвестныхStepDefinition.id                 = СтрокаТаблицаУжеСуществующихСценариев.Снипет;
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	Ванесса = ВладелецФормы;
	
	Если ЯзыкГенератораGherkin = "ru" Тогда
		Элементы.ПоказатьПеревод.Видимость = Ложь;
	Иначе
		Если Ванесса.КешДанныеПеревода.ТаблицаПеревода = Неопределено Тогда
			Ванесса.ПеревестиТекст("");
			КешТаблицыПеревода = Ванесса.КешДанныеПеревода.ТаблицаПеревода;
		Иначе
			Если Ванесса.КешДанныеПеревода.Язык = ЯзыкГенератораGherkin Тогда
				КешТаблицыПеревода = Ванесса.КешДанныеПеревода.ТаблицаПеревода;
			КонецЕсли;	 
		КонецЕсли;	 
	КонецЕсли;	 
	
	ДвДанныеvbFeatureReader = ПолучитьДДFeatureReader();
	ДопПараметры = Новый Структура;
	ДопПараметры.Вставить("ТекстСообщенийПользователю",Ванесса.ДанныеПереводаСообщенийПользователю());
	ЗаполнитьДеревоИзвестныхШаговНаСервере(ДвДанныеvbFeatureReader,ДопПараметры);
	
	Если ЗначениеЗаполнено(ПараметрСнипет) Тогда
		АктивизироватьСтрокуПоСнипету(ПараметрСнипет);
	КонецЕсли;	 
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура НайтиШагиОчистка(Элемент, СтандартнаяОбработка)
КонецПроцедуры

&НаКлиенте
Процедура ПоказыватьСлужебныеШагиПриИзменении(Элемент)
	ЗаполнитьДеревоИзвестныхШагов();
КонецПроцедуры

&НаКлиенте
Процедура ПоказыватьУстаревшиеШагиПриИзменении(Элемент)
	ЗаполнитьДеревоИзвестныхШагов();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ВыгрузитьШагиВJSON(Команда)
	
	ДиалогВыбораФайла = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Сохранение);
	ДиалогВыбораФайла.МножественныйВыбор = Ложь;
	ДиалогВыбораФайла.Фильтр = "(*.json)|*.json";
	ДиалогВыбораФайла.Показать(Вычислить("Новый ОписаниеОповещения(""ВыгрузитьШагиВJSONВыборФайлаЗавершение"", ЭтаФорма)"));
	
КонецПроцедуры

&НаКлиенте
Процедура НайтиШаги(Команда)

	ВыполнитьПоиск();

КонецПроцедуры

&НаКлиенте
Процедура ПоказатьПеревод(Команда)
	
	ДанныеПеревода = Новый Структура;
	ДанныеПеревода.Вставить("ЯзыкПеревода", ЯзыкГенератораGherkin);	
	ДанныеПеревода.Вставить("ДвоичныеДанныеФайлПеревода", ПолучитьДвоичныеДанныеФайлПереводаСервер());
	ДанныеПеревода.Вставить("ФормированиеТаблицыДляДальнейшегоПеревода", Истина);
	ДанныеПеревода.Вставить("ВерсияПоставки", Ванесса.Объект.ВерсияПоставки);
	ДанныеПеревода.Вставить("СтруктураПараметров", Ванесса.СлужебныеДанныеДляПарсераФич());
	
	ТабДок = ПоказатьПереводТекстаGherkin(ДанныеПеревода);
	ТабДок.Показать();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура НайтиСтрокуПоСнипетуРекурсивно(Снипет,СтрокиДерева,Результат)
	Для каждого СтрокаДерева Из СтрокиДерева Цикл
		Если Результат <> Неопределено Тогда
			Возврат;
		КонецЕсли;	 
		
		СтрИзДерева = НРег(СтрокаДерева.Снипет);
		Поз = Найти(СтрИзДерева,"(");
		Если Поз > 0 Тогда
			СтрИзДерева = Лев(СтрИзДерева,Поз-1);
		КонецЕсли;
		
		Если Снипет = СтрИзДерева Тогда
			Результат = СтрокаДерева;
			Возврат;
		КонецЕсли;	 
		
		ПодчиненныеЭлементыСтроки = СтрокаДерева.ПолучитьЭлементы();
		НайтиСтрокуПоСнипетуРекурсивно(Снипет, ПодчиненныеЭлементыСтроки, Результат);
	КонецЦикла;
КонецПроцедуры

&НаКлиенте
Процедура АктивизироватьСтрокуПоСнипету(Знач Снипет)
	СтрокаДерева = Неопределено;
	Поз = Найти(Снипет,"(");
	Если Поз > 0 Тогда
		Снипет = Лев(Снипет,Поз-1);
	КонецЕсли;
	Снипет = НРег(Снипет);
	
	НайтиСтрокуПоСнипетуРекурсивно(Снипет,ДеревоШагов.ПолучитьЭлементы(),СтрокаДерева);
	Если СтрокаДерева <> Неопределено Тогда
		Элементы.ДеревоШагов.ТекущаяСтрока = СтрокаДерева.ПолучитьИдентификатор();
		ЭтаФорма.ТекущийЭлемент = Элементы.ДеревоШагов;
	КонецЕсли;	 
КонецПроцедуры 

&НаСервереБезКонтекста
Функция ПолучитьТекстСообщенияПользователюСервер(Текст,ТекстСообщенийПользователю)
	Значение = ТекстСообщенийПользователю[Текст];
	Если ЗначениеЗаполнено(Значение) Тогда
		Возврат Значение;
	КонецЕсли;	 
	
	Возврат Текст; 
КонецФункции

&НаКлиенте               
Функция ПолучитьДДFeatureReader()
	Если Ванесса.Объект.ВерсияПоставки = "single" Тогда
		Возврат Неопределено;
	Иначе	
		Возврат Новый ДвоичныеДанные(ЭтаФорма.ВладелецФормы.ПолучитьПутьКFeatureReader());
	КонецЕсли;	 
КонецФункции	

#КонецОбласти

&НаСервереБезКонтекста
Функция РазложитьСтрокуВМассивПодстрок(Знач Строка, Знач Разделитель = ",", Знач ПропускатьПустыеСтроки = Неопределено) Экспорт
	
	Результат = Новый Массив;
	
	// для обеспечения обратной совместимости
	Если ПропускатьПустыеСтроки = Неопределено Тогда
		ПропускатьПустыеСтроки = ?(Разделитель = " ", Истина, Ложь);
		Если ПустаяСтрока(Строка) Тогда 
			Если Разделитель = " " Тогда
				Результат.Добавить("");
			КонецЕсли;
			Возврат Результат;
		КонецЕсли;
	КонецЕсли;
		
	Позиция = Найти(Строка, Разделитель);
	Пока Позиция > 0 Цикл
		Подстрока = Лев(Строка, Позиция - 1);
		Если Не ПропускатьПустыеСтроки Или Не ПустаяСтрока(Подстрока) Тогда
			Результат.Добавить(Подстрока);
		КонецЕсли;
		Строка = Сред(Строка, Позиция + СтрДлина(Разделитель));
		Позиция = Найти(Строка, Разделитель);
	КонецЦикла;
	
	Если Не ПропускатьПустыеСтроки Или Не ПустаяСтрока(Строка) Тогда
		Результат.Добавить(Строка);
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции 

&НаСервере
Процедура ДобавитьТипыШагов(Дерево,Тип,ТаблицаПеревода)
	НайденныеСтрокиДерева = Дерево.Строки.НайтиСтроки(Новый Структура("ПолныйТипШага",Тип),Истина);
	Если НайденныеСтрокиДерева.Количество() = 0 Тогда
		ТекСтроки = Дерево.Строки;
		МассивТип = РазложитьСтрокуВМассивПодстрок(Тип,".");
		ПолныйТипШага = "";
		Для Каждого ПодТип Из МассивТип Цикл
			ЕстьПеревод = Ложь;
			
			Если ТаблицаПеревода <> Неопределено Тогда
				СтрокаТаблицаПеревода = ТаблицаПеревода.Найти(НРег(ПодТип),"ОригиналРусскийШагНРег");
				Если СтрокаТаблицаПеревода <> Неопределено Тогда
					Если ЗначениеЗаполнено(СтрокаТаблицаПеревода.ТекстПереводаШаг) Тогда
						ПодТип = СтрокаТаблицаПеревода.ТекстПереводаШаг;
					КонецЕсли;	 
					ЕстьПеревод = Истина;
				КонецЕсли;	 
			КонецЕсли;	 
			
			Если ПолныйТипШага = "" Тогда
				ПолныйТипШага = ПодТип;
			Иначе
				ПолныйТипШага = ПолныйТипШага + "." + ПодТип;
			КонецЕсли;	 
			
			НайденныеСтрокиДерева = ТекСтроки.НайтиСтроки(Новый Структура("ТипШага",ПодТип),Ложь);
			Если НайденныеСтрокиДерева.Количество() = 0 Тогда
				ТекСтрока               = ТекСтроки.Добавить();
				ТекСтрока.ТипШага       = ПодТип;
				ТекСтрока.ПолныйТипШага = ПолныйТипШага;
				ТекСтрока.Язык          = "ru";
				Если ТаблицаПеревода <> Неопределено и ЕстьПеревод Тогда
					ТекСтрока.Язык          = ЯзыкГенератораGherkin;
				КонецЕсли;	 
				
				ТекСтроки = ТекСтрока.Строки;
			Иначе	
				ТекСтроки = НайденныеСтрокиДерева[0].Строки;
			КонецЕсли;	 
		КонецЦикла;	
	КонецЕсли;	 
КонецПроцедуры

&НаСервереБезКонтекста
Функция ПреобразоватьТипПеревод(Тип,ТаблицаПеревода)
	МассивТип = РазложитьСтрокуВМассивПодстрок(Тип,".");
	ПолныйТипШага = "";
	Для Каждого ПодТип Из МассивТип Цикл
		СтрокаТаблицаПеревода = ТаблицаПеревода.Найти(НРег(ПодТип),"ОригиналРусскийШагНРег");
		Если СтрокаТаблицаПеревода <> Неопределено Тогда
			Если ЗначениеЗаполнено(СтрокаТаблицаПеревода.ТекстПереводаШаг) Тогда
				ПодТип = СтрокаТаблицаПеревода.ТекстПереводаШаг;
			КонецЕсли;	 
		КонецЕсли;	 
		
		Если ПолныйТипШага = "" Тогда
			ПолныйТипШага = ПодТип;
		Иначе
			ПолныйТипШага = ПолныйТипШага + "." + ПодТип;
		КонецЕсли;	 
	КонецЦикла;	
	
	Возврат ПолныйТипШага;
КонецФункции	

&НаСервере
Функция ДобавитьШаги(Дерево,Тип,Данные,ТаблицаПеревода,СтрТаблицаИзвестныхStepDefinition,ДопПараметры)
	
	Если ТаблицаПеревода <> Неопределено Тогда
		Тип = ПреобразоватьТипПеревод(Тип,ТаблицаПеревода);
	КонецЕсли;	 
	
	НайденныеСтрокиДерева = Дерево.Строки.НайтиСтроки(Новый Структура("ПолныйТипШага",Тип),Истина);
	Если НайденныеСтрокиДерева.Количество() = 0 Тогда
		ТекстСообщения = ПолучитьТекстСообщенияПользователюСервер("Не найден тип шага <%1>",ДопПараметры.ТекстСообщенийПользователю);
		ТекстСообщения = СтрЗаменить(ТекстСообщения,"%1",Тип);
		ВызватьИсключение(ТекстСообщения);
	КонецЕсли;
	
	
	СтрокаДерева = НайденныеСтрокиДерева[0];	
	СтрокаШага   = СтрокаДерева.Строки.Добавить();
	СтрокаШага.ПредставлениеТеста = Данные.ПредставлениеТеста;
	СтрокаШага.ОписаниеШага       = Данные.ОписаниеШага;
	Если СтрТаблицаИзвестныхStepDefinition <> Неопределено Тогда
		СтрокаШага.ОписаниеШагаОригинал = СтрТаблицаИзвестныхStepDefinition.ОписаниеШагаОригинал;
		СтрокаШага.ПредставлениеТестаОригинал = СтрТаблицаИзвестныхStepDefinition.ПредставлениеТестаОригинал;
	КонецЕсли;	 
	СтрокаШага.ИмяФайла = СтрЗаменить(Данные.ИмяФайла,"/","\");
	СтрокаШага.Язык = "ru";
	СтрокаШага.Снипет = Данные.ID;
	
	Если ТаблицаПеревода <> Неопределено Тогда
		СтрокаПоиска = СтрТаблицаИзвестныхStepDefinition.СтрокаДляПоиска;
		
		СтрокаТаблицаПеревода = ТаблицаПеревода.Найти(СтрокаПоиска,"СтрокаДляПоискаРусский");
		Если СтрокаТаблицаПеревода <> Неопределено Тогда
			СтрокаШага.Язык               = ЯзыкГенератораGherkin;
			Если ЗначениеЗаполнено(СтрокаТаблицаПеревода.ТекстПереводаШаг) Тогда
				СтрокаШага.ПредставлениеТеста = УбратьСлужебныеСимволыИзПредставления(СтрокаТаблицаПеревода.ТекстПереводаШаг);
			КонецЕсли;	 
			Если ЗначениеЗаполнено(СтрокаТаблицаПеревода.ТекстПереводаОписание) Тогда
				СтрокаШага.ОписаниеШага = СтрокаТаблицаПеревода.ТекстПереводаОписание;
			КонецЕсли;	 
		Иначе
			ТекстСообщения = ПолучитьТекстСообщенияПользователюСервер("Не найден перевод для шага <%1>",ДопПараметры.ТекстСообщенийПользователю);
			ТекстСообщения = СтрЗаменить(ТекстСообщения,"%1",Данные.ПредставлениеТеста);
			Сообщить(ТекстСообщения);
		КонецЕсли;	 
	КонецЕсли;	 
	
	Возврат СтрокаШага;
	
КонецФункции

&НаСервере
Процедура ПроставитьРекурсивноСтрокуВПустойТип(Дерево,СлужебнаяСтрока,ЗаменятьПустойТип)
	Для Каждого СтрокаДерева Из Дерево.Строки Цикл
		Если ЗаменятьПустойТип Тогда
			Если СокрЛП(СтрокаДерева.ТипШага) = "" Тогда
				СтрокаДерева.ТипШага = СлужебнаяСтрока;
			КонецЕсли;	 
		Иначе	
			Если СтрокаДерева.ТипШага = СлужебнаяСтрока Тогда
				СтрокаДерева.ТипШага = "Другое";
			КонецЕсли;	 
		КонецЕсли;	 
		
		ПроставитьРекурсивноСтрокуВПустойТип(СтрокаДерева,СлужебнаяСтрока,ЗаменятьПустойТип);
	КонецЦикла;	
КонецПроцедуры

&НаСервере
Процедура СделатьСортировкуДерева(Дерево)
	Дерево.Строки.Сортировать("ТипШага,ОписаниеШага",Истина);
КонецПроцедуры

&НаСервере
Функция ПолучитьТаблицуПеревода(ДвДанныеvbFeatureReader)
	Если ЗначениеЗаполнено(КешТаблицыПеревода) Тогда
		Возврат ПолучитьИзВременногоХранилища(КешТаблицыПеревода);
	КонецЕсли;	 
	
	ТаблицаДляПереводаИзвестныхШагов = Новый ТаблицаЗначений;
	ТаблицаДляПереводаИзвестныхШагов.Колонки.Добавить("ОригиналРусскийШаг");
	ТаблицаДляПереводаИзвестныхШагов.Колонки.Добавить("ОригиналРусскийОписаниеШага");
	ТаблицаДляПереводаИзвестныхШагов.Колонки.Добавить("Перевод");
	
	
	//ЗаполнитьТаблицуДляПеревода(ТаблицаДляПереводаИзвестныхШагов,ДеревоСервер);
	
	
	
	ДанныеПеревода = Новый Структура;
	ДанныеПеревода.Вставить("ЯзыкПеревода",ЯзыкГенератораGherkin);
	
	ДанныеПеревода.Вставить("ДвоичныеДанныеФайлПеревода",ЗначениеИзСтрокиВнутр(ДвоичныеДанныеФайлПеревода));
	ДанныеПеревода.Вставить("ФормированиеТаблицыДляДальнейшегоПеревода",Истина);
	
	ДанныеПеревода.Вставить("ТаблицаДляПереводаИзвестныхШагов",ТаблицаДляПереводаИзвестныхШагов);
	ДанныеПеревода.Вставить("МакетШаблонПеревода",МакетШаблонПеревода);
	
	ТабТаблицаИзвестныхStepDefinition = РеквизитФормыВЗначение("ТаблицаИзвестныхStepDefinition");
	
	ДанныеПеревода.Вставить("ТаблицаИзвестныхStepDefinition",ТабТаблицаИзвестныхStepDefinition);
	

	
	ВременноеИмяФайла = Неопределено;
	FeatureReader = СоздатьFeatureReader(КаталогИнструментов, ДвДанныеvbFeatureReader, ВременноеИмяФайла);
	
	FeatureReader.ПолучитьПереводТекстаGherkin(ДанныеПеревода);
	
	КешТаблицыПеревода = ЗначениеВСтрокуВнутр(ДанныеПеревода.ТаблицаПеревода);
	
	
	ЗначениеВРеквизитФормы(ДанныеПеревода.ТаблицаИзвестныхStepDefinition,"ТаблицаИзвестныхStepDefinition");
	
	Возврат ДанныеПеревода.ТаблицаПеревода;
КонецФункции	

&НаСервере
Функция УбратьСлужебныеСимволыИзПредставления(Знач Стр)
	Стр = СтрЗаменить(Стр,"%1 ","");
	Стр = СтрЗаменить(Стр,"%2 ","");
	Стр = СтрЗаменить(Стр,"%3 ","");
	Стр = СтрЗаменить(Стр,"%4 ","");
	Стр = СтрЗаменить(Стр,"%5 ","");
	Стр = СтрЗаменить(Стр,"%6 ","");
	Стр = СтрЗаменить(Стр,"%7 ","");
	
	Возврат Стр;
КонецФункции	

&НаСервере
Процедура ЗаменитьПредставлениеТестаВТаблице(ТаблицаПеревода,Тзн)
	Для Каждого СтрокаТзн Из Тзн Цикл
		СтрокаДляПоиска = СтрокаТзн.СтрокаДляПоиска;
		СтрТаблицаПеревода = ТаблицаПеревода.Найти(СтрокаДляПоиска,"СтрокаДляПоискаРусский");
		
		Если СтрТаблицаПеревода <> Неопределено Тогда
			Если ЗначениеЗаполнено(СтрТаблицаПеревода.ТекстПереводаШаг) Тогда
				СтрокаТзн.ПредставлениеТестаОригинал = СтрокаТзн.ПредставлениеТеста;
				СтрокаТзн.ПредставлениеТеста = СтрТаблицаПеревода.ТекстПереводаШаг;
			КонецЕсли;	 
			
			Если ЗначениеЗаполнено(СтрТаблицаПеревода.ТекстПереводаОписание) Тогда
				СтрокаТзн.ОписаниеШагаОригинал = СтрокаТзн.ОписаниеШага;
				СтрокаТзн.ОписаниеШага         = СтрТаблицаПеревода.ТекстПереводаОписание;
			КонецЕсли;	 
		КонецЕсли;	 
	КонецЦикла;	
КонецПроцедуры

&НаСервере
Процедура ДополнитьТаблицуРезультатаПоиска(ТабРезультат,ТабРезультат2)
	Для Каждого СтрокаТабРезультат2 Из ТабРезультат2 Цикл
		СтрокаТабРезультат = ТабРезультат.Найти(СтрокаТабРезультат2.СтрокаДляПоиска,"СтрокаДляПоиска");
		Если СтрокаТабРезультат = Неопределено Тогда
			СтрокаТабРезультат = ТабРезультат.Добавить();
			ЗаполнитьЗначенияСвойств(СтрокаТабРезультат,СтрокаТабРезультат2);
		КонецЕсли;	 
	КонецЦикла;	
КонецПроцедуры 

&НаСервере
Функция ПолучитьРезультатПоиска(ТаблицаДанных,ИмяКолонки)
	Построитель = Новый ПостроительЗапроса;
	Построитель.ИсточникДанных = Новый ОписаниеИсточникаДанных(ТаблицаДанных);
	
	тОтбор = Построитель.Отбор.Добавить(ИмяКолонки);
	тОтбор.ВидСравнения = ВидСравнения.Содержит;
	тОтбор.Значение = ФильтрДереваШагов;
	тОтбор.Использование = Истина;
	
	Построитель.Выполнить();
	Возврат Построитель.Результат.Выгрузить();
КонецФункции	 

&НаСервере
Процедура ЗаполнитьДеревоИзвестныхШаговНаСервере(ДвДанныеvbFeatureReader,ДопПараметры)
	ТабОригинал = РеквизитФормыВЗначение("ТаблицаИзвестныхStepDefinition");
	ТабОригинал.Колонки.Добавить("ПредставлениеТестаОригинал",Новый ОписаниеТипов("Строка"));
	ТабОригинал.Колонки.Добавить("ОписаниеШагаОригинал",Новый ОписаниеТипов("Строка"));

	ТаблицаПеревода = Неопределено;
	Если ЯзыкГенератораGherkin <> "ru" Тогда
		ТаблицаПеревода = ПолучитьТаблицуПеревода(ДвДанныеvbFeatureReader);
		ЗаменитьПредставлениеТестаВТаблице(ТаблицаПеревода,ТабОригинал);
	КонецЕсли;	 
	
	Дерево = РеквизитФормыВЗначение("ДеревоШагов");
	
	Если Ложь Тогда
		Дерево = Новый ДеревоЗначений;
	КонецЕсли;
	Дерево.Строки.Очистить();
	
	//получить список шагов с учетом фильтра
	Если ЗначениеЗаполнено(ФильтрДереваШагов) Тогда
		
		ТабРезультат = ТабОригинал.Скопировать();
		ТабРезультат = ПолучитьРезультатПоиска(ТабОригинал,"ПредставлениеТеста");
		
		ТабРезультат.Индексы.Добавить("СтрокаДляПоиска");
		
		ТабРезультат2 = ТабОригинал.Скопировать();
		ТабРезультат2 = ПолучитьРезультатПоиска(ТабОригинал,"ОписаниеШага");
		ДополнитьТаблицуРезультатаПоиска(ТабРезультат,ТабРезультат2);
		
		Если ПоказатьШагиНаРусском Тогда
			ТабРезультат3 = ТабОригинал.Скопировать();
			ТабРезультат3 = ПолучитьРезультатПоиска(ТабОригинал,"ОписаниеШагаОригинал");
			ДополнитьТаблицуРезультатаПоиска(ТабРезультат,ТабРезультат3);
			
			ТабРезультат4 = ТабОригинал.Скопировать();
			ТабРезультат4 = ПолучитьРезультатПоиска(ТабОригинал,"ПредставлениеТестаОригинал");
			ДополнитьТаблицуРезультатаПоиска(ТабРезультат,ТабРезультат4);
		КонецЕсли;	 
	Иначе
		ТабРезультат = ТабОригинал;
	КонецЕсли;	
	
	Для Каждого СтрТаблицаИзвестныхStepDefinition Из ТабРезультат Цикл
		Тип = СокрЛП(СтрТаблицаИзвестныхStepDefinition.ТипШага);
		Если ПоказыватьСлужебныеШаги И Тип = "" Тогда
			Тип = "Служебные";
		ИначеЕсли Тип = "" Тогда
			Продолжить;
		КонецЕсли;
		
		Если НЕ ПоказыватьУстаревшиеШаги Тогда
			Если Найти(СтрТаблицаИзвестныхStepDefinition.ТипШага,"Устаревшее") > 0 Тогда
				Продолжить;
			КонецЕсли;	 
		КонецЕсли;	 
		
		ДобавитьТипыШагов(Дерево,Тип,ТаблицаПеревода); //группы
	КонецЦикла;
	
	Для Каждого СтрТаблицаИзвестныхStepDefinition Из ТабРезультат Цикл
		Тип = СокрЛП(СтрТаблицаИзвестныхStepDefinition.ТипШага);
		Если ПоказыватьСлужебныеШаги И Тип = "" Тогда
			Тип = "Служебные";
		ИначеЕсли Тип = "" Тогда
			Продолжить;
		КонецЕсли;
		
		Данные = СтрТаблицаИзвестныхStepDefinition;
		
		Если НЕ ПоказыватьУстаревшиеШаги Тогда
			Если Найти(Данные.ТипШага,"Устаревшее") > 0 Тогда
				Продолжить;
			КонецЕсли;	 
		КонецЕсли;	 
		
		СтрокаШага = ДобавитьШаги(Дерево,Тип,Данные,ТаблицаПеревода,СтрТаблицаИзвестныхStepDefinition,ДопПараметры);
	КонецЦикла;	
	
	СделатьСортировкуДерева(Дерево);
	
	ЗначениеВРеквизитФормы(Дерево,"ДеревоШагов");

	Элементы.ДеревоШаговПредставлениеТестаОригинал.Видимость = ПоказатьШагиНаРусском;
	Элементы.ДеревоШаговПредставлениеТестаОригинал.Видимость = ПоказатьШагиНаРусском;
КонецПроцедуры

&НаКлиенте
Процедура ДеревоШаговВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	Если Не ЗначениеЗаполнено(Элемент.ТекущиеДанные.ПредставлениеТеста) Тогда
		Возврат;
	КонецЕсли;	
	
	Оповестить("ВыборИзвестногоШага",Элемент.ТекущиеДанные.ПредставлениеТеста);
	ТекстСообщения = Ванесса.ПолучитьТекстСообщенияПользователю("Добавил шаг: %1");
	ТекстСообщения = СтрЗаменить(ТекстСообщения,"%1",Элемент.ТекущиеДанные.ПредставлениеТеста);
	Сообщить(Ванесса.ПолучитьТекстСообщенияПользователю(ТекстСообщения));
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьДеревоИзвестныхШагов()
	ДвДанныеvbFeatureReader = ПолучитьДДFeatureReader();
	ДопПараметры = Новый Структура;
	ДопПараметры.Вставить("ТекстСообщенийПользователю",Ванесса.ДанныеПереводаСообщенийПользователю());
	ЗаполнитьДеревоИзвестныхШаговНаСервере(ДвДанныеvbFeatureReader,ДопПараметры);
КонецПроцедуры 

&НаКлиенте
Процедура РазвернутьСтрокиДерева(Дерево)
	
	Строки = Дерево.ПолучитьЭлементы();
	
	Для Каждого Строка Из Строки Цикл
		ИдентификаторСтроки = Строка.ПолучитьИдентификатор();
		Элементы.ДеревоШагов.Развернуть(ИдентификаторСтроки);

		РазвернутьСтрокиДерева(Строка);
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура СвернутьСтрокиДерева(ДеревоФормыСтроки)
	
	Для Каждого Строка Из ДеревоФормыСтроки Цикл
		ИдентификаторСтроки = Строка.ПолучитьИдентификатор();
		Элементы.ДеревоШагов.Свернуть(ИдентификаторСтроки);
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура АктивизироватьСтрокуДереваСНужнымШагомРекурсивно(ПредставлениеТеста,Дерево,Нашли)
	Если Нашли Тогда
		Возврат;
	КонецЕсли;	 
	
	ЭлементыДерева = Дерево.ПолучитьЭлементы();
	Для Каждого СтрокаДерева Из ЭлементыДерева Цикл
		Если СтрокаДерева.ПредставлениеТеста = ПредставлениеТеста Тогда
			Элементы.ДеревоШагов.ТекущаяСтрока = СтрокаДерева.ПолучитьИдентификатор();
			Нашли = Истина;
			Возврат;
		КонецЕсли;
		
		АктивизироватьСтрокуДереваСНужнымШагомРекурсивно(ПредставлениеТеста,СтрокаДерева,Нашли);
	КонецЦикла;	
КонецПроцедуры

&НаКлиенте
Процедура АктивизироватьСтрокуДереваСНужнымШагом(ТекСтрока)
	Нашли = Ложь;
	АктивизироватьСтрокуДереваСНужнымШагомРекурсивно(ТекСтрока,ДеревоШагов,Нашли);
КонецПроцедуры

&НаКлиенте
Функция ПолучитьТекстШагаТекущейСтроки(ВсегдаПолучатьТекстШага = Ложь)
	ТекстШага = Неопределено;
	Если НЕ ЗначениеЗаполнено(ФильтрДереваШагов) или ВсегдаПолучатьТекстШага Тогда
		ТекСтрока = Элементы.ДеревоШагов.ТекущаяСтрока;
		Если ТекСтрока <> Неопределено Тогда
			СтрокаДерева = ДеревоШагов.НайтиПоИдентификатору(ТекСтрока);
			Если СтрокаДерева <> Неопределено Тогда
				ТекстШага = СтрокаДерева.ПредставлениеТеста;
			КонецЕсли;	 
		КонецЕсли;	 
	КонецЕсли;	 
	
	Возврат ТекстШага; 
КонецФункции	 

&НаКлиенте
Процедура НайтиШагиПриИзменении(Элемент)
	
	ВыполнитьПоиск();
	
КонецПроцедуры

&НаСервере
Функция СоздатьFeatureReader(КаталогИнструментов, ДвДанныеvbFeatureReader, ВременноеИмяФайла)
	Если Объект.ВерсияПоставки = "single" Тогда
		ОбъектСервер = РеквизитФормыВЗначение("Объект");
		Возврат ОбъектСервер; 
	КонецЕсли;	 
	
	ФайлvbFeatureReader = Новый Файл(КаталогИнструментов + "\lib\FeatureReader\vbFeatureReader.epf");
	ВременноеИмяФайла = Неопределено;
	Если Не ФайлvbFeatureReader.Существует() Тогда
		ВременноеИмяФайла = ПолучитьИмяВременногоФайла("epf");
		ДвДанныеvbFeatureReader.Записать(ВременноеИмяФайла);
		FeatureReader = ВнешниеОбработки.Создать(ВременноеИмяФайла, Ложь);
	Иначе	
		FeatureReader = ВнешниеОбработки.Создать(ФайлvbFeatureReader.ПолноеИмя, Ложь);
	КонецЕсли;	 
	
	Возврат FeatureReader;
КонецФункции	

&НаСервере
Функция УбратьЛишиниеСимволыИзТекста(Знач Стр)
	Стр = СтрЗаменить(Стр,Символы.Таб," ");
	Пока Найти(Стр,"  ") > 0 Цикл
		Стр = СтрЗаменить(Стр,"  "," ");
	КонецЦикла;	
	
	Возврат Стр;
КонецФункции	

&НаСервере
Процедура ДобавитьЗначенияВТаблицуДляПереодаРекурсивно(ТаблицаДляПереводаИзвестныхШагов,Дерево)
	Для Каждого СтрокаДерева Из Дерево.Строки Цикл
		Если СтрокаДерева.Язык = "ru" Тогда
			Если ЗначениеЗаполнено(СтрокаДерева.ТипШага) Тогда
				СтрокаТаблицаДляПереводаИзвестныхШагов = ТаблицаДляПереводаИзвестныхШагов.Найти(СтрокаДерева.ТипШага,"ОригиналРусскийШаг");
				Если СтрокаТаблицаДляПереводаИзвестныхШагов = Неопределено Тогда
					СтрокаТаблицаДляПереводаИзвестныхШагов = ТаблицаДляПереводаИзвестныхШагов.Добавить();
					СтрокаТаблицаДляПереводаИзвестныхШагов.ОригиналРусскийШаг          = СтрокаДерева.ТипШага;
					СтрокаТаблицаДляПереводаИзвестныхШагов.ОригиналРусскийОписаниеШага = "Категория шагов";
				КонецЕсли;	 
			Иначе
				СтрокаТаблицаДляПереводаИзвестныхШагов = ТаблицаДляПереводаИзвестныхШагов.Найти(СтрокаДерева.ПредставлениеТеста,"ОригиналРусскийШаг");
				Если СтрокаТаблицаДляПереводаИзвестныхШагов = Неопределено Тогда
					СтрокаТаблицаДляПереводаИзвестныхШагов = ТаблицаДляПереводаИзвестныхШагов.Добавить();
					СтрокаТаблицаДляПереводаИзвестныхШагов.ОригиналРусскийШаг          = УбратьЛишиниеСимволыИзТекста(СтрокаДерева.ПредставлениеТеста);
					СтрокаТаблицаДляПереводаИзвестныхШагов.ОригиналРусскийОписаниеШага = СтрокаДерева.ОписаниеШага;
				КонецЕсли;	 
			КонецЕсли;	
		КонецЕсли;	 
		
		ДобавитьЗначенияВТаблицуДляПереодаРекурсивно(ТаблицаДляПереводаИзвестныхШагов,СтрокаДерева);
	КонецЦикла;	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьТаблицуДляПеревода(ТаблицаДляПереводаИзвестныхШагов,Дерево)
	ДобавитьЗначенияВТаблицуДляПереодаРекурсивно(ТаблицаДляПереводаИзвестныхШагов,Дерево);
КонецПроцедуры

&НаСервере
Функция ПоказатьПереводТекстаGherkin(ДанныеПеревода)
	ДеревоСервер = РеквизитФормыВЗначение("ДеревоШагов");
	
	ТаблицаДляПереводаИзвестныхШагов = Новый ТаблицаЗначений;
	ТаблицаДляПереводаИзвестныхШагов.Колонки.Добавить("ОригиналРусскийШаг");
	ТаблицаДляПереводаИзвестныхШагов.Колонки.Добавить("ОригиналРусскийОписаниеШага");
	ТаблицаДляПереводаИзвестныхШагов.Колонки.Добавить("Перевод");
	
	
	ЗаполнитьТаблицуДляПеревода(ТаблицаДляПереводаИзвестныхШагов,ДеревоСервер);
	
	ДанныеПеревода.Вставить("ТаблицаДляПереводаИзвестныхШагов",ТаблицаДляПереводаИзвестныхШагов);
	ДанныеПеревода.Вставить("МакетШаблонПеревода",МакетШаблонПеревода);
	
	
	ТаблицаИзвестныхStepDefinitionСервер = РеквизитФормыВЗначение("ТаблицаИзвестныхStepDefinition");
	ДанныеПеревода.Вставить("ТаблицаИзвестныхStepDefinition",ТаблицаИзвестныхStepDefinitionСервер);
	
	
	
	ДвДанныеvbFeatureReader = Неопределено;
	ВременноеИмяФайла = Неопределено;
	Если ДанныеПеревода.ВерсияПоставки = "single" Тогда
		ОбъектСервер  = РеквизитФормыВЗначение("Объект");
		FeatureReader = ОбъектСервер;
	Иначе	
		FeatureReader = СоздатьFeatureReader(КаталогИнструментов, ДвДанныеvbFeatureReader, ВременноеИмяФайла);
	КонецЕсли;	 
	
	КешСнипетовИзХранилищаЗначений(ДанныеПеревода.СтруктураПараметров);
	
	FeatureReader.ПолучитьПереводТекстаGherkin(ДанныеПеревода);
	ДанныеПеревода.Вставить("ТаблицаПеревода",Неопределено);
	
	ДанныеПеревода.Вставить("ТаблицаДляПереводаИзвестныхШагов",Неопределено);
	
	ТабДок         = ДанныеПеревода.ТабДок;
	ДанныеПеревода = Неопределено;
	
	Возврат ТабДок;
КонецФункции	

&НаСервере
Функция ПолучитьДвоичныеДанныеФайлПереводаСервер()
	Возврат ЗначениеИзСтрокиВнутр(ДвоичныеДанныеФайлПеревода);
КонецФункции	

&НаСервере
Функция ПодготовитьТаблицуДляВыгрузкиШагов()
	ДеревоШаговСервер                    = РеквизитФормыВЗначение("ДеревоШагов");
	ТаблицаИзвестныхStepDefinitionСервер = РеквизитФормыВЗначение("ТаблицаИзвестныхStepDefinition");
	
	Массив = Новый Массив;
	
	Для Каждого СтрокаТаблицаИзвестныхStepDefinitionСервер Из ТаблицаИзвестныхStepDefinitionСервер Цикл
		Если НЕ ЗначениеЗаполнено(СтрокаТаблицаИзвестныхStepDefinitionСервер.ПредставлениеТеста) Тогда
			Продолжить;
		КонецЕсли;	 
		
		СтрокаДерева = ДеревоШаговСервер.Строки.Найти(СтрокаТаблицаИзвестныхStepDefinitionСервер.ПредставлениеТеста,"ПредставлениеТеста",Истина);
		Если СтрокаДерева = Неопределено Тогда
			Продолжить;
		КонецЕсли;	 
		
		Структура = Новый Структура;
		Структура.Вставить("ИмяШага",СтрокаТаблицаИзвестныхStepDefinitionСервер.ПредставлениеТеста);
		Структура.Вставить("ОписаниеШага",СтрокаТаблицаИзвестныхStepDefinitionСервер.ОписаниеШага);
		Структура.Вставить("ПолныйТипШага",СтрокаДерева.Родитель.ПолныйТипШага);
		
		Массив.Добавить(Структура);
	КонецЦикла;	
	
	Возврат Массив;
КонецФункции	

&НаКлиенте
Процедура ВыгрузитьШагиВJSONВыборФайлаЗавершение(ВыбранныеФайлы, ДополнительныеПараметры) Экспорт
	
	Если НЕ ЗначениеЗаполнено(ВыбранныеФайлы) Тогда
		Возврат;
	КонецЕсли;	 
	
	МассивДляВыгрузкиШагов = ПодготовитьТаблицуДляВыгрузкиШагов();
	
	
	ЗаписьJSON = Вычислить("Новый ЗаписьJSON");
	
	
	ЗаписьJSON.ОткрытьФайл(ВыбранныеФайлы[0]);
	
	ЗаписьJSON.ЗаписатьНачалоМассива();
	
	Для Каждого ШагДляВыгрузки Из МассивДляВыгрузкиШагов Цикл
		ЗаписьJSON.ЗаписатьНачалоОбъекта();
		
		
		Для Каждого СвойстваШага Из ШагДляВыгрузки Цикл
			ЗаписьJSON.ЗаписатьИмяСвойства(СвойстваШага.Ключ);
			ЗаписьJSON.ЗаписатьЗначение(СвойстваШага.Значение);
		КонецЦикла;	
		
		ЗаписьJSON.ЗаписатьКонецОбъекта();
	КонецЦикла;	
	
	
	ЗаписьJSON.ЗаписатьКонецМассива();
	
	ЗаписьJSON.Закрыть();
КонецПроцедуры

&НаКлиенте
Процедура ПоказатьШагиНаРусскомПриИзменении(Элемент)
	ТекстШага = ПолучитьТекстШагаТекущейСтроки(Истина);
	
	Элементы.ДеревоШаговПредставлениеТестаОригинал.Видимость = ПоказатьШагиНаРусском;
	Элементы.ДеревоШаговОписаниеШагаОригинал.Видимость       = ПоказатьШагиНаРусском;
	ДвДанныеvbFeatureReader = ПолучитьДДFeatureReader();
	
	ДопПараметры = Новый Структура;
	ДопПараметры.Вставить("ТекстСообщенийПользователю",Ванесса.ДанныеПереводаСообщенийПользователю());
	ЗаполнитьДеревоИзвестныхШаговНаСервере(ДвДанныеvbFeatureReader,ДопПараметры);
	
	Если ЗначениеЗаполнено(ТекстШага) Тогда
		АктивизироватьСтрокуДереваСНужнымШагом(ТекстШага);
	КонецЕсли;	 
	
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьПоиск()

	ТекстШага = ПолучитьТекстШагаТекущейСтроки();

	ДвДанныеvbFeatureReader = ПолучитьДДFeatureReader();

	ДопПараметры = Новый Структура;
	ДопПараметры.Вставить("ТекстСообщенийПользователю", Ванесса.ДанныеПереводаСообщенийПользователю());
	ЗаполнитьДеревоИзвестныхШаговНаСервере(ДвДанныеvbFeatureReader, ДопПараметры);
	Если Не ЗначениеЗаполнено(ФильтрДереваШагов) Тогда
		Если ЗначениеЗаполнено(ТекстШага) Тогда
			АктивизироватьСтрокуДереваСНужнымШагом(ТекстШага);
		КонецЕсли;

		Возврат;
	КонецЕсли;

	РазвернутьСтрокиДерева(ДеревоШагов);

КонецПроцедуры

&НаСервереБезКонтекста
Процедура КешСнипетовИзХранилищаЗначений(СтруктураПараметров)
	Если СтруктураПараметров.КешСнипетов = Неопределено Тогда
		СтруктураПараметров.КешСнипетов = Новый Соответствие;
	Иначе
		АдресВременногоХранилища = СтруктураПараметров.КешСнипетов;
		СтруктураПараметров.Вставить("КешСнипетов",ПолучитьИзВременногоХранилища(АдресВременногоХранилища));
	КонецЕсли;	 
КонецПроцедуры 

