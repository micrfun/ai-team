# Workflow: Ship

## When to use
Когда фича прошла ревью и готовится к релизу.

## Steps

1. **Activate `qa`** → финальная проверка
   - Прогон всех тестов и evals
   - Smoke-тест на staging если применимо
   - Output: отчёт о готовности

2. **Activate `security`** → финальная проверка перед релизом
   - Зависимости, секреты, логи, права доступа
   - Output: security sign-off или список блокеров

3. **Activate `growth`** (если фича пользовательская) → подготовка коммуникации
   - Changelog, anonsement, обновление лендинга
   - Output: `releases/<version>-notes.md`

4. **Human checkpoint** → решение о релизе
   - Релиз — необратимая операция, всегда подтверждается человеком

5. **Post-release**:
   - Мониторинг метрик и ошибок
   - Если есть гипотеза — фиксация результатов проверки
   - Output: `releases/<version>-postmortem.md` при необходимости

## Artifacts
- `releases/<version>-notes.md`
- `releases/<version>-postmortem.md` (если применимо)
- Тег в git, релиз

## Exit criteria
- Релиз выпущен
- Мониторинг настроен
- Коммуникация отправлена пользователям (если применимо)
- Гипотеза проверяется по плану из discovery
