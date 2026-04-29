---
description: Review error messages to match the guidelines.
agent: plan
---

Review the changes in this branch, including the unstaged changes, and ensure that all error messages conform to the established guidelines. Provide feedback on any error messages that do not meet the criteria outlined below.

Never hallucinate new error messages; only review and critique existing ones. Never hallucinate a fix that isn't already in the code. You can ask for followups for a fix if it's missing.

# Error Message Guidelines

## The Rule
Every error must answer three questions immediately:
1. **What** happened?
2. **Why** did it happen?
3. **What** can I do now?

If it doesn't answer all three, it's not done.

Take inspiration from modern compilers and CLIs like Elm, Rust and other languages that are known for great, actionable error messages.

---

## Checklist

- [ ] **Name the exact failure.** Use the specific function, file, or value that failed.
- [ ] **Explain the real reason.** Domain cause, not implementation detail.
- [ ] **Suggest a concrete fix.** Code, command, or config—not just "try again".
- [ ] **Adding more information as "help:".** Code, command, or config—not just "try again".
- [ ] **Reassure when possible.** Say what didn't break.
- [ ] **Include a link only as supplement.** Don't rely on users clicking it.
- [ ] **Make it greppable.** Agents and humans both search for exact terms.
- [ ] **Avoid dead ends.** "Contact support" needs context; it's a last resort.
- [ ] **Use structure.** Separate cause → explanation → fix visually.
- [ ] **No jargon without explanation.** No blame. No jokes in serious errors.
- [ ] **Prefer no error at all.** Safe defaults and auto-recovery beat good messages.

---

## Structure Template

```text
error: <what happened>
├▶ <why it happened>
│  <optional: link or extra context>
╰▶ fix: <concrete action to resolve>
```

---

## Examples

```
<example>
<summary>setInterval used in workflow context; non-deterministic functions are forbidden</summary>
<error_message>
error: `setInterval` is not available in a workflow context.
├▶ Timer-based functions introduce non-deterministic behavior and cannot be
│  recorded in the workflow event log.
│  Read more: https://useworkflow.dev/err/timeout-in-workflow
╰▶ fix: use the `sleep` function from the `workflow` package for delays, or
   model repeating behavior with workflow steps.
</error_message>
</example>
```

```
<example>
<summary>misspelled workflow directive with suggested correction</summary>
<error_message>
error: unknown directive `"use wkrflow"`.
├▶ This directive is not recognized by the workflow compiler.
│  hint: did you mean `"use workflow"`?
╰▶ fix: replace with `"use workflow"`, or add `// wf-expect-err` to suppress.
</error_message>
</example>
```

```
<example>
<summary>CLI data directory cannot be inferred on unsupported OS</summary>
<error_message>
error: cannot infer Vercel CLI data directory.
├▶ Platform `freebsd` is not supported by this library or the Vercel CLI.
├▶ fix: override manually:
│    XDG_DATA_DIR=$HOME/.local/state/cli.vercel.com
╰▶ If this platform should be supported, open an issue at
   https://github.com/vercel/vercel with this message.
</error_message>
</example>
```

```
<example>
<summary>workflow step called outside workflow execution context</summary>
<error_message>
error: `step.run()` called outside workflow execution.
├▶ Workflow steps require an active workflow context to record state.
╰▶ fix: move this call inside a workflow function, or use a regular async
   function if workflow semantics are not needed.
</error_message>
</example>
```

```
<example>
<summary>OIDC token missing in production with no recovery path</summary>
<error_message>
error: no valid Vercel OIDC token available.
├▶ No token found in request context or environment. Interactive login is
│  disabled in production.
╰▶ fix: set VERCEL_OIDC_TOKEN in your environment, or run within a
   Vercel-managed runtime.
</error_message>
</example>
```

---

## Anti-patterns

| ❌ Bad | ✅ Better |
|--------|-----------|
| "An error occurred" | "`fetchUser` failed: connection refused" |
| "Please try again" | "Retry in 30s, or check network connectivity" |
| "Contact support" | "Open an issue at [url] with this message" |
| "Something went wrong" | "Payment declined: card expired" |
| "Invalid input" | "`email` field must be a valid email address" |

---

## North Star

Errors are product. Treat them like UI copy—drafted, reviewed, tested. The best error is the one you never show because the library handled it already.
