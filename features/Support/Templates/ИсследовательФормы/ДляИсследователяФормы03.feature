# language: ru

@IgnoreOnCIMainBuild
@tree


Функциональность: ДляИсследователяФормы03

 



Сценарий: ДляИсследователяФормы03
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий
	И В командном интерфейсе я выбираю 'Основная' 'Справочник3'
	Тогда открылось окно 'Справочник3'
	И я нажимаю на кнопку с именем 'ФормаСоздать'
	Тогда открылось окно 'Справочник3 (создание)'
	И в поле с именем 'Наименование' я ввожу текст '111'
	И я нажимаю на кнопку с именем 'ФормаЗаписать'
	Тогда открылось окно '* (Справочник3)'
	И я нажимаю на кнопку с именем 'СформироватьОтчет'
	И в табличном документе 'РеквизитТабличныйДокумент' я перехожу к ячейке "ОбластьПерваяСтрокаОтчетаНаименование"
