#Использовать json
#Использовать logos
#Использовать strings

Перем Лог;
Перем КлиентВеб;
Перем мСоединение;

Перем ИмяОпубликованнойБазы;
Перем ПрефиксИмени;
Перем ИмяОбъектаКонфигурации;
Перем СуффиксИмени;

Процедура ИспользоватьСоединениеИнформационнойБазы(Знач Соединение, Знач ИмяОпубликованнойБазы) Экспорт
	мСоединение = Соединение;
	ИмяОпубликованнойБазы = ИмяОпубликованнойБазы;
	КлиентВеб.ИспользоватьСоединение(мСоединение);
КонецПроцедуры

Функция ПолучитьПубликациюОбъектаOData() Экспорт
	Если ЗначениеЗаполнено(ПрефиксИмени) И ЗначениеЗаполнено(ИмяОбъектаКонфигурации) Тогда
		АдресПубликации = СтрШаблон("%1/odata/standard.odata/%2_%3_%4", ИмяОпубликованнойБазы,ПрефиксИмени,ИмяОбъектаКонфигурации,СуффиксИмени);
		Возврат АдресПубликации;
	Иначе
		ВызватьИсключение "Не указан объект метаданных
		|Текущий объект-ресурс: " + ПрефиксИмени + "_" + ИмяОбъектаКонфигурации + СуффиксИмени;
	КонецЕсли;
КонецФункции

//функции выборки
Функция ПолучитьВсе() Экспорт
	АдресРесурса = ПолучитьПубликациюОбъектаOData() + "()$format=json";
	Лог.Отладка("Запрашиваю ресурс: " + АдресРесурса);
	Возврат КлиентВеб.Получить(АдресРесурса);
КонецФункции

Функция ПолучитьПоКлючевымПолям(ВыражениеКлючевыхПолей) Экспорт
	АдресРесурса = ПолучитьПубликациюОбъектаOData() 
		+ СтрШаблон("(%4)$format=json",ВыражениеКлючевыхПолей);
	Лог.Отладка("Запрашиваю ресурс: " + АдресРесурса);
	Возврат КлиентВеб.Получить(АдресРесурса);
КонецФункции

// Функции инициализации адреса объекта
Функция Справочник(_Имя) Экспорт ИмяОбъектаКонфигурации = _Имя;	ПрефиксИмени = "Catalog"; 	Возврат ЭтотОбъект; КонецФункции
Функция Документ(_Имя) Экспорт ИмяОбъектаКонфигурации = _Имя;	ПрефиксИмени = "Document";	Возврат ЭтотОбъект; КонецФункции
Функция ЖурналДокументов(_Имя) Экспорт	ИмяОбъектаКонфигурации = _Имя;	ПрефиксИмени = "DocumentJournal";	Возврат ЭтотОбъект;КонецФункции
Функция Константа(_Имя) Экспорт ИмяОбъектаКонфигурации = _Имя;	ПрефиксИмени = "Constant";	Возврат ЭтотОбъект; КонецФункции
Функция ПланыОбмена(_Имя) Экспорт ИмяОбъектаКонфигурации = _Имя;	ПрефиксИмени = "ExchangePlan";	Возврат ЭтотОбъект; КонецФункции
Функция ПланыСчетов(_Имя) Экспорт ИмяОбъектаКонфигурации = _Имя;	ПрефиксИмени = "ChartOfAccounts"; Возврат ЭтотОбъект; КонецФункции
Функция ПланВидовРасчета(_Имя) Экспорт	ИмяОбъектаКонфигурации = _Имя;	ПрефиксИмени = "ChartOfCalculationTypes";	Возврат ЭтотОбъект; КонецФункции
Функция ПланВидовХарактеристик(_Имя) Экспорт ИмяОбъектаКонфигурации = _Имя;	ПрефиксИмени = "ChartOfCharacteristicTypes"; Возврат ЭтотОбъект; КонецФункции 
Функция РегистрСведений(_Имя) Экспорт ИмяОбъектаКонфигурации = _Имя;	ПрефиксИмени = "InformationRegister"; Возврат ЭтотОбъект; КонецФункции 
Функция РегистрРасчета(_Имя) Экспорт ИмяОбъектаКонфигурации = _Имя;	ПрефиксИмени = "CalculationRegister";	Возврат ЭтотОбъект; КонецФункции
Функция РегистрБухгалтерии(_Имя) Экспорт ИмяОбъектаКонфигурации = _Имя;	ПрефиксИмени = "AccountingRegister"; Возврат ЭтотОбъект; КонецФункции
Функция РегистрНакопления(_Имя) Экспорт ИмяОбъектаКонфигурации = _Имя;	ПрефиксИмени = "AccumulationRegister"; 	Возврат ЭтотОбъект; КонецФункции
Функция БизнесПроцесс(_Имя) Экспорт ИмяОбъектаКонфигурации = _Имя;	ПрефиксИмени = "BusinessProcess"; Возврат ЭтотОбъект; КонецФункции
Функция Задача(_Имя) Экспорт ИмяОбъектаКонфигурации = _Имя;	ПрефиксИмени = "Task"; Возврат ЭтотОбъект; КонецФункции

//Суффиксы
Функция ТабличнаяЧасть(_Имя) Экспорт СуффиксИмени = _Имя; Возврат ЭтотОбъект; КонецФункции
Функция ВиртуальнаяТаблица(_Имя) Экспорт СуффиксИмени = _Имя; Возврат ЭтотОбъект; КонецФункции
Функция ТипСтрокиТабличнойЧасти(_Имя) Экспорт ВызватьИсключение "Формально RowType - но даная функциональность не реализована"; КонецФункции
Функция ЗаписьРегистра(_Имя) Экспорт СуффиксИмени = "RecordType"; КонецФункции



КлиентВеб = Новый КлиентВебAPI();
Лог = Логирование.ПолучитьЛог("oscript.lib.restler.odata");
