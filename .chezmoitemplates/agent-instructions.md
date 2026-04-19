Always write code comments and docstrings in English, regardless of the conversation language.

When installing chezmoi via get.chezmoi.io, always use `-b ~/.local/bin` to install to ~/.local/bin.

When creating git commits, follow the commit message style established in the repository's recent history.

## Python

- Do not use `pip install`. Use `uv add` to add project dependencies, or `uv run --with <package>` for one-off usage.
- When running Python, use `uv run python`. For ad-hoc scripts unrelated to any Python project, use `uv run --no-project python`.
- Do not create virtual environments manually (`python -m venv`). Use `uv venv` or let `uv run` handle it automatically.
- Use `uvx <tool>` to run Python CLI tools (e.g., `uvx ruff check .`). Do not use `pipx`.
- For one-off scripts that need dependencies, use PEP 723 inline metadata with `uv run --script`:
  ```python
  # /// script
  # dependencies = ["requests"]
  # ///
  ```
