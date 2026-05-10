# Workflow: Plan

## When to use
Когда есть user story или задача, нужна техническая спецификация и план реализации.

## Steps

1. **Activate `product`** (если ещё не было) → сформулировать user story и acceptance criteria
   - Output: `specs/<feature>-story.md`

2. **Activate `ux-designer`** (если фича имеет UI) → описать экраны и flow
   - Output: `specs/<feature>-ux.md`

3. **Activate `architect`** → техническая спецификация
   - Альтернативы, выбор, контракты, схемы данных
   - Output: `specs/<feature>.md` + при необходимости `decisions/NNNN-<title>.md`

4. **Activate `security`** → проверка спеки на риски
   - Threat model для значимых изменений
   - Output: добавляется секция `## Security` в `specs/<feature>.md`

5. **Human checkpoint** → ревью спеки
   - Утверждение → переход к `implement`
   - Правки → возврат на нужный шаг

## Artifacts
- `specs/<feature>-story.md`
- `specs/<feature>-ux.md` (если применимо)
- `specs/<feature>.md`
- `decisions/NNNN-<title>.md` (если применимо)

## Exit criteria
- Спека описывает, что и как строить
- Acceptance criteria измеримы
- Открытые вопросы либо закрыты, либо явно помечены
- Security-риски проверены
