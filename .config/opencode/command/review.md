---
description: Run the full test suite with coverage report and show any failures. Focus on the failing tests and suggest fixes.
agent: plan
model: anthropic/claude-sonnet-4-20250514
---

Please review the code changes implemented in the current branch against `origin/main` or the upstream main branch (`master`, `dev`, depends on the repository).
Then, compile a list of suggestions for improvements, optimizations, or potential issues in the code. Be concise and specific in your feedback without fluff.
You can run the `review-comments` executable (already in $PATH) to find if there are any reviews from teammates on the current branch.
