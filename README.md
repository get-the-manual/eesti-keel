# eesti-keel
Здесь находятся материалы по изучению эстонского языка.

Скомпилированный сайт [доступен к просмотру здесь](https://get-the-manual.github.io/eesti-keel/)

Содержимое страниц лежит в папке `docs`. Pull request'ы по улучшению ресурса приветствуются.

Сайт собирается и публикуется автоматически (GitHub Actions, `.github/workflows/build-site.yml`) при каждом push в `main`. Локальный запуск нужен только для предварительного просмотра.

Сайт собирается генератором [Zensical](https://zensical.org/) (преемник Material for MkDocs). Настройки лежат в `mkdocs.yml`.

Навигация (`nav:` в `mkdocs.yml`) ведется вручную: новую страницу нужно добавить туда самостоятельно.

Правила оформления страниц для людей и ИИ-агентов описаны в `AGENTS.md`.

## Установка

```
pip install "zensical~=0.1.3"
```

## Локальный запуск

```
zensical serve
```

На Windows Zensical 0.1.3 падает на плагине дат git. Для локального запуска отключите его переменной окружения (страницы будут без дат):

```powershell
$env:EESTI_GIT_DATES = 'false'
zensical serve
```

Сайт публикуется в GitHub Pages напрямую из GitHub Actions (`actions/deploy-pages`), без ветки `gh-pages`.
