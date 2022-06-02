# SimpleInterpreter
## Язык программирования *ruby* динамически типизированный язык, поэтому инициализация типов данных отсутствует. Для инициализации переменной необходимо просто написать её название и значение через знак равенства.

Уясним семантику понятий, для которых конструируется таблица идентификаторов. Собственно, структура таблицы:

![image](https://user-images.githubusercontent.com/47382305/171619115-88fb1381-eb7b-402e-9023-0e5f0efcc715.png)

Для организации таблицы и действия над ней была предусмотрена следующая структура:

1.  Класс Interpreter отвечает за операции над таблицей.

![image](https://user-images.githubusercontent.com/47382305/171619243-8b7e5ac2-551c-4ddc-a685-55d659291a3e.png)

2.  Класс Handler обрабатывает вводимые данные.

![image](https://user-images.githubusercontent.com/47382305/171619284-33eb1954-791e-46c3-9d59-a37665bf06b6.png)

- - -
## Результаты работы

1.  Справочная информация перед началом работы (вызывается командой *help*):

![image](https://user-images.githubusercontent.com/47382305/171619423-5dc972ee-02cc-49a7-aedc-8905b25401f0.png)

2.  Демонстрация работы с численными типами:

![image](https://user-images.githubusercontent.com/47382305/171619514-924d9f7a-f060-4f7b-8330-8056ce132f43.png)

![image](https://user-images.githubusercontent.com/47382305/171619522-fea6614d-e420-4cab-850f-688cdac507b6.png)

![image](https://user-images.githubusercontent.com/47382305/171619532-d03859cf-1122-47e9-87d3-f824ed8f6c32.png)

![image](https://user-images.githubusercontent.com/47382305/171619536-409f8410-e9a0-43ff-8b35-ba0f54a37b5b.png)

![image](https://user-images.githubusercontent.com/47382305/171619547-dfba1488-a509-42e6-ba84-3ae887da706c.png)

3.  Демонстрация работы с символьными типами:

![image](https://user-images.githubusercontent.com/47382305/171619726-6ed16711-b445-4dc5-9db1-85091c9bd6b4.png)

![image](https://user-images.githubusercontent.com/47382305/171619752-9420af45-27bb-4823-be53-2d1fce6f89c6.png)
