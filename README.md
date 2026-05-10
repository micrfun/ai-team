# AI Team

Универсальный шаблон для добавления AI-команды разработки в любой проект.

Проект добавляет в целевой репозиторий инструмент-независимое ядро `.ai/` с ролями, workflow, шаблонами артефактов и адаптерами для разных AI-инструментов: Claude Code, Codex, Gemini CLI, Cursor, Antigravity и других агентов, которые умеют читать файлы проекта.

GitHub: https://github.com/micrfun/ai-team

[![Smoke tests](https://github.com/micrfun/ai-team/actions/workflows/smoke-tests.yml/badge.svg)](https://github.com/micrfun/ai-team/actions/workflows/smoke-tests.yml)

## Quickstart

### Установка одной командой

**Windows / PowerShell:**

```powershell
$installer = Join-Path $env:TEMP "install-ai-team.ps1"; Invoke-WebRequest "https://raw.githubusercontent.com/micrfun/ai-team/main/install.ps1" -OutFile $installer; powershell -ExecutionPolicy Bypass -File $installer -Target .
```

Stable `v0.1.0` link:

```powershell
$installer = Join-Path $env:TEMP "install-ai-team.ps1"; Invoke-WebRequest "https://raw.githubusercontent.com/micrfun/ai-team/v0.1.0/install.ps1" -OutFile $installer; powershell -ExecutionPolicy Bypass -File $installer -Target .
```

**macOS / Linux:**

```bash
curl -fsSL https://raw.githubusercontent.com/micrfun/ai-team/main/install.sh | bash -s -- .
```

Stable `v0.1.0` link:

```bash
curl -fsSL https://raw.githubusercontent.com/micrfun/ai-team/v0.1.0/install.sh | bash -s -- .
```

### Установка из локальной копии

**macOS / Linux:**

```bash
./install.sh /path/to/your/project
# или из папки проекта
cd /path/to/your/project && /path/to/template/install.sh
```

**Windows:**
```powershell
.\install.ps1 -Target C:\path\to\your\project
```

Установщик копирует нужные папки в проект. Существующие файлы сохраняются, а новые версии конфликтующих файлов записываются рядом с суффиксом `.ai-team-new`. Для явной перезаписи используй `-Force` или `--force`.

### Установка через любого агента

Открой целевой проект в Hermes, OpenClaw, Codex, Claude Code, Gemini CLI или другом агенте и дай ему инструкцию из [AGENT_INSTALL_PROMPT.md](AGENT_INSTALL_PROMPT.md).

Короткая версия:

```text
Install AI Team into this project from https://github.com/micrfun/ai-team.
Use the official installer for this OS if possible. After installation, read .ai/context/project.md.
If it contains AI-TEAM-CONTEXT: NOT_INITIALIZED, run the init workflow by reading .ai/workflows/init.md and .ai/roles/bootstrap.md, then fill .ai/context/project.md, .ai/context/stack.md, and .ai/context/conventions.md based on this project.
Do not overwrite existing agent instructions without asking.
```

### Первый запуск

Открой проект в любом AI CLI (Claude Code, Codex, Gemini CLI, Cursor, Antigravity) и попроси агента прочитать `AI-TEAM-BOOTSTRAP.md`.

После этого агент явно проверит маркер `NOT_INITIALIZED` в `.ai/context/project.md` и запустит роль **bootstrap**, которая:

1. Прочитает существующие файлы проекта (`package.json`, `README.md`, lockfiles, конфиги)
2. Покажет тебе, что нашёл, и попросит подтвердить
3. Спросит несколько коротких вопросов — или примет твоё свободное описание проекта текстом
4. Заполнит файлы контекста

После этого можно работать обычно: вызывать роли, запускать workflow'ы.

### Если хочется инициализировать вручную
Скажи агенту: «запусти init» — или используй слэш-команду `/init` в Claude Code.

## Что устанавливается

```
.ai/                      ← инструмент-независимое ядро
  roles/                  ← описания ролей
  workflows/              ← процессы
  templates/              ← шаблоны артефактов (spec, ADR, review, eval)
  presets/                ← типовые настройки для web, Python, open-source, agent tooling
  context/                ← контекст проекта (заполняется bootstrap'ом)
.claude/                  ← адаптер Claude Code (CLAUDE.md + agents/ + commands/)
.codex/                   ← адаптер Codex CLI (AGENTS.md)
.gemini/                  ← адаптер Gemini CLI (GEMINI.md)
.cursor/                  ← адаптер Cursor (rules/ai-team.mdc)
.antigravity/             ← адаптер Antigravity (AGENTS.md)
install.sh / install.ps1  ← установщики
```

Установщик также кладет `AI-TEAM-README.md`, `AI-TEAM-INSTALL.md`, `AI-TEAM-AGENT-INSTALL-PROMPT.md` и `AI-TEAM-BOOTSTRAP.md` в целевой проект.

По умолчанию установка безопасная: существующие файлы не перезаписываются. Если файл уже есть, новая версия сохраняется рядом с суффиксом `.ai-team-new`. Явное перезаписывание включается только через `-Force` в PowerShell или `--force` в bash.

Перед установкой можно посмотреть план без изменения файлов:

```powershell
powershell -ExecutionPolicy Bypass -File .\install.ps1 -Target C:\path\to\your\project -DryRun
```

```bash
./install.sh /path/to/your/project --dry-run
```

## Роли

| Роль | Назначение |
|------|-----------|
| `bootstrap` | Инициализация: заполняет контекст при первом запуске |
| `orchestrator` | Координирует команду, декомпозирует задачи |
| `product` | Что строим и почему: discovery, user stories, приоритеты |
| `ux-designer` | Пользовательский опыт: flows, экраны, состояния |
| `architect` | Технический дизайн: контракты, схемы, ADR |
| `engineer` | Реализация по спеке |
| `qa` | Тесты, evals, чек-листы |
| `reviewer` | Код-ревью + базовая security |
| `security` | Угрозы, риски, compliance |
| `growth` | Позиционирование, ICP, метрики, эксперименты |

## Workflows

| Workflow | Когда использовать |
|----------|-------------------|
| `init` | Первичная настройка проекта (запускается автоматически) |
| `discovery` | Есть идея, неясно что строить |
| `plan` | Есть задача, нужна спека |
| `implement` | Есть спека, нужен код |
| `review` | Отдельное ревью без полного цикла |
| `ship` | Подготовка и проведение релиза |

## Как использовать

### Описать задачу обычным языком
```
"Помоги спроектировать систему уведомлений для приложения"
```
Агент прочитает контекст, выберет подходящий workflow или роль, начнёт работу.

### Явно вызвать роль
```
"Действуй как architect. Спроектируй систему уведомлений."
```

### Запустить workflow
```
"Запусти workflow plan для системы уведомлений."
```

### Оркестрация
```
"Действуй как orchestrator. Задача: реализовать систему уведомлений от и до."
```

## Артефакты

Все значимые результаты сохраняются в файлы — это позволяет ролям передавать контекст друг другу через файловую систему, независимо от того, какой инструмент их вызвал. Это значит: Codex может написать спеку, Claude Code — код по ней, Gemini — провести ревью.

```
specs/      ← технические спецификации
decisions/  ← ADR (Architecture Decision Records)
discovery/  ← материалы discovery
reviews/    ← отчёты ревью
evals/      ← планы тестов и evals
releases/   ← release notes и postmortem
```

## Принципы

- **Tool-agnostic**: ядро в `.ai/`, адаптеры тонкие
- **Files as protocol**: всё значимое — в файлах, не в памяти агента
- **Human in the loop**: чекпоинты после спеки, перед релизом, при blocker'ах
- **Roles, not personas**: роль — это режим работы, не персонаж
- **Auto-init, don't pre-fill**: контекст заполняется в диалоге, а не вручную перед стартом

## Адаптация

Шаблон — стартовая точка. После пары проектов:
- Удали роли, которыми не пользуешься
- Добавь свои workflow'ы
- Расширь шаблоны артефактов под специфику
- Обновляй контекстные файлы при значимых изменениях проекта (или просто запусти `init` повторно)

## Публикация и обновление

Этот репозиторий рассчитан на установку по raw-ссылкам GitHub. После изменений в `main` новые установки будут брать актуальные версии:

- `https://raw.githubusercontent.com/micrfun/ai-team/main/install.ps1`
- `https://raw.githubusercontent.com/micrfun/ai-team/main/install.sh`

Для воспроизводимых установок можно ссылаться на конкретный commit SHA вместо `main`.

## Поддержка проекта

- Изменения и релизы: [CHANGELOG.md](CHANGELOG.md)
- Правила вклада: [CONTRIBUTING.md](CONTRIBUTING.md)
- Security policy: [SECURITY.md](SECURITY.md)
- Smoke tests: [docs/SMOKE_TESTS.md](docs/SMOKE_TESTS.md)
- Update guide: [docs/UPDATE_GUIDE.md](docs/UPDATE_GUIDE.md)
- Release checklist: [docs/RELEASE_CHECKLIST.md](docs/RELEASE_CHECKLIST.md)
- Agent compatibility: [docs/AGENT_COMPATIBILITY.md](docs/AGENT_COMPATIBILITY.md)
- Presets: [docs/PRESETS.md](docs/PRESETS.md)
- Roadmap: [docs/ROADMAP.md](docs/ROADMAP.md)
- Examples: [examples/README.md](examples/README.md)
