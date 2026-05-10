# Workflow: Review

## When to use
Когда нужно отдельное ревью кода, спеки или архитектурного решения — без полного цикла implement.

## Steps

1. **Define scope** — что ревьюим: PR, файл, спеку, ADR

2. **Activate `reviewer`** → код-ревью + базовая security-проверка
   - Output: `reviews/<scope>-<date>.md`

3. **Activate `security`** (если ревью затрагивает данные, аутентификацию, внешние интерфейсы) → углублённая security-оценка
   - Output: добавляется секция в ревью или отдельный `reviews/<scope>-security.md`

4. **Human action** — решение о принятии замечаний

## Artifacts
- `reviews/<scope>-<date>.md`

## Exit criteria
- Все замечания категоризированы
- Вердикт явный: approved / request_changes / needs_discussion
