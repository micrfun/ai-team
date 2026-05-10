# Workflow: Implement

## When to use
Когда есть утверждённая спека и нужно реализовать фичу.

## Steps

1. **Activate `engineer`** → реализация по спеке
   - Код + базовые тесты
   - Если спека неполная — возврат к `architect`
   - Output: код в репозитории + summary изменений

2. **Activate `qa`** → тесты и evals
   - Unit + integration тесты
   - Для AI-фич — eval-сценарии
   - Output: тесты в репозитории + `evals/<feature>.md` (если применимо)

3. **Activate `reviewer`** → код-ревью + security
   - Output: `reviews/<feature>-<date>.md`

4. **Iteration loop**:
   - Если `request_changes` → возврат к `engineer` с замечаниями
   - Если `needs_discussion` → эскалация к человеку
   - Если `approved` → переход к `ship`

## Artifacts
- Код + тесты
- `reviews/<feature>-<date>.md`
- `evals/<feature>.md` (для AI-фич)

## Exit criteria
- Код реализует спеку
- Тесты проходят
- Ревью approved
- Нет открытых blocker'ов или major-замечаний
