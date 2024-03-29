---
layout: post
title:  Резервне електропостачання
ref:    2023-05-08-reserve-power
lang:   uk
date:   2023-05-07 15:00:39 +03:00
tags:   електрика
---


Це історія про те, як я провів зиму, будуючи джерела резервного живлення, щоб
розібратися із відключеннями електроенергії. Коли росіяни почали втручатися в
нашу енергомережу, у нас почали діяти аварійні й планові відключення. Це
почало завдавати багато незручностей для нашої роботи, навчання дітей і нашого
щоденного життя. Я порадився із товаришем, який порадив використати гібридний
сонячний інвертор з літій-іонним акумулятором, щоб накопичувати енергію, коли
вона доступна, і споживати її під час відключень.

## Перемикання

Я замовив кілька гібридних інверторів на АліЕкспресі і чекав десь зо місяць,
як вони почали надходити. Коли ж вони з’явилися, я якраз гостював у батьків
і почав дивитися в електричний щиток, щоб з’ясувати, як краще підключити проводи.
Було кілька різних схем з різними входами (однофазні, трифазні), різним обсягом
вільного місця і різними вимогами. Всього я виконав чотири підключення, всі
дуже різні. Ось підсумок мого досвіду:

<p align="center" width="100%">
  <img src="/assets/2023-05/reserve-power.svg" width="75%"/>
</p>

Ця схема видається найбільш гнучкою у бажаних сценаріях:

* Мережа є і може живити будинок, включаючи заряджання акумулятора
* Мережа частково функціонує, деяких фаз немає, проте все ще може живити будинок однією фазою
* Мережі немає, бензиновий генератор живить будинок і заряджає акумулятор надлишковою енергією
* Генератор зупинено, інвертор живить будинок, використовуючи накопичену в акумуляторі енергію.

### Можливі комбінації

Перший перемикач — це триполюсний перемикач введення резерву I-0-II. Коли він у положенні I,
будинок під’єднано до мережі навпростець. Коли він в положенні II, будинок під’єднано
до резервного джерела енергії: генератора, інвертора чи просто якоїсь одної вибраної фази.

Другий перемикач — однополюсний I-0-II, яким можна перемкнути з’єднання або від безпосередньо
селектора, або з виходу інвертора.

Селектор — це поворотний вибір фази чи резерву I-0-II-0-III-0-IV-0. Він дозволяє вибрати
одну фазу з мережі або вихід генератора.

Тож, може бути багато різних способів підключення будинку, але розгляньмо найбільш
потрібні.

### Випадок 1: мережа є

Це нормальний стан, коли доступна дешева й потужна електрика з мережі.
Струм тече, наче до мого втручання в щиток. Можна зарядити батарею, вибравши
одну з фаз і увімкнувши постачання енергії на вхід інвертора.

<p align="center" width="100%">
  <img src="/assets/2023-05/reserve-power1.svg" width="75%"/>
</p>

### Випадок 2: немає деяких фаз

У випадку, коли є якась проблема в мережі, і хоча б одна з фаз присутня, будинок все ще можна
живити від мережі. Це підходить, якщо навантаження помірне з деяких міркувань.
Але досить перемкнути перемикач на резерв і вибрати фазу селектором, електрика буде у всьому
будинку, а не тільки частині.

<p align="center" width="100%">
  <img src="/assets/2023-05/reserve-power2.svg" width="75%"/>
</p>

### Випадок 3: генератор працює, але електрика пропускається через інвертор

Хоча можливо використовувати бензиновий генератор безпосередньо, більш доцільно
накопичувати надлишкову енергію у батарею. Справа в тому, щоб двигун внутрішнього
згоряння не дуже лінійний, і значна порція пального потрібна, щоб він просто працював.
Додавання навантаження, звісно, збільшить споживання пального, але не обов’язково
пропорційно. Більше того, генератор потребує зупинки для догляду: або просто
поповнення пального, або для зміни оливи і чищення фільтрів.

<p align="center" width="100%">
  <img src="/assets/2023-05/reserve-power3.svg" width="75%"/>
</p>

### Випадок 4: немає живлення, інвертор працює від батареї

Тож це остання можливість, коли більше нічого не працює: без мережі, без генератора.
Інвертор не створює багато шуму, хіба що вмикаються вентилятори охолодження в залежності
від поточного навантаження.
Обмеженням в цьому випадку є ємність батареї. 120&nbsp;Аг більше, ніж досить, щоб вистачило
на кілька годин для освітлення, зв’язку і періодичного підкачування води.

<p align="center" width="100%">
  <img src="/assets/2023-05/reserve-power4.svg" width="75%"/>
</p>

## Демонстрація

### Будинок батьків

Будинок живиться від однієї фази мережі.
Запобіжник і з’єднувач Андерсона були додані пізніше.

![Щиток](/assets/2023-05/parents0.jpg)
![Інвертор](/assets/2023-05/parents1.jpg)

<iframe width="560" height="315" src="https://www.youtube.com/embed/LeAzsSsG7Ps" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

### Будинок тестя

Трифазне постачання з мережі.
Було використано свинцеві акумулятори, тому що їм потрібно менше догляду, ніж літієвим,
і мережева електрика була більш доступна о тій порі. Це було перше трифазне підключення,
і знадобилася окрема коробка для перемикачів і селектора.

![Огляд](/assets/2023-05/parents2.jpg)

<iframe width="560" height="315" src="https://www.youtube.com/embed/gOWEL1YNkFs" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

### Наша квартира в Києві

Однофазне постачання. Місця було дуже мало, проте все ще досить для двох нових деталей.

![Щиток](/assets/2023-05/appartment.jpg)
![Інвертор](/assets/2023-05/appartment2.jpg)

<iframe width="560" height="315" src="https://www.youtube.com/embed/AhoMDwEC_s8" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

### Дача

Цього разу вдалося скористатися вже прокладеним кабелем від щитка до технічної кімнати.
Електричний котел не використовувався і навряд чи буде працювати в майбутньому.
Тож я просто перепризначив ті самі проводи.

![Щиток](/assets/2023-05/house1.jpg)
![Інвертор](/assets/2023-05/house2.jpg)

<iframe width="560" height="315" src="https://www.youtube.com/embed/PIUN383YU18" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>


## Переносне джерело живлення

Після двох підключень, залишався тільки один інвертор на два різних місця.
В цей момент я збагнув, що можливо один і той самий інвертор разом з батареєю
переносити. Справді, для підключення потрібно з’єднати тільки чотири проводи:
вхід, вихід, нейтраль і заземлення. Я вибрав стандартну вилку й розетки до неї
на 16A 4-лінії, призначивши з’єднання таким чином:

| Вихід | Колір провода                              | Призначення     |
|-------|--------------------------------------------|-----------------|
| Земля | <span style="color:blue">█</span> синій    | Нейтраль        |
| 1     | <span style="color:black">█</span> чорний  | Вхід інвертора  |
| 2     | <span style="color:yellow">█</span> жовтий | Заземлення      |
| 3     | <span style="color:red">█</span> червоний  | Вихід інвертора |

Таким з’єднувачем інвертор можна під’єднувати не тільки до будинку, але й до
спеціального подовжувача, який я зробив окремо. Тепер інвертор міг би живити
зарядом акумулятора якесь обладнання на природі. І навіть можна було б заряджати
акумулятор від генератора.

![Extension cable](/assets/2023-05/extension.jpg)

## Проблеми

Особливо обережно треба ставитися до підключення генератора. Зазвичай, генератори
з розетками для вилок типу F дозволяють підключити навантаження в довільному напрямку:
або N-L, або L-N. І це не має ніякого значення для побутових приладів.
Але в нашому випадку важливо під’єднати нейтраль до нейтралі і фазу до фази у схемі
перемикання. Я не досліджував, що станеться, якщо під’єднати неправильно.
Мій план пом’якшення — використовувати асиметричні вилки типу F, і ретельно перевіряти
стан фази перед підключенням з допомогою пробника.
