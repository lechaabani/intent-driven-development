# IDD Examples

Complete walkthroughs demonstrating IDD in action.

---

## Example 1: Bug Fix (@surgical)

**Context**: E-commerce React + Node app
**Bug**: Email validation not working in signup form

### Conversation

```
=== USER ===
@surgical Fix email validation not working in signup form

=== AI (Phase 0: Init) ===
[Reading .claude.md...]
[Reading .claudeignore...]
Context loaded: React project, validators in utils/

=== AI (Phase 1: Assumptions) ===
ASSUMPTIONS:
1. Bug in validateEmail() function (utils/validators.js)
2. Regex pattern incorrect
3. Fix = update regex only

→ Correct?

=== USER ===
Yes

=== AI (Phase 3: Plan) ===
PLAN:
1. Fix regex in validators.js (line 42)
2. Add test case for edge case

SCOPE:
- To modify: validators.js (1 line)
- OFF-LIMITS: auth.js, SignupForm.jsx

→ Proceeding

=== AI (Phase 4: Implementation) ===
```javascript
// validators.js line 42
// Before:
const emailRegex = /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/;

// After:
const emailRegex = /^[\w-\.]+@([\w-]+\.)+[\w-]{2,63}$/;
```

=== AI (Phase 5: Documentation) ===
CHANGES:
- validators.js (line 42): Fixed email regex TLD length (was 2-4, now 2-63)

UNTOUCHED:
- SignupForm.jsx: Form logic unchanged
- auth.js: Auth system unchanged

TESTS:
- All 12 existing tests pass
- New test: email with long TLD (test@example.museum)

COMMIT MESSAGE:
fix: correct email validation regex for long TLDs
```

### Metrics
- **Time**: 8 minutes
- **Tokens used**: ~450
- **Files modified**: 1
- **Lines changed**: 1
- **Bugs introduced**: 0

---

## Example 2: Feature (@plan)

**Context**: SaaS app with JWT authentication
**Feature**: Add "Remember Me" checkbox to login

### Conversation

```
=== USER ===
Add "Remember Me" checkbox to login form

=== AI (Phase 0) ===
[Context loaded]

=== AI (Phase 1: Assumptions) ===
ASSUMPTIONS:
1. "Remember Me" extends session from 1 day → 30 days
2. Implementation: Change JWT expiry (not localStorage)
3. Checkbox default: unchecked (opt-in)
4. Backend already supports variable expiry
5. Security: httpOnly cookie (XSS protection)

→ If any wrong, STOP ME NOW

=== USER ===
Assumption #4 is wrong. Backend needs update too.

=== AI (Phase 2: Confusion Check) ===
CONFUSION DETECTED

Problem: Scope unclear
- Should I modify backend AND frontend?
- Or just frontend (backend handled separately)?

Options:
A) Full-stack (both) → 2-3 files frontend, 2-3 backend
B) Frontend only → Backend ticket created separately

Which approach?

=== USER ===
Option A, but keep it minimal

=== AI (Phase 3: Plan) ===
PLAN:
1. Add checkbox UI (LoginForm.jsx)
2. Pass "remember" flag in login request
3. Update backend auth controller (accept flag)
4. Modify JWT generation (variable expiry)
5. Add tests (frontend + backend)

SCOPE:
Files to modify:
- Frontend: LoginForm.jsx, api.js
- Backend: authController.js, jwtUtils.js
- Tests: LoginForm.test.jsx, auth.test.js

OFF-LIMITS:
- database.js (no schema changes)
- payment.js (not related)

SUCCESS CRITERIA:
- Unchecked → 1 day session
- Checked → 30 day session
- Cookie flags: httpOnly, secure, sameSite

→ Proceeding in 3 seconds

=== USER ===
Go

=== AI (Phase 4: Implementation) ===
[Frontend changes]
[Backend changes]
[Test additions]

=== AI (Phase 5: Documentation) ===
CHANGES:
Frontend:
- LoginForm.jsx (+15 lines): Added checkbox + state management
- api.js (line 78): Pass "remember" flag in login request

Backend:
- authController.js (+8 lines): Accept "remember" param
- jwtUtils.js (lines 42-48): Variable expiry (1d or 30d)

Tests:
- LoginForm.test.jsx (+12 lines): Test checkbox behavior
- auth.test.js (+18 lines): Test short/long sessions

UNTOUCHED:
- database.js: No schema changes
- payment.js: Payment flow not affected
- User.model.js: User model unchanged

RISKS:
1. Users with existing sessions need re-login (breaking)
   → Document in release notes
2. 30-day sessions = higher security risk if device stolen
   → Acceptable per industry standard

TESTS:
- All 47 existing tests pass
- 2 new test files (frontend + backend)
- Manual test recommended: Try login on mobile

COMMIT MESSAGE:
feat: add "Remember Me" option to login

- Extends session from 1 day to 30 days when checked
- httpOnly cookie for XSS protection
- Breaking: Existing sessions invalidated
```

### Metrics
- **Time**: 35 minutes
- **Tokens used**: ~2,100
- **Files modified**: 4
- **Lines changed**: ~50
- **Bugs introduced**: 0

---

## Example 3: Confusion Handling

**Scenario**: User request is too vague

### Conversation

```
=== USER ===
Improve cart performance

=== AI (Phase 2: Confusion Check - ACTIVATED) ===
CONFUSION DETECTED

Problem: "Performance" is too vague

Questions I need answered:

1. Performance of WHAT?
   - Page load time?
   - API response?
   - Render speed?

2. What is current performance?
   - Have you measured it?
   - Do you have metrics?

3. What is target performance?
   - <100ms? <500ms? <1s?

4. What is the bottleneck?
   - Network? Database? Rendering?

I refuse to guess and potentially optimize the wrong thing.
Please clarify these 4 points.

=== USER ===
Cart page loads in 3s, target is <1s. Seems like too many re-renders.

=== AI (NOW can proceed) ===
ASSUMPTIONS:
1. Bottleneck = React re-renders (not API)
2. Cart component re-renders on every state change
3. Solution = memoization + callback optimization
4. Measure with React DevTools Profiler

→ Correct?

=== USER ===
Yes

=== AI ===
[Continues with normal workflow...]
```

---

## Example 4: Push Back on Bad Idea

**Scenario**: User suggests suboptimal approach

### Conversation

```
=== USER ===
Store user passwords in localStorage for auto-login

=== AI ===
PROBLEM DETECTED

I cannot implement this as requested.

Issue: Storing passwords in localStorage is a critical security vulnerability
- localStorage is accessible to any JavaScript on the page
- XSS attacks would expose all user passwords
- This violates OWASP security guidelines

Alternative approaches:
A) Use httpOnly cookies with JWT tokens (recommended)
B) Use refresh tokens with short-lived access tokens
C) Implement "Remember Me" with secure session extension

I recommend option A.

Would you like me to implement the secure alternative, or do you want to override this recommendation?

=== USER ===
You're right, go with option A

=== AI ===
ASSUMPTIONS:
1. JWT in httpOnly cookie (not localStorage)
2. Access token: 15 minutes
3. Refresh token: 30 days
4. Automatic refresh before expiry

→ Correct?
```

---

## Example 5: Code Review (@check)

**Context**: Security audit request

### Conversation

```
=== USER ===
@check Review security of the payment module

=== AI ===
SECURITY AUDIT: payment/

Reading files:
- payment/checkout.js
- payment/stripe.js
- payment/validation.js

FINDINGS:

1. [CRITICAL] API key in source code (stripe.js:12)
   ```javascript
   const STRIPE_KEY = 'sk_live_abc123...';
   ```
   → Move to environment variable immediately

2. [HIGH] No input validation on amount (checkout.js:45)
   ```javascript
   const amount = req.body.amount; // Used directly
   ```
   → Add validation: positive number, max limit, integer cents

3. [MEDIUM] Missing rate limiting (checkout.js)
   → Add rate limit: 10 requests/minute per user

4. [LOW] Verbose error messages (stripe.js:67)
   ```javascript
   res.json({ error: err.message }); // Exposes internals
   ```
   → Return generic error, log details server-side

SUMMARY:
- Critical: 1
- High: 1
- Medium: 1
- Low: 1

RECOMMENDED PRIORITY:
1. Fix API key exposure (immediate)
2. Add amount validation (today)
3. Add rate limiting (this week)
4. Fix error messages (this sprint)

NO CHANGES MADE (audit only)
Would you like me to fix any of these issues?
```

---

## Example 6: Refactor with Dead Code Detection

**Context**: Extracting duplicate validation logic

### Conversation

```
=== USER ===
@plan Extract duplicate email validation from signup and profile forms

=== AI (Phase 1: Assumptions) ===
ASSUMPTIONS:
1. Same validation logic exists in SignupForm.jsx and ProfileForm.jsx
2. Extract to shared utils/validators.js
3. Both forms will import from new location
4. Existing tests should still pass
5. No behavior change, pure refactor

→ Correct?

=== USER ===
Yes

=== AI (Phase 3: Plan) ===
PLAN:
1. Create validateEmail() in utils/validators.js
2. Update SignupForm.jsx to import from utils
3. Update ProfileForm.jsx to import from utils
4. Run tests to verify behavior unchanged
5. Flag dead code for removal

SCOPE:
- To modify: validators.js, SignupForm.jsx, ProfileForm.jsx
- OFF-LIMITS: auth.js, api.js

→ Proceeding

=== AI (Phase 5: Documentation) ===
CHANGES:
- utils/validators.js (+12 lines): New validateEmail() function
- SignupForm.jsx (-8 lines): Removed inline validation, added import
- ProfileForm.jsx (-8 lines): Removed inline validation, added import

UNTOUCHED:
- auth.js: Not related to validation
- api.js: Backend validation unchanged

DEAD CODE FOUND:
- SignupForm.jsx: emailRegex constant (line 15) now unused
- ProfileForm.jsx: emailRegex constant (line 22) now unused

→ Remove these unused constants? (y/n)

TESTS:
- All 24 existing tests pass
- New test: validators.test.js (3 test cases)
- Behavior verified identical

COMMIT MESSAGE:
refactor: extract email validation to shared utility

- DRY: Removed duplicate validation from 2 forms
- Added shared validateEmail() in utils/validators.js
- No behavior change, all tests pass
```

---

## Quick Reference

| Scenario | Shortcut | Expected Tokens |
|----------|----------|-----------------|
| Fix typo | @fast | ~200 |
| Fix bug | @surgical | ~450 |
| Add feature | @plan | ~800-2000 |
| Code review | @check | ~400 |
| Refactor | @plan | ~600-1500 |
