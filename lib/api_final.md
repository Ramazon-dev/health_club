Записи на первую тренировку

**GET** `/trainings/first`

Возвращает список всех запланированных первых тренировок (вводных).

| Параметр   | Тип     | Описание                                     |
| ---------- | ------- | -------------------------------------------- |
| `place_id` | integer | Фильтр по клубу                              |
| `date`     | string  | Фильтр по дате (Y-m-d)                       |
| `limit`    | integer | Количество записей (max: 100, default: все)  |

**Примеры:**
- `GET /trainings/first` — все будущие записи
- `GET /trainings/first?place_id=1` — записи в клубе ID=1
- `GET /trainings/first?date=2026-01-30` — записи на конкретную дату
- `GET /trainings/first?limit=10` — первые 10 записей

**Ответ:**

```json
{
  "success": true,
  "count": 3,
  "data": [
    {
      "id": 123,
      "client_id": 36048,
      "client_name": "Иван Иванов",
      "client_phone": "+77001234567",
      "place_id": 1,
      "place_title": "Oltintepa",
      "date": "2026-01-30",
      "time": "10:00",
      "datetime": "2026-01-30 10:00:00",
      "created_at": "2026-01-29 15:30:00"
    },
    {
      "id": 124,
      "client_id": 36049,
      "client_name": "Петр Петров",
      "client_phone": "+77009876543",
      "place_id": 1,
      "place_title": "Oltintepa",
      "date": "2026-01-30",
      "time": "10:30",
      "datetime": "2026-01-30 10:30:00",
      "created_at": "2026-01-29 16:00:00"
    }
  ]
}

# API v2 Client - Полная документация

**Версия:** 2.0.0  
**Последнее обновление:** 2026-01-15  
**Base URL:** `https://api.crm1.35minut.club/api/v2/client`

> ⚠️ Все запросы (кроме авторизации) требуют заголовок:
> `Authorization: Bearer <token>`

---

## Содержание

1. [Авторизация](#1-авторизация)
2. [Wizard (Анкета)](#2-wizard-анкета)
3. [Профиль клиента](#3-профиль-клиента)
4. [История клиента](#4-история-клиента)
5. [Замеры и показатели](#5-замеры-и-показатели)
6. [Календарь](#6-календарь)
7. [Дневник питания](#7-дневник-питания)
8. [Карта и Партнеры](#8-карта-и-партнеры)
9. [Бронирование](#9-бронирование)
10. [Рейтинг и Отзывы](#10-рейтинг-и-отзывы)
11. [Чат (Поддержка)](#11-чат-поддержка)
12. [QR Scanner](#12-qr-scanner)

---

## 1. Авторизация

Поддерживает три варианта входа:

1. **Только SMS** — вход по коду из SMS (без пароля)
2. **SMS + Пароль** — регистрация с паролем через SMS верификацию
3. **Прямой вход по паролю** — без SMS, сразу токен

---

### 1.1. Отправка SMS кода

**POST** `/login`

Отправляет 4-значный код на телефон. Опционально принимает пароль для сохранения после верификации.

**Запрос:**

```json
{
    "phone": "+77001234567",
    "password": "mypassword123"
}
```

| Поле       | Тип    | Required | Описание                                |
| ---------- | ------ | -------- | --------------------------------------- |
| `phone`    | string | ✅       | Телефон в международном формате         |
| `password` | string | ❌       | Пароль для сохранения (мин. 6 символов) |

**Ответ (успех):**

```json
{
    "success": ["4 digit code sent to +77001234567"],
    "is_new": true,
    "has_password": false,
    "channel": "sms"
}
```

| Поле           | Тип     | Описание                                         |
| -------------- | ------- | ------------------------------------------------ |
| `success`      | array   | Сообщение об успешной отправке                   |
| `is_new`       | boolean | `true` — новый пользователь                      |
| `has_password` | boolean | `true` — пароль будет сохранён после верификации |
| `channel`      | string  | Канал доставки: `sms` или `whatsapp`             |

**Ошибки:**

```json
// 422 — Некорректный телефон
{ "success": false, "message": "Некорректный номер телефона", "error_code": "invalid_phone" }

// 500 — Не удалось отправить SMS
{ "success": false, "message": "Не удалось отправить код подтверждения", "error_code": "sms_send_failed" }
```

---

### 1.2. Верификация SMS кода

**POST** `/code`

Проверяет код и выдаёт токен. Если при `/login` был передан пароль — он сохраняется.

**Запрос:**

```json
{
    "code": 1234
}
```

| Поле   | Тип     | Required | Описание             |
| ------ | ------- | -------- | -------------------- |
| `code` | integer | ✅       | 4-значный код из SMS |

**Ответ (успех):**

```json
{
    "token": "1|abc123...",
    "wizard": true,
    "has_password": true
}
```

| Поле           | Тип     | Описание                                            |
| -------------- | ------- | --------------------------------------------------- |
| `token`        | string  | Bearer токен для авторизации                        |
| `wizard`       | boolean | `true` — нужно показать wizard (новый пользователь) |
| `has_password` | boolean | `true` — у пользователя есть пароль                 |

**Ошибки:**

```json
// 401 — Неверный код
{ "success": false, "message": "Неверный код подтверждения", "error_code": "invalid_code" }

// 401 — Ошибка авторизации
{ "success": false, "message": "Ошибка авторизации", "error_code": "auth_failed" }
```

---

### 1.3. Прямой вход по паролю

**POST** `/login-password`

Авторизация без SMS, сразу по паролю. Работает только если у пользователя уже есть пароль.

**Запрос:**

```json
{
    "phone": "+77001234567",
    "password": "mypassword123"
}
```

| Поле       | Тип    | Required | Описание                        |
| ---------- | ------ | -------- | ------------------------------- |
| `phone`    | string | ✅       | Телефон в международном формате |
| `password` | string | ✅       | Пароль пользователя             |

**Ответ (успех):**

```json
{
    "token": "1|abc123...",
    "wizard": false,
    "has_password": true
}
```

**Ошибки:**

```json
// 404 — Пользователь не найден
{ "success": false, "message": "Пользователь не найден", "error_code": "user_not_found" }

// 403 — Пароль не установлен
{ "success": false, "message": "Пароль не установлен. Используйте вход по SMS", "error_code": "password_not_set" }

// 401 — Неверный пароль
{ "success": false, "message": "Неверный пароль", "error_code": "invalid_password" }
```

---

### 1.4. Выход

**POST** `/logout`

Завершает сессию пользователя (удаляет токен).

**Ответ:**

```json
{
    "success": ["Logged out successfully"]
}
```

---

### 1.5. Безопасность

-   SMS коды действительны **5 минут**
-   Максимум **3 попытки** ввода кода
-   Повторная отправка SMS через **60 секунд**
-   Пароль минимум **6 символов**
-   Rate limit: **5 запросов/минуту** на телефон

---

## 2. Wizard (Анкета)

### 2.0. Общий эндпоинт

**GET** `/wizard`

Возвращает полное состояние wizard со всеми данными клиента и статусом заполненности.

```json
{
    "wizard": true,
    "step": 2,
    "filled": {
        "name": true,
        "concerns": false,
        "problems": false,
        "height": false,
        "weight": false,
        "birthday": false,
        "gender": false,
        "goals": false,
        "address": false,
        "place_id": false,
        "first_training": false
    },
    "data": {
        "name": "Иван",
        "surname": null,
        "birthday": null,
        "gender": null,
        "height": null,
        "weight": null,
        "address": null,
        "place_id": null,
        "concerns": {
            "selected": [],
            "custom_text": null
        },
        "problems": {
            "selected": [],
            "custom_text": null
        },
        "goals": {
            "selected": [],
            "custom_text": null
        },
        "training": null
    }
}
```

| Поле     | Тип     | Описание                                          |
| -------- | ------- | ------------------------------------------------- |
| `wizard` | boolean | `true` — нужно показать wizard                    |
| `step`   | number  | Текущий шаг (1-7) или `null` если wizard завершён |
| `filled` | object  | Статус заполненности каждого поля (true/false)    |
| `data`   | object  | Все данные клиента                                |

---

### 2.1. Шаг 1: Имя

**GET** `/wizard/1`

```json
{
    "step": 1,
    "data": {
        "name": "Клиент"
    }
}
```

**POST** `/wizard/1`

```json
{
    "name": "Иван"
}
```

| Поле   | Тип    | Обязательное | Описание    |
| ------ | ------ | ------------ | ----------- |
| `name` | string | ✅           | Имя клиента |

---

### 2.2. Шаг 2: Что вас беспокоит?

**GET** `/wizard/2`

```json
{
    "step": 2,
    "data": {
        "selected": ["Боли в спине"],
        "custom_text": null
    },
    "options": [
        {
            "text": "Боли в спине",
            "answer": "Мы знаем, это неприятно!...",
            "selected": true
        },
        {
            "text": "Боли в суставах",
            "answer": "Правильные упражнения...",
            "selected": false
        },
        {
            "text": "Проблемы с осанкой",
            "answer": "Красивая осанка...",
            "selected": false
        },
        {
            "text": "Лишний вес",
            "answer": "Вместе мы справимся!...",
            "selected": false
        },
        {
            "text": "Низкая выносливость",
            "answer": "Выносливость тренируется!...",
            "selected": false
        },
        {
            "text": "Слабые мышцы",
            "answer": "Сила придёт!...",
            "selected": false
        },
        {
            "text": "Проблемы со сном",
            "answer": "Физическая активность...",
            "selected": false
        },
        {
            "text": "Стресс и тревожность",
            "answer": "Тренировки - лучший антистресс!...",
            "selected": false
        },
        {
            "text": "Другое",
            "answer": "Мы разберёмся вместе!...",
            "selected": false
        }
    ]
}
```

**POST** `/wizard/2`

**Параметры:**

| Поле          | Тип      | Описание                              |
| ------------- | -------- | ------------------------------------- |
| `selected`    | string[] | Массив выбранных опций (мультиселект) |
| `custom_text` | string   | Кастомный текст (опционально)         |

```json
{
    "selected": ["Боли в спине", "Стресс и тревожность"],
    "custom_text": "Иногда болит колено"
}
```

---

### 2.3. Шаг 3: Что мешает заниматься?

**GET** `/wizard/3`

```json
{
    "step": 3,
    "data": {
        "selected": [],
        "custom_text": null
    },
    "options": [
        {
            "text": "Сидячий образ жизни",
            "answer": "Пора это менять!...",
            "selected": false
        },
        {
            "text": "Нерегулярное питание",
            "answer": "Наши специалисты...",
            "selected": false
        },
        {
            "text": "Недостаток сна",
            "answer": "Регулярные тренировки...",
            "selected": false
        },
        {
            "text": "Отсутствие мотивации",
            "answer": "Наши тренеры заряжают!...",
            "selected": false
        },
        {
            "text": "Нехватка времени",
            "answer": "30 минут 2-3 раза в неделю...",
            "selected": false
        },
        {
            "text": "Травмы в прошлом",
            "answer": "Мы учтём это...",
            "selected": false
        },
        {
            "text": "Хронические заболевания",
            "answer": "Тренировки адаптируем...",
            "selected": false
        },
        {
            "text": "Другое",
            "answer": "Обсудим на консультации!",
            "selected": false
        }
    ]
}
```

**POST** `/wizard/3`

**Параметры:**

| Поле          | Тип      | Описание                              |
| ------------- | -------- | ------------------------------------- |
| `selected`    | string[] | Массив выбранных опций (мультиселект) |
| `custom_text` | string   | Кастомный текст (опционально)         |

```json
{
    "selected": ["Сидячий образ жизни", "Нехватка времени"],
    "custom_text": null
}
```

---

### 2.4. Шаг 4: Физические данные

**GET** `/wizard/4`

```json
{
    "step": 4,
    "data": {
        "height": null,
        "weight": null,
        "birthday": null,
        "gender": "M"
    }
}
```

**POST** `/wizard/4`

```json
{
    "height": 175,
    "weight": 80,
    "birthday": "1990-05-15",
    "gender": "M"
}
```

| Поле       | Тип    | Обязательное | Описание                             |
| ---------- | ------ | ------------ | ------------------------------------ |
| `height`   | number | ✅           | Рост в см                            |
| `weight`   | number | ✅           | Вес в кг                             |
| `birthday` | string | ✅           | Дата рождения (YYYY-MM-DD)           |
| `gender`   | string | ✅           | Пол: `M` (мужской) или `W` (женский) |

---

### 2.5. Шаг 5: Цель тренировок

**GET** `/wizard/5`

```json
{
    "step": 5,
    "data": {
        "selected": [],
        "custom_text": null
    },
    "options": [
        {
            "text": "Похудеть",
            "answer": "Отличная цель!...",
            "selected": false
        },
        {
            "text": "Набрать мышечную массу",
            "answer": "Силовые тренировки...",
            "selected": false
        },
        {
            "text": "Улучшить выносливость",
            "answer": "Кардио + силовые...",
            "selected": false
        },
        {
            "text": "Укрепить здоровье",
            "answer": "Здоровье - лучшая инвестиция!...",
            "selected": false
        },
        {
            "text": "Избавиться от болей",
            "answer": "Правильные упражнения...",
            "selected": false
        },
        {
            "text": "Улучшить осанку",
            "answer": "Красивая осанка...",
            "selected": false
        },
        {
            "text": "Повысить гибкость",
            "answer": "Гибкость - молодость тела!...",
            "selected": false
        },
        {
            "text": "Снизить стресс",
            "answer": "Тренировки - лучший способ...",
            "selected": false
        },
        {
            "text": "Подготовиться к событию",
            "answer": "Вы будете в лучшей форме!...",
            "selected": false
        },
        {
            "text": "Другое",
            "answer": "Расскажете подробнее!...",
            "selected": false
        }
    ]
}
```

**POST** `/wizard/5`

**Параметры:**

| Поле          | Тип      | Описание                              |
| ------------- | -------- | ------------------------------------- |
| `selected`    | string[] | Массив выбранных целей (мультиселект) |
| `custom_text` | string   | Кастомная цель (опционально)          |

```json
{
    "selected": ["Похудеть", "Улучшить самочувствие"],
    "custom_text": "Хочу пробежать марафон"
}
```

---

### 2.6. Шаг 6: Адрес

**GET** `/wizard/6`

```json
{
    "step": 6,
    "data": {
        "address": ""
    }
}
```

**POST** `/wizard/6`

```json
{
    "address": "Ташкент, Юнусабад, 14 квартал"
}
```

| Поле      | Тип    | Обязательное | Описание         |
| --------- | ------ | ------------ | ---------------- |
| `address` | string | ✅           | Адрес проживания |

---

### 2.7. Шаг 7: Выбор клуба и запись на тренировку

**GET** `/wizard/7`

```json
{
    "step": 7,
    "data": {
        "surname": "№36048",
        "place_id": 24,
        "date": null,
        "time": null
    },
    "places": [
        {
            "id": 1,
            "title": "Oltintepa",
            "address": "ул. Олтинтепа, 26/28",
            "selected": true
        },
        {
            "id": 2,
            "title": "Bodomzar",
            "address": "90 Bogishamol Street",
            "selected": false
        }
    ]
}
```

**GET** `/wizard/slots` — Получение доступных слотов

| Параметр   | Тип    | Обязательное | Описание          |
| ---------- | ------ | ------------ | ----------------- |
| `date`     | string | ✅           | Дата (YYYY-MM-DD) |
| `place_id` | number | ✅           | ID клуба          |

**Пример:** `GET /wizard/slots?date=2025-12-20&place_id=1`

**Ответ:**

```json
{
    "slots": ["08:00", "08:30", "09:00", "14:00", "14:30"]
}
```

> **Логика слотов:**
>
> -   **Время работы:** 08:00 - 20:00 (шаг 30 мин)
> -   **Буфер:** Слоты доступны минимум через 3 часа от текущего времени
> -   **Занятость:** Если на это время уже есть запись — слот скрывается
> -   **Дни работы:** UZ: Пн-Сб | KZ: Пн-Вс

**POST** `/wizard/7`

```json
{
    "surname": "Иванов",
    "place_id": 1,
    "date": "2025-12-20",
    "time": "10:00"
}
```

| Поле       | Тип    | Обязательное | Описание                     |
| ---------- | ------ | ------------ | ---------------------------- |
| `surname`  | string | ✅           | Фамилия клиента              |
| `place_id` | number | ✅           | ID выбранного клуба          |
| `date`     | string | ✅           | Дата тренировки (YYYY-MM-DD) |
| `time`     | string | ✅           | Время тренировки (HH:MM)     |

**Ответ (wizard завершён):**

```json
{
    "success": ["Wizard completed"],
    "step": 7,
    "wizard": false
}
```

---

### 2.8. Пропуск wizard

**POST** `/wizard/skip`

Пропускает wizard и переводит на шаг 7 (выбор клуба).

```json
{
    "success": ["Skipped to step 7"],
    "step": 7
}
```

---

### 2.9. Справочники

**GET** `/wizard/places` — Список клубов

```json
[
    { "id": 1, "title": "Oltintepa", "address": "ул. Олтинтепа, 26/28" },
    { "id": 2, "title": "Bodomzar", "address": "90 Bogishamol Street" }
]
```

**GET** `/wizard/concerns` — Список "Беспокойств"  
**GET** `/wizard/problems` — Список "Проблем"  
**GET** `/wizard/goals` — Список "Целей"

---

## 3. Профиль клиента

### 3.1. Получить профиль

**GET** `/me`

```json
{
    "data": {
        "places": ["Oltintepa"],
        "id": 36048,
        "name": "Иван",
        "surname": "Иванов",
        "email": null,
        "gender": "M",
        "in_place": 0,
        "level": { "title": "Start", "total": 10 },
        "level_visit": 5,
        "is_loyality": 1,
        "subscription": {
            "id": 123,
            "membership_id": 1,
            "name": "1 Month",
            "daysLeft": 25,
            "daysFreeze": 0,
            "status": 1,
            "start_at": "2025-12-01",
            "membership": { "id": 1, "title": "1 Month", "by_visit": 0 },
            "freezes": [],
            "freeze": null,
            "plus_days": 0
        },
        "reservations": [],
        "plus": 0,
        "debitor_date": { "date": null, "status": 0 }
    }
}
```

---

### 3.2. Получить данные профиля (для редактирования)

**GET** `/profile`

```json
{
    "name": "Agnes",
    "surname": "Kalnina",
    "email": "example@gmail.com",
    "phone": "+998901234567",
    "birthday": "2003-11-28",
    "gender": "female",
    "avatar": "http://api.crm1.35minut.club/storage/avatars/...",
    "goals": {
        "selected": ["Похудеть", "Улучшить самочувствие"],
        "custom_text": "Хочу пробежать марафон"
    },
    "subscription": {
        "name": "Месячный",
        "started_at": "2025-09-30",
        "ended_at": "2025-10-12",
        "daysLeft": 12,
        "is_frozen": false,
        "freeze_days_left": 7,
        "freeze_days_total": 7,
        "plus_days": 5
    },
    "month_progress": {
        "current": 3,
        "target": 10,
        "percent": 30
    }
}
```

---

### 3.3. Обновить профиль

**POST** `/profile`  
**Content-Type:** `multipart/form-data` (если загружается аватар)

| Поле       | Тип    | Обязательное | Описание                 |
| ---------- | ------ | ------------ | ------------------------ |
| `name`     | string | ✅           | Имя                      |
| `surname`  | string | ✅           | Фамилия                  |
| `phone`    | string | ✅           | Телефон                  |
| `email`    | email  | ❌           | Email                    |
| `birthday` | date   | ❌           | Дата рождения (Y-m-d)    |
| `gender`   | string | ❌           | Пол: `male` или `female` |
| `goal`     | string | ❌           | Цель тренировок          |
| `avatar`   | file   | ❌           | Аватар (image, max 10MB) |

**Ответ:**

```json
{
    "success": true,
    "message": "Профиль успешно обновлён",
    "data": {
        "avatar": "http://api.crm1.35minut.club/storage/avatars/..."
    }
}
```

---

### 3.4. Смена пароля

**PUT** `/password`

| Поле                    | Тип    | Обязательное | Описание                      |
| ----------------------- | ------ | ------------ | ----------------------------- |
| `password`              | string | ✅           | Новый пароль (min 8 символов) |
| `password_confirmation` | string | ✅           | Подтверждение пароля          |

**Ответ:**

```json
{
    "success": true,
    "message": "Пароль успешно обновлён"
}
```

---

## 4. История клиента

### 4.1. История платежей

**GET** `/history/payments`

```json
[
    {
        "date": "Сегодня",
        "items": [
            {
                "id": 123,
                "title": "Abonement 12 mashg'ulot",
                "amount": 1200000,
                "currency": "UZS",
                "payment_method": "Click",
                "time": "14:30"
            }
        ]
    }
]
```

---

### 4.2. История заморозок

**GET** `/history/freezes`

```json
[
    { "id": 2099, "start_date": "01.11.2024", "end_date": "07.11.2024" },
    { "id": 1528, "start_date": "17.07.2024", "end_date": "28.07.2024" }
]
```

---

### 4.3. Заморозка абонемента

**POST** `/freeze`

| Поле         | Тип     | Обязательное | Описание                                 |
| ------------ | ------- | ------------ | ---------------------------------------- |
| `days`       | integer | ✅           | Количество дней (min: 1)                 |
| `start_date` | date    | ✅           | Дата начала (Y-m-d, сегодня или будущее) |

**Ответ (успех):**

```json
{ "message": "Абонемент успешно заморожен" }
```

**Ошибки:**

```json
// 404 — Нет активного абонемента
{ "success": false, "message": "Нет активного абонемента", "error_code": "no_active_subscription" }

// 400 — Недостаточно дней заморозки
{ "success": false, "message": "Недостаточно дней заморозки", "error_code": "not_enough_freeze_days" }
```

---

### 4.4. История договоров/абонементов

**GET** `/history/subscriptions`

**Query Params:** `status` (optional): `all`, `active`, `expired`

```json
[
    {
        "date": "30.09.2025",
        "items": [
            {
                "id": 13593,
                "title": "[2025][1+1] 12 VIP",
                "start_date": "30.09.2025",
                "end_date": null,
                "price": 6500000,
                "currency": "UZS",
                "status": "Активен",
                "status_color": "green",
                "file_url": "http://api.crm1.35minut.club/files/..."
            }
        ]
    }
]
```

---

### 4.5. История тренировок

**GET** `/history/trainings`

```json
[
    {
        "date": "Сегодня",
        "items": [
            {
                "id": 8462,
                "time_range": "18:05 - 19:10",
                "type": "Силовая тренировка",
                "club": "35'Health Clubs — Центр",
                "trainer": "Алексей Ильин"
            }
        ]
    }
]
```

---

### 4.6. История тренировок с пагинацией

**GET** `/history/trainings/paginated?page=1&per_page=10`

| Параметр   | Тип     | Default | Описание            |
| ---------- | ------- | ------- | ------------------- |
| `page`     | integer | 1       | Номер страницы      |
| `per_page` | integer | 10      | Записей на странице |

```json
{
    "success": true,
    "data": [
        {
            "date": "Сегодня",
            "items": [...]
        }
    ],
    "pagination": {
        "current_page": 1,
        "per_page": 10,
        "total": 45,
        "has_more": true,
        "next_page": 2
    }
}
```

---

### 4.7. История замеров Tanita

**GET** `/history/measures`

```json
[
    {
        "date": "25.11.2024",
        "items": [
            {
                "id": 2,
                "weight": "78.3",
                "fat_percent": "23.5",
                "muscle_mass": "31.2",
                "visceral_fat": "11",
                "metabolic_age": "37",
                "file_url": null
            }
        ]
    }
]
```

---

## 5. Замеры и показатели

### 5.1. Дашборд тренировок

**GET** `/trainings/dashboard`

```json
{
    "trainings_this_month": 7,
    "trainings_norm": 10,
    "interval_status": "norm",
    "interval_status_text": "В норме",
    "next_load_change": 3,
    "next_load_change_text": "через 3 трен.",
    "next_tanita_measure": 5,
    "next_tanita_measure_text": "через 5 трен.",
    "recent_trainings": [
        { "date": "14.01.2026", "time": "10:30", "check_in": true },
        { "date": "12.01.2026", "time": "11:00", "check_in": true }
    ]
}
```

| Поле                   | Описание                            |
| ---------------------- | ----------------------------------- |
| `trainings_this_month` | Тренировок в текущем месяце         |
| `trainings_norm`       | Норма тренировок (10)               |
| `interval_status`      | Статус интервала: `norm`, `warning` |
| `next_load_change`     | Тренировок до смены нагрузки        |
| `next_tanita_measure`  | Тренировок до замеров Tanita        |

---

### 5.3. Tanita — Текущие данные

**GET** `/tanita`

```json
{
    "current": {
        "date": "08.01.2026",
        "height": "177",
        "weight": "78",
        "fat_percent": "27.1",
        "muscle_mass": "69.2",
        "visceral_fat": "6",
        "metabolic_age": "40",
        "bone_mass": "2.9",
        "water_percent": "53.9",
        "bmr": "1657"
    },
    "next_measure_in": 14,
    "next_measure_text": "через 14 трен.",
    "history": [...]
}
```

| Поле            | Описание                     |
| --------------- | ---------------------------- |
| `height`        | Рост (см)                    |
| `weight`        | Вес (кг)                     |
| `fat_percent`   | Процент жира (%)             |
| `muscle_mass`   | Мышечная масса (кг)          |
| `visceral_fat`  | Висцеральный жир (уровень)   |
| `metabolic_age` | Метаболический возраст (лет) |
| `bone_mass`     | Костная масса (кг)           |
| `water_percent` | Процент воды (%)             |
| `bmr`           | Базальный метаболизм (ккал)  |

---

### 5.4. Нагрузки — Текущие данные

**GET** `/loads`

```json
{
    "current": {
        "date": "31.10.2025",
        "machine-1-con": "75",
        "machine-2-con": "15",
        "machine-2-ecc": "3",
        ...
    },
    "next_change_in": 0,
    "next_change_text": "Сейчас",
    "history": [...]
}
```

**Machines Mapping:**

-   `machine-1` = A1 (только con)
-   `machine-2` = A2 (con + ecc)
-   `machine-3` = A3 (con + ecc)
-   `machine-4` = A4 (con + ecc)
-   `machine-5` = B1 (только con)
-   `machine-6` = B2 (con + ecc)
-   `machine-7` = B3 (con + ecc)
-   `machine-8` = B4 (con + ecc)

---

### 5.5. Прогноз результатов

**GET** `/forecast`

```json
{
    "start": {
        "date": "2024-01-01",
        "weight_kg": 110.0,
        "fat_percent": 35.0,
        "muscle_mass_kg": 71.5
    },
    "target": {
        "target_body_fat_percent": 22.0,
        "target_muscle_mass_kg": 73.0,
        "target_total_weight_kg": 93.6
    },
    "current": {
        "date": "2024-06-01",
        "weight_kg": 105.0,
        "fat_percent": 30.0,
        "muscle_mass_kg": 73.5
    },
    "forecast": {
        "target_body_fat_percent": 22.0,
        "target_muscle_mass_kg": 75.0,
        "target_total_weight_kg": 96.2
    }
}
```

---

### 5.6. Ежедневные показатели — Сегодня

**GET** `/metrics/today`

```json
{
    "water_ml": 1500,
    "water_norm": 2550,
    "sleep_hours": 7.5,
    "sleep_norm": 8,
    "sleep_start": "23:30",
    "sleep_end": "07:00",
    "steps": 5000,
    "steps_norm": 8000
}
```

| Поле         | Тип     | Описание                               |
| ------------ | ------- | -------------------------------------- |
| `water_ml`   | integer | Выпито воды за сегодня (мл)            |
| `water_norm` | integer | Норма воды = вес × 30 мл (или 2000 мл) |
| `sleep_norm` | float   | Норма сна = 8 ч                        |
| `steps_norm` | integer | Норма шагов = 8000 в день              |

---

### 5.7. Обновить показатели

**POST** `/metrics`

| Поле          | Тип     | Описание                                           |
| ------------- | ------- | -------------------------------------------------- |
| `water_ml`    | integer | **Накапливается** (каждый вызов добавляет к сумме) |
| `sleep_hours` | float   | Перезаписывается                                   |
| `sleep_start` | string  | Время засыпания (HH:MM)                            |
| `sleep_end`   | string  | Время пробуждения (HH:MM)                          |
| `steps`       | integer | **Накапливается** (каждый вызов добавляет к сумме) |

```json
{ "success": true, "message": "Метрики обновлены" }
```

---

### 5.8. Дашборд показателей

**GET** `/metrics/dashboard`

```json
{
    "water": {
        "current": 2600,
        "norm": 2550,
        "unit": "мл",
        "status": "norm",
        "status_text": "В норме"
    },
    "sleep": {
        "current": 7.2,
        "norm": 8,
        "unit": "ч",
        "status": "below",
        "status_text": "Ниже нормы"
    },
    "steps": {
        "current": 5000,
        "norm": 8000,
        "unit": "шагов",
        "status": "below",
        "status_text": "Ниже нормы"
    }
}
```

**Статусы:** `norm`, `below`, `reached`

---

### 5.9. История показателей

**GET** `/metrics/history?type=water` (или `sleep`, `steps`)

```json
[
    { "date": "19.12.2025", "value": 2600 },
    { "date": "18.12.2025", "value": 2400 }
]
```

---

### 5.10. История воды

**GET** `/metrics/water-history?days=30`

| Параметр | Тип     | Default | Описание                 |
| -------- | ------- | ------- | ------------------------ |
| `days`   | integer | 30      | Количество дней (max 90) |

```json
{
    "history": [
        {
            "date": "2026-01-09",
            "total_ml": 550,
            "logs": [
                { "id": 5, "amount_ml": 250, "logged_at": "09:30" },
                { "id": 6, "amount_ml": 300, "logged_at": "11:45" }
            ]
        },
        {
            "date": "2026-01-08",
            "total_ml": 2100,
            "logs": [...]
        }
    ]
}
```

---

### 5.11. Удалить запись о воде

**DELETE** `/metrics/water/{id}`

```json
{ "success": true, "total_ml": 500 }
```

---

## 6. Календарь

**GET** `/calendar`

Типы событий:

-   `first-visit` — Вводная тренировка (планируемая)
-   `reservation` — Резервация у партнера
-   `training` — Прошедшая тренировка

```json
{
    "upcoming": [
        {
            "id": 123,
            "type": "reservation",
            "title": "Кардио/Силовая тренировка",
            "subtitle": "Partner Name",
            "date": "2025-10-18",
            "time_start": "18:00",
            "time_end": "19:00",
            "datetime_start": "2025-10-18 18:00:00",
            "location": "Address...",
            "status": "upcoming",
            "can_cancel": true,
            "can_reschedule": false
        }
    ],
    "past": [...]
}
```

---

## 7. Дневник питания

### 7.1. Питание за день

**GET** `/nutrition/day?date=2026-01-09`

```json
{
    "breakfast": {
        "has_photo": true,
        "images": ["http://.../img1.jpg", "http://.../img2.jpg"],
        "status": "analyzed",
        "analysis": {
            "name": "Oatmeal with fruits",
            "calories": 350,
            "protein": 12,
            "fat": 6,
            "carbs": 60,
            "rating": 9,
            "verdict": "Отличный завтрак",
            "recommendation": "Добавьте орехи для полезных жиров"
        }
    },
    "lunch": { ... },
    "dinner": { ... }
}
```

---

### 7.2. Загрузить фото еды

**POST** `/nutrition/upload`  
**Content-Type:** `multipart/form-data`

| Поле    | Тип    | Обязательное | Описание                       |
| ------- | ------ | ------------ | ------------------------------ |
| `image` | File   | ✅           | Фото (max 10MB)                |
| `type`  | string | ✅           | `breakfast`, `lunch`, `dinner` |
| `date`  | date   | ❌           | YYYY-MM-DD (default: today)    |

**Ответ:**

```json
{
    "success": true,
    "message": "Фото успешно загружено",
    "meal": {
        "has_photo": true,
        "image_url": "...",
        "status": "pending",
        "analysis": null
    }
}
```

**Ошибка (дубликат):**

```json
{
    "success": false,
    "message": "Это фото уже использовалось",
    "error_code": "duplicate_image"
}
```

---

### 7.3. AI Анализ питания

**POST** `/nutrition/analyze`

| Поле   | Тип  | Обязательное | Описание                    |
| ------ | ---- | ------------ | --------------------------- |
| `date` | date | ❌           | YYYY-MM-DD (default: today) |

Запускает AI анализ для всех фото со статусом `pending`.

```json
{
    "success": true,
    "message": "Анализ завершён",
    "results": { "breakfast": {...}, "dinner": {...} }
}
```

---

### 7.4. История питания

**GET** `/nutrition/history?start_date=2025-12-01&end_date=2025-12-07`

```json
[
    { "date": "19.12.2025", "breakfast": {...}, "lunch": {...}, "dinner": {...} },
    ...
]
```

---

## 8. Карта и Партнеры

### 8.1. Объекты на карте

**GET** `/map`

| Параметр                | Тип     | Описание                                                                         |
| ----------------------- | ------- | -------------------------------------------------------------------------------- |
| `q`                     | string  | Поисковый запрос                                                                 |
| `types`                 | string  | Фильтр: `places`, `partners_subscription`, `partners_discount`, `bonus_partners` |
| `user_lat`, `user_long` | decimal | Координаты пользователя                                                          |
| `radius`                | integer | Радиус в км                                                                      |

```json
{
    "success": true,
    "data": [
        {
            "id": 1,
            "type": "place",
            "title": "35 Health Club",
            "lat": 41.311,
            "long": 69.24,
            "rating": 4.8,
            "is_open": true
        },
        {
            "id": 5,
            "type": "partner",
            "partner_type": "subscription",
            "title": "Gold Gym",
            "lat": 41.32,
            "long": 69.25
        },
        {
            "id": 2,
            "type": "bonus_partner",
            "title": "Healthy Food",
            "lat": 41.33,
            "long": 69.26
        }
    ]
}
```

---

### 8.2. Детали объекта

**GET** `/map/detail?type=partner&id=5`

```json
{
    "success": true,
    "data": {
        "id": 5,
        "type": "partner",
        "title": "Gold Gym",
        "address": "Amir Temur str, 15",
        "rating": 4.8,
        "reviews_count": 100,
        "description": "Best gym in town",
        "contacts": { "phone": "+998901234567", "instagram": "@goldgym" },
        "work_hours": [...],
        "gallery": ["url1", "url2"],
        "services": [{ "id": 0, "title": "subscription" }],
        "reviews": [...],
        "other_branches": [...]
    }
}
```

---

### 8.3. Списки партнеров

**GET** `/partners` — Список всех партнеров  
**GET** `/partners/{id}` — Детали партнера  
**GET** `/bonus-partners` — Список бонусных партнеров  
**GET** `/bonus-partners/{id}` — Детали бонусного партнера

---

## 9. Бронирование

### 9.1. Слоты партнера

**GET** `/partners/{id}/slots?day=1`

| Параметр | Тип     | Описание          |
| -------- | ------- | ----------------- |
| `day`    | integer | День недели (1-7) |

```json
[
    {
        "id": 10,
        "time": "12:00",
        "spots": 10,
        "available_spots": 8,
        "title": "Yoga",
        "has_client_reservation": false,
        "client_reservation_id": null
    },
    {
        "id": 11,
        "time": "13:00",
        "spots": 10,
        "available_spots": 9,
        "title": "Pilates",
        "has_client_reservation": true,
        "client_reservation_id": 555
    }
]
```

---

### 9.2. Забронировать слот

**POST** `/partners/reserve`

```json
{ "reservation_id": 10 }
```

**Ограничения:**

-   Максимум 3 бронирования в неделю
-   Минимум 1 час между бронированиями
-   Нельзя бронировать на прошедшее время

**Ответ:**

```json
{ "success": true, "message": "Бронирование успешно" }
```

**Ошибки:**

```json
// 404 — Слот не найден
{ "success": false, "message": "Слот не найден", "error_code": "slot_not_found" }

// 422 — Максимум бронирований
{ "success": false, "message": "Вы достигли максимума бронирований в неделю (3)", "error_code": "max_reservations_reached" }

// 422 — Нет свободных мест
{ "success": false, "message": "Нет свободных мест", "error_code": "no_spots_available" }
```

---

### 9.3. Отменить бронирование

**POST** `/partners/cancel`

```json
{ "client_reservation_id": 555 }
```

**Ограничение:** Отмена возможна только до 23:59 предыдущего дня.

```json
{ "success": true, "message": "Бронирование отменено" }
```

---

## 10. Рейтинг и Отзывы

### 10.1. Теги для оценки

**GET** `/rating/tags`

```json
{
    "staff": ["Вежливые", "Профессионалы"],
    "club": ["Чисто", "Уютно"],
    "training": ["Интенсивно", "Интересно"]
}
```

---

### 10.2. Отправить отзыв

**POST** `/rating`

```json
{
    "place_id": 1,
    "visit_id": 123,
    "staff_rating": 5,
    "club_rating": 5,
    "training_rating": 5,
    "staff_tags": ["Вежливые"],
    "club_tags": ["Чисто"],
    "training_tags": ["Интенсивно"],
    "comment": "Отличный клуб!"
}
```

**Ответ:**

```json
{ "success": ["Спасибо за ваш отзыв!"], "rating": {...} }
```

---

### 10.3. Мои отзывы

**GET** `/rating/my`

---

### 10.4. Отзывы о клубе

**GET** `/rating/place/{place_id}`

```json
{
    "place": { "id": 1, "title": "Oltintepa", "rating": 4.8, "ratings_count": 120 },
    "ratings": { "data": [...] }
}
```

---

### 10.5. Статистика рейтинга клуба

**GET** `/rating/place/{place_id}/stats`

---

## 11. Чат (Поддержка)

### 11.1. Список сообщений

**GET** `/messages/{client_id}`

```json
[
    {
        "id": 1,
        "client_id": 36048,
        "user_id": 10,
        "text": "Hello",
        "to": 1,
        "read_at": null,
        "created_at": "..."
    }
]
```

---

### 11.2. Количество непрочитанных

**GET** `/messages/{client_id}/count`  
**Ответ:** `5` (integer)

---

### 11.3. Отправить сообщение

**POST** `/messages/user`

```json
{ "text": "Hello support" }
```

**Ответ:**

```json
{ "id": 2, "text": "Hello support", "to": false, "created_at": "..." }
```

---

### 11.4. Прочитать сообщение

**POST** `/messages/read/{message_id}`

---

## 12. QR Scanner

**POST** `/check-code/{code}`

Проверяет отсканированный QR код.

**Логика:**

-   `code <= 5000` — Партнер. Проверяет бронирование (+/- 15 мин)
-   `code > 5000` — Бонусный партнер. Проверяет таймаут (90 мин)

**Ответы:**
| Status | Описание |
|--------|----------|
| `ok` | Успешно (посещение засчитано) |
| `deny` | Нет активной подписки или брони |
| `visited` | Уже посещал недавно (бонусный партнер) |
| `wrong` | Неверный код |

---

## Коды ответов

| Code | Описание                  |
| ---- | ------------------------- |
| 200  | Успешный запрос           |
| 400  | Некорректный запрос       |
| 401  | Не авторизован            |
| 403  | Доступ запрещен           |
| 404  | Не найдено                |
| 422  | Ошибка валидации          |
| 500  | Внутренняя ошибка сервера |

---

## Формат ошибок

Все ошибки возвращаются в едином формате:

```json
{
    "success": false,
    "message": "Описание ошибки для пользователя",
    "error_code": "unique_error_code"
}
```

| Поле         | Тип     | Описание                               |
| ------------ | ------- | -------------------------------------- |
| `success`    | boolean | Всегда `false` для ошибок              |
| `message`    | string  | Локализованное сообщение (на русском)  |
| `error_code` | string  | Уникальный код для обработки в клиенте |

### Справочник кодов ошибок

| error_code                     | HTTP | Описание                       |
| ------------------------------ | ---- | ------------------------------ |
| `sms_send_failed`              | 500  | Не удалось отправить SMS       |
| `invalid_code`                 | 401  | Неверный код подтверждения     |
| `auth_failed`                  | 401  | Ошибка авторизации             |
| `user_not_found`               | 404  | Пользователь не найден         |
| `password_not_set`             | 403  | Пароль не установлен           |
| `invalid_password`             | 401  | Неверный пароль                |
| `record_not_found`             | 404  | Запись не найдена              |
| `not_found`                    | 404  | Объект не найден               |
| `partner_not_found`            | 404  | Партнёр не найден              |
| `slot_taken`                   | 422  | Время занято                   |
| `slot_not_found`               | 404  | Слот не найден                 |
| `no_active_subscription`       | 404  | Нет активного абонемента       |
| `not_enough_freeze_days`       | 400  | Недостаточно дней заморозки    |
| `duplicate_image`              | 400  | Фото уже использовалось        |
| `no_pending_meals`             | 200  | Нет фото для анализа           |
| `max_reservations_reached`     | 422  | Максимум бронирований в неделю |
| `past_date`                    | 422  | Нельзя бронировать на прошлое  |
| `interval_too_short`           | 422  | Слишком маленький интервал     |
| `no_spots_available`           | 422  | Нет свободных мест             |
| `reservation_not_found`        | 404  | Бронирование не найдено        |
| `cancellation_deadline_passed` | 422  | Истёк срок отмены              |
