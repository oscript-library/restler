# restler
Помощник работы с различными RestAPI

# Назначение

Более удобная работа с JSON API, инкапсулирующая HTTPЗапросы и Ответы в вызовы методов.

```bsl

Клиент = Новый КлиентВебAPI();
Клиент.ИспользоватьСоединение(httpСоединениеСНастроеннойАвторизациейСертификатамиETC);
ИнформацияОПродажах = Клиент.Получить("sales/totals");

Для Каждого Инфо Из ИнформацияОПродажах Цикл
  Сообщить(СтрШаблон("Продано товара %1 на сумму %2", Инфо["nomenclature"], Инфо["sum"]));
КонецЦикла;

```

и удобная работа с OData от 1С

```bsl
СоединениеERP = Новый HTTPСоединение("https://erp.example.com", 443, "superadmin", "supersecret");

КлиентERP = Новый КлиентOData();
КлиентERP.ИспользоватьСоединениеИнформационнойБазы(СоединениеERP, "prod");

ДокументМенеджерЗаказПокупателя = КлиентERP.Документ("ЗаказПокупателя");
ЗаказыПокупателей = ДокументМенеджерЗаказПокупателя.ПолучитьВсе();
	
Для Каждого Заказ Из ЗаказыПокупателей Цикл

	Сообщить(СтрШаблон("Заказ %1 - на сумму %2", Заказ["Number"], Заказ["СуммаДокумента"]), СтатусСообщения.Важное);
	
  Контрагент = КлиентERP.Справочник("Контрагенты").ПолучитьСсылку(Заказ["Контрагент_Key"]);
		
	Сообщить(СтрШаблон("Контрагент %1 - вида %2", Контрагент["Description"], Контрагент["ВидКонтрагента"]), СтатусСообщения.Важное);

КонецЦикла;

// создание элементов

РезультатПоиска = КлиентERP.Справочник("КонтактныеЛица").ТабличнаяЧасть("КонтактнаяИнформация").ОтборПоРеквизиту("Представление", Клиент["email"]);
Если РезультатПоиска.Количество() = 0 Тогда

		РекзвитыСоздания = Новый Соответствие;
		РекзвитыСоздания.Вставить("Комментарий", "Загружено автоматически из oscript.restler");

		СтрокаТабличнойЧасти = Новый Соответствие;
		СтрокаТабличнойЧасти.Вставить("Представление", Клиент["email"]);
		СтрокаТабличнойЧасти.Вставить("Тип", "АдресЭлектроннойПочты");

		мКонтактнаяИнформация = Новый Массив();
		мКонтактнаяИнформация.Добавить(СтрокаТабличнойЧасти);

		РекзвитыСоздания.Вставить("КонтактнаяИнформация", мКонтактнаяИнформация);

		КлиентERP.Справочник("КонтактныеЛица").СоздатьЭлементСправочника(Клиент["email"],РекзвитыСоздания);
		
	КонецЕсли;

```

## Disclaimer

Активная фаза разработки. Библиотека действительно нужна
